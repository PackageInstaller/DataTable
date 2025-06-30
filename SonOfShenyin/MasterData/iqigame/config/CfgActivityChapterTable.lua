-- chunkname: @IQIGame\\Config\\CfgActivityChapterTable.lua

local CfgActivityChapterTable = {
	[21000101] = {
		ActivityID = 60006001,
		Index = 1,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_12.png",
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_114.png",
		EnglishName = "BEIPANDETIANGOU",
		BossChapterImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_114.png",
		SmallImg = "/DataResource/ChapterResource/BossImg/Ya/Img_02.png",
		BigImg = "/DataResource/ChapterResource/BossImg/Ya/Img_01.png",
		ElementImg = "/Common/Warlock/Warlock_Element/Role_Element_2.png",
		Type = 11,
		Id = 21000101,
		Name = getI18NValue(180124716),
		Desc = getI18NValue(180124715),
		Suggest = getI18NValue(180164602),
		RewardDrop = {
			3,
			300001,
			6,
			300002,
			9,
			300003,
			12,
			300004
		}
	},
	[21000102] = {
		ActivityID = 60006001,
		OpenTime = 259200,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_10.png",
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_112.png",
		EnglishName = "JINGUZHIYING",
		BossChapterImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_112.png",
		ElementImg = "/Common/Warlock/Warlock_Element/Role_Element_2.png",
		BigImg = "/DataResource/ChapterResource/BossImg/ShuiX/Img_01.png",
		Type = 11,
		Id = 21000102,
		Index = 2,
		Name = getI18NValue(180124718),
		Desc = getI18NValue(180124717),
		Suggest = getI18NValue(180164603),
		RewardDrop = {
			3,
			300005,
			6,
			300006,
			9,
			300007,
			12,
			300008
		}
	},
	[21000103] = {
		ActivityID = 60006001,
		OpenTime = 518400,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_11.png",
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_113.png",
		EnglishName = "GUZHIBEIMING",
		BossChapterImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_113.png",
		SmallImg = "/DataResource/ChapterResource/BossImg/YuHSZL/Img_02.png",
		BigImg = "/DataResource/ChapterResource/BossImg/YuHSZL/Img_01.png",
		ElementImg = "/Common/Warlock/Warlock_Element/Role_Element_2.png",
		Type = 11,
		Id = 21000103,
		Index = 3,
		Name = getI18NValue(180124720),
		Desc = getI18NValue(180124719),
		Suggest = getI18NValue(180164604),
		RewardDrop = {
			3,
			300009,
			6,
			300010,
			9,
			300011,
			12,
			300012
		}
	},
	[21000104] = {
		ActivityID = 60006001,
		OpenTime = 777600,
		TabImg = "/DataResource/ChapterResource/ResourceCommonImg/Common_ResourceTitleImg_11.png",
		ChapterNameImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_115.png",
		EnglishName = "GUZHIBEIMING",
		BossChapterImg = "/DataResource/ChapterResource/ResourceImg/ResourceImg_115.png",
		SmallImg = "/DataResource/ChapterResource/BossImg/YuHSZL/Img_02.png",
		BigImg = "/DataResource/ChapterResource/BossImg/YuHSZL/Img_01.png",
		ElementImg = "/Common/Warlock/Warlock_Element/Role_Element_2.png",
		Type = 11,
		Id = 21000104,
		Index = 4,
		Name = getI18NValue(180124722),
		Desc = getI18NValue(180124721),
		Suggest = getI18NValue(180164605),
		RewardDrop = {
			3,
			300013,
			6,
			300014,
			9,
			300015,
			12,
			300016
		}
	}
}

setmetatable(CfgActivityChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgActivityChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Index = 0,
		OpenTime = 0,
		Chaptercomponents = "",
		Desc = "",
		Name = "",
		EnglishName = "",
		ActivityID = 0,
		IsTrue = false,
		UnlockConditionId = 0,
		ChapterNameImg = "",
		RewardTimes = 0,
		Type = 0,
		BossChapterImg = "",
		ElementImg = "",
		TabImg = "",
		Suggest = "",
		SmallImg = "",
		BigImg = "",
		RewardDrop = {}
	}
}

for i, data in pairs(CfgActivityChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgActivityChapterTable
