-- chunkname: @IQIGame\\Config\\CfgSurvivalChallengeAttributeTable.lua

local CfgSurvivalChallengeAttributeTable = {
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		IsShow = true,
		Id = 1,
		AttName = getI18NValue(180918097)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_Attack.png",
		IsShow = true,
		Id = 2,
		AttName = getI18NValue(180918098)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_Attack_Speed.png",
		IsShow = true,
		Id = 3,
		AttName = getI18NValue(180918099)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		Id = 4,
		AttName = getI18NValue(180918100)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		Id = 5,
		AttName = getI18NValue(180918101)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		Id = 6,
		AttName = getI18NValue(180918102)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		Id = 7,
		AttName = getI18NValue(180918103)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_HP.png",
		Id = 8,
		AttName = getI18NValue(180918162)
	},
	{
		Group = 2,
		ImageIcon = "/Activity/SurvivalFlyGame/SurvivalFlyGameSettlementUI/Icon_Weapon_Lv.png",
		IsShow = true,
		Id = 9,
		AttName = getI18NValue(180918427)
	}
}

setmetatable(CfgSurvivalChallengeAttributeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSurvivalChallengeAttributeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ImageIcon = "",
		AttName = "",
		IsShow = false
	}
}

for i, data in pairs(CfgSurvivalChallengeAttributeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSurvivalChallengeAttributeTable
