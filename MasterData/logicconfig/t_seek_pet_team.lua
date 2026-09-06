-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_pet_team.lua

module("logicconfig.config.t_seek_pet_team", package.seeall)

local title = {
	description = 8,
	name = 2,
	video = 9,
	skipTime = 3,
	perfectWinId = 11,
	btlMode = 7,
	btlBg = 4,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		101,
		"哆啦梦梦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10338,
		3
	},
	{
		102,
		"热血梦梦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10342,
		3
	},
	{
		103,
		"炼金梦梦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10341,
		3
	},
	{
		104,
		"爱心梦梦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10343,
		3
	},
	{
		105,
		"暗黑梦梦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10339,
		3
	},
	{
		106,
		"寒战·空无流",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10084,
		3
	},
	{
		107,
		"烈阳·龙君焰",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10082,
		3
	},
	{
		108,
		"无畏·苍零式",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10083,
		3
	},
	{
		109,
		"魄月·炽辰光",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10085,
		3
	},
	{
		110,
		"黯墨·夜无忧",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10086,
		3
	},
	{
		111,
		"当当",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10032,
		3
	},
	{
		112,
		"问问",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10031,
		3
	},
	{
		113,
		"弹弹",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10030,
		3
	},
	{
		114,
		"绝绝",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10033,
		3
	},
	{
		115,
		"魔魔",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10037,
		3
	},
	{
		116,
		"夜羽执事·洛世琦",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10323,
		3
	},
	{
		117,
		"圣域·黄金圣龙",
		0,
		"",
		"",
		0,
		"",
		"1、击败敌阵所有精灵即可过关\r\n2、自方阵亡精灵小于2个可完美通关",
		false,
		10324,
		3
	}
}
local t_seek_pet_team = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8],
	[109] = dataList[9],
	[110] = dataList[10],
	[111] = dataList[11],
	[112] = dataList[12],
	[113] = dataList[13],
	[114] = dataList[14],
	[115] = dataList[15],
	[116] = dataList[16],
	[117] = dataList[17]
}

t_seek_pet_team.dataList = dataList

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

return t_seek_pet_team
