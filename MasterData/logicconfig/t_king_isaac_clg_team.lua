-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_isaac_clg_team.lua

module("logicconfig.config.t_king_isaac_clg_team", package.seeall)

local title = {
	skipTime = 2,
	forbidPetIndex = 10,
	WinDesc = 11,
	formCondition = 8,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 3,
	selfBuffProviderId = 9,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 4
}
local dataList = {
	{
		1001,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1002,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1003,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1004,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1005,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1006,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1007,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1008,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1009,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1010,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1011,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	},
	{
		1012,
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		1,
		"击败敌阵全部精灵即可过关"
	}
}
local t_king_isaac_clg_team = {
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

t_king_isaac_clg_team.dataList = dataList

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

return t_king_isaac_clg_team
