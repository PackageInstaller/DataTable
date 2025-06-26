-- chunkname: @IQIGame\\Config\\CfgTreasureHuntActivityTable.lua

local CfgTreasureHuntActivityTable = {
	[10001] = {
		ItemId = 3,
		ItemCount = 600,
		Heavy = 10,
		Id = 10001,
		ActivityId = 60007002
	},
	[10002] = {
		ItemId = 12023,
		ItemCount = 10,
		Heavy = 10,
		Id = 10002,
		ActivityId = 60007002
	},
	[10003] = {
		ItemId = 15015,
		ItemCount = 1,
		Heavy = 10,
		Id = 10003,
		ActivityId = 60007002
	},
	[10004] = {
		ItemId = 16005,
		ItemCount = 10,
		Heavy = 20,
		Id = 10004,
		ActivityId = 60007002
	},
	[10005] = {
		ItemId = 3,
		ItemCount = 100,
		Heavy = 20,
		Id = 10005,
		ActivityId = 60007002
	},
	[10006] = {
		ItemId = 15011,
		ItemCount = 30,
		Heavy = 30,
		Id = 10006,
		ActivityId = 60007002
	},
	[10007] = {
		ItemId = 15012,
		ItemCount = 30,
		Heavy = 30,
		Id = 10007,
		ActivityId = 60007002
	},
	[10008] = {
		ItemId = 15013,
		ItemCount = 30,
		Heavy = 30,
		Id = 10008,
		ActivityId = 60007002
	},
	[10009] = {
		ItemId = 15014,
		ItemCount = 30,
		Heavy = 30,
		Id = 10009,
		ActivityId = 60007002
	},
	[10010] = {
		ItemId = 15001,
		ItemCount = 20,
		Heavy = 30,
		Id = 10010,
		ActivityId = 60007002
	},
	[10011] = {
		ItemId = 15002,
		ItemCount = 20,
		Heavy = 30,
		Id = 10011,
		ActivityId = 60007002
	},
	[10012] = {
		ItemId = 15003,
		ItemCount = 20,
		Heavy = 30,
		Id = 10012,
		ActivityId = 60007002
	},
	[10013] = {
		ItemId = 15004,
		ItemCount = 20,
		Heavy = 30,
		Id = 10013,
		ActivityId = 60007002
	},
	[10014] = {
		ItemId = 15021,
		ItemCount = 40,
		Heavy = 30,
		Id = 10014,
		ActivityId = 60007002
	},
	[10015] = {
		ItemId = 3,
		ItemCount = 50,
		Heavy = 30,
		Id = 10015,
		ActivityId = 60007002
	},
	[10016] = {
		ItemId = 50033,
		ItemCount = 4,
		Heavy = 40,
		Id = 10016,
		ActivityId = 60007002
	},
	[10017] = {
		ItemId = 50004,
		ItemCount = 6,
		Heavy = 40,
		Id = 10017,
		ActivityId = 60007002
	},
	[10018] = {
		ItemId = 4,
		ItemCount = 30000,
		Heavy = 40,
		Id = 10018,
		ActivityId = 60007002
	},
	[10019] = {
		ItemId = 3,
		ItemCount = 30,
		Heavy = 40,
		Id = 10019,
		ActivityId = 60007002
	},
	[10020] = {
		ItemId = 50033,
		ItemCount = 3,
		Heavy = 50,
		Id = 10020,
		ActivityId = 60007002
	},
	[10021] = {
		ItemId = 50003,
		ItemCount = 6,
		Heavy = 50,
		Id = 10021,
		ActivityId = 60007002
	},
	[10022] = {
		ItemId = 4,
		ItemCount = 15000,
		Heavy = 50,
		Id = 10022,
		ActivityId = 60007002
	},
	[10023] = {
		ItemId = 50032,
		ItemCount = 4,
		Heavy = 80,
		Id = 10023,
		ActivityId = 60007002
	},
	[10024] = {
		ItemId = 50003,
		ItemCount = 2,
		Heavy = 80,
		Id = 10024,
		ActivityId = 60007002
	},
	[10025] = {
		ItemId = 4,
		ItemCount = 5000,
		Heavy = 80,
		Id = 10025,
		ActivityId = 60007002
	}
}

setmetatable(CfgTreasureHuntActivityTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTreasureHuntActivityTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ItemId = 0,
		ItemCount = 0,
		ActivityId = 0,
		Heavy = 0
	}
}

for i, data in pairs(CfgTreasureHuntActivityTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTreasureHuntActivityTable
