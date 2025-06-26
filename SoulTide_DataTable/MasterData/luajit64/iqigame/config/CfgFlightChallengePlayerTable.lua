-- chunkname: @IQIGame\\Config\\CfgFlightChallengePlayerTable.lua

local CfgFlightChallengePlayerTable = {
	[1001] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Akaset_Dress_01_Battle01.png",
		BulletEffect = 1,
		BulletPath = 1,
		SkillType = 1,
		PlayerSpine = 815101,
		SkillNun = 10,
		HeadIcon = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_Akaset_Dress_01_HeadIcon01.png",
		Id = 1001,
		MechaImage = "/Activity/FlightGame/FlightGameCommon/FlightGame_Akaset_1.png",
		Name = getI18NValue(180768342),
		Skill = getI18NValue(180776972),
		DamageBonus = {
			1,
			50
		},
		AttType = {
			1,
			2,
			3,
			4
		},
		AttValue = {
			500,
			100,
			1.5,
			100
		}
	},
	[1002] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_Andrea_Dress_01_Battle01.png",
		BulletEffect = 2,
		BulletPath = 2,
		SkillType = 2,
		PlayerSpine = 815102,
		SkillNun = 10,
		HeadIcon = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_Andrea_Dress_01_HeadIcon01.png",
		Id = 1002,
		MechaImage = "/Activity/FlightGame/FlightGameCommon/FlightGame_Andrea_1.png",
		Name = getI18NValue(180768343),
		Skill = getI18NValue(180776973),
		DamageBonus = {
			2,
			50
		},
		AttType = {
			1,
			2,
			3,
			4
		},
		AttValue = {
			500,
			100,
			1.5,
			100
		}
	},
	[1003] = {
		Group = 1,
		EndImage = "/Image_Resources/SoulResources/SoulResourcesAllDress/Image_EtsukazuMiko_Dress_01_Battle01.png",
		BulletEffect = 3,
		BulletPath = 3,
		SkillType = 3,
		PlayerSpine = 815103,
		SkillNun = 10,
		HeadIcon = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_EtsukazuMiko_Dress_01_HeadIcon01.png",
		Id = 1003,
		MechaImage = "/Activity/FlightGame/FlightGameCommon/FlightGame_EtsukazuMiko_1.png",
		Name = getI18NValue(180768344),
		Skill = getI18NValue(180776974),
		DamageBonus = {
			3,
			50
		},
		AttType = {
			1,
			2,
			3,
			4
		},
		AttValue = {
			500,
			100,
			1.5,
			100
		}
	}
}

setmetatable(CfgFlightChallengePlayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengePlayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Skill = "",
		EndImage = "",
		BulletEffect = 0,
		BulletPath = 0,
		SkillType = 0,
		PlayerSpine = 0,
		HeadIcon = "",
		Name = "",
		SkillNun = 0,
		MechaImage = "",
		DamageBonus = {},
		AttType = {
			0,
			0,
			0,
			0
		},
		AttValue = {
			0,
			0,
			0,
			0
		}
	}
}

for i, data in pairs(CfgFlightChallengePlayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengePlayerTable
