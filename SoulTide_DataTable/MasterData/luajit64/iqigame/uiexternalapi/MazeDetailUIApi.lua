-- chunkname: @IQIGame\\UIExternalApi\\MazeDetailUIApi.lua

MazeDetailUIApi = BaseLangApi:Extend()

function MazeDetailUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("MazeOrderText", self.GetMazeOrderText)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("FormationPowerText", self.GetFormationPowerText)
	self:RegisterApi("MonsterPanelLabel", self.GetMonsterPanelLabel)
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("ExploreText", self.GetExploreText)
	self:RegisterApi("ChangeFormationBtnText", self.GetChangeFormationBtnText)
	self:RegisterApi("SweepNoticeText", self.GetSweepNoticeText)
	self:RegisterApi("CheckPointText", self.GetCheckPointText)
	self:RegisterApi("ElementTextDes", self.GetElementTextDes)
	self:RegisterApi("ShowSweepNotice", self.GetShowSweepNotice)
	self:RegisterApi("FirstPassFlagText", self.GetFirstPassFlagText)
	self:RegisterApi("UncertainFlagText", self.GetUncertainFlagText)
	self:RegisterApi("SpecialDropFlagText", self.GetSpecialDropFlagText)
	self:RegisterApi("MoodTipViewText", self.GetMoodTipViewText)
	self:RegisterApi("FirstEnergyText", self.GetFirstEnergyText)
	self:RegisterApi("CannotSweepBtnText1", self.GetCannotSweepBtnText1)
	self:RegisterApi("CannotSweepBtnText2", self.GetCannotSweepBtnText2)
	self:RegisterApi("SweepBtnText", self.GetSweepBtnText)
end

function MazeDetailUIApi:GetElementTextDes(type)
	local typeStr = ""

	if type == 0 then
		typeStr = ""
	elseif type == 5 then
		typeStr = self:GetCfgText(2000104)
	elseif type == 6 then
		typeStr = self:GetCfgText(2000105)
	elseif type == 1 then
		typeStr = self:GetCfgText(2000100)
	elseif type == 3 then
		typeStr = self:GetCfgText(2000102)
	elseif type == 2 then
		typeStr = self:GetCfgText(2000101)
	elseif type == 4 then
		typeStr = self:GetCfgText(2000103)
	end

	return typeStr
end

function MazeDetailUIApi:GetMonsterPanelLabel()
	return self:GetCfgText(2100001)
end

function MazeDetailUIApi:GetTitleText()
	return self:GetCfgText(2100002)
end

function MazeDetailUIApi:GetCostItemNumText(num, notEnough)
	local color

	color = notEnough and "#e33535" or "#FFFFFF"

	return "<color=" .. color .. ">" .. num .. "</color>"
end

function MazeDetailUIApi:GetRewardLabelText()
	return self:GetCfgText(1213064)
end

function MazeDetailUIApi:GetConfirmBtnText()
	return self:GetCfgText(2100004)
end

function MazeDetailUIApi:GetMazeOrderText(chapterOrder, order)
	if order == 0 then
		return ""
	end

	if chapterOrder == 1 then
		if order <= 3 then
			return "0-" .. order
		else
			return chapterOrder .. "-" .. order - 3
		end
	end

	if chapterOrder == 16 and order <= 4 then
		return "16-?"
	end

	return chapterOrder .. "-" .. order
end

function MazeDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function MazeDetailUIApi:GetFormationPowerText(currentPower, recommendPower)
	local rate = recommendPower / currentPower

	if rate >= 1.25 then
		return self.TextColor[203] .. currentPower .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. currentPower .. self.TextColor[0]
	else
		return self.TextColor[219] .. currentPower .. self.TextColor[0]
	end
end

function MazeDetailUIApi:GetExploreLabel()
	return self:GetCfgText(2300010)
end

function MazeDetailUIApi:GetExploreText(score)
	return score .. "%"
end

function MazeDetailUIApi:GetChangeFormationBtnText()
	return self:GetCfgText(2300011)
end

function MazeDetailUIApi:GetSweepNoticeText()
	return self:GetCfgText(2300012) .. "100%" .. self:GetCfgText(2300009)
end

function MazeDetailUIApi:GetCheckPointText()
	return self:GetCfgText(2300013)
end

function MazeDetailUIApi:GetShowSweepNotice(chapterOrder, order)
	if chapterOrder == 1 and order <= 3 then
		return false
	end

	return true
end

function MazeDetailUIApi:GetFirstPassFlagText()
	return self:GetCfgText(1213044)
end

function MazeDetailUIApi:GetUncertainFlagText()
	return self:GetCfgText(2300006)
end

function MazeDetailUIApi:GetSpecialDropFlagText()
	return self:GetCfgText(2300014)
end

function MazeDetailUIApi:GetMoodTipViewText()
	return self:GetCfgText(2300007)
end

function MazeDetailUIApi:GetFirstEnergyText()
	return self:GetCfgText(2300008)
end

function MazeDetailUIApi:GetCannotSweepBtnText1()
	return self:GetCfgText(1213023)
end

function MazeDetailUIApi:GetCannotSweepBtnText2()
	return self:GetCfgText(2300005)
end

function MazeDetailUIApi:GetSweepBtnText()
	return self:GetCfgText(1213023)
end

MazeDetailUIApi:Init()
