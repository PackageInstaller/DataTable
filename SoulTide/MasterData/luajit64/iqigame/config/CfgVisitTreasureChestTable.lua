-- chunkname: @IQIGame\\Config\\CfgVisitTreasureChestTable.lua

local CfgVisitTreasureChestTable = {
	{
		Id = 1,
		RoomId = 15,
		BoxDecorate = 6001,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			3,
			0
		}
	},
	{
		Id = 2,
		RoomId = 15,
		BoxDecorate = 6001,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			22,
			0
		}
	},
	{
		Id = 3,
		RoomId = 15,
		BoxDecorate = 6001,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			32,
			0
		}
	},
	{
		Id = 4,
		RoomId = 15,
		BoxDecorate = 6001,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			52,
			0
		}
	},
	{
		Id = 5,
		RoomId = 15,
		BoxDecorate = 6001,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			62,
			0
		}
	},
	{
		Id = 6,
		RoomId = 11,
		BoxDecorate = 6003,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			6,
			0
		}
	},
	{
		Id = 7,
		RoomId = 11,
		BoxDecorate = 6003,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			22,
			0
		}
	},
	{
		Id = 8,
		RoomId = 11,
		BoxDecorate = 6003,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			27,
			0
		}
	},
	{
		Id = 9,
		RoomId = 11,
		BoxDecorate = 6003,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			18,
			0
		}
	},
	{
		Id = 10,
		RoomId = 9,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			16,
			0
		}
	},
	{
		Id = 11,
		RoomId = 9,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			35,
			0
		}
	},
	{
		Id = 12,
		RoomId = 9,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			12,
			0
		}
	},
	{
		Id = 13,
		RoomId = 9,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			27,
			0
		}
	},
	{
		Id = 14,
		RoomId = 16,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			27,
			0
		}
	},
	{
		Id = 15,
		RoomId = 16,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			16,
			0
		}
	},
	{
		Id = 16,
		RoomId = 16,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			22,
			0
		}
	},
	{
		Id = 17,
		RoomId = 16,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			31,
			0
		}
	},
	{
		Id = 18,
		RoomId = 16,
		BoxDecorate = 6002,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			42,
			0
		}
	},
	{
		Id = 19,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			12,
			0
		}
	},
	{
		Id = 20,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			25,
			0
		}
	},
	{
		Id = 21,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			37,
			0
		}
	},
	{
		Id = 22,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			56,
			0
		}
	},
	{
		Id = 23,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			65,
			0
		}
	},
	{
		Id = 24,
		RoomId = 19,
		BoxDecorate = 6004,
		BoxReward = {
			10610002
		},
		BoxPoint = {
			83,
			0
		}
	}
}

setmetatable(CfgVisitTreasureChestTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgVisitTreasureChestTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RoomId = 0,
		BoxDecorate = 0,
		BoxPoint = {},
		BoxReward = {}
	}
}

for i, data in pairs(CfgVisitTreasureChestTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgVisitTreasureChestTable
