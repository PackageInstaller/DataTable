-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationPostControlTable.lua

local CfgRestaurantOperationPostControlTable = {
	[1001] = {
		Group = 1,
		MainAtt = 1,
		InComeID = 2,
		WalkArea = 1,
		Type = 1,
		IsInTheRoom = 1,
		Id = 1001,
		PostName = getI18NValue(180829304),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833937),
			getI18NValue(180833938),
			getI18NValue(180833939),
			getI18NValue(180833940),
			getI18NValue(180835327)
		}
	},
	[1002] = {
		Group = 1,
		MainAtt = 2,
		InComeID = 3,
		WalkArea = 2,
		Type = 2,
		IsInTheRoom = 1,
		Id = 1002,
		PostName = getI18NValue(180829305),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833941),
			getI18NValue(180833942),
			getI18NValue(180833943),
			getI18NValue(180833944),
			getI18NValue(180835328)
		}
	},
	[1003] = {
		Group = 1,
		MainAtt = 3,
		InComeID = 4,
		WalkArea = 3,
		Type = 3,
		IsInTheRoom = 1,
		Id = 1003,
		PostName = getI18NValue(180829306),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833945),
			getI18NValue(180833946),
			getI18NValue(180833947),
			getI18NValue(180833948),
			getI18NValue(180835329)
		}
	},
	[1004] = {
		Group = 1,
		MainAtt = 4,
		InComeID = 1,
		WalkArea = 3,
		Type = 4,
		IsInTheRoom = 2,
		Id = 1004,
		PostName = getI18NValue(180829307),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833949),
			getI18NValue(180833950),
			getI18NValue(180833951),
			getI18NValue(180833952),
			getI18NValue(180835330)
		}
	},
	[1005] = {
		Group = 1,
		Type = 5,
		MainAtt = 5,
		WalkArea = 3,
		IsInTheRoom = 2,
		Id = 1005,
		PostName = getI18NValue(180829308),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833953),
			getI18NValue(180833954),
			getI18NValue(180833955),
			getI18NValue(180833956),
			getI18NValue(180835331)
		}
	},
	[1006] = {
		Group = 1,
		MainAtt = 6,
		InComeID = 6,
		WalkArea = 3,
		Type = 6,
		IsInTheRoom = 2,
		Id = 1006,
		PostName = getI18NValue(180829309),
		RetroactiveBehavior = {
			"idle",
			"eat",
			"homeInsert01",
			"homeInsert02",
			"homeInsert03"
		},
		PostUnlockDesc = {
			getI18NValue(180833957),
			getI18NValue(180833958),
			getI18NValue(180833959),
			getI18NValue(180833960),
			getI18NValue(180835332)
		}
	}
}

setmetatable(CfgRestaurantOperationPostControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationPostControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		InComeID = 0,
		MainAtt = 0,
		WalkArea = 0,
		Type = 0,
		IsInTheRoom = 0,
		PostName = "",
		RetroactiveBehavior = {},
		PostUnlockDesc = {}
	}
}

for i, data in pairs(CfgRestaurantOperationPostControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationPostControlTable
