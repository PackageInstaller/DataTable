-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_common.lua

module("logicconfig.config.t_lotus_battle_field_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MATCH_TIME",
		"30"
	},
	{
		"rulekey_mainview",
		"honglianzhanchang_rule"
	},
	{
		"title_mainview",
		"红莲战场"
	},
	{
		"gold_mainview",
		"104:2#10:17073"
	},
	{
		"shopJumpTo_mainview",
		"func#191#268#268002"
	},
	{
		"shareJumpTo",
		"func#880"
	}
}
local t_lotus_battle_field_common = {
	MATCH_TIME = dataList[1],
	rulekey_mainview = dataList[2],
	title_mainview = dataList[3],
	gold_mainview = dataList[4],
	shopJumpTo_mainview = dataList[5],
	shareJumpTo = dataList[6]
}

t_lotus_battle_field_common.dataList = dataList

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

return t_lotus_battle_field_common
