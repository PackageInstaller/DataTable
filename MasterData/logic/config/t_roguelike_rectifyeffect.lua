-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_rectifyeffect.lua

module("logic.config.t_roguelike_rectifyeffect", package.seeall)

local title = {
	way = 6,
	effect = 4,
	name = 2,
	desc = 3,
	camp = 8,
	formula = 5,
	id = 1,
	icon = 9,
	attr = 7
}
local dataList = {
	{
		1,
		"作战准备",
		"为下一次判定提供%d个&chenggong&",
		80000001,
		"x",
		"ATTR_MAX",
		0,
		0,
		""
	},
	{
		2,
		"有序应对",
		"下一次判定所有队员均分%d个空白骰",
		80000002,
		"x/2",
		"ATTR_MAX",
		1,
		0,
		""
	},
	{
		3,
		"紧急医疗",
		"回复所有队员%d点的HP",
		80000003,
		"x",
		"ATTR_MAX",
		2,
		0,
		""
	},
	{
		4,
		"漫步闲谈",
		"回复所有队员%d点SAN",
		80000006,
		"x/2",
		"ATTR_MAX",
		3,
		0,
		""
	},
	{
		5,
		"环境侦查",
		"随机查看%d个房间内容",
		80000004,
		"x",
		"ATTR_MAX",
		4,
		0,
		""
	},
	{
		6,
		"悄然降临",
		"幸运熊熊币+%d",
		80000005,
		"x*10",
		"ATTR_MAX",
		5,
		0,
		""
	},
	{
		7,
		"主动防御",
		"为下一次判定提供%d个&fanzhi&",
		80000007,
		"x/2",
		"ATTR_MAX",
		0,
		3,
		""
	},
	{
		8,
		"无序混乱",
		"随机执行一个效果:???",
		80000012,
		"",
		"",
		1,
		7,
		""
	},
	{
		9,
		"混乱子效果",
		"为下一次判定提供%d个&shizhi&",
		80000010,
		"x",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		10,
		"混乱子效果",
		"下一次判定所有队员均分%d个&zhenxiang&",
		80000011,
		"x/2",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		11,
		"混乱子效果",
		"为所有队员恢复%d点HP",
		80000003,
		"x",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		12,
		"混乱子效果",
		"随机查看%d个房间内容",
		80000004,
		"x",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		13,
		"混乱子效果",
		"幸运熊熊币+%d",
		80000005,
		"x*15",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		14,
		"混乱子效果",
		"为所有队员回复X点理智",
		80000006,
		"x/2",
		"ATTR_MAX",
		1,
		7,
		""
	},
	{
		15,
		"作战准备",
		"为下一次判定提供%d个&chenggong&",
		80000001,
		"x",
		"LORE1",
		2,
		5,
		""
	},
	{
		16,
		"有序应对",
		"下一次判定所有队员均分%d（向下取整）空白骰子",
		80000002,
		"x/2",
		"LORE2",
		2,
		5,
		""
	},
	{
		17,
		"紧急医疗",
		"为所有队员回复%d点HP",
		80000003,
		"x",
		"LORE3",
		2,
		5,
		""
	},
	{
		18,
		"环境侦查",
		"随机查看%d个房间内容",
		80000004,
		"x",
		"LORE4",
		2,
		5,
		""
	},
	{
		19,
		"悄然降临",
		"幸运熊熊币+%d",
		80000005,
		"x*10",
		"LORE_MAX",
		2,
		5,
		""
	},
	{
		20,
		"漫步闲谈",
		"为所有队员回复%d点SAN",
		80000006,
		"x/2",
		"LORE_MIN",
		2,
		5,
		""
	},
	{
		21,
		"管制预备",
		"为下一次判定提供%d个&baoji&",
		80000008,
		"x",
		"ATTR_MAX",
		4,
		1,
		""
	},
	{
		22,
		"神化预备",
		"为下一次判定提供%d个&shenhua&",
		80000009,
		"x",
		"ATTR_MAX",
		5,
		2,
		""
	}
}
local t_roguelike_rectifyeffect = {}

t_roguelike_rectifyeffect.dataList = dataList

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
	t_roguelike_rectifyeffect[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_rectifyeffect
