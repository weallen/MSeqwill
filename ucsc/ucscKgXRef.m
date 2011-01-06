classdef ucscKgXRef
    %UCSCKGXREF Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        srcfile;
        kg_id;
        mrna;
    end
    
    methods
        function obj = ucscKgXRef(srcfile)
            if (nargin > 0)
                obj.srcfile = srcfile;
            end
        end
    end
    
end

