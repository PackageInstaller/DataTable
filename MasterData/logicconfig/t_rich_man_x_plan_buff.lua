-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_buff.lua

module("logicconfig.config.t_rich_man_x_plan_buff", package.seeall)

local title = {
	addRate = 4,
	name = 5,
	buffId = 2,
	iconRes = 7,
	effectDesc = 6,
	fakeItemId = 8,
	activityId = 1,
	times = 3
}
local dataList = {
	{
		373001,
		1,
		11,
		0.2,
		"资金增幅Lv.1",
		"资金收益增加20%，持续10次投骰子",
		"com_icon_boyige01",
		1365
	},
	{
		373001,
		2,
		10,
		0.5,
		"资金增幅Lv.2",
		"资金收益增加50%，持续9次投骰子",
		"com_icon_boyige01",
		1366
	},
	{
		373001,
		3,
		9,
		0.8,
		"资金增幅Lv.3",
		"资金收益增加80%，持续8次投骰子",
		"com_icon_boyige01",
		1367
	},
	{
		373001,
		4,
		8,
		1,
		"资金增幅Lv.4",
		"资金收益增加100%，持续7次投骰子",
		"com_icon_boyige01",
		1368
	},
	{
		373001,
		5,
		7,
		1.5,
		"资金增幅Lv.5",
		"资金收益增加150%，持续6次投骰子",
		"com_icon_boyige02",
		1369
	},
	{
		373001,
		6,
		6,
		2,
		"资金增幅Lv.6",
		"资金收益增加200%，持续5次投骰子",
		"com_icon_boyige02",
		1370
	},
	{
		373001,
		7,
		5,
		3,
		"资金增幅Lv.7",
		"资金收益增加300%，持续4次投骰子",
		"com_icon_boyige02",
		1371
	},
	{
		373001,
		8,
		4,
		4,
		"资金增幅Lv.8",
		"资金收益增加400%，持续3次投骰子",
		"com_icon_boyige02",
		1372
	},
	{
		373001,
		9,
		3,
		5,
		"资金增幅Lv.9",
		"资金收益增加500%，持续2次投骰子",
		"com_icon_boyige02",
		1373
	}
}
local t_rich_man_x_plan_buff = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_rich_man_x_plan_buff.dataList = dataList

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

return t_rich_man_x_plan_buff
