-- chunkname: @IQIGame\\UIExternalApi\\ChapterUIApi.lua

ChapterUIApi = BaseLangApi:Extend()

function ChapterUIApi:GetRewardTitle(type)
	if type == 1 then
		return self:GetCfgText(111001)
	elseif type == 2 then
		return self:GetCfgText(7050007)
	end
end

function ChapterUIApi:GetOpenTitle()
	return self:GetCfgText(111002)
end

function ChapterUIApi:GetMazeOpenTips()
	return self:GetCfgText(240117)
end

function ChapterUIApi:GetMapImg(mapType)
	if mapType < 10 then
		return UIGlobalApi.GetImagePath(string.format("/Level/Map/Fight_Terrain_00%s.png", mapType))
	else
		return UIGlobalApi.GetImagePath(string.format("/Level/Map/Fight_Terrain_0%s.png", mapType))
	end
end

function ChapterUIApi:GetMapTypeText(mapType)
	if mapType == Constant.MapType.TYPE_NORMAL then
		return self:GetCfgText(111003)
	elseif mapType == Constant.MapType.TYPE_VOLCANO then
		return self:GetCfgText(111004)
	elseif mapType == Constant.MapType.TYPE_SWAMP then
		return self:GetCfgText(111005)
	end
end

function ChapterUIApi:GetSkillDescValue(str)
	return self:SkillValueColor(str, 2)
end

function ChapterUIApi:GetResourcePassFrame(type)
	if type == Constant.ChapterPassEnemyType.TYPE_NORMAL then
		return UIGlobalApi.GetImagePath("/Level/LevelFrame/Frame_1_general.png")
	elseif type == Constant.ChapterPassEnemyType.TYPE_BOSS then
		return UIGlobalApi.GetImagePath("/Level/LevelFrame/Frame_1_boss.png")
	end
end

function ChapterUIApi:GetPassInfoPanelReturnStr()
	return self:GetCfgText(3060004)
end

function ChapterUIApi:GetPassInfoPanelToggleStr()
	return {
		self:GetCfgText(111006),
		self:GetCfgText(111007)
	}
end

function ChapterUIApi:GetPassInfoPanelTitle(type)
	if type == 1 then
		return self:GetCfgText(111008)
	elseif type == 2 then
		return self:GetCfgText(111009)
	end
end

function ChapterUIApi:GetPassInfoPanelTerrainTitle()
	return self:GetCfgText(111010)
end

function ChapterUIApi:GetPassInfoPanelTerrainInfo()
	return {
		self:GetCfgText(111011),
		self:GetCfgText(111012)
	}
end

function ChapterUIApi:GetEquipChapterTitle(type)
	if type == 1 then
		return self:GetCfgText(111013)
	elseif type == 2 then
		return self:GetCfgText(111014)
	elseif type == 3 then
		return self:GetCfgText(111015)
	end
end

function ChapterUIApi:GetRomanNum(index)
	if index == 1 then
		return self:GetCfgText(300)
	elseif index == 2 then
		return self:GetCfgText(301)
	elseif index == 3 then
		return self:GetCfgText(302)
	end
end

function ChapterUIApi:GetDifficultyStr(index)
	return self:GetCfgText(111016) .. index
end

function ChapterUIApi:GetConsumTitle()
	return self:GetCfgText(111017)
end

function ChapterUIApi:GetConsumText(curNum, MaxNum)
	return self:GetCfgText(111018) .. curNum .. "/" .. MaxNum
end

function ChapterUIApi:GetBossTitle()
	return self:GetCfgText(111019)
end

function ChapterUIApi:GetOrderTitle(index)
	return "NO." .. (index < 10 and "0" .. index or index)
end

function ChapterUIApi:GetLastRewardText(count, maxCount)
	return self:GetCfgText(111020) .. count .. "/" .. maxCount
end

function ChapterUIApi:GetMonsterDetailsBtn()
	return self:GetCfgText(111021)
end

function ChapterUIApi:GetRuleTitle()
	return self:GetCfgText(111022)
end

function ChapterUIApi:GetDetailsTitle(index)
	if index == 1 then
		return self:GetCfgText(111021)
	elseif index == 2 then
		return self:GetCfgText(111023)
	else
		return ""
	end
end
