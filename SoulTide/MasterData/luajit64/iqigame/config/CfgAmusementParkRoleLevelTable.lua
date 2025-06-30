-- chunkname: @IQIGame\\Config\\CfgAmusementParkRoleLevelTable.lua

local CfgAmusementParkRoleLevelTable = {
	[1001] = {
		Group = 1,
		Level = 1,
		Id = 1001,
		Cost = {
			351,
			660
		}
	},
	[1002] = {
		Group = 1,
		Level = 2,
		Id = 1002,
		Cost = {
			351,
			6800
		}
	},
	[1003] = {
		Group = 1,
		Level = 3,
		Id = 1003,
		Cost = {
			351,
			28000
		}
	},
	[1004] = {
		Group = 1,
		Level = 4,
		Id = 1004,
		Cost = {
			351,
			73000
		}
	},
	[1005] = {
		Group = 1,
		Level = 5,
		Id = 1005,
		Cost = {
			351,
			200000
		}
	},
	[1006] = {
		Group = 1,
		Level = 6,
		Id = 1006,
		Cost = {
			351,
			370000
		}
	},
	[1007] = {
		Group = 1,
		Level = 7,
		Id = 1007,
		Cost = {
			351,
			770000
		}
	},
	[1008] = {
		Group = 1,
		Level = 8,
		Id = 1008,
		Cost = {
			351,
			1400000
		}
	},
	[1009] = {
		Group = 1,
		Level = 9,
		Id = 1009,
		Cost = {
			351,
			2600000
		}
	},
	[1010] = {
		Group = 1,
		Level = 10,
		Id = 1010
	}
}

setmetatable(CfgAmusementParkRoleLevelTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkRoleLevelTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Level = 0,
		Cost = {}
	}
}

for i, data in pairs(CfgAmusementParkRoleLevelTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkRoleLevelTable
