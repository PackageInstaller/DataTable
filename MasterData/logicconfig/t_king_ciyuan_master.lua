-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_master.lua

module("logicconfig.config.t_king_ciyuan_master", package.seeall)

local title = {
	description = 10,
	name = 9,
	formCondition = 7,
	skipTime = 2,
	btlMode = 5,
	btlBg = 3,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 4
}
local dataList = {
	{
		101,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境入口-1",
		"战斗结束，即可通关。"
	},
	{
		201,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境浅处-2",
		"战斗结束，即可通关。"
	},
	{
		301,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境浅处-3",
		"战斗结束，即可通关。"
	},
	{
		401,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境中心-4",
		"战斗结束，即可通关。"
	},
	{
		501,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境中心-5",
		"战斗结束，即可通关。"
	},
	{
		601,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境中心-6",
		"战斗结束，即可通关。"
	},
	{
		701,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境深处-7",
		"战斗结束，即可通关。"
	},
	{
		801,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境深处-8",
		"战斗结束，即可通关。"
	},
	{
		901,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"秘境尽头-9",
		"战斗结束，即可通关。"
	},
	{
		1001,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"赤焰龙皇试炼",
		"根据战斗伤害量结算奖励。"
	},
	{
		1002,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"次元龙试炼",
		"根据战斗伤害量结算奖励。"
	},
	{
		1003,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"黄金龙试炼",
		"根据战斗伤害量结算奖励。"
	},
	{
		1004,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"圣光飞龙试炼",
		"根据战斗伤害量结算奖励。"
	},
	{
		1005,
		0,
		"",
		"",
		"",
		0,
		0,
		0,
		"星蓝龙试炼",
		"根据战斗伤害量结算奖励。"
	}
}
local t_king_ciyuan_master = {
	[101] = dataList[1],
	[201] = dataList[2],
	[301] = dataList[3],
	[401] = dataList[4],
	[501] = dataList[5],
	[601] = dataList[6],
	[701] = dataList[7],
	[801] = dataList[8],
	[901] = dataList[9],
	[1001] = dataList[10],
	[1002] = dataList[11],
	[1003] = dataList[12],
	[1004] = dataList[13],
	[1005] = dataList[14]
}

t_king_ciyuan_master.dataList = dataList

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

return t_king_ciyuan_master
