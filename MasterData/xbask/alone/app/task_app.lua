local var_0_0 = lx

lx.define_class("task_app", function(arg_1_0)
	function arg_1_0.eventOnInit(arg_2_0)
		var_0_0.add_do_hot_update_prefix("xbask/")
		var_0_0.add_do_hot_update_prefix("script/")
		var_0_0.http_request_manager:enableHostIPCache(false)
		var_0_0.task:init()
	end

	function arg_1_0.eventOnExit(arg_3_0)
		var_0_0.reset_instance()
		var_0_0.ldb.destroy()
		log.writelog("destroy")
	end

	function arg_1_0.eventOnRunning(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0.eventFrameOverElapsed(arg_5_0, arg_5_1)
		return
	end

	function arg_1_0.eventOnHotUpdate(arg_6_0)
		return
	end
end, "bind_object")

return function()
	return (var_0_0.class("task_app", var_0_0.bind_object:inherit()))
end
