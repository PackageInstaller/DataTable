local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = math.floor
local var_0_4 = string.format
local var_0_5 = debug.traceback
local var_0_6 = get_millisecond

lx.define_class("QueueLoader", function(arg_1_0)
	function arg_1_0.setEveryDoTime(arg_2_0, arg_2_1)
		if arg_2_1 < 1 then
			arg_2_1 = 16
		end

		if arg_2_1 > 3000 then
			arg_2_1 = 3000
		end

		arg_2_0._the_frame_max_dotime = arg_2_1
	end

	function arg_1_0:begin()
		if self._is_loading then
			var_0_2(not self._is_loading, "now is loading, error.")

			return
		end

		self:__reset()
	end

	function arg_1_0:addTask(arg_4_1, arg_4_2, arg_4_3)
		if self._is_loading or not arg_4_1 then
			return
		end

		if arg_4_3 == nil then
			arg_4_3 = ""
		end

		self._list:push_back({
			do_func = arg_4_1,
			arg = arg_4_2,
			tips = arg_4_3
		})

		self._total_num = self._list:size()
	end

	function arg_1_0:start(arg_5_1, arg_5_2, arg_5_3)
		if self._is_loading then
			return
		end

		if var_0_1(arg_5_3) ~= "number" then
			arg_5_3 = 1
		end

		self._is_loading = true
		self._event_progress_change_func = arg_5_1
		self._event_finish_func = arg_5_2
		self._begin_skip_frame = arg_5_3
	end

	function arg_1_0:run_once()
		if not self._is_loading then
			return
		end

		if self._begin_skip_frame > 0 then
			self._begin_skip_frame = self._begin_skip_frame - 1

			return
		end

		local var_6_0 = var_0_6()
		local var_6_1 = self._list:front()

		while var_6_1 do
			self._list:pop_front()
			self:__update_progress(var_6_1.tips)
			self:__do_the_task(var_6_1)

			if var_0_6() - var_6_0 >= self._the_frame_max_dotime then
				break
			end

			var_6_1 = self._list:front()
		end

		self:__update_progress(nil, true)
	end

	function arg_1_0.__do_the_task(arg_7_0, arg_7_1)
		local var_7_0, var_7_1 = xpcall(arg_7_1.do_func, var_0_5, arg_7_1.arg)

		if not var_7_0 then
			log.errorlog(var_0_4("do loader task failed, task info:{arg:%s, tips:%s}, err:%s", tostring(arg_7_1.arg), tostring(arg_7_1.tips)), var_7_1)
		end
	end

	function arg_1_0:__update_progress(arg_8_1, arg_8_2)
		self._progress = var_0_3(((self._total_num > 0 or nil) and (self._total_num - self._list:size()) / self._total_num) * 100)

		if self._event_progress_change_func and arg_8_1 then
			self._event_progress_change_func(self._progress, arg_8_1)
		end

		if self._progress == 100 and arg_8_2 then
			var_0_2(self._list:empty())

			self._is_loading = false

			self:__reset()

			if self._event_finish_func then
				self._event_finish_func()
			end
		end
	end

	function arg_1_0.__reset(arg_9_0)
		arg_9_0._is_loading = false
		arg_9_0._list = var_0_0.appendlist:create()
		arg_9_0._total_num = 0
		arg_9_0._progress = 0
		arg_9_0._the_frame_max_dotime = 16
		arg_9_0._begin_skip_frame = 0
		arg_9_0._event_progress_change_func = nil
		arg_9_0._event_finish_func = nil
	end
end)

return function()
	local var_10_0 = var_0_0.class("QueueLoader")

	var_10_0._is_loading = false
	var_10_0._list = nil
	var_10_0._total_num = 0
	var_10_0._progress = 0
	var_10_0._the_frame_max_dotime = 16
	var_10_0._begin_skip_frame = 0
	var_10_0._event_progress_change_func = nil
	var_10_0._event_finish_func = nil

	return var_10_0
end
