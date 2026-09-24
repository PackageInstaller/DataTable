local var_0_0 = lx

lx.define_class("engine_instance", function(arg_1_0)
	function arg_1_0.eventOnInit(arg_2_0)
		var_0_0.error("need override this method")
	end

	function arg_1_0.eventOnStart(arg_3_0)
		var_0_0.error("need override this method")
	end

	function arg_1_0.eventOnExit(arg_4_0)
		var_0_0.error("need override this method")
	end

	function arg_1_0.eventOnRunning(arg_5_0, arg_5_1)
		var_0_0.error("need override this method")
	end

	function arg_1_0.eventOnHotUpdate(arg_6_0)
		var_0_0.error("need override this method")
	end

	var_0_0.extend_method(arg_1_0)
end)

return function()
	local var_7_0 = var_0_0.class("engine_instance")

	var_0_0.extend_obj(var_7_0)

	return var_7_0
end
