-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_never_land_activity.lua

module("logicconfig.config.t_never_land_activity", package.seeall)

local title = {
	defenseModeMonsterId = 6,
	attackModeMonsterId = 3,
	mailTpId = 2,
	attackModeCalc = 5,
	jump_shop = 9,
	defenseModeCalc = 8,
	buff_res = 11,
	main_res = 10,
	attackModeSupportCreepsId = 4,
	activityId = 1,
	defenseModeSupportCreepsId = 7
}
local dataList = {
	{
		294001,
		217,
		101,
		10000001,
		"DamageTotal",
		102,
		10000002,
		"CircleCount",
		"func#191#288#288001",
		"10:17084",
		"10:294001"
	}
}
local t_never_land_activity = {
	[294001] = dataList[1]
}

t_never_land_activity.dataList = dataList

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

return t_never_land_activity
