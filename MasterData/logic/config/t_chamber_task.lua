-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_chamber_task.lua

module("logic.config.t_chamber_task", package.seeall)

local title = {
	jump = 8,
	priority = 9,
	param = 5,
	isCrossSeason = 11,
	reward = 7,
	label = 2,
	content = 4,
	secretTime = 13,
	text = 3,
	point = 6,
	id = 1,
	icon = 10,
	quantifier = 12
}
local dataList = {
	{
		91010001,
		100032,
		"密室时间的主线中，任意一个守秘人在一次战斗中累计收到自身最大生命值50%以上伤害而没有退场",
		617,
		"50",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	},
	{
		91010002,
		100032,
		"密室时间的序列矿场中，敌方在一次战斗中累计恢复生命值不超过1000点",
		618,
		"1000",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	},
	{
		91010003,
		100032,
		"密室时间的测验点中，任意一个守秘人在一次战斗中累计收到自身最大生命值50%以上伤害而没有退场",
		617,
		"50",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	},
	{
		91010004,
		100032,
		"密室时间的红雾地区中，敌方在一次战斗中累计恢复生命值不超过1000点",
		618,
		"1000",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	},
	{
		91010005,
		100032,
		"密室时间中的管制行动中，被施与诅咒的守秘人累计产生10格移动",
		619,
		"10#1520007",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	},
	{
		91010006,
		100032,
		"密室时间中的夸克制药中，累计击杀5个被战力提升的敌人",
		620,
		"5#1520009",
		400,
		0,
		"",
		0,
		"",
		false,
		"",
		2
	}
}
local t_chamber_task = {}

t_chamber_task.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_chamber_task[v[1]] = v

	setmetatable(v, mt)
end

return t_chamber_task
