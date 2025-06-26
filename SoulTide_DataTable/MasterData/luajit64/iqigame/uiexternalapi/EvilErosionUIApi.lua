-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionUIApi.lua

EvilErosionUIApi = BaseLangApi:Extend()

function EvilErosionUIApi:Init()
	self:RegisterApi("LevelGroupPrefabPath", self.GetLevelGroupPrefabPath)
	self:RegisterApi("LevelGroupBGM", self.GetLevelGroupBGM)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SupplyBuffLevel", self.GetSupplyBuffLevel)
	self:RegisterApi("RewardLabel", self.GetRewardLabel)
	self:RegisterApi("AffixBuffLabel", self.GetAffixBuffLabel)
	self:RegisterApi("GamePlayLevelText", self.GetGamePlayLevelText)
	self:RegisterApi("GamePlayLevelLabel", self.GetGamePlayLevelLabel)
	self:RegisterApi("RatingTimeText", self.GetRatingTimeText)
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("DailySupplyBtnText", self.GetDailySupplyBtnText)
	self:RegisterApi("SoulBtnText", self.GetSoulBtnText)
	self:RegisterApi("EquipBtnText", self.GetEquipBtnText)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("SwitchToRewardPanelBtnText", self.GetSwitchToRewardPanelBtnText)
	self:RegisterApi("ReturnToFunctionPanelBtnText", self.GetReturnToFunctionPanelBtnText)
	self:RegisterApi("EnterBtnText", self.GetEnterBtnText)
	self:RegisterApi("LockedBtnText", self.GetLockedBtnText)
	self:RegisterApi("FinishedBtnText", self.GetFinishedBtnText)
	self:RegisterApi("RatingImage", self.GetRatingImage)
	self:RegisterApi("LevelCell_GamePlayLevelText", self.GetLevelCell_GamePlayLevelText)
	self:RegisterApi("RewardCell_NumText", self.GetRewardCell_NumText)
	self:RegisterApi("RewardItem_TimeText", self.GetRewardItem_TimeText)
end

function EvilErosionUIApi:GetLevelGroupPrefabPath(curLevelIndex)
	if curLevelIndex > 15 then
		return "/_EvilErosionUI/EvilErosionMould_04"
	elseif curLevelIndex > 10 then
		return "/_EvilErosionUI/EvilErosionMould_03"
	elseif curLevelIndex > 5 then
		return "/_EvilErosionUI/EvilErosionMould_02"
	else
		return "/_EvilErosionUI/EvilErosionMould_01"
	end
end

function EvilErosionUIApi:GetLevelGroupBGM(curLevelIndex)
	if curLevelIndex > 15 then
		return 77
	elseif curLevelIndex > 10 then
		return 76
	elseif curLevelIndex > 5 then
		return 75
	else
		return 74
	end
end

function EvilErosionUIApi:GetTitleText()
	return self:GetCfgText(1213105)
end

function EvilErosionUIApi:GetSupplyBuffLevel(levelIndex, elapsedDays)
	print(elapsedDays)

	if elapsedDays >= 14 then
		return 3
	elseif elapsedDays >= 9 then
		return 2
	else
		return 1
	end
end

function EvilErosionUIApi:GetRewardLabel()
	return self:GetCfgText(1213146)
end

function EvilErosionUIApi:GetAffixBuffLabel()
	return self:GetCfgText(1213106)
end

function EvilErosionUIApi:GetGamePlayLevelText(curLevel, maxLevel)
	return curLevel
end

function EvilErosionUIApi:GetGamePlayLevelLabel()
	return self:GetCfgText(1213148)
end

function EvilErosionUIApi:GetRatingTimeText(leftTime, hasLimitTime, isAllPassed, rating)
	local timeStr

	if isAllPassed then
		return self:GetCfgText(1213006)
	end

	if leftTime == nil then
		timeStr = self:GetCfgText(1213107)
	else
		timeStr = rating == 3 and "--" or self.TextColor[44] .. leftTime .. self.TextColor[0]
	end

	return string.format(self:GetCfgText(1213113), timeStr)
end

function EvilErosionUIApi:GetTitleName()
	return self:GetCfgText(1213108)
end

function EvilErosionUIApi:GetDailySupplyBtnText()
	return self:GetCfgText(1213111)
end

function EvilErosionUIApi:GetSoulBtnText()
	return self:GetCfgText(1213168)
end

function EvilErosionUIApi:GetEquipBtnText()
	return self:GetCfgText(1213108)
end

function EvilErosionUIApi:GetShopBtnText()
	return self:GetCfgText(1213169)
end

function EvilErosionUIApi:GetSwitchToRewardPanelBtnText()
	return self:GetCfgText(1213146)
end

function EvilErosionUIApi:GetReturnToFunctionPanelBtnText()
	return self:GetCfgText(1213138)
end

function EvilErosionUIApi:GetEnterBtnText()
	return self:GetCfgText(1213109)
end

function EvilErosionUIApi:GetLockedBtnText(timeStr)
	return timeStr
end

function EvilErosionUIApi:GetFinishedBtnText()
	return self:GetCfgText(1213006)
end

function EvilErosionUIApi:GetRatingImage(rating)
	if rating == 1 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_02.png"
	elseif rating == 2 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_03.png"
	elseif rating == 3 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_04.png"
	end

	return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_04.png"
end

function EvilErosionUIApi:GetLevelCell_GamePlayLevelText(level, name)
	return name
end

function EvilErosionUIApi:GetRewardCell_NumText(num)
	return "x" .. num
end

function EvilErosionUIApi:GetRewardItem_TimeText(time)
	if time / 60 % 60 == 0 then
		return getTimeDurationText(time, 1)
	else
		return getTimeDurationText(time, 2)
	end
end

EvilErosionUIApi:Init()
