classdef ucscKnownGene
    %UCSCANNOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        src_path;
        name;
        chrom;
        strand;
        tx;
        cds;
        exon_count;
        exons;
        protein_id;
        align_id;
    end
    
    methods
        function obj = ucscKnownGene(src_path)
            if (nargin > 0)
                obj.src_path = src_path;
            end
        end
        
        % exons is a 2D matrix [[start, end]; ...]
        function exons = getAllExons(obj)
        end
        
        % TSS is a 1D matrix of start pos
        function tss = getAllTSS(obj)
        end
        
        function tse = getAllTSE(obj)
        end
    end
    
end

