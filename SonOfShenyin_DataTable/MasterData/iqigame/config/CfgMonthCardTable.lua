-- chunkname: @IQIGame\\Config\\CfgMonthCardTable.lua

local CfgMonthCardTable = {
	[102] = {
		Picture = "/UI/ActivityPart/Shop/NewUI/ShopUI/title_monthCard.png",
		CommodityId = 50202101,
		Time = 7,
		Id = 102,
		Limit = 364,
		Name = getI18NValue(180260245),
		Tips = {
			getI18NValue(180260380),
			getI18NValue(180260379),
			getI18NValue(180260381)
		},
		Reward = {
			2,
			6
		},
		DailyReward = {
			3,
			150
		}
	}
}

setmetatable(CfgMonthCardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMonthCardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Picture = "",
		CommodityId = 0,
		Name = "",
		Time = 0,
		Type = 0,
		Desc1 = "",
		Limit = 0,
		Desc = "",
		DailyReward = {},
		Reward = {},
		Tips = {
			"",
			"",
			""
		}
	}
}

for i, data in pairs(CfgMonthCardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMonthCardTable
