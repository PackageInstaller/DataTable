-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineDetailUIApi.lua

LunaBattleLineDetailUIApi = BaseLangApi:Extend()

function LunaBattleLineDetailUIApi:Init()
	self:RegisterApi("SealProgressText", self.GetSealProgressText)
	self:RegisterApi("SealProgressLabel", self.GetSealProgressLabel)
	self:RegisterApi("SetCampTipText", self.GetSetCampTipText)
	self:RegisterApi("NoCampViewEnterBtnText", self.GetNoCampViewEnterBtnText)
	self:RegisterApi("DetailViewTitleText", self.GetDetailViewTitleText)
	self:RegisterApi("DetailViewWeakLabel", self.GetDetailViewWeakLabel)
	self:RegisterApi("DetailViewRewardLabel", self.GetDetailViewRewardLabel)
	self:RegisterApi("DetailViewAssistanceTipText", self.GetDetailViewAssistanceTipText)
	self:RegisterApi("DetailViewEnterBtnText", self.GetDetailViewEnterBtnText)
	self:RegisterApi("DetailViewAssistantTagText", self.GetDetailViewAssistantTagText)
	self:RegisterApi("SealingViewSealBtnText", self.GetSealingViewSealBtnText)
	self:RegisterApi("SealingViewEnhanceBtnText", self.GetSealingViewEnhanceBtnText)
	self:RegisterApi("SealingViewChangeAssistantBtnText", self.GetSealingViewChangeAssistantBtnText)
	self:RegisterApi("AssistantHeadLevelText", self.GetAssistantHeadLevelText)
	self:RegisterApi("GarrisonNoticeText", self.GetGarrisonNoticeText)
end

function LunaBattleLineDetailUIApi:GetSealProgressText(value, maxValue)
	return value .. "%"
end

function LunaBattleLineDetailUIApi:GetSealProgressLabel(value, maxValue)
	if value == maxValue then
		return self:GetCfgText(3600065)
	else
		return self:GetCfgText(3600051)
	end
end

function LunaBattleLineDetailUIApi:GetDetailViewTitleText(zoneName, mazeName)
	return self:GetCfgText(3600052)
end

function LunaBattleLineDetailUIApi:GetNoCampViewEnterBtnText()
	return self:GetCfgText(3600053)
end

function LunaBattleLineDetailUIApi:GetSetCampTipText()
	return self:GetCfgText(3600054)
end

function LunaBattleLineDetailUIApi:GetDetailViewWeakLabel()
	return self:GetCfgText(3600055)
end

function LunaBattleLineDetailUIApi:GetDetailViewRewardLabel()
	return self:GetCfgText(3600056)
end

function LunaBattleLineDetailUIApi:GetDetailViewAssistanceTipText()
	return self:GetCfgText(3600057)
end

function LunaBattleLineDetailUIApi:GetDetailViewEnterBtnText()
	return self:GetCfgText(3600058)
end

function LunaBattleLineDetailUIApi:GetDetailViewAssistantTagText()
	return self:GetCfgText(3600059)
end

function LunaBattleLineDetailUIApi:GetSealingViewSealBtnText()
	return self:GetCfgText(3600060)
end

function LunaBattleLineDetailUIApi:GetSealingViewEnhanceBtnText()
	return self:GetCfgText(3600061)
end

function LunaBattleLineDetailUIApi:GetSealingViewChangeAssistantBtnText(isEmpty)
	if isEmpty then
		return self:GetCfgText(3600062)
	else
		return self:GetCfgText(3600063)
	end
end

function LunaBattleLineDetailUIApi:GetAssistantHeadLevelText(level)
	return tostring(level)
end

function LunaBattleLineDetailUIApi:GetGarrisonNoticeText(playerName, soulName)
	return string.format(self:GetCfgText(3600064), playerName, soulName)
end

LunaBattleLineDetailUIApi:Init()
