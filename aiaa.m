%Airfoil awesomeness
%Author: Arun Surath

%Declare the structure to hold our "useful" airfoils
usefulFoils = struct;

%get all files in the current working directory
files = dir('*.txt');
data = struct;

%loop over all the files
for file = files'
   %create a new field in the data structure with the values of the polar using importdata
   %the regular expression replace and strcat make sure we produce a valid unique property name
   data = setfield(data, strcat('f', regexprep(file.name, '[^a-zA-Z0-9]', '')), importdata(file.name, ' ', 12));
end

%make a new array with all of the property names we just created
sNames = fieldnames(data);

%loop over those names
for loopIndex = 1:numel(sNames)
    %if the property has a polar correctly loaded into it then continue
    if(isa(data.(sNames{loopIndex}), 'struct'))
	%load informtion about the current polar from the loop into temporary array variables
        currentPolar = data.(sNames{loopIndex});
        currentData = currentPolar.data;
        currentDataSize = size(currentData);
        
	%only check airfoils whos simulations covereged for all 14 alphas
        if(currentDataSize(1) == 14)
            moments = currentData(:, 5);
            moment = max(abs(moments));
	    %if the maximum moment is less than 0.05 from 0 then continue
            if(moment < 0.05)
                %calculate cl over cd
		cdl = currentData(:, 2) ./ currentData(:, 3);
                
		%find the index for the maximum cl (stall point)
		stall = find(currentData(:, 2) == max(currentData(:, 2)));
                maxcdl = find(cdl == max(cdl));
	
		%if the stall angle is greater than 9 degrees then add the airfoil to the usefulFoils structure
                if(stall > 9) 
                    usefulFoils =  setfield(usefulFoils, sNames{loopIndex}, [stall maxcdl max(cdl) moment]);
                end
        
	    end
        end
        
    end
end


%This last part I copypasta'd off of stackover flow and just modified it a little bit but don't really understand it but it works
%It takes the usefulFoils structure and saves it to a file in a relatively decent looking way
%// Extract field data
fields = repmat(fieldnames(usefulFoils), numel(usefulFoils), 1);
values = struct2cell(usefulFoils);

%// Convert all numerical values to strings
idx = cellfun(@isnumeric, values); 
values(idx) = cellfun(@num2str, values(idx), 'UniformOutput', 0);

%// Combine field names and values in the same array
C = {fields{:}; values{:}};

%// Write fields to SSV file
fid = fopen('aiaa.csv', 'wt');
fmt_str = repmat('%s\n', 1, size(C, 2));
fprintf(fid, [fmt_str(1:end - 1), '\n'], C{:});
fclose(fid);

