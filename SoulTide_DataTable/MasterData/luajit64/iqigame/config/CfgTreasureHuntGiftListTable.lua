-- chunkname: @IQIGame\\Config\\CfgTreasureHuntGiftListTable.lua

local CfgTreasureHuntGiftListTable = {
	[1001] = {
		Team = 1,
		Id = 1001,
		LimitTime = 10,
		NeedItem = {
			20807,
			1,
			20808,
			1,
			20809,
			1,
			20810,
			1
		},
		Reward = {
			10005,
			1
		}
	},
	[1002] = {
		Team = 1,
		Id = 1002,
		LimitTime = 10,
		NeedItem = {
			20811,
			1,
			20812,
			1,
			20813,
			1,
			20814,
			1
		},
		Reward = {
			10006,
			1
		}
	},
	[1003] = {
		Team = 1,
		Id = 1003,
		LimitTime = 10,
		NeedItem = {
			20815,
			1,
			20816,
			1,
			20817,
			1,
			20818,
			1
		},
		Reward = {
			10028,
			1
		}
	},
	[1004] = {
		Team = 2,
		Id = 1004,
		LimitTime = 10,
		NeedItem = {
			20848,
			1,
			20849,
			1,
			20850,
			1,
			20851,
			1
		},
		Reward = {
			10005,
			1
		}
	},
	[1005] = {
		Team = 2,
		Id = 1005,
		LimitTime = 10,
		NeedItem = {
			20852,
			1,
			20853,
			1,
			20854,
			1,
			20855,
			1
		},
		Reward = {
			10006,
			1
		}
	},
	[1006] = {
		Team = 2,
		Id = 1006,
		LimitTime = 10,
		NeedItem = {
			20856,
			1,
			20857,
			1,
			20858,
			1,
			20859,
			1
		},
		Reward = {
			10028,
			1
		}
	},
	[1007] = {
		Team = 3,
		Id = 1007,
		LimitTime = 10,
		NeedItem = {
			20880,
			1,
			20881,
			1,
			20882,
			1,
			20883,
			1
		},
		Reward = {
			10005,
			1
		}
	},
	[1008] = {
		Team = 3,
		Id = 1008,
		LimitTime = 10,
		NeedItem = {
			20884,
			1,
			20885,
			1,
			20886,
			1,
			20887,
			1
		},
		Reward = {
			10006,
			1
		}
	},
	[1009] = {
		Team = 3,
		Id = 1009,
		LimitTime = 10,
		NeedItem = {
			20888,
			1,
			20889,
			1,
			20890,
			1,
			20891,
			1
		},
		Reward = {
			10028,
			1
		}
	}
}

setmetatable(CfgTreasureHuntGiftListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTreasureHuntGiftListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Team = 0,
		LimitTime = 0,
		NeedItem = {},
		Reward = {}
	}
}

for i, data in pairs(CfgTreasureHuntGiftListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTreasureHuntGiftListTable
