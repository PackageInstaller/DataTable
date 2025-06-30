-- chunkname: @IQIGame\\Config\\CfgMagicTowerEquipTable.lua

local CfgMagicTowerEquipTable = {
	[101] = {
		Id = 101,
		ItemID = 621,
		EquipType = 1,
		Atk = 10
	},
	[102] = {
		Id = 102,
		ItemID = 622,
		EquipType = 1,
		Atk = 20
	},
	[103] = {
		Id = 103,
		ItemID = 623,
		EquipType = 1,
		Atk = 30
	},
	[104] = {
		Id = 104,
		ItemID = 624,
		EquipType = 1,
		Atk = 40
	},
	[105] = {
		Id = 105,
		ItemID = 625,
		EquipType = 1,
		Atk = 50
	},
	[201] = {
		Id = 201,
		Def = 5,
		EquipType = 2,
		ItemID = 626
	},
	[202] = {
		Id = 202,
		Def = 10,
		EquipType = 2,
		ItemID = 627
	},
	[203] = {
		Id = 203,
		Def = 15,
		EquipType = 2,
		ItemID = 628
	},
	[204] = {
		Id = 204,
		Def = 20,
		EquipType = 2,
		ItemID = 629
	},
	[205] = {
		Id = 205,
		Def = 25,
		EquipType = 2,
		ItemID = 630
	}
}

setmetatable(CfgMagicTowerEquipTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMagicTowerEquipTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ItemID = 0,
		Def = 0,
		EquipType = 0,
		Atk = 0
	}
}

for i, data in pairs(CfgMagicTowerEquipTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMagicTowerEquipTable
