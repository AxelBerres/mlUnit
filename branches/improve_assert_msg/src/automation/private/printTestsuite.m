function report = printTestsuite(suiteresult)
% PRINTTESTSUITE Return the result of a test suite as printable string.
%
% Input argument suiteresult is a structure of these fields:
%  name           the package name of the test suite
%  errors         the number of errors
%  failures       the number of failures
%  tests          the number of executed tests
%  time           the time used for executing the tests
%  testcaseList   a list of all testcases with specific information

%  This Software and all associated files are released unter the 
%  GNU General Public License (GPL), see LICENSE for details.
%  
%  $Author$
%  $Id$

   report = sprintf('Running %s', suiteresult.name);

   if suiteresult.failures || suiteresult.errors
      report = [report ' <<< FAILED'];
      
      for tc=1:numel(suiteresult.testcaseList)
         testcase = suiteresult.testcaseList{tc};
         report = [report printTestcase(testcase)];
      end
   end


%% Return the result of a failed test case as printable string
% List of testcase fields:
%     .name       the test case name
%     .classname  the name of the class/package, constructed from the
%                 relative path name and the test suite file name
%     .error      a description of its error. [] if no error.
%     .failure    a description of its failure. [] if no failure.
%     (.time)     the time used. Not supported.
function report = printTestcase(testcase)

   report = '';

   if ~isempty(testcase.error)
      report = [report sprintf('\n  Test %s reported error: %s', testcase.name, testcase.error)];
   end
   
   if ~isempty(testcase.failure)
      report = [report sprintf('\n  Test %s reported failure: %s', testcase.name, testcase.failure)];
   end
