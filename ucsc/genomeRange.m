classdef genomeRange
    %RANGEDDATATRACK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        chr;
        chr_start;
        chr_end;
    end
    
    methods
        function obj = genomeRange(chr, chr_start, chr_end)
            if (nargin > 0)
                obj.chr = chr;
                obj.chr_start = chr_start;
                obj.chr_end = chr_end;
            end
        end
    end
    
end

