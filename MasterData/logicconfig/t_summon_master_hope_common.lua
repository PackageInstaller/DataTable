-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_common.lua

module("logicconfig.config.t_summon_master_hope_common", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 4,
	jumpRedIdThree = 9,
	jumpStrThree = 6,
	godRankScore = 11,
	ruleExplain = 10,
	jumpStrTwo = 5,
	jumpRedIdTwo = 8,
	comPlanId = 1,
	jumpRedIdOne = 7,
	ruleKeyMain = 3,
	dailyRankScore = 12
}
local dataList = {
	{
		1,
		18011,
		"zhoahuanshixiayin_rule_main",
		"mibao#shenyaonuoya1",
		"func#618#18011",
		"mibao#Skin",
		"",
		"",
		"",
		"敌方拥有20%减伤\r\n敌方在受击时，若受到非属性克制攻击，则受伤减少提升至60%",
		"30000",
		""
	}
}
local t_summon_master_hope_common = {
	dataList[1]
}

t_summon_master_hope_common.dataList = dataList

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

return t_summon_master_hope_common
