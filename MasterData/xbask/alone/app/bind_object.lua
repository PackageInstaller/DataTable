local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = xpcall
local var_0_3 = debug.traceback
local var_0_4 = lxnet
local var_0_5 = packet
local var_0_6 = self_sleep
local var_0_7 = lx.Time
local var_0_8 = get_millisecond
local var_0_9 = lx_core_x.currentframetime
local var_0_10 = lx.http_request_manager
local var_0_11 = lx.runtime_profiler
local var_0_12 = lx.message_profiler

if raw_processinfo_get == nil then
	raw_processinfo_get = processinfo_get

	function _G.processinfo_get()
		local var_1_0 = raw_processinfo_get()

		return {
			cpu_num = var_1_0.cpu_num,
			thread_num = var_1_0.thread_num,
			cpu = {
				current = var_1_0.cpu_current,
				max = var_1_0.cpu_max,
				max_time = var_0_7:getDateString(var_1_0.cpu_max_time)
			},
			memory = {
				current = var_1_0.memory_current,
				max = var_1_0.memory_max,
				max_time = var_0_7:getDateString(var_1_0.memory_max_time)
			},
			virtual_memory = {
				current = var_1_0.vm_current,
				max = var_1_0.vm_max,
				max_time = var_0_7:getDateString(var_1_0.vm_max_time)
			},
			system_cpu = {
				current = var_1_0.system_cpu_current,
				max = var_1_0.system_cpu_max,
				max_time = var_0_7:getDateString(var_1_0.system_cpu_max_time)
			}
		}
	end
end

lx.define_class("bind_object", function(arg_2_0)
	function arg_2_0.eventOnInit(arg_3_0)
		var_0_1.error("need override this method")
	end

	function arg_2_0.eventOnExit(arg_4_0)
		var_0_1.error("need override this method")
	end

	function arg_2_0.eventOnRunning(arg_5_0, arg_5_1)
		var_0_1.error("need override this method")
	end

	function arg_2_0.eventFrameOverElapsed(arg_6_0, arg_6_1)
		var_0_1.error("need override this method")
	end

	function arg_2_0.eventOnHotUpdate(arg_7_0)
		var_0_1.error("need override this method")
	end

	function arg_2_0:__event_on_init()
		var_0_12:init(lx_core_x.get_log_dir(), "info")
		self:eventOnInit()
	end

	function arg_2_0:__event_on_exit()
		self:eventOnExit()
	end

	function arg_2_0.__event_on_run_begin(arg_10_0)
		local var_10_0 = var_0_9()

		arg_10_0._time_run_begin = var_10_0

		var_0_7:run_once(var_10_0)
		var_0_11:reset()
		var_0_11:on_begin("all")
		var_0_12:on_frame_begin()
	end

	function arg_2_0:__event_on_running()
		var_0_11:on_begin("running")

		local var_11_0 = var_0_9()

		var_0_11:on_begin("lxnet")
		var_0_4.run()
		var_0_11:on_end("lxnet")
		var_0_11:on_begin("ldb")
		var_0_1.ldb.debug_run_once()
		var_0_11:on_end("ldb")
		var_0_11:on_begin("http")
		var_0_10:run_once(var_11_0)
		var_0_11:on_end("http")
		var_0_11:on_begin("bind_object")
		self:eventOnRunning(var_11_0)
		var_0_11:on_end("bind_object")
		var_0_12:run_once(var_11_0)
		var_0_11:on_begin("processinfo")

		self._process_last_update_time = self._process_last_update_time or 0

		if var_11_0 > self._process_last_update_time + 300 then
			self._process_last_update_time = var_11_0

			processinfo_update()
		end

		var_0_11:on_end("processinfo")
		var_0_11:on_end("running")
	end

	function arg_2_0:__event_on_run_end()
		local var_12_0 = var_0_9()

		var_0_7:run_once(var_12_0)
		var_0_11:on_end("all")

		if var_12_0 - self._time_run_begin < self._frame_time then
			var_0_6(self._frame_time - (var_12_0 - self._time_run_begin))
		elseif var_12_0 - self._time_run_begin > self._super_frame_time then
			self:eventFrameOverElapsed(var_12_0 - self._time_run_begin)
		end
	end

	function arg_2_0:__event_on_task_msg(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		var_0_5.begin(arg_13_2)

		local var_13_0, var_13_1 = var_0_2(self._handler_task_msg_func, var_0_3, "", arg_13_2)

		if not var_13_0 then
			log.errorlog(var_13_1)
		end
	end

	function arg_2_0:__task_event_on_init()
		self:eventOnInit()
	end

	function arg_2_0:__task_event_on_exit()
		self:eventOnExit()
	end

	function arg_2_0:__task_event_running()
		local var_16_0 = var_0_8()

		var_0_7:run_once(var_16_0)
		var_0_1.ldb.debug_run_once()
		var_0_10:run_once(var_16_0)
		self:eventOnRunning(var_16_0)
	end

	function arg_2_0:__task_event_on_msg(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		var_0_5.begin(arg_17_2)
		self._handler_main_msg_func(arg_17_2)
	end

	function arg_2_0:reinitEventFunc()
		local var_18_0 = {
			EventType_RunEnd = 5,
			EventType_Running = 4,
			EventType_TaskMsg = 19,
			EventType_Exit = 2,
			EventType_RunBegin = 3,
			EventType_Init = 1
		}

		if var_0_1.is_main_thread() then
			function var_0_1.on_hot_update()
				self:eventOnHotUpdate()
			end

			self._event_obj:registerEventFunc(var_18_0.EventType_Init, self.__event_on_init)
			self._event_obj:registerEventFunc(var_18_0.EventType_Exit, self.__event_on_exit)
			self._event_obj:registerEventFunc(var_18_0.EventType_RunBegin, self.__event_on_run_begin)
			self._event_obj:registerEventFunc(var_18_0.EventType_Running, self.__event_on_running)
			self._event_obj:registerEventFunc(var_18_0.EventType_RunEnd, self.__event_on_run_end)
			self._event_obj:registerEventFunc(var_18_0.EventType_TaskMsg, self.__event_on_task_msg)

			function var_0_1.send_msg_to_task(arg_20_0)
				lx_core_x.create_task(arg_20_0)
			end

			function var_0_1.set_task_msg_func(arg_21_0)
				self._handler_task_msg_func = arg_21_0
			end

			self._frame_time = 0
			self._super_frame_time = 200
		else
			self._event_obj:registerEventFunc(var_18_0.EventType_Init, self.__task_event_on_init)
			self._event_obj:registerEventFunc(var_18_0.EventType_Exit, self.__task_event_on_exit)
			self._event_obj:registerEventFunc(var_18_0.EventType_Running, self.__task_event_running)
			self._event_obj:registerEventFunc(var_18_0.EventType_TaskMsg, self.__task_event_on_msg)

			function var_0_1.send_msg_to_main(arg_22_0)
				lx_core_x.create_task_result(arg_22_0)
			end

			function var_0_1.set_main_msg_func(arg_23_0)
				self._handler_main_msg_func = arg_23_0
			end

			self._frame_time = 16
			self._super_frame_time = 200
		end
	end
end)

function var_0_0.inherit(arg_24_0)
	local var_24_0 = var_0_1.class("bind_object")

	var_24_0._time_run_begin = nil
	var_24_0._frame_time = nil
	var_24_0._super_frame_time = nil
	var_24_0._process_last_update_time = 0
	var_24_0._event_obj = var_0_1.event_dispatch:create(lx_core_x.instance())

	var_24_0._event_obj:setCoreArg(var_24_0)

	return var_24_0
end

return var_0_0
