function sorted = GrabChannel(data, names, keystring)
    samplenumber = sum(contains(names,keystring));
    sorted = zeros(length(data(:,1)),samplenumber);
    iterator = 1;
    for i = 1:length(data(1,:))
        if(contains(names{1,i},keystring))
            sorted(:, iterator) = data(:,i);
            iterator = iterator +1;
        end
    end
end