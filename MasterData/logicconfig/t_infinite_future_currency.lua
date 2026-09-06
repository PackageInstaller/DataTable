-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_infinite_future_currency.lua

module("logicconfig.config.t_infinite_future_currency", package.seeall)

local title = {
	parameter = 1,
	value = 2
}
local dataList = {
	{
		"challenge_plot",
		"4250001"
	},
	{
		"challenge_map",
		"1231002"
	},
	{
		"challenge_pet",
		"12004"
	},
	{
		"challenge_skin_func",
		"func#545#33"
	},
	{
		"challenge_skin",
		"1200401"
	},
	{
		"activity_task",
		"142003"
	},
	{
		"activity_luck_draw",
		"112007"
	},
	{
		"challenge_aword_preview",
		"最多获得 <quad name=4:139|icon size=40 width=1 offsetY=-10/> x 39"
	},
	{
		"challenge_currency",
		"4:139"
	},
	{
		"challenge_time",
		"活动时间：01.19 5:00 - 02.09 5:00"
	},
	{
		"challenge_firedragon_1",
		"firedragonlevelsview#123006"
	},
	{
		"challenge_firedragon_2",
		"firedragonlevelsview#123007"
	},
	{
		"challenge_firedragon_3",
		"firedragonlevelsview#123008"
	},
	{
		"activity_luck_draw_firedragon",
		"112007"
	},
	{
		"challenge_currency_weileita",
		"4:140"
	}
}
local t_infinite_future_currency = {
	challenge_plot = dataList[1],
	challenge_map = dataList[2],
	challenge_pet = dataList[3],
	challenge_skin_func = dataList[4],
	challenge_skin = dataList[5],
	activity_task = dataList[6],
	activity_luck_draw = dataList[7],
	challenge_aword_preview = dataList[8],
	challenge_currency = dataList[9],
	challenge_time = dataList[10],
	challenge_firedragon_1 = dataList[11],
	challenge_firedragon_2 = dataList[12],
	challenge_firedragon_3 = dataList[13],
	activity_luck_draw_firedragon = dataList[14],
	challenge_currency_weileita = dataList[15]
}

t_infinite_future_currency.dataList = dataList

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

return t_infinite_future_currency
