local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = math.floor

lx.define_class("BattleTime", function(arg_1_0)
	function arg_1_0.initTime(arg_2_0, arg_2_1, arg_2_2)
		arg_2_0._speed = arg_2_1
		arg_2_0._frame_interval = arg_2_2
	end

	function arg_1_0.setStartTime(arg_3_0, arg_3_1)
		arg_3_0._frame = 1
		arg_3_0._last_run_time = arg_3_1
	end

	function arg_1_0:getTime()
		return self._frame * self._frame_interval
	end

	function arg_1_0.setFrame(arg_5_0, arg_5_1)
		arg_5_0._frame = arg_5_1
	end

	function arg_1_0:getFrame()
		return self._frame
	end

	function arg_1_0:hasFrame()
		return self._wait_do_frame_num > 0
	end

	function arg_1_0:nextFrame()
		if self._wait_do_frame_num <= 0 then
			return
		end

		self._wait_do_frame_num = self._wait_do_frame_num - 1
		self._frame = self._frame + 1
	end

	function arg_1_0:run_once(arg_9_1)
		self._total_delta_time = self._total_delta_time + (arg_9_1 - self._last_run_time)
		self._last_run_time = arg_9_1
		self._wait_do_frame_num = var_0_2(self._total_delta_time / (self._frame_interval / self._speed))
		self._total_delta_time = self._total_delta_time % (self._frame_interval / self._speed)
	end
end)

function var_0_0.create(arg_10_0)
	local var_10_0 = var_0_1.class("BattleTime")

	var_10_0._speed = 0
	var_10_0._frame_interval = 0
	var_10_0._wait_do_frame_num = 0
	var_10_0._last_run_time = 0
	var_10_0._total_delta_time = 0
	var_10_0._frame = 0

	return var_10_0
end

return var_0_0
