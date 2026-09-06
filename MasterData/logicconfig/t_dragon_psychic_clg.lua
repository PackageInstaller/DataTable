-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_psychic_clg.lua

module("logicconfig.config.t_dragon_psychic_clg", package.seeall)

local title = {
	extremeClgPrize = 7,
	signs = 6,
	initSystemPetCount = 2,
	taskActivityId = 9,
	hatchTime = 5,
	decHatchTimeCost = 3,
	comPlanId = 10,
	redPointId = 8,
	decHatchTime = 4,
	activityId = 1
}
local dataList = {
	{
		351001,
		5,
		"4:510285:10",
		1800,
		5400,
		"龙",
		"100:12020:1:1",
		563,
		351001,
		1
	},
	{
		351002,
		5,
		"4:510285:10",
		1800,
		5400,
		"龙",
		"8:1:1",
		0,
		0,
		2
	}
}
local t_dragon_psychic_clg = {
	[351001] = dataList[1],
	[351002] = dataList[2]
}

t_dragon_psychic_clg.dataList = dataList

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

return t_dragon_psychic_clg
