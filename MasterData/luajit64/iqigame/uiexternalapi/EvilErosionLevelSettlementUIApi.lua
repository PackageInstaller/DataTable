-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionLevelSettlementUIApi.lua

EvilErosionLevelSettlementUIApi = BaseLangApi:Extend()

function EvilErosionLevelSettlementUIApi:Init()
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("RewardLabel2", self.GetRewardLabel2)
	self:RegisterApi("RewardLabel1", self.GetRewardLabel1)
	self:RegisterApi("NormalPasTimeText", self.GetNormalPasTimeText)
	self:RegisterApi("NormalPassTimeLabel", self.GetNormalPassTimeLabel)
	self:RegisterApi("RatingLabel", self.GetRatingLabel)
	self:RegisterApi("PassLabel", self.GetPassLabel)
	self:RegisterApi("RatingImage", self.GetRatingImage)
	self:RegisterApi("RatingEffect", self.GetRatingEffect)
	self:RegisterApi("FirstPassText", self.GetFirstPassText)
	self:RegisterApi("LevelNameText", self.GetLevelNameText)
end

function EvilErosionLevelSettlementUIApi:GetCloseBtnText()
	return self:GetCfgText(79)
end

function EvilErosionLevelSettlementUIApi:GetRewardLabel2()
	return self:GetCfgText(1213146)
end

function EvilErosionLevelSettlementUIApi:GetRewardLabel1()
	return self:GetCfgText(1213020)
end

function EvilErosionLevelSettlementUIApi:GetNormalPasTimeText(timeStr)
	return timeStr
end

function EvilErosionLevelSettlementUIApi:GetNormalPassTimeLabel()
	return self:GetCfgText(1213126)
end

function EvilErosionLevelSettlementUIApi:GetRatingLabel()
	return self:GetCfgText(1213147)
end

function EvilErosionLevelSettlementUIApi:GetPassLabel(isWin)
	if isWin then
		return self:GetCfgText(1213127)
	else
		return ""
	end
end

function EvilErosionLevelSettlementUIApi:GetRatingImage(rating, isFirstPass)
	if rating == 1 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_02.png"
	elseif rating == 2 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_03.png"
	elseif rating == 3 then
		return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_04.png"
	end

	return "Assets/05_Images/MainCity/EvilErosionUI/EvilErosionCommon/EvilErosion_Image_List_04.png"
end

function EvilErosionLevelSettlementUIApi:GetRatingEffect(rating, isFirstPass)
	if rating == 1 then
		if isFirstPass then
			return 9004101
		else
			return 9004102
		end
	elseif rating == 2 then
		return 9004103
	elseif rating == 3 then
		return 9004104
	end

	return 9004104
end

function EvilErosionLevelSettlementUIApi:GetFirstPassText()
	return self:GetCfgText(1213128)
end

function EvilErosionLevelSettlementUIApi:GetLevelNameText(name, isWin)
	return name
end

EvilErosionLevelSettlementUIApi:Init()
