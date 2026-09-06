-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_path_finding_npc.lua

module("logicconfig.config.t_camp_battle_path_finding_npc", package.seeall)

local title = {
	score = 7,
	creepsMasterId = 4,
	id = 2,
	pos = 9,
	prize = 6,
	sceneId = 1,
	npcId = 3,
	ratio = 5,
	raceId = 8,
	scale = 10
}
local dataList = {
	{
		1001,
		1,
		10019001,
		1001,
		1000,
		"10:187002:200",
		200,
		10075,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		2,
		10019002,
		1002,
		1000,
		"10:187002:200",
		200,
		10155,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		3,
		10019003,
		1003,
		1000,
		"10:187002:200",
		200,
		10019,
		{
			0,
			-450
		},
		0.5
	},
	{
		1001,
		4,
		10019004,
		1004,
		1000,
		"10:187002:200",
		200,
		10349,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		5,
		10019005,
		1005,
		1000,
		"10:187002:200",
		200,
		10072,
		{
			0,
			-450
		},
		0.5
	},
	{
		111,
		1,
		1119001,
		2001,
		1000,
		"10:187002:200",
		200,
		10033,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		2,
		1119002,
		2002,
		1000,
		"10:187002:200",
		200,
		10018,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		3,
		1119003,
		2003,
		1000,
		"10:187002:200",
		200,
		10016,
		{
			0,
			-450
		},
		0.5
	},
	{
		111,
		4,
		1119004,
		2004,
		1000,
		"10:187002:200",
		200,
		10037,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		5,
		1119005,
		2005,
		1000,
		"10:187002:200",
		200,
		10037,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		1,
		1189001,
		3001,
		1000,
		"10:187002:200",
		200,
		10032,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		2,
		1189002,
		3002,
		1000,
		"10:187002:200",
		200,
		10360,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		3,
		1189003,
		3003,
		1000,
		"10:187002:200",
		200,
		10016,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		4,
		1189004,
		3004,
		1000,
		"10:187002:200",
		200,
		10349,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		5,
		1189005,
		3005,
		1000,
		"10:187002:200",
		200,
		10072,
		{
			0,
			-450
		},
		0.5
	}
}
local t_camp_battle_path_finding_npc = {
	[1001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[111] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[118] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_camp_battle_path_finding_npc.dataList = dataList

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

return t_camp_battle_path_finding_npc
