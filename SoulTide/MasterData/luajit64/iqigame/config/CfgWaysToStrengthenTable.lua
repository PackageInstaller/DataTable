-- chunkname: @IQIGame\\Config\\CfgWaysToStrengthenTable.lua

local CfgWaysToStrengthenTable = {
	{
		Function = 10207001,
		EngName = "Doll",
		Id = 1,
		ButtionWord = getI18NValue(180135127)
	},
	{
		Function = 10204001,
		EngName = "Wish",
		Id = 2,
		ButtionWord = getI18NValue(180135128)
	},
	{
		Function = 10208001,
		EngName = "Equip",
		Id = 3,
		ButtionWord = getI18NValue(180135129)
	},
	{
		Function = 10202001,
		EngName = "Shop",
		Id = 4,
		ButtionWord = getI18NValue(180135130)
	}
}

setmetatable(CfgWaysToStrengthenTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWaysToStrengthenTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ButtionWord = "",
		Function = 0,
		EngName = ""
	}
}

for i, data in pairs(CfgWaysToStrengthenTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWaysToStrengthenTable
