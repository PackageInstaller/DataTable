-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_doppelganger_clg_monster.lua

module("logicconfig.config.t_dragon_king_doppelganger_clg_monster", package.seeall)

local title = {
	skipTime = 10,
	name = 2,
	formCondition = 8,
	retreatMsgType = 6,
	btlMode = 4,
	btlBg = 3,
	selfBuffProviderId = 7,
	winId = 5,
	creepsMasterId = 1,
	heroSkillId = 9
}
local dataList = {
	{
		1001,
		"阵1",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1002,
		"阵2",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1003,
		"阵3",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1004,
		"阵4",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1005,
		"阵5",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1006,
		"阵6",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1007,
		"阵7",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1008,
		"阵8",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1009,
		"阵9",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1010,
		"阵10",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1011,
		"阵11",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1012,
		"阵12",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1013,
		"阵13",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1014,
		"阵14",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	},
	{
		1015,
		"阵15",
		"",
		"",
		147,
		0,
		0,
		0,
		"",
		5
	}
}
local t_dragon_king_doppelganger_clg_monster = {
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
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15]
}

t_dragon_king_doppelganger_clg_monster.dataList = dataList

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

return t_dragon_king_doppelganger_clg_monster
