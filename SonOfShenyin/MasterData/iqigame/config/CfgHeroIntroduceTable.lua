-- chunkname: @IQIGame\\Config\\CfgHeroIntroduceTable.lua

local CfgHeroIntroduceTable = {
	[10001] = {
		Order = 1,
		Id = 10001,
		IntroduceHero = {
			10000001,
			10000032,
			10000030
		},
		TitleText = getI18NValue(180260861),
		IntroduceText = getI18NValue(180260862)
	},
	[10002] = {
		Order = 5,
		Id = 10002,
		IntroduceHero = {
			10000001,
			10000016
		},
		TitleText = getI18NValue(180260863),
		IntroduceText = getI18NValue(180260864)
	},
	[10003] = {
		Order = 2,
		Id = 10003,
		IntroduceHero = {
			10000020,
			10000021,
			10000011
		},
		TitleText = getI18NValue(180260865),
		IntroduceText = getI18NValue(180260866)
	},
	[10004] = {
		Order = 6,
		Id = 10004,
		IntroduceHero = {
			10000009,
			10000005,
			10000021
		},
		TitleText = getI18NValue(180260867),
		IntroduceText = getI18NValue(180260868)
	},
	[10005] = {
		Order = 3,
		Id = 10005,
		IntroduceHero = {
			10000013,
			10000002,
			10000008
		},
		TitleText = getI18NValue(180260869),
		IntroduceText = getI18NValue(180260870)
	},
	[10006] = {
		Order = 7,
		Id = 10006,
		IntroduceHero = {
			10000023,
			10000006
		},
		TitleText = getI18NValue(180260871),
		IntroduceText = getI18NValue(180260872)
	},
	[10007] = {
		Order = 4,
		Id = 10007,
		IntroduceHero = {
			10000004,
			10000017,
			10000031
		},
		TitleText = getI18NValue(180260873),
		IntroduceText = getI18NValue(180260874)
	},
	[10008] = {
		Order = 8,
		Id = 10008,
		IntroduceHero = {
			10000024,
			10000004
		},
		TitleText = getI18NValue(180260875),
		IntroduceText = getI18NValue(180260876)
	}
}

setmetatable(CfgHeroIntroduceTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHeroIntroduceTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TitleText = "",
		Order = 0,
		IntroduceText = "",
		IntroduceHero = {},
		Tag = {}
	}
}

for i, data in pairs(CfgHeroIntroduceTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHeroIntroduceTable
