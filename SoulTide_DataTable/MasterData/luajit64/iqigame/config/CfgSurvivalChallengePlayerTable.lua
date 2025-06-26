-- chunkname: @IQIGame\\Config\\CfgSurvivalChallengePlayerTable.lua

local CfgSurvivalChallengePlayerTable = {
	[1001] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Akaset_Dress_01_Battle01.png",
		PlayerSpine = 815104,
		Animation = "homeInsert03",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Benten_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Benten_Homeland_01_HeadIcon01.png",
		Id = 1001,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_05",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFlyGameMainUI/FlightGame_Benten_1.png",
		Name = getI18NValue(180918115),
		Skill = getI18NValue(180918114)
	},
	[1002] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Andrea_Dress_01_Battle01.png",
		PlayerSpine = 815105,
		Animation = "homeInsert03",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Minerdwen_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Minerdwen_Homeland_01_HeadIcon01.png",
		Id = 1002,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_07",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFlyGameMainUI/FlightGame_Minerdwen_1.png",
		Name = getI18NValue(180918117),
		Skill = getI18NValue(180918116)
	},
	[1003] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_EtsukazuMiko_Dress_01_Battle01.png",
		PlayerSpine = 815106,
		Animation = "homeInsert01",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_QingDai_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_QingDai_Homeland_01_HeadIcon01.png",
		Id = 1003,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_35",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFlyGameMainUI/FlightGame_QingDai_1.png",
		Name = getI18NValue(180918119),
		Skill = getI18NValue(180918118)
	},
	[2001] = {
		Group = 2,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Alisa_Dress_01_Battle01.png",
		PlayerSpine = 815107,
		Animation = "Active",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Alisa_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalChallengeUpgradeUI_02/Role.png",
		Id = 2001,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_25",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameMainUI_02/SurvivalAction_Alisa_idle.png",
		Name = getI18NValue(180946762),
		Skill = getI18NValue(180946761)
	},
	[2002] = {
		Group = 2,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress2/Antonina/Image_Antonina_Dress_01_Battle01.png",
		PlayerSpine = 815108,
		Animation = "Active",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Antonina_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalChallengeUpgradeUI_02/Role_2.png",
		Id = 2002,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_39",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameMainUI_02/SurvivalAction_Antonina_idle.png",
		Name = getI18NValue(180946764),
		Skill = getI18NValue(180946763)
	},
	[2003] = {
		Group = 2,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Dreizehn_Dress_01_Battle01.png",
		PlayerSpine = 815109,
		Animation = "Active",
		HeadIcon = "/Image_Resources/SoulResources/SoulHomeLandHead/Image_Dreizehn_Homeland_01_HeadIcon01.png",
		PlayerImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalChallengeUpgradeUI_02/Role_3.png",
		Id = 2003,
		PlayerStart = "/_SurvivalChallengePayerUI/SurvivalPlayer_15",
		MechaImage = "/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameMainUI_02/SurvivalAction_Dreizehn_Active.png",
		Name = getI18NValue(180946766),
		Skill = getI18NValue(180946765)
	}
}

setmetatable(CfgSurvivalChallengePlayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSurvivalChallengePlayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Skill = "",
		EndImage = "",
		PlayerSpine = 0,
		Animation = "",
		HeadIcon = "",
		Name = "",
		PlayerImage = "",
		PlayerStart = "",
		MechaImage = ""
	}
}

for i, data in pairs(CfgSurvivalChallengePlayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSurvivalChallengePlayerTable
