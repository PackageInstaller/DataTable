-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_mo_yan_clg_activity.lua

module("logicconfig.config.t_king_mo_yan_clg_activity", package.seeall)

local title = {
	jumpStrThree = 7,
	jumpRedIdThree = 10,
	supportPetId = 2,
	jumpStrOne = 5,
	jumpStrTwo = 6,
	jumpRedIdTwo = 9,
	jumpRedIdOne = 8,
	raceId = 3,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		429001,
		100001,
		12023,
		"wangzhemoyan_rule_main",
		"func#618#12023",
		"mibao#shuangjiekuanghuan3",
		"func#1164",
		"",
		"",
		""
	},
	{
		429002,
		100001,
		12023,
		"wangzhemoyan_rule_main",
		"func#618#12023",
		"mibao#shuangjiekuanghuan3",
		"func#1164",
		"",
		"",
		""
	}
}
local t_king_mo_yan_clg_activity = {
	[429001] = dataList[1],
	[429002] = dataList[2]
}

t_king_mo_yan_clg_activity.dataList = dataList

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

return t_king_mo_yan_clg_activity
