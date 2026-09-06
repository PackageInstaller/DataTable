-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_power_monster.lua

module("logicconfig.config.t_disorder_power_monster", package.seeall)

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
		"无序变身-秩序",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1002,
		"无序变身-无烬",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1003,
		"无序变身-永恒",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1004,
		"无序变身-黄金",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1005,
		"无序变身-次元",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1006,
		"无序变身-时空",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1007,
		"无序变身-超神",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1008,
		"无序变身-解神",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1009,
		"无序变身-王者",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	},
	{
		1010,
		"无序变身-龙主",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"进入战斗时，敌阵会变为指定精灵"
	}
}
local t_disorder_power_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10]
}

t_disorder_power_monster.dataList = dataList

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

return t_disorder_power_monster
