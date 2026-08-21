-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_system_open_hint.lua

module("logic.config.t_system_open_hint", package.seeall)

local title = {
	typ = 6,
	name = 3,
	title = 2,
	unlockHintDesc = 5,
	code = 1,
	icon = 4,
	sysType = 7
}
local dataList = {
	{
		12009,
		"",
		"守秘人提升",
		"xgnjs_icon_0010",
		"使用成长液，强化守秘人战力",
		1,
		0
	},
	{
		12010,
		"",
		"守秘人亲和度",
		"xgnjs_icon_0009",
		"帮助守秘人提高亲和度，强化守秘人战力",
		1,
		0
	},
	{
		12012,
		"",
		"校时器",
		"xgnjs_icon_0012",
		"装备校时器，提升守秘人作战能力",
		1,
		0
	},
	{
		12013,
		"",
		"残响",
		"xgnjs_icon_0005",
		"选择合适的残响，使守秘人获得质变",
		1,
		0
	},
	{
		13000,
		"",
		"思维",
		"xgnjs_icon_0011",
		"学习共同思维，使守秘人产生质变",
		1,
		0
	},
	{
		16002,
		"",
		"安定区域",
		"xgnjs_icon_0004",
		"获取材料，强化守秘人战力",
		1,
		0
	},
	{
		16011,
		"",
		"月相计划",
		"xgnjs_icon_0002",
		"明与暗背向而立，引力如梭牵系仰望之人",
		0,
		0
	},
	{
		16015,
		"",
		"梦境档案室",
		"xgnjs_icon_0008",
		"意识世界探索湮灭真相",
		0,
		0
	},
	{
		22000,
		"",
		"守秘人招募",
		"tab_28",
		"通过招募，获取新的守秘人",
		1,
		0
	},
	{
		26000,
		"",
		"24/36系统",
		"xgnjs_icon_0001",
		"密室时间已悄然到来，做好作战部署准备",
		1,
		0
	},
	{
		26001,
		"",
		"蜂巢评议",
		"xgnjs_icon_0001",
		"接受蜂巢议会的评议",
		1,
		0
	},
	{
		31001,
		"",
		"主管名片",
		"xgnjs_icon_0013",
		"是枷锁，还是保护？",
		1,
		0
	},
	{
		35001,
		"",
		"管制行动",
		"xgnjs_icon_0006",
		"越过字符与好奇心，终结超凡的逃脱游戏",
		1,
		0
	},
	{
		22002,
		"",
		"特邀招募",
		"xgnjs_icon_0003",
		"主管，你会需要我的！",
		1,
		0
	},
	{
		20000,
		"",
		"邮件",
		"xgnjs_icon_0003",
		"天文台的补给已送达",
		1,
		0
	},
	{
		12015,
		"",
		"默契",
		"xgnjs_icon_0014",
		"提升默契等级，完成天赋觉醒",
		1,
		0
	},
	{
		16012,
		"",
		"战术培训",
		"xgnjs_icon_0019",
		"完成战术培训，提升指挥水平",
		0,
		0
	},
	{
		16013,
		"",
		"红雾区域",
		"xgnjs_icon_0017",
		"调查红雾区域，回收校时器",
		0,
		0
	},
	{
		16019,
		"月相计划-暗面",
		"月相计划-暗面",
		"xgnjs_icon_0002",
		"明与暗背向而立，引力如梭牵系仰望之人",
		0,
		0
	},
	{
		15102,
		"新章节解锁",
		"密室 partB",
		"xgnjs_icon_0020",
		"第二章已解锁",
		1,
		1
	},
	{
		15103,
		"新章节解锁",
		"余响",
		"xgnjs_icon_0020",
		"第三章已解锁",
		1,
		1
	},
	{
		15104,
		"新章节解锁",
		"造梦者",
		"xgnjs_icon_0020",
		"第四章已解锁",
		1,
		1
	},
	{
		15105,
		"新章节解锁",
		"孤名",
		"xgnjs_icon_0020",
		"第五章已解锁",
		1,
		1
	},
	{
		15106,
		"新章节解锁",
		"棋手",
		"xgnjs_icon_0020",
		"第六章已解锁",
		1,
		1
	},
	{
		15201,
		"新章节解锁",
		"密室 partA-异常",
		"xgnjs_icon_0020",
		"第一章-异常已解锁",
		1,
		1
	},
	{
		15202,
		"新章节解锁",
		"密室 partB-异常",
		"xgnjs_icon_0020",
		"第二章-异常已解锁",
		1,
		1
	},
	{
		15203,
		"新章节解锁",
		"余响-异常",
		"xgnjs_icon_0020",
		"第三章-异常已解锁",
		1,
		1
	},
	{
		15204,
		"新章节解锁",
		"造梦者-异常",
		"xgnjs_icon_0020",
		"第四章-异常已解锁",
		1,
		1
	},
	{
		15205,
		"新章节解锁",
		"孤名-异常",
		"xgnjs_icon_0020",
		"第五章-异常已解锁",
		1,
		1
	},
	{
		15206,
		"新章节解锁",
		"棋手-异常",
		"xgnjs_icon_0020",
		"第六章-异常已解锁",
		1,
		1
	}
}
local t_system_open_hint = {}

t_system_open_hint.dataList = dataList

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
	t_system_open_hint[v[1]] = v

	setmetatable(v, mt)
end

return t_system_open_hint
