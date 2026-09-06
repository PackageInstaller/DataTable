-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_loop_clg_attribute.lua

module("logicconfig.config.t_chop_king_loop_clg_attribute", package.seeall)

local title = {
	zdl = 3,
	loopId = 2,
	rank = 4,
	loopDesc = 8,
	activeScorePlanId = 7,
	circleScorePlanId = 6,
	activityId = 1,
	baseScore = 5
}
local dataList = {
	{
		470001,
		1,
		400000,
		false,
		5,
		3,
		2,
		"属性增加0%"
	},
	{
		470001,
		2,
		600000,
		false,
		5,
		3,
		2,
		"属性增加50%"
	},
	{
		470001,
		3,
		800000,
		false,
		5,
		3,
		2,
		"属性增加100%"
	},
	{
		470001,
		4,
		1000000,
		false,
		5,
		3,
		2,
		"属性增加150%"
	},
	{
		470001,
		5,
		1200000,
		false,
		5,
		3,
		2,
		"属性增加200%"
	},
	{
		470001,
		6,
		2000000,
		true,
		5,
		3,
		2,
		"属性增加400%"
	},
	{
		470001,
		7,
		4000000,
		true,
		5,
		3,
		2,
		"属性增加900%"
	},
	{
		470001,
		8,
		6000000,
		true,
		5,
		3,
		2,
		"属性增加1400%"
	},
	{
		470001,
		9,
		8000000,
		true,
		5,
		3,
		2,
		"属性增加1900%"
	},
	{
		470001,
		10,
		10000000,
		true,
		5,
		3,
		2,
		"属性增加2400%"
	}
}
local t_chop_king_loop_clg_attribute = {
	[470001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_chop_king_loop_clg_attribute.dataList = dataList

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

return t_chop_king_loop_clg_attribute
