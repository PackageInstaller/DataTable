-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_dark_dragon_daily_sign.lua

module("logicconfig.config.t_light_dark_dragon_daily_sign", package.seeall)

local title = {
	dailySignId = 2,
	prize = 3,
	dailySignPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:133:1"
	},
	{
		1,
		2,
		"4:133:2"
	},
	{
		1,
		3,
		"4:133:1"
	},
	{
		1,
		4,
		"4:133:2"
	},
	{
		1,
		5,
		"4:133:2"
	},
	{
		1,
		6,
		"4:133:2"
	},
	{
		2,
		1,
		"4:133:1"
	},
	{
		2,
		2,
		"4:133:2"
	},
	{
		2,
		3,
		"4:133:1"
	},
	{
		2,
		4,
		"4:133:2"
	},
	{
		2,
		5,
		"4:133:2"
	},
	{
		2,
		6,
		"4:133:2"
	}
}
local t_light_dark_dragon_daily_sign = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_light_dark_dragon_daily_sign.dataList = dataList

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

return t_light_dark_dragon_daily_sign
