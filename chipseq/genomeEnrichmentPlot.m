function foo = genomeEnrichmentPlot( chipseqdata, dset_names, scale_fac)
%GENOMEENRICHMENT Summary of this function goes here
%   dsets = cell array of N dataset names
    [part_data, sizes] = partitionDataAndScale(chipseqdata, dset_names, scale_fac);
    for chr=1:20
        for j=1:length(dset_names)
            part_data{chr}(j,:) =  10^6 * part_data{chr}(j,:) / sizes(j);
        end
    end
    foo = part_data;
    max_chr_size = 0;
    for chr=1:20
        chr_len = length(part_data{chr});
        if chr_len > max_chr_size
            max_chr_size = chr_len;
        end
    end
    h = figure;
    set(gcf,'PaperUnits','inches');
    x_size = 60; y_size = 40;
    for chr=1:20
        subplot(20,1, chr);
        h = axes('Position', [0 chr/x_size length(part_data{chr})/max_chr_size 1]);
        imagesc(part_data{chr}(:,:));
      %  axis off;
    end
    saveas(h, '~/Documents/Neuroscience/barnea_lab/rna_seq_experiment/stavros_chip/all_chr.pdf');
end

% sizes is total size of each dataset before partitioning and scaling
function [partitioned_data, sizes] = partitionDataAndScale(chipseqdata, dset_names, scale_fac)
    sizes = zeros(1, length(dset_names));
    partitioned_data = cell(1,20);
    num_dsets = length(dset_names);
    for i=1:num_dsets
        name = dset_names{i};
        sizes(i) = chipseqdata.dset_sizes(name);
    end
    for chr=1:20
        for i=1:num_dsets
            chr_data = reduceResolution(chipseqdata.getDataByChr(chr, dset_names{i}), scale_fac);
            if isempty(partitioned_data{chr})
                partitioned_data{chr} = zeros(num_dsets, length(chr_data));
            end
            partitioned_data{chr}(i, :) = chr_data;
        end
    end
end