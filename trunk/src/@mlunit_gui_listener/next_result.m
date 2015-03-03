%Update display with next test case result.
%  SELF = next_result(SELF, RESULT) notifies the listener of a completed test
%  run, providing it with the result. SELF is a mlunit_gui_listener instance.
%  RESULT is the test result as returned by run_test().
%
%  This method is provided by the user, but should not be called by her.
%
%  See also init_results, run_test

%  This Software and all associated files are released unter the 
%  GNU General Public License (GPL), see LICENSE for details.
%  
%  $Id$

function self = next_result(self, result)

self.num_results = self.num_results + 1;

% consolidate errors into single string
msg_and_stack_list = cellfun(@get_message_with_stack, result.errors, 'UniformOutput', false);
errmessages = mlunit_strjoin(msg_and_stack_list, sprintf('\n'));

if ~isempty(errmessages)
    self.num_errors = self.num_errors + 1;
    add_to_errorlist(self, 'ERROR', result.name, errmessages);
end

if ~isempty(result.failure)
    self.num_failures = self.num_failures + 1;
    add_to_errorlist(self, 'FAIL', result.name, result.failure);
end

update_display(self);