-- chunkname: @IQIGame\\UIExternalApi\\GirlContractUIApi.lua

GirlContractUIApi = BaseLangApi:Extend()

function GirlContractUIApi:Init()
	self:RegisterApi("TextState", self.GetTextState)
	self:RegisterApi("TextTime1", self.GetTextTime1)
	self:RegisterApi("TextTime2", self.GetTextTime2)
	self:RegisterApi("TextBtnConclusion", self.GetTextBtnConclusion)
	self:RegisterApi("TextBtnReview", self.GetTextBtnReview)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("PanelText1", self.GetPanelText1)
	self:RegisterApi("PanelText2", self.GetPanelText2)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
end

function GirlContractUIApi:GetTextTitle1()
	return self:GetCfgText(1014030)
end

function GirlContractUIApi:GetPanelText2()
	return self:GetCfgText(1014031)
end

function GirlContractUIApi:GetPanelText1()
	return self:GetCfgText(1014032)
end

function GirlContractUIApi:GetTextTitle(type)
	if type == 1 then
		return "<color=#DD3046>" .. self:GetCfgText(1014034) .. "</color>" .. self:GetCfgText(1014035)
	end

	return self:GetCfgText(1014033)
end

function GirlContractUIApi:GetTextBtnReview()
	return self:GetCfgText(1014002)
end

function GirlContractUIApi:GetTextBtnConclusion()
	return self:GetCfgText(1014032)
end

function GirlContractUIApi:GetTextTime2(str)
	return self:GetCfgText(1239001) .. str
end

function GirlContractUIApi:GetTextTime1(str)
	return self:GetCfgText(1239002) .. str
end

function GirlContractUIApi:GetTextState(index)
	if index == 1 then
		return self:GetCfgText(1239003)
	elseif index == 2 then
		return self:GetCfgText(1239004)
	elseif index == 3 then
		return self:GetCfgText(1239005)
	elseif index == 4 then
		return self:GetCfgText(1239006)
	elseif index == 5 then
		return self:GetCfgText(1239007)
	else
		return ""
	end
end

GirlContractUIApi:Init()
