-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_clg.lua

module("logicconfig.config.t_divine_ji_clg", package.seeall)

local title = {
	extremeClgPrize = 2,
	extremeClgBaseScore = 4,
	jumpStrOne = 6,
	jumpStrThree = 8,
	skinId = 9,
	extremeClgScoreDetails = 10,
	jumpStrTwo = 7,
	redPointId = 5,
	extremeClgTargetScore = 3,
	activityId = 1
}
local dataList = {
	{
		421001,
		"4:510378:100",
		8000,
		100,
		639,
		"mibao#shenyaolibao",
		"func#618#16027",
		"func#43#129",
		16027,
		"1、破阵后，己方每存活1只精灵获得100基础积分\r\n2、存活精灵中与本关属性相同的精灵数量越多，积分倍率越高，最终积分=总基础积分×积分倍率"
	},
	{
		421002,
		"8:1:1",
		8000,
		100,
		0,
		"mibao#shenyaolibao",
		"func#618#16027",
		"func#43#129",
		16027,
		"1、破阵后，己方每存活1只精灵获得100基础积分\r\n2、存活精灵中与本关属性相同的精灵数量越多，积分倍率越高，最终积分=总基础积分×积分倍率"
	}
}
local t_divine_ji_clg = {
	[421001] = dataList[1],
	[421002] = dataList[2]
}

t_divine_ji_clg.dataList = dataList

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

return t_divine_ji_clg
