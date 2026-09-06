-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_wei_lei_ta_clg_team.lua

module("logicconfig.config.t_divine_wei_lei_ta_clg_team", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	winDesc = 10,
	skipTime = 3,
	retreatMsgType = 8,
	bottomDesc = 11,
	btlMode = 6,
	btlBg = 4,
	winId = 7,
	creepsMasterId = 1,
	heroSkillId = 5
}
local dataList = {
	{
		101,
		"全民1",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		102,
		"全民2",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		103,
		"全民3",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1001,
		"第1关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1002,
		"第2关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1003,
		"第3关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1004,
		"第4关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1005,
		"第5关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1006,
		"第6关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1007,
		"第7关",
		5,
		"",
		"413015",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1008,
		"第8关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1009,
		"第9关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1010,
		"第10关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1011,
		"第11关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	},
	{
		1012,
		"第12关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"光圈位置上的精灵带有火焰标记，自动激活标记效果，通关后将被封印"
	}
}
local t_divine_wei_lei_ta_clg_team = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[1001] = dataList[4],
	[1002] = dataList[5],
	[1003] = dataList[6],
	[1004] = dataList[7],
	[1005] = dataList[8],
	[1006] = dataList[9],
	[1007] = dataList[10],
	[1008] = dataList[11],
	[1009] = dataList[12],
	[1010] = dataList[13],
	[1011] = dataList[14],
	[1012] = dataList[15]
}

t_divine_wei_lei_ta_clg_team.dataList = dataList

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

return t_divine_wei_lei_ta_clg_team
