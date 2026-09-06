-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_activity.lua

module("logicconfig.config.t_lotus_battle_field_activity", package.seeall)

local title = {
	petNum = 2,
	firstStepNum = 7,
	firstBuffNum = 6,
	unlockPackageCost = 4,
	maxPackageNum = 5,
	secondStepNum = 8,
	activityId = 1,
	initPackageNum = 3
}
local dataList = {
	{
		268001,
		6,
		1,
		"105:6060:200",
		3,
		3,
		3,
		2
	},
	{
		268002,
		7,
		1,
		"105:6060:200",
		3,
		3,
		3,
		3
	}
}
local t_lotus_battle_field_activity = {
	[268001] = dataList[1],
	[268002] = dataList[2]
}

t_lotus_battle_field_activity.dataList = dataList

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

return t_lotus_battle_field_activity
