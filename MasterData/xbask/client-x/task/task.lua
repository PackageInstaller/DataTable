local var_0_0 = lx
local var_0_1 = packet
local var_0_3 = string.format
local var_0_4 = lx.task_event

lx.define_class("task", function(arg_1_0)
	function arg_1_0:init()
		var_0_0.set_main_msg_func(self._wrap_on_task_manager_msg)
	end

	function arg_1_0:registerMsgFunc(arg_3_1, arg_3_2)
		if self._msgtype_handle_set[arg_3_1] then
			var_0_0.error(var_0_3("on registerMsgFunc, but msgtype already register. msgtype:[%s]", tostring(arg_3_1)))
		end

		self._msgtype_handle_set[arg_3_1] = arg_3_2
	end

	function arg_1_0.sendMsg(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = var_0_1.core_x_msg()

		var_0_1.settype(var_4_0, arg_4_1)
		var_0_1.encode(var_4_0, arg_4_2)
		var_0_0.send_msg_to_main(var_4_0)
	end

	function arg_1_0:__event_on_req_is_ready()
		self:sendMsg(var_0_4.RES_IS_READY, {})
	end

	function arg_1_0:__on_task_manager_msg(arg_6_1)
		local var_6_0 = var_0_1.gettype(arg_6_1)

		if not self._msgtype_handle_set[var_6_0] then
			var_0_0.error(var_0_3("on task manager msg, but not find msgtype func, msgtype:[%s]", tostring(var_6_0)))
		end

		self._msgtype_handle_set[var_6_0]((var_0_1.decode(arg_6_1)))
	end

	function arg_1_0:__reinit_func()
		self._msgtype_handle_set = {}
		self._msgtype_handle_set[var_0_4.REQ_IS_READY] = function(...)
			self:__event_on_req_is_ready(...)
		end
	end
end)

return function()
	local var_9_0 = var_0_0.class("task")

	var_9_0._msgtype_handle_set = nil

	function var_9_0._wrap_on_task_manager_msg(...)
		return var_9_0:__on_task_manager_msg(...)
	end

	var_9_0:__reinit_func()

	return var_9_0
end
