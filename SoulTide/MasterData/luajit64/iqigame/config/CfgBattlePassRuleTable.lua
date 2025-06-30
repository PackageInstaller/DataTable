-- chunkname: @IQIGame\\Config\\CfgBattlePassRuleTable.lua

local CfgBattlePassRuleTable = {
	{
		Point = 1,
		Image = "/MainCity/PassCheckUI/PassCheckFunctionInfoUI_Image_01.png",
		RuleType = 1,
		Id = 1,
		Desc = getI18NValue(180000002)
	},
	{
		Point = 2,
		Image = "/MainCity/PassCheckUI/PassCheckFunctionInfoUI_Image_01.png",
		RuleType = 2,
		Id = 2,
		Desc = getI18NValue(180000003)
	}
}

setmetatable(CfgBattlePassRuleTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgBattlePassRuleTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Image = "",
		Point = 0,
		RuleType = 0,
		Desc = ""
	}
}

for i, data in pairs(CfgBattlePassRuleTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgBattlePassRuleTable
