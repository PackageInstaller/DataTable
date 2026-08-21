-- chunkname: @IQIGame\\Config\\CfgGuildAreaTable.lua

local CfgGuildAreaTable = {
	[10010] = {
		PosIndex = 1,
		IsUnlocked = 1,
		Id = 10010,
		FunctionType = 1,
		Name = getI18NValue(180500101)
	},
	[10020] = {
		PosIndex = 2,
		IsUnlocked = 1,
		Id = 10020,
		FunctionType = 2,
		Name = getI18NValue(180500102)
	},
	[10030] = {
		PosIndex = 3,
		IsUnlocked = 1,
		Id = 10030,
		FunctionType = 3,
		Name = getI18NValue(180500103)
	},
	[10040] = {
		PosIndex = 4,
		IsUnlocked = 1,
		Id = 10040,
		FunctionType = 4,
		Name = getI18NValue(180500104)
	},
	[10050] = {
		PosIndex = 5,
		IsUnlocked = 1,
		Id = 10050,
		FunctionType = 5,
		Name = getI18NValue(180500105)
	},
	[10060] = {
		PosIndex = 6,
		Id = 10060,
		FunctionType = 6,
		IsUnlocked = 1
	},
	[10070] = {
		PosIndex = 7,
		Id = 10070,
		FunctionType = 7,
		IsUnlocked = 1
	},
	[10080] = {
		PosIndex = 8,
		IsUnlocked = 1,
		Id = 10080,
		FunctionType = 8,
		Name = getI18NValue(180825931)
	}
}

setmetatable(CfgGuildAreaTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildAreaTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PosIndex = 0,
		Name = "",
		FunctionType = 0,
		IsUnlocked = 0
	}
}

for i, data in pairs(CfgGuildAreaTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildAreaTable
