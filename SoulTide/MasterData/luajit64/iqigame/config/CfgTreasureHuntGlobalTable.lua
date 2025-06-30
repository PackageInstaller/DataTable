-- chunkname: @IQIGame\\Config\\CfgTreasureHuntGlobalTable.lua

local CfgTreasureHuntGlobalTable = {
	{
		Id = 1,
		BackGround = "/UI/_DailyActivityUI/NewYearCollect_20220127.prefab",
		Name = getI18NValue(180250472),
		Desc = getI18NValue(180250471)
	},
	{
		Id = 2,
		BackGround = "/UI/_DailyActivityUI/NewYearCollect_20221229.prefab",
		Name = getI18NValue(180481430),
		Desc = getI18NValue(180481429)
	},
	{
		Id = 3,
		BackGround = "/UI/_DailyActivityUI/NewYearCollect_20250123.prefab",
		Name = getI18NValue(180932150),
		Desc = getI18NValue(180932149)
	}
}

setmetatable(CfgTreasureHuntGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTreasureHuntGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BackGround = "",
		Name = "",
		Desc = ""
	}
}

for i, data in pairs(CfgTreasureHuntGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTreasureHuntGlobalTable
