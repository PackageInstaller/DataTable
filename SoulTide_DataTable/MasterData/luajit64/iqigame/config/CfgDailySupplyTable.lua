-- chunkname: @IQIGame\\Config\\CfgDailySupplyTable.lua

local CfgDailySupplyTable = {
	{
		PaidEndTime = "24:00",
		OpenTime = "12:00",
		NPC = 210,
		Id = 1,
		EndTime = "24:00",
		Supply = 50,
		Name = getI18NValue(180007339),
		Price = {
			2,
			0
		}
	},
	{
		PaidEndTime = "24:00",
		OpenTime = "18:00",
		NPC = 210,
		Id = 2,
		EndTime = "24:00",
		Supply = 50,
		Name = getI18NValue(180007340),
		Price = {
			2,
			0
		}
	}
}

setmetatable(CfgDailySupplyTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDailySupplyTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PaidEndTime = "",
		OpenTime = "",
		NPC = 0,
		EndTime = "",
		Supply = 0,
		Name = "",
		Price = {}
	}
}

for i, data in pairs(CfgDailySupplyTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDailySupplyTable
