-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_client_common.lua

module("logicconfig.config.t_hit_boss_client_common", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 5,
	ruleKeyExt = 4,
	jumpStrThree = 7,
	jumpRedIdThree = 11,
	jumpRedIdFour = 12,
	jumpStrTwo = 6,
	jumpRedIdTwo = 10,
	comPlanId = 1,
	jumpRedIdOne = 9,
	jumpStrFour = 8,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		18001,
		"kingkayamainview_rule",
		"kingkayaview_jixian_rule",
		"mibao#yingsenzhuxiang2",
		"func#618#13015",
		"func#43#125",
		"",
		"",
		"",
		"",
		""
	},
	{
		2,
		12022,
		"kingkayamainview_rule",
		"kingkayaview_jixian_rule",
		"func#618#12022",
		"func#1096",
		"mibao#qijijianglin2",
		"func#545#1",
		"",
		"",
		"",
		""
	}
}
local t_hit_boss_client_common = {
	dataList[1],
	dataList[2]
}

t_hit_boss_client_common.dataList = dataList

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

return t_hit_boss_client_common
