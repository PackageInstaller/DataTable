local var_0_0 = lx
local var_0_1 = lx_core_x
local var_0_2 = lx.import
local var_0_3 = xpcall
local var_0_4 = tostring
local var_0_5 = string.format
local var_0_6 = debug.traceback
local var_0_7 = lx.runtime_profiler
local var_0_8 = lx.message_profiler
local var_0_9 = lx.bootstrap_manager
local var_0_10 = lx.sub_packet_manager
local var_0_11 = lx.monitor_report
local var_0_12 = lx.task_manager
local var_0_13 = lx.install_manager
local var_0_14 = lx.patch_manager
local var_0_15 = lx.engine_instance
local var_0_16 = lx.ServerTime
local var_0_17 = lx.BaseNetworkManager
local var_0_18 = lx.QueueLoader
local var_0_19 = lx.platform

lx.define_class("main_app", function(arg_1_0)
	function arg_1_0.install(arg_2_0, arg_2_1)
		var_0_13:install(arg_2_1)
	end

	function arg_1_0:launch(arg_3_1)
		if not self._launching then
			var_0_0.error("why already do start!")
		end

		var_0_9:launch()
		var_0_14:start(arg_3_1)
	end

	function arg_1_0:downloadSubPacket(arg_4_1, arg_4_2)
		if self._launching then
			var_0_0.error("why is launching!")
		end

		var_0_14:startSubPacket(arg_4_1, arg_4_2)
	end

	function arg_1_0:start()
		if not self._launching then
			var_0_0.error("why already do start!")
		end

		if not var_0_9:tryStart() then
			if not self._script_module.reset() then
				var_0_0.error("reset script module failed!")
			end

			self._need_reset = true

			var_0_0.hotUpdateAll()

			return
		end

		self._launching = false

		if not self._script_module.init(self._import_func) then
			var_0_0.error("init script module failed!")
		end

		if not self._script_module.start(self._import_func) then
			var_0_0.error("start script module failed!")
		end
	end

	function arg_1_0:restart()
		self._launching = true

		if not self._script_module.reset() then
			var_0_0.error("reset script module failed!")
		end

		self._need_reset = true

		var_0_0.hotUpdateAll()
	end

	function arg_1_0.getSystem(arg_7_0)
		return var_0_9
	end

	function arg_1_0.getSubPacketManager(arg_8_0)
		return var_0_10
	end

	function arg_1_0.getMonitorReport(arg_9_0)
		return var_0_11
	end

	function arg_1_0.isPC(arg_10_0)
		return var_0_9:isPC()
	end

	function arg_1_0.enableUpdateProgressLog(arg_11_0, arg_11_1)
		var_0_14:enableUpdateProgressLog(arg_11_1)
	end

	function arg_1_0.getNotice(arg_12_0)
		return var_0_14:getNotice()
	end

	function arg_1_0:eventOnInit()
		lxnet.init(512, 1, 32768, 64, 2, 16, 1)
		var_0_0.add_do_hot_update_prefix("xbask/")
		var_0_0.add_do_hot_update_prefix("script/")
		var_0_0.http_request_manager:enableHostIPCache(false)
		var_0_1.start_task_thread(33, 16, 16384)
		self:__event_on_init()
	end

	function arg_1_0.eventOnExit(arg_14_0)
		var_0_15:eventOnExit()
		var_0_0.reset_instance()
		var_0_0.ldb.destroy()
		lxnet.release()
		log.writelog("destroy")
	end

	function arg_1_0:eventOnRunning(arg_15_1)
		var_0_15:eventOnRunning(arg_15_1)
		var_0_16:run_once()
		var_0_17:run_once()
		var_0_18:run_once()

		if not self._launching then
			var_0_7:on_begin("logic_script")
			self:__script_module__run_once(arg_15_1)
			var_0_7:on_end("logic_script")
		end
	end

	function arg_1_0.eventFrameOverElapsed(arg_16_0, arg_16_1)
		var_0_1.elapsed_writelog(var_0_5("\n{run once need:[%s]\n%s\n\n" .. "\n\ncurrent frame profiler info:\n{\n%s}\n" .. "\n\nnetwork netdata allinfo:\n%s\nnetwork memory info:\n%s\nmemory info:\n%s\n" .. "}\n\n", var_0_4(arg_16_1), var_0_7:getProfilerInfo(), var_0_8:getCurrentFrameProfilerInfo(), var_0_0.json_format(lxnet.get_netdata_info()), var_0_0.json_format(lxnet.get_memory_info()), var_0_0.json_format(lx_node_x.get_objectpool_meminfo())))
	end

	function arg_1_0:eventOnHotUpdate()
		var_0_15:eventOnHotUpdate()
		var_0_17:eventOnHotUpdate()
		self:__hot_update()
	end

	function arg_1_0.__event_on_init(arg_18_0)
		var_0_15:eventOnInit()
		var_0_15:eventOnStart()
		var_0_12:init(function()
			arg_18_0:__event_on_init_finish()
		end)
	end

	function arg_1_0:__event_on_init_finish()
		_G.app = self

		var_0_9:init()
		var_0_13:init()
		log.clear_old_log(3)
		var_0_19:init()
		self:__script_load_module()
		self:__launch()
	end

	function arg_1_0:__launch()
		if not self._script_module.launch(self._import_func) then
			var_0_0.error("launch script module failed!")
		end
	end

	function arg_1_0:__script_module__run_once(arg_22_1)
		local var_22_0, var_22_1 = var_0_3(self._script_module.run_once, var_0_6, arg_22_1)

		if not var_22_0 then
			log.errorlog(var_22_1)
		end
	end

	function arg_1_0:__hot_update()
		self:__check_reset()
		self:__script_load_module()

		if not self._script_module.launch(self._import_func) then
			return false
		end

		if not self._launching then
			return self._script_module.init(self._import_func)
		end

		return true
	end

	function arg_1_0:__script_load_module()
		function self._import_func(arg_25_0)
			return var_0_2(arg_25_0, "script/")
		end

		self._script_module = require("script/init")

		if type(self._script_module) ~= "table" then
			var_0_0.error(var_0_5("require the module, need table type, path:[%s]", "script/init"))
		end
	end

	function arg_1_0:__check_reset()
		if not self._need_reset then
			return
		end

		self._need_reset = false
	end
end, "bind_object")

return function()
	local var_27_0 = var_0_0.class("main_app", var_0_0.bind_object:inherit())

	var_27_0._launching = true
	var_27_0._need_reset = false
	var_27_0._import_func = nil
	var_27_0._script_module = nil

	return var_27_0
end
