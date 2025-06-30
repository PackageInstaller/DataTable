-- chunkname: @IQIGame\\Config\\CfgEquipDupChapterTable.lua

local CfgEquipDupChapterTable = {
	[20400001] = {
		Index = 1,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_01.png",
		EnglishName = "SUWANGZHIYUE",
		DaliyChapterBackground = "/DataResource/ChapterResource/ChapterBackground/ChapterBackground_19.jpg",
		UnlockConditionId = 30030701,
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_116.png",
		Type = 3,
		Id = 20400001,
		ActivityTag = 9,
		Name = getI18NValue(180121957),
		ItemID = {
			500065,
			500005
		}
	},
	[20400002] = {
		Index = 2,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_02.png",
		EnglishName = "YUMENGZHIFEI",
		DaliyChapterBackground = "/DataResource/ChapterResource/ChapterBackground/ChapterBackground_01.jpg",
		UnlockConditionId = 30030711,
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_110.png",
		Type = 3,
		Id = 20400002,
		ActivityTag = 9,
		Name = getI18NValue(180121958),
		ItemID = {
			500045,
			500025
		}
	},
	[20400003] = {
		Index = 3,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_03.png",
		EnglishName = "HUASHOUZHILUN",
		DaliyChapterBackground = "/DataResource/ChapterResource/ChapterBackground/ChapterBackground_20.jpg",
		UnlockConditionId = 30030721,
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_117.png",
		Type = 3,
		Id = 20400003,
		ActivityTag = 9,
		Name = getI18NValue(180121959),
		ItemID = {
			500055,
			500015
		}
	},
	[20400004] = {
		Index = 4,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_04.png",
		EnglishName = "BUDUZHIXIAO",
		DaliyChapterBackground = "/DataResource/ChapterResource/ChapterBackground/ChapterBackground_21.jpg",
		UnlockConditionId = 30030731,
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_118.png",
		Type = 3,
		Id = 20400004,
		ActivityTag = 9,
		Name = getI18NValue(180121960),
		ItemID = {
			500035,
			500075
		}
	}
}

setmetatable(CfgEquipDupChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEquipDupChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChapterImg = "",
		Name = "",
		TabImg = "",
		Type = 0,
		Desc = "",
		EnglishName = "",
		DaliyChapterBackground = "",
		UnlockConditionId = 0,
		ChapterNameImg = "",
		Chaptercomponents = "",
		Index = 0,
		ActivityTag = 0,
		ChapterNameBGImg = "",
		ItemID = {}
	}
}

for i, data in pairs(CfgEquipDupChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEquipDupChapterTable
