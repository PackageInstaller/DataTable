-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_endless_stage_prize.lua

module("logicconfig.config.t_aoqi_hero_endless_stage_prize", package.seeall)

local title = {
	prizeId = 2,
	stageId = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		450001,
		1,
		3,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		2,
		6,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		3,
		9,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		4,
		12,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		5,
		15,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		6,
		18,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		7,
		21,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		8,
		24,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		9,
		27,
		"10:450002:1500#10:450001:200"
	},
	{
		450001,
		10,
		30,
		"10:450002:1500#10:450001:200"
	}
}
local t_aoqi_hero_endless_stage_prize = {
	[450001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_aoqi_hero_endless_stage_prize.dataList = dataList

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

return t_aoqi_hero_endless_stage_prize
