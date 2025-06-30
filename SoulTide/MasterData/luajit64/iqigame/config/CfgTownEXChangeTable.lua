-- chunkname: @IQIGame\\Config\\CfgTownEXChangeTable.lua

local CfgTownEXChangeTable = {
	{
		Id = 1,
		RewardNum = 5,
		Name = getI18NValue(180132903),
		Cost = {
			12101,
			50
		}
	},
	{
		Id = 2,
		RewardNum = 5,
		Name = getI18NValue(180132904),
		Cost = {
			12102,
			50
		}
	}
}

setmetatable(CfgTownEXChangeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownEXChangeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		RewardNum = 0,
		Cost = {}
	}
}

for i, data in pairs(CfgTownEXChangeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownEXChangeTable
