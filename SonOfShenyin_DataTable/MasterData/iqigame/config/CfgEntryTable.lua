-- chunkname: @IQIGame\\Config\\CfgEntryTable.lua

local CfgEntryTable = {
	[20001] = {
		Id = 20001,
		Name = getI18NValue(180001083),
		Describe = getI18NValue(180001082)
	},
	[20002] = {
		Id = 20002,
		Name = getI18NValue(180001085),
		Describe = getI18NValue(180001084)
	},
	[20003] = {
		Id = 20003,
		Name = getI18NValue(180001087),
		Describe = getI18NValue(180001086)
	},
	[20004] = {
		Id = 20004,
		Name = getI18NValue(180001089),
		Describe = getI18NValue(180001088)
	},
	[20005] = {
		Id = 20005,
		Name = getI18NValue(180001091),
		Describe = getI18NValue(180001090)
	},
	[20006] = {
		Id = 20006,
		Name = getI18NValue(180001093),
		Describe = getI18NValue(180001092)
	},
	[20007] = {
		Id = 20007,
		Name = getI18NValue(180001095),
		Describe = getI18NValue(180001094)
	},
	[20008] = {
		Id = 20008,
		Name = getI18NValue(180001097),
		Describe = getI18NValue(180001096)
	},
	[20009] = {
		Id = 20009,
		Name = getI18NValue(180001099),
		Describe = getI18NValue(180001098)
	},
	[20010] = {
		Id = 20010,
		Name = getI18NValue(180001101),
		Describe = getI18NValue(180001100)
	}
}

setmetatable(CfgEntryTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEntryTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		Describe = "",
		StrengthenId = 0
	}
}

for i, data in pairs(CfgEntryTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEntryTable
