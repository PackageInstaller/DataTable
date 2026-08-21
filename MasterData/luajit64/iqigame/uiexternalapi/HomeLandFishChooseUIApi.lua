-- chunkname: @IQIGame\\UIExternalApi\\HomeLandFishChooseUIApi.lua

HomeLandFishChooseUIApi = BaseLangApi:Extend()

function HomeLandFishChooseUIApi:Init()
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("BtnFishLabel", self.GetBtnFishLabel)
	self:RegisterApi("BtnFishLabelEng", self.GetBtnFishLabelEng)
	self:RegisterApi("TextHaveNone", self.GetTextHaveNone)
	self:RegisterApi("TagNoChooseNum", self.GetTagNoChooseNum)
	self:RegisterApi("TagChooseNum", self.GetTagChooseNum)
	self:RegisterApi("BtnFishTenLabel", self.GetBtnFishTenLabel)
	self:RegisterApi("BtnFishTenLabelEng", self.GetBtnFishTenLabelEng)
	self:RegisterApi("BtnFishHundredLabel", self.GetBtnFishHundredLabel)
	self:RegisterApi("BtnFishHundredLabelEng", self.GetBtnFishHundredLabelEng)
	self:RegisterApi("NeedTips", self.GetNeedTips)
end

function HomeLandFishChooseUIApi:GetNeedTips(toolName, toolNum, itemName, itemNum, toolAmple, itemAmple)
	local green = self.ColorValue[101]
	local red = self.ColorValue[105]
	local toolColor = red
	local itemColor = red

	if toolAmple and itemAmple then
		toolColor = green
		itemColor = green
	elseif toolAmple and not itemAmple then
		toolColor = green
		itemColor = red
	elseif not toolAmple and itemAmple then
		toolColor = red
		itemColor = green
	end

	return string.format(self:GetCfgText(1015770), toolColor, toolName, toolNum, itemColor, itemName, itemNum)
end

function HomeLandFishChooseUIApi:GetBtnFishHundredLabelEng()
	return "Hundred"
end

function HomeLandFishChooseUIApi:GetBtnFishHundredLabel()
	return self:GetCfgText(1015768)
end

function HomeLandFishChooseUIApi:GetBtnFishTenLabelEng()
	return "Ten"
end

function HomeLandFishChooseUIApi:GetBtnFishTenLabel()
	return self:GetCfgText(1015769)
end

function HomeLandFishChooseUIApi:GetTagChooseNum(haveNum, maxNum)
	return string.format(self:GetCfgText(1015766), haveNum, maxNum)
end

function HomeLandFishChooseUIApi:GetTagNoChooseNum(haveNum, maxNum)
	return string.format(self:GetCfgText(1015766), haveNum, maxNum)
end

function HomeLandFishChooseUIApi:GetTextHaveNone()
	return self:GetCfgText(1015767)
end

function HomeLandFishChooseUIApi:GetBtnFishLabelEng(type)
	if type == 1 then
		return self:GetCfgText(1015761)
	end

	return self:GetCfgText(1015761)
end

function HomeLandFishChooseUIApi:GetBtnFishLabel(type)
	if type == 1 then
		return self:GetCfgText(1015762)
	end

	return self:GetCfgText(1015763)
end

function HomeLandFishChooseUIApi:GetPanelTitle(type)
	if type == 1 then
		return self:GetCfgText(1015764)
	end

	return self:GetCfgText(1015765)
end

HomeLandFishChooseUIApi:Init()
