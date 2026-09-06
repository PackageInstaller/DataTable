-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shi_zu_dragon_clg_phase.lua

module("logicconfig.config.t_shi_zu_dragon_clg_phase", package.seeall)

local title = {
	needNum = 4,
	name = 7,
	buffId = 6,
	type = 5,
	phaseId = 2,
	prize = 3,
	desc = 9,
	typeName = 8,
	activityId = 1
}
local dataList = {
	{
		500001,
		1,
		"4:385:20",
		5,
		"CIRCLE",
		0,
		"第一层",
		"回合数",
		"统计己阵回合数，回合数越多，龙血数量越多\r\n每1个回合获得1龙血，单关最多3龙血"
	},
	{
		500001,
		2,
		"4:385:40",
		10,
		"BUFF_NUM",
		30000078,
		"第二层",
		"暴击数",
		"统计己阵暴击次数，暴击次数越多，龙血数量越多\r\n每暴击1次获得1龙血，单关最多6龙血"
	},
	{
		500001,
		3,
		"4:385:60",
		15,
		"BUFF_NUM",
		30000091,
		"第三层",
		"受击数",
		"统计己阵受击次数，受击次数越高，龙血数量越多\r\n每受击5次获得1龙血，单关最多6龙血"
	}
}
local t_shi_zu_dragon_clg_phase = {
	[500001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_shi_zu_dragon_clg_phase.dataList = dataList

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

return t_shi_zu_dragon_clg_phase
