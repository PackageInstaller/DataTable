-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_game_activity.lua

module("logicconfig.config.t_pin_game_activity", package.seeall)

local title = {
	redPointId = 3,
	dailyGameTimes = 2,
	raceId = 4,
	actId = 1,
	passPrize = 5
}
local dataList = {
	{
		325001,
		3,
		535,
		18001,
		""
	},
	{
		325002,
		3,
		535,
		16019,
		""
	},
	{
		325003,
		3,
		535,
		16031,
		"10:453001:12500"
	},
	{
		325004,
		3,
		535,
		1104003,
		"10:453003:5000"
	}
}
local t_pin_game_activity = {
	[325001] = dataList[1],
	[325002] = dataList[2],
	[325003] = dataList[3],
	[325004] = dataList[4]
}

t_pin_game_activity.dataList = dataList

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

return t_pin_game_activity
