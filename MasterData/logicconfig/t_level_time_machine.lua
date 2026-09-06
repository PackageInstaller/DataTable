-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_level_time_machine.lua

module("logicconfig.config.t_level_time_machine", package.seeall)

local title = {
	periodLimit = 4,
	buyPlanId = 7,
	name = 2,
	type = 3,
	id = 1,
	talentDesc = 9,
	funcId = 10,
	maxLevelLimit = 8,
	initRareLimits = 6,
	limitTimes = 5
}
local dataList = {
	{
		1,
		"等级直升",
		"pet",
		"weekly",
		1,
		"3,4",
		1,
		100,
		"最强王者",
		282
	},
	{
		2,
		"星神直升",
		"starGodPlus",
		"weekly",
		4,
		"1,2,3,4",
		2,
		50,
		"",
		282
	}
}
local t_level_time_machine = {
	dataList[1],
	dataList[2]
}

t_level_time_machine.dataList = dataList

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

return t_level_time_machine
