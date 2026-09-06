-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ts_dragon_loard_clg_common.lua

module("logicconfig.config.t_divine_ts_dragon_loard_clg_common", package.seeall)

local title = {
	ruleKeyLevel = 4,
	skinId = 2,
	jumpStrThree = 7,
	jumpStrOne = 5,
	jumpRedIdThree = 10,
	jumpStrTwo = 6,
	jumpRedIdTwo = 9,
	comPlanId = 1,
	jumpRedIdOne = 8,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		15027,
		"shenyaoshikonglongzun_rule_main",
		"zhoahuanshixiayin_rule_main",
		"func#618#15027",
		"func#43",
		"mibao#anxishenyao2",
		"",
		"",
		""
	}
}
local t_divine_ts_dragon_loard_clg_common = {
	dataList[1]
}

t_divine_ts_dragon_loard_clg_common.dataList = dataList

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

return t_divine_ts_dragon_loard_clg_common
