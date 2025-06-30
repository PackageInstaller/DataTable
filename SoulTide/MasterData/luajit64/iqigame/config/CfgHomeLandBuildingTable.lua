-- chunkname: @IQIGame\\Config\\CfgHomeLandBuildingTable.lua

local CfgHomeLandBuildingTable = {
	[36000001] = {
		BelongRoom = 15,
		ProductionID = 36100001,
		HelpParam = 1,
		Type = 1,
		Id = 36000001,
		HelpType = 1,
		Name = getI18NValue(180079086),
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079085)
	},
	[36000002] = {
		Manufacturing = 36200001,
		BelongRoom = 16,
		HelpParam = 5,
		Type = 2,
		Id = 36000002,
		HelpType = 2,
		TipID = 1015019,
		Name = getI18NValue(180079088),
		CanHelpTimes = {
			10,
			1
		},
		NamePos = {
			45,
			-200
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079087)
	},
	[36000003] = {
		BelongRoom = 19,
		HelpParam = 5,
		Type = 3,
		Id = 36000003,
		HelpType = 3,
		TipID = 1015020,
		Name = getI18NValue(180079090),
		PlantID = {
			1,
			2,
			3,
			4,
			5,
			6
		},
		CanHelpTimes = {
			10,
			1
		},
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079089)
	},
	[36000005] = {
		BelongRoom = 11,
		HelpParam = 5,
		Type = 5,
		Id = 36000005,
		HelpType = 5,
		Name = getI18NValue(180079092),
		CanHelpTimes = {
			10,
			1
		},
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079091)
	},
	[36000006] = {
		BelongRoom = 9,
		HelpParam = 5,
		Type = 6,
		Id = 36000006,
		HelpType = 6,
		Name = getI18NValue(180079094),
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079093)
	},
	[36000007] = {
		BelongRoom = 9,
		Type = 7,
		Id = 36000007,
		HelpType = 7,
		Name = getI18NValue(180079096),
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079095)
	},
	[36000008] = {
		BelongRoom = 16,
		Type = 8,
		Id = 36000008,
		HelpType = 7,
		Name = getI18NValue(180079098),
		NamePos = {
			0,
			0
		},
		HelpButtonPos = {
			0,
			80
		},
		HelpNotice = getI18NValue(180079097)
	}
}

setmetatable(CfgHomeLandBuildingTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandBuildingTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Manufacturing = 0,
		BelongRoom = 0,
		ProductionID = 0,
		HelpNotice = "",
		CompleteImage = "",
		Name = "",
		HelpParam = 0,
		Type = 0,
		HelpType = 0,
		TipID = 0,
		PlantID = {},
		CanHelpTimes = {},
		HelpButtonPos = {},
		NamePos = {}
	}
}

for i, data in pairs(CfgHomeLandBuildingTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandBuildingTable
