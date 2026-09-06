-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding_npc.lua

module("logicconfig.config.t_weak_path_finding_npc", package.seeall)

local title = {
	sceneId = 1,
	npcId = 3,
	id = 2,
	scale = 6,
	raceId = 4,
	pos = 5
}
local dataList = {
	{
		1001,
		1,
		10011037,
		10036,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		2,
		10011038,
		10031,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		3,
		10011039,
		10018,
		{
			0,
			-450
		},
		0.5
	},
	{
		1001,
		4,
		10011040,
		10351,
		{
			0,
			-250
		},
		0.5
	},
	{
		1001,
		5,
		10011041,
		10337,
		{
			0,
			-450
		},
		0.5
	},
	{
		111,
		1,
		1111010,
		10036,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		2,
		1111011,
		10031,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		3,
		1111012,
		10018,
		{
			0,
			-450
		},
		0.5
	},
	{
		111,
		4,
		1111013,
		10351,
		{
			0,
			-250
		},
		0.5
	},
	{
		111,
		5,
		1111014,
		10337,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		1,
		1181017,
		10036,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		2,
		1181018,
		10031,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		3,
		1181019,
		10018,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		4,
		1181020,
		10351,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		5,
		1181021,
		10337,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		6,
		1181022,
		10356,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		7,
		1181023,
		10031,
		{
			0,
			-250
		},
		0.5
	},
	{
		118,
		8,
		1181024,
		10346,
		{
			0,
			-450
		},
		0.5
	},
	{
		118,
		9,
		1181025,
		10005,
		{
			0,
			-350
		},
		0.5
	},
	{
		118,
		10,
		1181026,
		10169,
		{
			0,
			-450
		},
		0.5
	}
}
local t_weak_path_finding_npc = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_weak_path_finding_npc.dataList = dataList

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

return t_weak_path_finding_npc
