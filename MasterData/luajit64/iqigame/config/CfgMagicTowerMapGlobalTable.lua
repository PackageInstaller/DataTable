-- chunkname: @IQIGame\\Config\\CfgMagicTowerMapGlobalTable.lua

local CfgMagicTowerMapGlobalTable = {
	{
		UIBGM = 418,
		ExploreHallUIBG = "Activity_MagicTower",
		DailyTimes = 3,
		PlayerEntity = 830000,
		MallMoney = 205,
		Id = 1,
		Name = getI18NValue(180270539),
		Desc = getI18NValue(180270536),
		QuestName = getI18NValue(180270538),
		MallName = getI18NValue(180270537),
		MagicTowerMap = {
			1
		},
		RemoveItems = {
			205
		}
	}
}

setmetatable(CfgMagicTowerMapGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMagicTowerMapGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MallName = "",
		ExploreHallUIBG = "",
		UIBGM = 0,
		PlayerEntity = 0,
		Name = "",
		MallMoney = 0,
		QuestName = "",
		DailyTimes = 0,
		Desc = "",
		RemoveItems = {},
		Quest = {},
		MallGoods = {},
		MagicTowerMap = {}
	}
}

for i, data in pairs(CfgMagicTowerMapGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMagicTowerMapGlobalTable
