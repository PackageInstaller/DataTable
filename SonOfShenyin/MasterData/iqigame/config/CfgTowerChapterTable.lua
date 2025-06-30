-- chunkname: @IQIGame\\Config\\CfgTowerChapterTable.lua

local CfgTowerChapterTable = {
	[20800001] = {
		UnlockConditionId = 30031101,
		Id = 20800001,
		Type = 6,
		Index = 1,
		TowerHeadImg = "Assets/05_Images/DataResource/ChapterResource/ResourceImg/ResourceImg_111.png",
		BackPicture = "Assets/05_Images/DataResource/ChapterResource/ChapterBackground/ChapterBackground_18.png",
		Name = getI18NValue(180122105),
		Desc = getI18NValue(180122104)
	}
}

setmetatable(CfgTowerChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTowerChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Chaptercomponents = "",
		EnglishName = "",
		BackPicture = "",
		UnlockConditionId = 0,
		Name = "",
		Type = 0,
		Index = 0,
		TowerHeadImg = "",
		Desc = ""
	}
}

for i, data in pairs(CfgTowerChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTowerChapterTable
