-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_contract_common.lua

module("logicconfig.config.t_contract_common", package.seeall)

local title = {
	value = 2,
	key = 1,
	value2 = 3
}
local dataList = {
	{
		"SUMMON_MASTER_MIN_LVL",
		"1",
		0
	},
	{
		"SUMMONED_PET_MIN_LVL",
		"1",
		0
	},
	{
		"RESET_CONTRACT_SKILL_COST",
		"4:120001:10",
		0
	},
	{
		"SELF_SELECT_NEED_RESETS_TIMES",
		"50",
		0
	},
	{
		"ACTIVITY_ID",
		"19400",
		0
	},
	{
		"SELF_SELECT_COUNT_TIPS",
		"重置达到50次后，可任选任意技能；",
		82056435
	},
	{
		"SELF_SELECT_FREE_TIPS",
		"已达标任选重置次数要求，可任意选择技能。",
		82056050
	}
}
local t_contract_common = {
	SUMMON_MASTER_MIN_LVL = dataList[1],
	SUMMONED_PET_MIN_LVL = dataList[2],
	RESET_CONTRACT_SKILL_COST = dataList[3],
	SELF_SELECT_NEED_RESETS_TIMES = dataList[4],
	ACTIVITY_ID = dataList[5],
	SELF_SELECT_COUNT_TIPS = dataList[6],
	SELF_SELECT_FREE_TIPS = dataList[7]
}

t_contract_common.dataList = dataList

local multiLanguageCells = {
	value2 = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_contract_common
