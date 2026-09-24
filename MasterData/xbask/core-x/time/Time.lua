local var_0_0 = lx
local var_0_1 = os.time
local var_0_2 = os.date
local var_0_3 = string.format
local var_0_4 = {
	"Sun",
	"Mon",
	"Tue",
	"Wed",
	"Thu",
	"Fri",
	"Sat"
}
local var_0_5 = {
	"Jan",
	"Feb",
	"Mar",
	"Apr",
	"May",
	"Jun",
	"Jul",
	"Aug",
	"Sep",
	"Oct",
	"Nov",
	"Dec"
}
local var_0_6 = {}

for iter_0_0, iter_0_1 in pairs(var_0_5) do
	var_0_6[iter_0_1] = iter_0_0
end

local function var_0_7(arg_1_0)
	return var_0_3("%s, %.2d %s %.4d %.2d:%.2d:%.2d GMT", var_0_4[arg_1_0.wday], arg_1_0.day, var_0_5[arg_1_0.month], arg_1_0.year, arg_1_0.hour, arg_1_0.min, arg_1_0.sec)
end

local function var_0_8(arg_2_0)
	local var_2_0, var_2_1, var_2_2, var_2_3, var_2_4, var_2_5 = arg_2_0:match(", (%d+) ([^ ]+) (%d+) (%d+):(%d+):(%d+) GMT$")

	if not var_2_0 then
		return 0
	end

	local var_2_6 = var_0_6[var_2_1]

	if not var_0_6[var_2_1] then
		return 0
	end

	return var_0_1({
		year = var_2_2,
		month = var_2_6,
		day = var_2_0,
		hour = var_2_3,
		min = var_2_4,
		sec = var_2_5
	})
end

lx.define_class("Time", function(arg_3_0)
	function arg_3_0:getTime()
		return self._current_time
	end

	function arg_3_0:getUtcTime()
		return self._current_date_time
	end

	function arg_3_0:getDate()
		return var_0_2("*t", self._current_date_time)
	end

	function arg_3_0:getDateString(arg_7_1)
		if arg_7_1 == nil then
			return self._current_date_str
		end

		return var_0_2("%Y-%m-%d %H:%M:%S", arg_7_1)
	end

	function arg_3_0:getGMTDateString(arg_8_1)
		if arg_8_1 == nil then
			return self._current_gmt_date_str
		end

		return var_0_7((var_0_2("!*t", arg_8_1)))
	end

	function arg_3_0:diffGMTDateString(arg_9_1)
		return var_0_8(self:getGMTDateString()) - var_0_8(arg_9_1)
	end

	function arg_3_0.utcToTmObj(arg_10_0, arg_10_1)
		return var_0_2("*t", arg_10_1)
	end

	function arg_3_0.tmObjToUtcTime(arg_11_0, arg_11_1)
		return var_0_1(arg_11_1)
	end

	function arg_3_0:run_once(arg_12_1)
		self._current_time = arg_12_1

		if arg_12_1 >= self._last_get_date_time + 300 then
			self:__update_date()

			self._last_get_date_time = self._current_time
		end
	end

	function arg_3_0:__update_date()
		self._current_date_time = var_0_1()
		self._current_date = var_0_2("*t", self._current_date_time)
		self._current_gmt_date = var_0_2("!*t", self._current_date_time)
		self._current_date_str = self:getDateString(self._current_date_time)
		self._current_gmt_date_str = var_0_7(self._current_gmt_date)
	end

	function arg_3_0:__init()
		self._current_time = get_millisecond()

		self:__update_date()
	end
end)

return function()
	local var_15_0 = var_0_0.class("Time")

	var_15_0._current_time = 0
	var_15_0._last_get_date_time = 0
	var_15_0._current_date_time = 0
	var_15_0._current_date = nil
	var_15_0._current_date_str = ""
	var_15_0._current_gmt_date = nil
	var_15_0._current_gmt_date_str = ""

	var_15_0:__init()

	return var_15_0
end
