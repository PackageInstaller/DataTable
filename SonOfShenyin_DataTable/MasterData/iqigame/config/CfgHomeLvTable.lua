-- chunkname: @IQIGame\\Config\\CfgHomeLvTable.lua

local CfgHomeLvTable = {
	[30100001] = {
		UnlickTaskQuality = 5,
		TaskTypeCountLimt = 3,
		Id = 30100001,
		DispTaskSpotRecoverCount = 1,
		DispTaskSpotRecoverTime = 720,
		SpecialTaskGuaranteed = 6,
		SpecialTaskCountLimit = 1,
		TaskCountLimt = 8,
		EverydayTaskRefreshLimit = 10,
		DispTaskSpotRecoverLimt = 120,
		NeedPlayerLv = 1,
		Lv = 1,
		UnlockRoom = {
			30300002,
			30300003,
			30300004,
			30300005,
			30300006,
			30300007,
			30300008
		},
		EverydayTaskRefreshCost = {
			5000,
			5000,
			6000,
			7000,
			8000,
			9000,
			10000,
			15000,
			15000,
			20000
		}
	},
	[30100002] = {
		UnlickTaskQuality = 2,
		Id = 30100002,
		DispTaskSpotRecoverCount = 1,
		DispTaskSpotRecoverTime = 640,
		TaskCountLimt = 6,
		EverydayTaskRefreshLimit = 6,
		DispTaskSpotRecoverLimt = 135,
		NeedPlayerLv = 200,
		TaskTypeCountLimt = 3,
		Lv = 2,
		UpgradeNeedCost = {
			4,
			10000
		},
		EverydayTaskRefreshCost = {
			1000,
			1000,
			1000,
			2000,
			2000,
			2000
		}
	},
	[30100003] = {
		UnlickTaskQuality = 3,
		DispTaskSpotRecoverCount = 1,
		DispTaskSpotRecoverTime = 576,
		TaskCountLimt = 7,
		EverydayTaskRefreshLimit = 9,
		DispTaskSpotRecoverLimt = 150,
		Id = 30100003,
		TaskTypeCountLimt = 3,
		Lv = 3,
		UpgradeNeedCost = {
			4,
			50000
		},
		EverydayTaskRefreshCost = {
			1000,
			1000,
			1000,
			2000,
			2000,
			2000,
			3000,
			3000,
			3000
		}
	},
	[30100004] = {
		UnlickTaskQuality = 4,
		Id = 30100004,
		DispTaskSpotRecoverCount = 1,
		DispTaskSpotRecoverTime = 523,
		TaskCountLimt = 8,
		EverydayTaskRefreshLimit = 12,
		DispTaskSpotRecoverLimt = 165,
		NeedPlayerLv = 30,
		TaskTypeCountLimt = 3,
		Lv = 4,
		UpgradeNeedCost = {
			4,
			150000
		},
		EverydayTaskRefreshCost = {
			1000,
			1000,
			1000,
			2000,
			2000,
			2000,
			3000,
			3000,
			3000,
			4000,
			4000,
			4000
		}
	},
	[30100005] = {
		UnlickTaskQuality = 5,
		Id = 30100005,
		DispTaskSpotRecoverCount = 1,
		DispTaskSpotRecoverTime = 480,
		SpecialTaskGuaranteed = 10,
		SpecialTaskCountLimit = 1,
		TaskCountLimt = 10,
		EverydayTaskRefreshLimit = 15,
		DispTaskSpotRecoverLimt = 180,
		NeedPlayerLv = 40,
		TaskTypeCountLimt = 3,
		Lv = 5,
		UpgradeNeedCost = {
			4,
			300000
		},
		EverydayTaskRefreshCost = {
			1000,
			1000,
			1000,
			2000,
			2000,
			2000,
			3000,
			3000,
			3000,
			4000,
			4000,
			4000,
			5000,
			5000,
			5000
		}
	}
}

setmetatable(CfgHomeLvTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLvTable]")
	end
})

local defaultMetaTable = {
	__index = {
		UnlickTaskQuality = 0,
		NeedPlayerLv = 0,
		DispTaskSpotRecoverCount = 0,
		DispTaskSpotRecoverTime = 0,
		SpecialTaskGuaranteed = 0,
		TaskTypeCountLimt = 0,
		TaskCountLimt = 0,
		EverydayTaskRefreshLimit = 0,
		DispTaskSpotRecoverLimt = 0,
		SpecialTaskCountLimit = 0,
		Lv = 0,
		UpgradeNeedCost = {},
		UnlockRoom = {},
		EverydayTaskRefreshCost = {}
	}
}

for i, data in pairs(CfgHomeLvTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLvTable
