-- chunkname: @IQIGame\\Config\\CfgMagicTowerMapTable.lua

local CfgMagicTowerMapTable = {
	{
		InitialDef = 50,
		InitialAtk = 100,
		InitialHP = 2000,
		Id = 1,
		Name = getI18NValue(180277950),
		MagicTowerFloorList = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	}
}

setmetatable(CfgMagicTowerMapTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMagicTowerMapTable]")
	end
})

local defaultMetaTable = {
	__index = {
		InitialHP = 0,
		InitialDef = 0,
		InitialAtk = 0,
		BattleFailDialog = 0,
		GiveUpDialog = 0,
		Name = "",
		MagicTowerFloorList = {}
	}
}

for i, data in pairs(CfgMagicTowerMapTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMagicTowerMapTable
