-- chunkname: @IQIGame\\Config\\CfgDreamMapSPRewardDataTable.lua

local CfgDreamMapSPRewardDataTable = {
	[1101] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 1101,
		RewardNum = 10
	},
	[1201] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 1201,
		RewardNum = 10
	},
	[1301] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 1301,
		RewardNum = 10
	},
	[1401] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 1401,
		RewardNum = 10
	},
	[1501] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 1501,
		RewardNum = 10
	},
	[1601] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 1601,
		RewardNum = 10
	},
	[1701] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 1701,
		RewardNum = 10
	},
	[1801] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 1801,
		RewardNum = 10
	},
	[1901] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 1901,
		RewardNum = 10
	},
	[2001] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 2001,
		RewardNum = 10
	},
	[2101] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 2101,
		RewardNum = 10
	},
	[2201] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 2201,
		RewardNum = 10
	},
	[2301] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 2301,
		RewardNum = 10
	},
	[2401] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 2401,
		RewardNum = 10
	},
	[2501] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 2501,
		RewardNum = 10
	},
	[2601] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 2601,
		RewardNum = 10
	},
	[2701] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 2701,
		RewardNum = 10
	},
	[2801] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 2801,
		RewardNum = 10
	},
	[2901] = {
		DropLimit = 20,
		RewardID = 2,
		DropWeight = 1,
		Id = 2901,
		RewardNum = 10
	},
	[3001] = {
		DropLimit = 30,
		RewardID = 2,
		DropWeight = 1,
		Id = 3001,
		RewardNum = 10
	},
	[3101] = {
		DropLimit = 50,
		RewardID = 2,
		DropWeight = 1,
		Id = 3101,
		RewardNum = 10
	}
}

setmetatable(CfgDreamMapSPRewardDataTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDreamMapSPRewardDataTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DropWeight = 0,
		RewardID = 0,
		DropLimit = 0,
		RewardNum = 0
	}
}

for i, data in pairs(CfgDreamMapSPRewardDataTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDreamMapSPRewardDataTable
