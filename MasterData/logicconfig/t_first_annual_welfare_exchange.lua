-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_first_annual_welfare_exchange.lua

module("logicconfig.config.t_first_annual_welfare_exchange", package.seeall)

local title = {
	poolType = 5,
	costQuality = 2,
	pageName = 10,
	weeklyRefresh = 8,
	costPos = 9,
	cosTips = 11,
	exchangeTips = 12,
	poolId = 6,
	matType = 4,
	showState = 13,
	pageTips = 14,
	exchangeId = 1,
	limitTimes = 7,
	costNum = 3
}
local dataList = {
	{
		1,
		4,
		6,
		18,
		2,
		1002,
		1,
		false,
		"-160:-80#0:-170#160:-80#-160:80#160:80#0:170",
		"换红色星神",
		"随机通用红色星神",
		"",
		1,
		""
	},
	{
		2,
		6,
		1,
		18,
		3,
		10011,
		1,
		true,
		"0:170",
		"换红色星神",
		"点击选择红色星神",
		"消耗59神钻可选指定红色星神，消耗99神钻可选气贯星河",
		1,
		""
	},
	{
		3,
		4,
		3,
		18,
		1,
		10010,
		1,
		false,
		"-145:-134#145:-134#0:170",
		"换金色星神",
		"点击选择金色星神",
		"气吞山河不在兑换范围中",
		0,
		""
	},
	{
		4,
		4,
		6,
		18,
		1,
		20010,
		1,
		false,
		"-160:-80#0:-170#160:-80#-160:80#160:80#0:170",
		"换气吞山河",
		"气吞山河",
		"",
		0,
		""
	},
	{
		5,
		8,
		4,
		7,
		1,
		30010,
		4,
		false,
		"-155:125#155:125#155:-125#-155:-125",
		"换属性橙装",
		"点击选择橙色装备",
		"",
		0,
		""
	},
	{
		6,
		9,
		4,
		7,
		1,
		20020,
		2,
		false,
		"-155:125#155:125#155:-125#-155:-125",
		"换属性橙+1",
		"点击选择橙色+1装备",
		"",
		0,
		""
	},
	{
		7,
		8,
		3,
		7,
		2,
		1001,
		5,
		false,
		"-145:-134#145:-134#0:170",
		"换随机橙装",
		"随机属性橙色装备",
		"",
		0,
		""
	}
}
local t_first_annual_welfare_exchange = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_first_annual_welfare_exchange.dataList = dataList

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

return t_first_annual_welfare_exchange
