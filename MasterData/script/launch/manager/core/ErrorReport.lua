local var_0_0 = lx

lx.define_class("ErrorReport", function(arg_1_0)
	function arg_1_0:init(arg_2_1, arg_2_2)
		self._core:init(arg_2_1, arg_2_2)
		self._core:setInterval(5000)

		self._release = arg_2_2
	end

	function arg_1_0:isRelease()
		return self._core:isRelease()
	end

	function arg_1_0:setUserInfoFunc(arg_4_1)
		self._core:setUserInfoFunc(arg_4_1)
	end

	function arg_1_0:report(arg_5_1)
		self._core:report(arg_5_1)
	end

	function arg_1_0.wrapFunc(arg_6_0, arg_6_1)
		return function()
			local var_7_0, var_7_1 = xpcall(arg_6_1)

			if not var_7_0 then
				log.errorlog(var_7_1)
			end
		end
	end
end)

return function()
	local var_8_0 = var_0_0.class("ErrorReport")

	var_8_0._release = true
	var_8_0._core = app:getMonitorReport()

	return var_8_0
end
