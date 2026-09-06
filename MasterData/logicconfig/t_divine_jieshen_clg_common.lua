-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_common.lua

module("logicconfig.config.t_divine_jieshen_clg_common", package.seeall)

local title = {
	jumpStrTwo = 7,
	skinId = 2,
	jumpStrOne = 6,
	jumpStrThree = 8,
	ruleKeyExt = 5,
	ruleKeyNor = 4,
	comPlanId = 1,
	jumpStrFour = 9,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		16026,
		"divinejieshenmainview_rule",
		"divinejieshenmainview_rule",
		"divinejieshenmainview_rule",
		"mibao#shenyaolibao",
		"func#618#16026",
		"func#856",
		"func#545#25"
	}
}
local t_divine_jieshen_clg_common = {
	dataList[1]
}

t_divine_jieshen_clg_common.dataList = dataList

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

return t_divine_jieshen_clg_common
