-- chunkname: @IQIGame\\Config\\CfgFlightChallengeElementTable.lua

local CfgFlightChallengeElementTable = {
	[1001] = {
		AttPlayer = 1001,
		Group = 1,
		ItemID = 125001,
		AttType = 1,
		Id = 1001,
		AttValue = 50
	},
	[1002] = {
		AttPlayer = 1001,
		Group = 1,
		ItemID = 125002,
		AttType = 2,
		Id = 1002,
		AttValue = 20
	},
	[1003] = {
		AttPlayer = 1001,
		Group = 1,
		ItemID = 125003,
		AttType = 3,
		Id = 1003,
		AttValue = 0.02
	},
	[1004] = {
		AttPlayer = 1001,
		Group = 1,
		ItemID = 125004,
		AttType = 4,
		Id = 1004,
		AttValue = 2
	},
	[2001] = {
		AttPlayer = 1002,
		Group = 1,
		ItemID = 125005,
		AttType = 1,
		Id = 2001,
		AttValue = 50
	},
	[2002] = {
		AttPlayer = 1002,
		Group = 1,
		ItemID = 125006,
		AttType = 2,
		Id = 2002,
		AttValue = 20
	},
	[2003] = {
		AttPlayer = 1002,
		Group = 1,
		ItemID = 125007,
		AttType = 3,
		Id = 2003,
		AttValue = 0.02
	},
	[2004] = {
		AttPlayer = 1002,
		Group = 1,
		ItemID = 125008,
		AttType = 4,
		Id = 2004,
		AttValue = 2
	},
	[3001] = {
		AttPlayer = 1003,
		Group = 1,
		ItemID = 125009,
		AttType = 1,
		Id = 3001,
		AttValue = 50
	},
	[3002] = {
		AttPlayer = 1003,
		Group = 1,
		ItemID = 125010,
		AttType = 2,
		Id = 3002,
		AttValue = 20
	},
	[3003] = {
		AttPlayer = 1003,
		Group = 1,
		ItemID = 125011,
		AttType = 3,
		Id = 3003,
		AttValue = 0.02
	},
	[3004] = {
		AttPlayer = 1003,
		Group = 1,
		ItemID = 125012,
		AttType = 4,
		Id = 3004,
		AttValue = 2
	}
}

setmetatable(CfgFlightChallengeElementTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengeElementTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AttPlayer = 0,
		AttValue = 0,
		ItemID = 0,
		AttType = 0,
		Group = 0
	}
}

for i, data in pairs(CfgFlightChallengeElementTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengeElementTable
