-- chunkname: @IQIGame\\Config\\CfgGiftBoxTable.lua

local CfgGiftBoxTable = {
	{
		GiftBoxPrefab = "/UI/_CelebrationGiftUI/CelebrationGift_20230824.prefab",
		Id = 1,
		GiftBoxImage1 = "/MainCity/CelebrationGiftUI/CelebrationGift_CommonRes/CelebrationGift_Skin_1.png",
		GiftBoxImage2 = "/MainCity/CelebrationGiftUI/CelebrationGift_CommonRes/CelebrationGift_Skin_2.png",
		Name = getI18NValue(180874498),
		GiftBoxMall = {
			1010501031,
			1010501032
		},
		GiftBoxPrice = {
			getI18NValue(180874656),
			getI18NValue(180874657)
		}
	},
	{
		GiftBoxPrefab = "/UI/_CelebrationGiftUI/CelebrationGift_20240502.prefab",
		Id = 2,
		GiftBoxImage1 = "/MainCity/CelebrationGiftUI/CelebrationGift_CommonRes/CelebrationGift_Skin_3.png",
		GiftBoxImage2 = "/MainCity/CelebrationGiftUI/CelebrationGift_CommonRes/CelebrationGift_Skin_4.png",
		Name = getI18NValue(180874499),
		GiftBoxMall = {
			1010501039,
			1010501040
		},
		GiftBoxPrice = {
			getI18NValue(180874658),
			getI18NValue(180874659)
		}
	}
}

setmetatable(CfgGiftBoxTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGiftBoxTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		GiftBoxPrefab = "",
		GiftBoxImage1 = "",
		GiftBoxImage2 = "",
		GiftBoxMall = {},
		GiftBoxPrice = {}
	}
}

for i, data in pairs(CfgGiftBoxTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGiftBoxTable
