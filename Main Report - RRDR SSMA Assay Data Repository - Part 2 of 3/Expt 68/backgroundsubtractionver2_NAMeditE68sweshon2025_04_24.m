clear all

sheetname = "2025-04-24 Expt 68 modified asym pcr and melt_20250715_110905.xlsx";
% Make sure to keep .xlsx in file name! 
data = readtable(sheetname,Sheet=3);

%%
readingnumber = max(data.ReadingNumber);
targetnames = unique(data.Target,'stable');
targetnumber = length(targetnames);
wellnames = unique(data.WellPosition,'stable');
wellnumber = length(wellnames);

fluordata = data.Fluorescence;
meltderiv = data.Derivative;
temperatures = data.Temperature;

fluordata = reshape(fluordata,readingnumber,[]);
meltderiv = reshape(meltderiv,readingnumber,[]);
temperatures = reshape(temperatures,readingnumber,[]);
names = reshape(data.Target,readingnumber,[]);
wells = reshape(data.WellPosition,readingnumber,[]);

LC = GrabChannel(fluordata,names(1,:),"LCGR");
LCtemp = GrabChannel(temperatures,names(1,:),"LCGR");
LCderiv = GrabChannel(meltderiv,names(1,:),"LCGR");

TXR = GrabChannel(fluordata,names(1,:),"TXR");
TXRtemp = GrabChannel(temperatures,names(1,:),"TXR");
TXRderiv = GrabChannel(meltderiv,names(1,:),"TXR");

figure
hold on
yyaxis left
plot(TXRtemp,TXR,Marker="none")
yyaxis right
plot(TXRtemp,TXRderiv,Marker="none")

figure
hold on
yyaxis left
plot(LCtemp,LC,Marker="none")
yyaxis right
plot(LCtemp,LCderiv,Marker="none")



%% Loop
maxstorage = zeros(10,length(LCtemp(1,:)));
cleanedstorage = zeros(readingnumber,length(LCtemp(1,:)));
for sample = 1:length(LCtemp(1,:))
    x= LCtemp(:,sample);
    y =LC(:,sample);
    deriv = LCderiv(:,sample);

    % figure
    % hold on
    % plot(x,deriv)

    safefitting = 100;
    cleanerindex = 60;
    fitfunc = @(a,b,c,x) a*exp(-b*x-c);
    fitx = x(x<safefitting);
    fity = deriv(x<safefitting);
    modifiedexp = fittype(fitfunc,'independent',{'x'});
    f = fit(fitx,fity,'exp1');
    % plot(f)

    f1data = feval(f,x);
    cleanedderiv1 = deriv-f1data;
    % figure
    % plot(x,cleanedderiv1)
    stddev = std(cleanedderiv1(x<cleanerindex));

    I = abs(cleanedderiv1) > 1.5*stddev; 
    outliers = excludedata(x,deriv,'indices',I);


    fit2 = fit(x,deriv,'exp1','Exclude',outliers);

    % figure
    % hold on
    % plot(x,deriv)
    % plot(fit2)
    cleanedderiv2 = deriv-feval(fit2,x);

    % figure
    % hold on
    % plot(x,cleanedderiv2)
    % title(wells(1,sample))
    cleanedstorage(:,sample) = cleanedderiv2;
    sampfrequency = mean(x(2:length(x))-x(1:length(x)-1));
    degreeseparation = 2;
    separation = degreeseparation/sampfrequency;
    mintemp = 71; % represents the starting temp at which possible Tm's will be grabbed 
    maxindices = islocalmax(cleanedderiv2,MinProminence=3000,MinSeparation=separation);
    maxstorage(:,sample) = paddata(x(and(x>mintemp,maxindices)),10);
end

%% Write to File
wellforfile = wells(1,:);
namesforfile = names(1,:);
cellsforfile = cell(readingnumber+2,length(wellforfile)*2);
maxforfile = cell(10+2,length(wellforfile));

for i = 1:length(namesforfile)
    startindex = 2*(i-1)+1;
    cellsforfile(1,startindex:startindex+1) = namesforfile(i);
    cellsforfile(2,startindex:startindex+1) = wellforfile(i);
    %cellsforfile(2,startindex+1) = wellforfile(i);
    cellsforfile(3:readingnumber+2,startindex) = num2cell(temperatures(:,i));
    cellsforfile(3:readingnumber+2,startindex+1) = num2cell(cleanedstorage(:,i));
    maxforfile(1,i) = namesforfile(i);
    maxforfile(2,i) = wellforfile(i);
    maxforfile(3:10+2,i) = num2cell(maxstorage(:,i));
end

newfilename = strcat("background subtracted ", sheetname);

writecell(cellsforfile,newfilename)
writecell(maxforfile,newfilename,Sheet=2)