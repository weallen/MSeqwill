classdef chipSeqData
    %CHIPSEQDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hdf5_file;
        windows;
        chr_range;
        dsets;
        dset_sizes;
        scale_factor;
    end
    
    methods
        function obj = chipSeqData(hdf5fname)
            if (nargin > 0)
                obj.hdf5_file = hdf5fname;
                [obj.windows, obj.chr_range] = loadWindows(hdf5fname);
                obj.dsets = containers.Map;
                obj.dset_sizes = containers.Map;
                obj.scale_factor = 1;
            end
        end
        
        function foo = loadDataSet(obj, dset_name)
            dset_path = strcat('/seqdata/', dset_name);
            obj.dsets(dset_name) = hdf5read(obj.hdf5_file, dset_path);
            obj.dset_sizes(dset_name) = sum(obj.dsets(dset_name));
        end
        
        function foo = setScaleFactor(obj, scale_factor)
            obj.scale_factor = scale_factor;
        end
        
        function all_data = getAllData(obj, dsetnames)
            tot_len = 0;
            for i=1:20
                tot_len = tot_len + obj.getChrLen(i);
            end
            all_data = zeros(length(dsetnames), tot_len);
            for i=1:20
                curr_data = obj.getDataByChr(i, dsetnames);
                all_data(:,obj.chr_range(i,1):obj.chr_range(i,2)) = curr_data;
            end
        end
        
        function chr_len = getChrLen(obj, chr)
            chr_len = ceil((obj.chr_range(chr,2) - obj.chr_range(chr, 1)) / obj.scale_factor) + 1;
        end
        
        function chr_data = getDataByChr(obj, chr, dsetnames)
            chr_data = zeros(length(dsetnames), obj.getChrLen(chr));
            for i=1:length(dsetnames)
                curr_data = obj.getRawDataByChr(chr, dsetnames{i});
                chr_data(i,:) = 10^6 * reduceResolution(curr_data, obj.scale_factor) / obj.dset_sizes(dsetnames{i});
            end
        end

         
        function data = getDataByRange(obj, dsetname, chr, start, stop)
            if isKey(obj.dsets, dsetname)
            end
        end
        
        function chr_data = getRawDataByChr(obj, chr, dsetname)
            assert(chr <= 20 && chr > 0);
            if isKey(obj.dsets, dsetname)
                dset = obj.dsets(dsetname);
                rng = obj.chr_range(chr,:);
                chr_data = dset(rng(1):rng(2));
            end
        end 
    end
end

