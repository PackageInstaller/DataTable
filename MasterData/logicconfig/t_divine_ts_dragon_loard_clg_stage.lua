-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ts_dragon_loard_clg_stage.lua

module("logicconfig.config.t_divine_ts_dragon_loard_clg_stage", package.seeall)

local title = {
	openDay = 3,
	passExpression = 4,
	stageId = 2,
	title = 7,
	rule = 8,
	teams = 6,
	activityId = 1,
	passPrize = 5
}
local dataList = {
	{
		418001,
		1,
		1,
		"A+B<=30",
		"4:510376:20",
		{
			1001,
			1002,
			1003
		},
		"第一层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	},
	{
		418001,
		2,
		1,
		"A+B>=30",
		"4:510376:30",
		{
			1004,
			1005,
			1006
		},
		"第二层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	},
	{
		418001,
		3,
		1,
		"A+B=30",
		"4:510376:50",
		{
			1007,
			1008,
			1009
		},
		"第三层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	},
	{
		418002,
		1,
		0,
		"A+B<=30",
		"8:1:1",
		{
			1001,
			1002,
			1003
		},
		"第一层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	},
	{
		418002,
		2,
		0,
		"A+B>=30",
		"8:1:1",
		{
			1004,
			1005,
			1006
		},
		"第二层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	},
	{
		418002,
		3,
		0,
		"A+B=30",
		"8:1:1",
		{
			1007,
			1008,
			1009
		},
		"第三层",
		"曙光印记：敌阵精灵死亡时，会移除负面状态，满血复活并变身为敌阵站位最靠前的存活精灵（敌阵站位最靠前的存活精灵死亡时会直接死亡），每触发一次该效果，曙光印记+1\r\n黑暗印记：己阵精灵死亡时，黑暗标记+1"
	}
}
local t_divine_ts_dragon_loard_clg_stage = {
	[418001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[418002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_ts_dragon_loard_clg_stage.dataList = dataList

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

return t_divine_ts_dragon_loard_clg_stage
