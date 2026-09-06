-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_check_strategy.lua

module("logicconfig.config.t_power_check_strategy", package.seeall)

local title = {
	strategyId = 1,
	desc = 3,
	jumpTo = 4,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		"幻境，获得经验果",
		"func#106"
	},
	{
		1,
		2,
		"剧情副本，获得经验材料",
		"func#47"
	},
	{
		2,
		1,
		"扫荡主线获得天赋材料",
		"func#47"
	},
	{
		3,
		1,
		"使用召唤券，获得精灵",
		"func#43"
	},
	{
		3,
		2,
		"挑战精灵领主",
		"func#99"
	},
	{
		3,
		3,
		"不断攀登，获得精灵之尘",
		"func#15"
	},
	{
		3,
		4,
		"派遣任务，获得精灵之尘",
		"func#74"
	},
	{
		4,
		1,
		"挑战幻境，获得装备奖励",
		"func#106"
	},
	{
		4,
		2,
		"失落遗迹，获得稀有装备奖励",
		"func#52"
	},
	{
		4,
		3,
		"家族试炼，可以获得稀有装备",
		"func#60"
	},
	{
		5,
		1,
		"幻境，获得星神奖励",
		"func#106"
	},
	{
		5,
		2,
		"研习阵法以破阵，获得星神奖励",
		"func#18"
	},
	{
		6,
		1,
		"迎接无尽的试炼，获得大量 潜能书、潜能果",
		"func#172"
	},
	{
		6,
		2,
		"精灵们外出执行派遣任务，有可能获得少量的潜能药水",
		"func#74"
	},
	{
		7,
		1,
		"羁绊精灵，激活羁绊效果",
		"func#43"
	},
	{
		7,
		2,
		"觉醒达到满级，无需上阵激活羁绊",
		"func#9"
	},
	{
		8,
		1,
		"灵纹幻境，海量极品灵纹",
		"func#611"
	},
	{
		9,
		1,
		"泰坦试炼，获得泰坦残骸，点亮源核技能",
		"func#1286"
	}
}
local t_power_check_strategy = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16]
	},
	{
		dataList[17]
	},
	{
		dataList[18]
	}
}

t_power_check_strategy.dataList = dataList

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

return t_power_check_strategy
