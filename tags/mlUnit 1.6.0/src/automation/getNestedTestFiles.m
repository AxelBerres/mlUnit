function suitespecs = getNestedTestFiles(basedir)
% GETNESTEDTESTFILES Return a list of all test_*.m files in all subdirectories.
%
% GETNESTEDTESTFILES(BASEDIR) returns a list of all test_*.m files in
% BASEDIR.
%
% The return value is a cell array of structures. Each structure contains:
%     testname the name of the found test file
%     fulldir  the absolute path of the containing directory
%     reldir   the relative path of the containing directory, set back
%              against the basedir input argument

%  $Author$
%  $Id$

   % get list of directories
   dirstring = genpath(basedir);
   dirlist = textscan(dirstring, '%s', 'Delimiter', ';');
   dirlist = dirlist{1};
   
   % build relative dir name for each directory name
   reldirlist = strrep(dirlist, basedir, '');     % crop basedir
   
   % search pattern
   search_prefix = 'test_';
   search_suffix = '.m';
   
   suitespecs = [];
   
   % get files from each directory
   for iDir = 1:numel(dirlist)
      % get list of test files
      files = dir(dirlist{iDir});
      ids = strmatch(search_prefix, {files.name});
      tests = {files(ids).name};
      
      for iFile = 1:numel(tests)
         [path name ext] = fileparts(tests{iFile});
         if strcmp(ext, search_suffix)
            
            spec = struct();
            spec.testname = name;
            spec.reldir = reldirlist{iDir};
            spec.fulldir = dirlist{iDir};

            suitespecs{end+1} = spec;
         end
      end
   end