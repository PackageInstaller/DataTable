-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_work_pet.lua

module("logicconfig.config.t_rich_man_x_plan_work_pet", package.seeall)

local title = {
	raceId = 2,
	name = 3,
	workType = 5,
	effectDesc = 4,
	linkRaceId = 6,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		"功夫熊猫",
		"放入专属工位后，打工收益增加20%",
		"街边走访",
		10159
	},
	{
		373001,
		2,
		"呆头鸭",
		"放入专属工位后，打工收益增加20%",
		"街边走访",
		10362
	},
	{
		373001,
		3,
		"阿瑞",
		"放入专属工位后，打工收益增加20%",
		"调查取证",
		10139
	},
	{
		373001,
		4,
		"绝息者·楼那",
		"放入专属工位后，打工收益增加20%",
		"调查取证",
		13004
	},
	{
		373001,
		5,
		"圣骑·迷踪",
		"放入专属工位后，打工收益增加20%",
		"街道潜行",
		13001
	},
	{
		373001,
		6,
		"神曜永恒·阿瑞斯",
		"放入专属工位后，打工收益增加20%",
		"街道潜行",
		13009
	},
	{
		373001,
		7,
		"不朽枯木·永恒圣龙",
		"放入专属工位后，打工收益增加20%",
		"深夜出逃",
		13008
	},
	{
		373001,
		8,
		"神曜八荒·天蛮王",
		"放入专属工位后，打工收益增加20%",
		"深夜出逃",
		13010
	},
	{
		373001,
		9,
		"创界天衍·昆仑",
		"放入专属工位后，打工收益增加20%",
		"据点巡逻",
		13013
	},
	{
		373001,
		10,
		"命运终章·梵瑞",
		"放入专属工位后，打工收益增加20%",
		"据点巡逻",
		13011
	},
	{
		373001,
		11,
		"生命神祇·阿瑞斯",
		"放入专属工位后，打工收益增加20%",
		"采购物资",
		13003
	},
	{
		373001,
		12,
		"神曜晨曦·盖西瑞",
		"放入专属工位后，打工收益增加20%",
		"采购物资",
		13014
	},
	{
		373001,
		13,
		"森境圣灵·卡雅",
		"放入专属工位后，打工收益增加20%",
		"深入虎穴",
		13015
	},
	{
		373001,
		14,
		"神曜梦蝶·潘多拉",
		"放入专属工位后，打工收益增加20%",
		"深入虎穴",
		13016
	},
	{
		373001,
		15,
		"藏天掌印·无问",
		"放入专属工位后，打工收益增加20%",
		"直面敌方",
		13017
	},
	{
		373001,
		16,
		"神曜罗刹·青骨",
		"放入专属工位后，打工收益增加20%",
		"直面敌方",
		13018
	}
}
local t_rich_man_x_plan_work_pet = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_rich_man_x_plan_work_pet.dataList = dataList

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

return t_rich_man_x_plan_work_pet
