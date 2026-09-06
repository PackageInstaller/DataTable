-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_convoy_param.lua

module("logicconfig.config.t_convoy_param", package.seeall)

local title = {
	paramVal = 2,
	paramName = 1
}
local dataList = {
	{
		"openTime",
		"08:00-23:00"
	},
	{
		"maxConvoyTimes",
		"2"
	},
	{
		"maxFreeChallengeTimes",
		"2"
	},
	{
		"maxBeChallengedTimes",
		"2"
	},
	{
		"convoyPeriod",
		"30"
	},
	{
		"materialItem",
		"4:700"
	},
	{
		"convoyItem",
		"4:701:1"
	},
	{
		"robberyItem",
		"4:702:1"
	},
	{
		"convoyLine",
		"10012009,1181006,1191005,1171004"
	},
	{
		"familyScore",
		"200"
	},
	{
		"robotNum",
		"2"
	},
	{
		"robotBoxId",
		"3"
	},
	{
		"robotZdlFactor",
		"0.7"
	},
	{
		"convoySlowDown",
		"5000"
	},
	{
		"npcWhereMapIcon",
		"aoqicheng.png,shazhiguo.png,xingshenjie.png,shuguangsenlin.png"
	},
	{
		"notOpenView",
		"145,47,99,169,56,15,52,18,19,61,69,93,171,172,181,170,182,156,189,26,96,97,245"
	}
}
local t_convoy_param = {
	openTime = dataList[1],
	maxConvoyTimes = dataList[2],
	maxFreeChallengeTimes = dataList[3],
	maxBeChallengedTimes = dataList[4],
	convoyPeriod = dataList[5],
	materialItem = dataList[6],
	convoyItem = dataList[7],
	robberyItem = dataList[8],
	convoyLine = dataList[9],
	familyScore = dataList[10],
	robotNum = dataList[11],
	robotBoxId = dataList[12],
	robotZdlFactor = dataList[13],
	convoySlowDown = dataList[14],
	npcWhereMapIcon = dataList[15],
	notOpenView = dataList[16]
}

t_convoy_param.dataList = dataList

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

return t_convoy_param
