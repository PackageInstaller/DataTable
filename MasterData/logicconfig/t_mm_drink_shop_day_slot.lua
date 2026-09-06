-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_drink_shop_day_slot.lua

module("logicconfig.config.t_mm_drink_shop_day_slot", package.seeall)

local title = {
	drinkId = 3,
	dayIndex = 2,
	activityId = 1
}
local dataList = {
	{
		596001,
		1,
		{
			1001,
			1002,
			1003
		}
	},
	{
		596001,
		2,
		{
			1004,
			1005,
			1006
		}
	},
	{
		596001,
		3,
		{
			1007,
			1008,
			1009
		}
	},
	{
		596001,
		4,
		{
			1010,
			1011,
			1012
		}
	},
	{
		596001,
		5,
		{
			1013,
			1014,
			1015
		}
	},
	{
		596001,
		6,
		{
			1016,
			1017,
			1018
		}
	},
	{
		596001,
		7,
		{
			1019,
			1020,
			1021
		}
	}
}
local t_mm_drink_shop_day_slot = {
	[596001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_mm_drink_shop_day_slot.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_mm_drink_shop_day_slot
