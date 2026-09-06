-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_dragon_common.lua

module("logicconfig.config.t_divine_king_dragon_common", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 4,
	jumpRedIdThree = 9,
	jumpStrThree = 6,
	jumpStrTwo = 5,
	jumpRedIdTwo = 8,
	comPlanId = 1,
	jumpRedIdOne = 7,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		17014,
		"wangzhelongchallenge_rule_main",
		"func#618#17014",
		"mibao#shenyaolibao",
		"func#43#119",
		"",
		"",
		""
	}
}
local t_divine_king_dragon_common = {
	dataList[1]
}

t_divine_king_dragon_common.dataList = dataList

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

return t_divine_king_dragon_common
