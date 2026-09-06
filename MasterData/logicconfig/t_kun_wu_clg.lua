-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_clg.lua

module("logicconfig.config.t_kun_wu_clg", package.seeall)

local title = {
	ruleKeyNormal = 5,
	skinId = 7,
	ruleKeyExtrem = 6,
	jumpStrOne = 8,
	jumpStrThree = 10,
	jumpStrTwo = 9,
	extremeClgPassPrize = 2,
	redPointId = 3,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		444001,
		"100:12028:1:1",
		667,
		"kunwuchallenge_rule_main",
		"kunwuchallenge_nor_rule_main",
		"kunwuchallenge_ext_rule_main",
		12028,
		"func#618#12028",
		"mibao#jinglingyangcheng",
		"func#43#129"
	}
}
local t_kun_wu_clg = {
	[444001] = dataList[1]
}

t_kun_wu_clg.dataList = dataList

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

return t_kun_wu_clg
