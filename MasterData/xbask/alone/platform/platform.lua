local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = tostring

lx.define_class("platform", function(arg_1_0)
	function arg_1_0:init()
		self:registerTaskTypeFunc("getExternalFilesDir", function(arg_3_0, arg_3_1)
			self:findTaskRegisterInfo(arg_3_0).result = arg_3_1
		end)

		function _G.getExternalWritePath()
			var_0_0.platform:doTask("getExternalFilesDir")

			local var_4_0 = self:findTaskRegisterInfo("getExternalFilesDir")
			local var_4_1 = var_4_0.result

			var_4_0.result = nil
			var_4_1 = var_4_1 and var_4_1 .. "/"

			return var_4_1 or var_0_0.bootstrap_manager:getWritePath()
		end

		if app:isPC() then
			return
		end

		if app:getSystem():getOSType() == "android" then
			self:registerTaskTypeFunc("exit_self_process_android")

			function _G.exit_self_process_android()
				var_0_0.platform:doTask("exit_self_process_android")
			end

			self:registerTaskTypeFunc("openFileByType")

			function _G.openFileByType(arg_6_0)
				var_0_0.platform:doTask("openFileByType", arg_6_0)
			end
		end
	end

	function arg_1_0:registerTaskTypeFunc(arg_7_1, arg_7_2)
		var_0_2(var_0_1(arg_7_1) == "string")
		var_0_2(arg_7_2 == nil or var_0_1(arg_7_2) == "function")
		var_0_2(not self:__findTaskRegisterInfo(arg_7_1), "already register, task type:" .. arg_7_1)
		self:__realRegisterTaskTypeFunc(arg_7_1, arg_7_2)
	end

	function arg_1_0:doTask(arg_8_1, arg_8_2)
		var_0_2(self:__findTaskRegisterInfo(arg_8_1), "not register, task type:" .. var_0_3(arg_8_1))
		var_0_2(arg_8_2 == nil or var_0_1(arg_8_2) == "string")

		arg_8_2 = arg_8_2 or ""

		self:__realDoTask(arg_8_1, arg_8_2)
	end

	function arg_1_0:findTaskRegisterInfo(arg_9_1)
		return self:__findTaskRegisterInfo(arg_9_1)
	end

	function arg_1_0:__findTaskRegisterInfo(arg_10_1)
		return self._task_type_func_set[arg_10_1]
	end

	function arg_1_0:__realRegisterTaskTypeFunc(arg_11_1, arg_11_2)
		self._task_type_func_set[arg_11_1] = {
			task_type = arg_11_1,
			func = arg_11_2
		}
	end

	function arg_1_0.__realDoTask(arg_12_0, arg_12_1, arg_12_2)
		platform_task.execute(arg_12_1, arg_12_2)
	end

	function arg_1_0:__onTaskResult(arg_13_1, arg_13_2)
		local var_13_0 = self:__findTaskRegisterInfo(arg_13_1)

		if not var_13_0 then
			var_0_0.error("on task result, but not register, task type:" .. var_0_3(arg_13_1))
		end

		if var_13_0.func then
			var_13_0.func(arg_13_1, arg_13_2)
		end
	end
end)

return function()
	local var_14_0 = var_0_0.class("platform")

	var_14_0._task_type_func_set = {}

	platform_task.set_callback(function(...)
		var_14_0:__onTaskResult(...)
	end)

	return var_14_0
end
