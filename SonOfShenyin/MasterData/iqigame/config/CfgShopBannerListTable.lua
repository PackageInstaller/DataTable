-- chunkname: @IQIGame\\Config\\CfgShopBannerListTable.lua

local CfgShopBannerListTable = {
	[50530001] = {
		Sort = 100,
		Id = 50530001,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_126.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_1",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_127.png",
		Name = getI18NValue(180133527),
		ShowConditionID = {
			30000000
		}
	},
	[50530002] = {
		Sort = 2,
		Id = 50530002,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_130.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_7",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_131.png",
		Name = getI18NValue(180133528),
		ShowConditionID = {
			40011002
		}
	},
	[50530003] = {
		Sort = 6,
		Id = 50530003,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_128.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_8",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_129.png",
		Name = getI18NValue(180133529),
		ShowConditionID = {
			30000001
		}
	},
	[50530004] = {
		Sort = 5,
		Id = 50530004,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_128.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_4",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_129.png",
		Name = getI18NValue(180235978),
		ShowConditionID = {
			30070222
		}
	},
	[50530005] = {
		Sort = 1,
		Id = 50530005,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_128.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_5",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_129.png",
		Name = getI18NValue(180235979),
		ShowConditionID = {
			40011003
		}
	},
	[50530006] = {
		Sort = 3,
		Id = 50530006,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_130.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_6",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_131.png",
		Name = getI18NValue(180253774),
		ShowConditionID = {
			40011001
		}
	},
	[50530007] = {
		Sort = 4,
		Id = 50530007,
		CheckToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_130.png",
		ShopBannerPrefab = "/_Shop/ShopRecommendScrollItem_9",
		NormaToggleImg = "/DataResource/UIResource/ShopCommonImg/Icon_ToggleImg_131.png",
		Name = getI18NValue(180268841),
		ShowConditionID = {
			40011004
		}
	}
}

setmetatable(CfgShopBannerListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgShopBannerListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		OpenTime = "",
		NormaToggleImg = "",
		ShopBannerPrefab = "",
		CheckToggleImg = "",
		Name = "",
		ShowConditionID = {},
		Duration = {}
	}
}

for i, data in pairs(CfgShopBannerListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgShopBannerListTable
