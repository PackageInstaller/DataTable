-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_assist_pet.lua

module("logicconfig.config.t_miracle_hero_assist_pet", package.seeall)

local title = {
	energyRatio = 7,
	name = 3,
	energyLimit = 11,
	assistId = 2,
	coldDown = 10,
	ultCostEnergy = 9,
	energyProvider = 6,
	ultSkillId = 8,
	unlockItemId = 5,
	faceIds = 4,
	activityId = 1
}
local dataList = {
	{
		383001,
		1,
		"蜜蕊可",
		"16008",
		0,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		216008,
		10,
		1,
		99
	},
	{
		383001,
		2,
		"奇迹蜜蕊可",
		"16025",
		383006,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		216025,
		10,
		1,
		99
	},
	{
		383002,
		1,
		"幻心晴",
		"17023",
		0,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		216026,
		10,
		1,
		99
	},
	{
		383002,
		2,
		"武月天",
		"14028",
		383010,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		216027,
		10,
		1,
		99
	},
	{
		383003,
		1,
		"末炎",
		"10097",
		0,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		210097,
		10,
		1,
		99
	},
	{
		383003,
		2,
		"王者末炎",
		"12023",
		383013,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		212023,
		10,
		1,
		99
	},
	{
		383004,
		1,
		"无限未来",
		"10097",
		0,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		210097,
		10,
		1,
		99
	},
	{
		383004,
		2,
		"神曜无限未来",
		"12023",
		383013,
		{
			1,
			2,
			3,
			4,
			5
		},
		2,
		212023,
		10,
		1,
		99
	}
}
local t_miracle_hero_assist_pet = {
	[383001] = {
		dataList[1],
		dataList[2]
	},
	[383002] = {
		dataList[3],
		dataList[4]
	},
	[383003] = {
		dataList[5],
		dataList[6]
	},
	[383004] = {
		dataList[7],
		dataList[8]
	}
}

t_miracle_hero_assist_pet.dataList = dataList

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

return t_miracle_hero_assist_pet
