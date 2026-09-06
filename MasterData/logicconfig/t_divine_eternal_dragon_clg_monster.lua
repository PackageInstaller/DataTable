-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_eternal_dragon_clg_monster.lua

module("logicconfig.config.t_divine_eternal_dragon_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"维达试炼-1",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1002,
		"维达试炼-2",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1003,
		"维达试炼-3",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1004,
		"维达试炼-4",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1005,
		"维达试炼-5",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1006,
		"维达试炼-6",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1007,
		"维达试炼-7",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1008,
		"维达试炼-8",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1009,
		"维达试炼-9",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1010,
		"维达试炼-10",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1011,
		"维达试炼-11",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	},
	{
		1012,
		"维达试炼-12",
		3,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		""
	}
}
local t_divine_eternal_dragon_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12]
}

t_divine_eternal_dragon_clg_monster.dataList = dataList

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

return t_divine_eternal_dragon_clg_monster
