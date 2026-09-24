local var_0_0 = lx
local var_0_1 = assert
local var_0_2 = tostring
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = table.remove
local var_0_6 = table.concat
local var_0_7 = io.open
local var_0_8 = get_microsecond
local var_0_9 = lx.Time
local var_0_10 = "message_profiler.log"

lx.define_class("message_profiler", function(arg_1_0)
	function arg_1_0:init(arg_2_1, arg_2_2)
		self._root_path = arg_2_1 .. "profiler_log/" .. arg_2_2 .. "/"
		self._can_backup = self:__check_can_backup()
	end

	function arg_1_0:backup()
		if not self._can_backup then
			return false
		end

		self._can_backup = false

		return self:__backup_message_profiler()
	end

	function arg_1_0.setIntervalTime(arg_4_0, arg_4_1)
		if arg_4_1 < 1000 then
			arg_4_1 = 1000
		end

		arg_4_0._interval_write_log = arg_4_1
	end

	function arg_1_0:registerProcessorName(arg_5_1, arg_5_2)
		self._processor_name_set[arg_5_1] = arg_5_2
	end

	function arg_1_0.setNowProcessorName(arg_6_0, arg_6_1)
		if arg_6_1 == nil then
			var_0_1(arg_6_1 ~= nil)
		end

		arg_6_0._now_processor_name = arg_6_1
	end

	function arg_1_0.setMsgTypeNameFunc(arg_7_0, arg_7_1)
		var_0_1(type(arg_7_1) == "function")

		arg_7_0._get_msgtype_name_func = arg_7_1
	end

	function arg_1_0.setLogProfilerInfoFunc(arg_8_0, arg_8_1)
		var_0_1(type(arg_8_1) == "function")

		arg_8_0._log_profiler_info_func = arg_8_1
	end

	function arg_1_0:getCurrentFrameProfilerInfo()
		return self:__profiler_info_to_string(self._current_frame_profiler)
	end

	function arg_1_0:on_process_msg_begin(arg_10_1)
		self._now_msgtype = arg_10_1
		self._begin_time = var_0_8()

		local var_10_0 = self._current_frame_profiler_pools[arg_10_1]
		local var_10_1 = self._profiler_set[arg_10_1]

		if not self._profiler_set[arg_10_1] then
			var_10_1 = {
				total = self:__create_message_profiler_info(arg_10_1),
				list = {}
			}
			self._profiler_set[arg_10_1] = var_10_1

			var_0_1(not var_10_0)

			var_10_0 = {
				total = self:__create_message_profiler_info(arg_10_1),
				list = {}
			}
			self._current_frame_profiler_pools[arg_10_1] = var_10_0
		end

		self._current_frame_profiler[arg_10_1] = var_10_0
		var_10_1.current = var_10_0
		self._now_profiler = var_10_1
		self._now_processor_name = nil
	end

	function arg_1_0:on_process_msg_end(arg_11_1)
		if self._now_msgtype ~= arg_11_1 then
			var_0_0.error(var_0_3("msgtype error, param:%s, expect:%s", var_0_2(arg_11_1), var_0_2(self._now_msgtype)))
		end

		local var_11_0 = var_0_8() - self._begin_time
		local var_11_1 = self._now_processor_name or self._processor_name_set[arg_11_1]

		self:__update_message_profiler(self._now_profiler, var_11_0, var_11_1)
		self:__update_message_profiler(self._now_profiler.current, var_11_0, var_11_1)

		self._now_profiler.current = nil
		self._now_profiler = nil
	end

	function arg_1_0:on_frame_begin()
		self._wait_removed = self._wait_removed or {}

		for iter_12_0, iter_12_1 in pairs(self._current_frame_profiler) do
			var_0_4(self._wait_removed, iter_12_0)
		end

		while true do
			local var_12_0 = var_0_5(self._wait_removed, 1)

			if not var_12_0 then
				break
			end

			self._current_frame_profiler[var_12_0] = nil
		end

		for iter_12_2, iter_12_3 in pairs(self._current_frame_profiler_pools) do
			self:__reset__message_profiler_info(iter_12_3.total)

			for iter_12_4, iter_12_5 in pairs(iter_12_3.list) do
				self:__reset__message_profiler_info(iter_12_5)
			end
		end
	end

	function arg_1_0:run_once(arg_13_1)
		if arg_13_1 - self._last_log_time < self._interval_write_log then
			return
		end

		if self._last_log_time == 0 then
			self._last_log_time = arg_13_1

			return
		end

		self._last_log_time = arg_13_1

		local var_13_0 = self:__profiler_info_to_string(self._profiler_set)

		if self._log_profiler_info_func then
			self._log_profiler_info_func(var_13_0)
		else
			local var_13_1 = self:__open_log()

			var_13_1:write(var_0_3("[%s - %s] \n%s", self._start_time_str, var_0_9:getDateString(), var_13_0))
			var_13_1:close()
		end
	end

	function arg_1_0:__check_can_backup()
		local var_14_0 = io.open(self._root_path .. var_0_10, "r")

		if not var_14_0 then
			return false
		end

		var_14_0:close()

		return true
	end

	function arg_1_0:__backup_message_profiler()
		local var_15_0 = io.open(self._root_path .. var_0_10, "r")

		if not var_15_0 then
			return false
		end

		local var_15_1 = var_15_0:read("*line")

		var_15_0:close()

		local var_15_2 = var_15_1:match("^%[([^%]]+)%]")

		if not var_15_2 then
			return false
		end

		os.rename(self._root_path .. var_0_10, (self._root_path .. var_0_10) .. " " .. var_15_2:gsub(":", "-"))

		return true
	end

	function arg_1_0:__open_log()
		self._can_backup = false

		while true do
			local var_16_0 = var_0_7(self._root_path .. var_0_10, "w")

			if var_16_0 then
				return var_16_0
			end

			directory.mkdir(self._root_path)
		end
	end

	function arg_1_0.__create_message_profiler_info(arg_17_0, arg_17_1, arg_17_2)
		return {
			max_time = 0,
			on_max_utc_time = 0,
			time_total = 0,
			num_total = 0,
			msgtype = arg_17_1,
			processor_name = arg_17_2
		}
	end

	function arg_1_0.__reset__message_profiler_info(arg_18_0, arg_18_1)
		arg_18_1.num_total = 0
		arg_18_1.time_total = 0
		arg_18_1.max_time = 0
		arg_18_1.on_max_utc_time = 0
	end

	function arg_1_0.__update_message_profiler_info(arg_19_0, arg_19_1, arg_19_2)
		arg_19_1.num_total = arg_19_1.num_total + 1
		arg_19_1.time_total = arg_19_1.time_total + arg_19_2

		if arg_19_2 > arg_19_1.max_time then
			arg_19_1.max_time = arg_19_2
			arg_19_1.on_max_utc_time = var_0_9:getUtcTime()
		end
	end

	function arg_1_0:__update_message_profiler(arg_20_1, arg_20_2, arg_20_3)
		self:__update_message_profiler_info(arg_20_1.total, arg_20_2)

		if arg_20_3 then
			local var_20_0 = arg_20_1.list[arg_20_3]

			if not arg_20_1.list[arg_20_3] then
				var_20_0 = self:__create_message_profiler_info(arg_20_1.total.msgtype, arg_20_3)
				arg_20_1.list[arg_20_3] = var_20_0
			end

			self:__update_message_profiler_info(var_20_0, arg_20_2)
		end
	end

	function arg_1_0.__format_profiler_info(arg_21_0, arg_21_1, arg_21_2)
		return var_0_3("%sprocess num:%s, total elapsed time:%sus, every elapsed time:%.2fus, " .. "max elapsed time:%sus, max elapsed utc time:%s\n", arg_21_1, arg_21_2.num_total, arg_21_2.time_total, arg_21_2.time_total / arg_21_2.num_total, arg_21_2.max_time, var_0_9:getDateString(arg_21_2.on_max_utc_time))
	end

	function arg_1_0:__format_profiler_list(arg_22_1)
		local var_22_0 = 2
		local var_22_1 = {}

		var_0_4(var_22_1, "\t{\n")

		for iter_22_0, iter_22_1 in pairs(arg_22_1) do
			if iter_22_1.num_total > 0 then
				var_0_4(var_22_1, (var_0_3("\t\t%s:\n%s", iter_22_1.processor_name, self:__format_profiler_info("\t\t\t", iter_22_1))))

				var_22_0 = var_22_0 + 1
			end
		end

		var_0_4(var_22_1, "\t}\n")

		if var_22_0 == 2 then
			return ""
		end

		return var_0_6(var_22_1)
	end

	function arg_1_0:__profiler_info_to_string(arg_23_1)
		local var_23_0 = ""

		for iter_23_0, iter_23_1 in pairs(arg_23_1) do
			var_23_0 = var_0_3("%smsg type:%s, msg name:%s:\n%s%s", var_23_0, iter_23_1.total.msgtype, var_0_2(self._get_msgtype_name_func(iter_23_1.total.msgtype)), self:__format_profiler_info("\t", iter_23_1.total), (self:__format_profiler_list(iter_23_1.list)))
		end

		return var_23_0
	end
end)

return function()
	local var_24_0 = var_0_0.class("message_profiler")

	var_24_0._root_path = nil
	var_24_0._can_backup = false
	var_24_0._interval_write_log = 300000
	var_24_0._processor_name_set = {}
	var_24_0._start_time_str = var_0_9:getDateString()
	var_24_0._last_log_time = 0

	function var_24_0._get_msgtype_name_func(...)
		return "invalid function"
	end

	var_24_0._log_profiler_info_func = nil
	var_24_0._now_msgtype = nil
	var_24_0._begin_time = nil
	var_24_0._now_profiler = nil
	var_24_0._now_processor_name = nil
	var_24_0._current_frame_profiler = {}
	var_24_0._current_frame_profiler_pools = {}
	var_24_0._profiler_set = {}
	var_24_0._wait_removed = {}

	return var_24_0
end
