-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_clg_common.lua

module("logicconfig.config.t_divine_xiu_er_clg_common", package.seeall)

local title = {
	jumpStrTwo = 7,
	skinId = 2,
	jumpStrOne = 6,
	jumpStrThree = 8,
	ruleKeyExt = 5,
	jumpRedIdThree = 12,
	ruleKeyNor = 4,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	comPlanId = 1,
	jumpRedIdOne = 10,
	jumpStrFour = 9,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		15018,
		"shenyaoxiuerchallenge_rule_main",
		"shenyaoxiuerchallenge_rule_quanmin",
		"shenyaoxiuerchallenge_rule_jixian",
		"mibao#shenyaolibao",
		"mibao#shuangjiekuanghuan3",
		"func#618#15018",
		"mibao#shengrihui1",
		"",
		"",
		"",
		""
	}
}
local t_divine_xiu_er_clg_common = {
	dataList[1]
}

t_divine_xiu_er_clg_common.dataList = dataList

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

return t_divine_xiu_er_clg_common
