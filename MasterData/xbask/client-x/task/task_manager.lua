local var_0_0 = lx
local var_0_1 = packet
local var_0_2 = type
local var_0_3 = assert
local var_0_4 = tostring
local var_0_5 = string.format
local var_0_6 = lx.task_event

lx.define_class("task_manager", function(arg_1_0)
	function arg_1_0:init(arg_2_1)
		var_0_3(var_0_2(arg_2_1) == "function")
		var_0_3(not self._on_init_funish_func)

		self._on_init_funish_func = arg_2_1

		self:__req_is_already()
		var_0_0.set_task_msg_func(self._wrap_on_task_msg)
	end

	function arg_1_0:registerMsgFunc(arg_3_1, arg_3_2)
		if self._msgtype_handle_set[arg_3_1] then
			var_0_0.error(var_0_5("on registerMsgFunc, but msgtype already register. msgtype:[%s]", var_0_4(arg_3_1)))
		end

		self._msgtype_handle_set[arg_3_1] = arg_3_2
	end

	function arg_1_0.sendMsg(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = var_0_1.core_x_msg()

		var_0_1.settype(var_4_0, arg_4_1)
		var_0_1.encode(var_4_0, arg_4_2)
		var_0_0.send_msg_to_task(var_4_0)
	end

	function arg_1_0:__req_is_already()
		self:sendMsg(var_0_6.REQ_IS_READY, {})
	end

	function arg_1_0:__event_on_res_is_ready()
		self._on_init_funish_func()
	end

	function arg_1_0:__on_task_msg(arg_7_1, arg_7_2)
		local var_7_0 = var_0_1.gettype(arg_7_2)

		if not self._msgtype_handle_set[var_7_0] then
			var_0_0.error(var_0_5("on task msg, but not find msgtype func, msgtype:[%s]", var_0_4(var_7_0)))
		end

		self._msgtype_handle_set[var_7_0]((var_0_1.decode(arg_7_2)))
	end

	function arg_1_0:__reinit_func()
		self._msgtype_handle_set = {}
		self._msgtype_handle_set[var_0_6.RES_IS_READY] = function(...)
			self:__event_on_res_is_ready(...)
		end
	end
end)

return function()
	local var_10_0 = var_0_0.class("task_manager")

	var_10_0._on_init_funish_func = nil
	var_10_0._msgtype_handle_set = nil

	function var_10_0._wrap_on_task_msg(...)
		var_10_0:__on_task_msg(...)
	end

	var_10_0:__reinit_func()

	return var_10_0
end
