-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_inflation_money_related_actId.lua

module("logicconfig.config.t_inflation_money_related_actId", package.seeall)

local title = {
	relatedActivityType = 2,
	activityId = 1,
	deductWanPercent = 6,
	deductToZeroAddCost = 5,
	deductMaxCount = 4,
	relatedActId = 3
}
local dataList = {
	{
		452001,
		219,
		219008,
		20,
		"8:1:1",
		0
	},
	{
		452001,
		215,
		215105,
		0,
		"",
		1000
	},
	{
		452001,
		215,
		215106,
		0,
		"",
		1000
	},
	{
		452001,
		215,
		215107,
		0,
		"",
		1000
	},
	{
		452001,
		25,
		25032,
		0,
		"",
		1000
	},
	{
		452001,
		25,
		25033,
		0,
		"",
		1000
	},
	{
		452001,
		25,
		25034,
		0,
		"",
		1000
	}
}
local t_inflation_money_related_actId = {
	[452001] = {
		[219008] = dataList[1],
		[215105] = dataList[2],
		[215106] = dataList[3],
		[215107] = dataList[4],
		[25032] = dataList[5],
		[25033] = dataList[6],
		[25034] = dataList[7]
	}
}

t_inflation_money_related_actId.dataList = dataList

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

return t_inflation_money_related_actId
