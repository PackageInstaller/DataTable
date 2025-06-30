-- chunkname: @IQIGame\\Config\\CfgGroupBuyGlobalTable.lua

local CfgGroupBuyGlobalTable = {
	{
		Id = 1,
		Mail = 12001,
		BackGround = "/UI/_DailyActivityUI/GroupBuy_211001001.prefab",
		Name = getI18NValue(180144925),
		Items = {
			1,
			2,
			3,
			4,
			5
		},
		Desc = getI18NValue(180079079)
	},
	[220622] = {
		Id = 220622,
		Mail = 12001,
		BackGround = "/UI/_DailyActivityUI/GroupBuy_220622001.prefab",
		Name = getI18NValue(180294946),
		Items = {
			11,
			12,
			13,
			14,
			15
		},
		Desc = getI18NValue(180294945)
	}
}

setmetatable(CfgGroupBuyGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGroupBuyGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BackGround = "",
		Name = "",
		Mail = 0,
		Desc = "",
		Items = {}
	}
}

for i, data in pairs(CfgGroupBuyGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGroupBuyGlobalTable
