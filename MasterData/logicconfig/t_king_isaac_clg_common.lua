-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_isaac_clg_common.lua

module("logicconfig.config.t_king_isaac_clg_common", package.seeall)

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
		16020,
		"wangzheyisachallenge_rule_main",
		"func#618#16020",
		"func#1039",
		"mibao#liudaojijie2",
		"",
		"",
		""
	}
}
local t_king_isaac_clg_common = {
	dataList[1]
}

t_king_isaac_clg_common.dataList = dataList

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

return t_king_isaac_clg_common
