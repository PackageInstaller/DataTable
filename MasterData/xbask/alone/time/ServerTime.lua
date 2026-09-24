local var_0_0 = lx
local var_0_1 = os.time
local var_0_2 = math.floor
local var_0_3 = get_millisecond

lx.define_class("ServerTime", function(arg_1_0)
	function arg_1_0:getTime()
		return self._server_utc_ms_time
	end

	function arg_1_0:getUtcTime()
		return self._server_utc_s_time
	end

	function arg_1_0.updateServerTime(arg_4_0, arg_4_1)
		if arg_4_1 < 0 then
			var_0_0.error(string.format("on update server time, but time value error!"))
		end

		arg_4_0._server_utc_s_time = arg_4_1
		arg_4_0._server_utc_ms_time = arg_4_1 * 1000
		arg_4_0._last_update_time = var_0_3()
	end

	function arg_1_0:run_once()
		local var_5_0 = var_0_3()

		if var_5_0 - self._last_update_time > 0 then
			self._server_utc_ms_time = self._server_utc_ms_time + (var_5_0 - self._last_update_time)
			self._server_utc_s_time = var_0_2(self._server_utc_ms_time / 1000)
			self._last_update_time = var_5_0
		end
	end

	function arg_1_0:__init()
		self._server_utc_s_time = var_0_1()
		self._server_utc_ms_time = self._server_utc_s_time * 1000
		self._last_update_time = var_0_3()
	end
end)

return function()
	local var_7_0 = var_0_0.class("ServerTime")

	var_7_0._server_utc_s_time = 0
	var_7_0._server_utc_ms_time = 0
	var_7_0._last_update_time = 0

	var_7_0:__init()

	return var_7_0
end
