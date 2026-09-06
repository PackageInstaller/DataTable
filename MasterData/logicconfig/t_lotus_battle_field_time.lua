-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_time.lua

module("logicconfig.config.t_lotus_battle_field_time", package.seeall)

local title = {
	battleBuffTime = 8,
	battleViewTime = 10,
	activityId = 1,
	selectSpoilsTime = 12,
	selectBuffTime = 4,
	secondStepTime = 7,
	forceMatchTime = 5,
	firstStepTime = 6,
	settleStopTime = 11,
	showFormationTime = 9,
	matchingTime = 2,
	selectPetTime = 3
}
local dataList = {
	{
		268001,
		60,
		30,
		10,
		10,
		25,
		25,
		10,
		3,
		15,
		3,
		10
	},
	{
		268002,
		60,
		30,
		10,
		10,
		25,
		25,
		10,
		3,
		15,
		3,
		10
	}
}
local t_lotus_battle_field_time = {
	[268001] = dataList[1],
	[268002] = dataList[2]
}

t_lotus_battle_field_time.dataList = dataList

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

return t_lotus_battle_field_time
