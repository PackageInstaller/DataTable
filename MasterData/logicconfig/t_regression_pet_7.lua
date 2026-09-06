-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_7.lua

module("logicconfig.config.t_regression_pet_7", package.seeall)

local title = {
	mark = 5,
	getDescription = 4,
	skinId = 3,
	type = 2,
	startTime = 9,
	endTime = 10,
	redPoint = 11,
	reportBehavior = 12,
	sqContent = 13,
	resources = 8,
	jumpType = 6,
	funcId = 7,
	sort = 1
}
local dataList = {
	{
		1,
		1,
		14045,
		"源起次元龙尊",
		0,
		1,
		"",
		"",
		"2026-06-26T09:00:00",
		nil,
		"",
		"",
		""
	},
	{
		2,
		1,
		11042,
		"源起哆啦梦梦",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		3,
		1,
		13031,
		"源起炼金梦梦",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		4,
		1,
		15050,
		"源起暗黑梦梦",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		5,
		1,
		12046,
		"源起热血梦梦",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		6,
		1,
		14044,
		"源起爱心梦梦",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		7,
		1,
		15048,
		"源起伊丽莎白",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		8,
		1,
		15047,
		"源起月影王",
		0,
		1,
		"",
		"",
		"2026-06-26T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		9,
		1,
		13030,
		"阿特拉斯",
		0,
		1,
		"",
		"",
		"2026-05-29T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		10,
		1,
		11039,
		"源起帝释天",
		0,
		1,
		"",
		"",
		"2026-05-29T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		11,
		1,
		11038,
		"源起冰灵王",
		0,
		1,
		"",
		"",
		"2026-05-29T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		12,
		1,
		12043,
		"召唤师末炎",
		0,
		1,
		"",
		"",
		"2026-04-30T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		13,
		1,
		12042,
		"源起龙炎",
		0,
		1,
		"",
		"",
		"2026-04-30T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		14,
		1,
		13027,
		"源起天蛮王",
		0,
		1,
		"",
		"",
		"2026-04-03T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		15,
		1,
		13026,
		"源起阿瑞斯",
		0,
		1,
		"",
		"",
		"2026-04-03T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		16,
		1,
		16043,
		"源起帝一鸣",
		0,
		1,
		"",
		"",
		"2026-03-13T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		17,
		1,
		14040,
		"源起诺亚",
		0,
		1,
		"",
		"",
		"2026-02-13T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		18,
		1,
		15042,
		"源起修尔",
		0,
		1,
		"",
		"",
		"2026-02-13T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		19,
		1,
		14041,
		"源起启",
		0,
		1,
		"",
		"",
		"2026-02-13T05:00:00",
		nil,
		"",
		"",
		""
	}
}
local t_regression_pet_7 = {
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
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19]
}

t_regression_pet_7.dataList = dataList

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

return t_regression_pet_7
