function reduced = reduceResolution( chip_data, scale_factor)
    red_len = ceil(length(chip_data) / scale_factor);
    reduced = zeros(1, red_len);
    for i=1:length(chip_data)
        red_idx = floor(i / scale_factor);
        reduced(red_idx) = reduced(red_idx) + chip_data(i);
    end
end

