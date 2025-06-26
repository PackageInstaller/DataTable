-- chunkname: @IQIGame\\Config\\CfgMemoryEventListTable.lua

local CfgMemoryEventListTable = {
	[10101] = {
		TriggerType = 1,
		Element = 1013,
		Type = 3,
		Id = 10101,
		Position = {
			0,
			-3.34
		},
		Parameter = {
			"2"
		}
	},
	[10102] = {
		Element = 2013,
		TriggerType = 2,
		Distance = 1,
		Type = 1,
		Id = 10102,
		Position = {
			-1,
			-3.34
		},
		Parameter = {
			"大大大大大大大大大"
		}
	},
	[10103] = {
		Element = 3013,
		TriggerType = 2,
		Distance = 1,
		Type = 2,
		Id = 10103,
		Position = {
			-2,
			-3.34
		},
		Parameter = {
			"2009",
			"50000",
			"ElementRoot"
		}
	}
}

setmetatable(CfgMemoryEventListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMemoryEventListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TriggerType = 0,
		Element = 0,
		Type = 0,
		Direction = false,
		Distance = 0,
		FrontEvent = {},
		Position = {},
		Parameter = {}
	}
}

for i, data in pairs(CfgMemoryEventListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMemoryEventListTable
