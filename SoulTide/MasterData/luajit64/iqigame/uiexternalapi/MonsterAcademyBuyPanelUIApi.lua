-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyBuyPanelUIApi.lua

MonsterAcademyBuyPanelUIApi = BaseLangApi:Extend()

function MonsterAcademyBuyPanelUIApi:Init()
	self:RegisterApi("btnMaxTxt", self.GetBtnMaxTxt)
	self:RegisterApi("btnMinTxt", self.GetBtnMinTxt)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("BtnBuyLabel", self.GetBtnBuyLabel)
end

function MonsterAcademyBuyPanelUIApi:GetBtnBuyLabel()
	return self:GetCfgText(3420140)
end

function MonsterAcademyBuyPanelUIApi:GetTitle()
	return self:GetCfgText(3420140)
end

function MonsterAcademyBuyPanelUIApi:GetBtnMinTxt()
	return self:GetCfgText(1140106)
end

function MonsterAcademyBuyPanelUIApi:GetBtnMaxTxt()
	return self:GetCfgText(1140105)
end

MonsterAcademyBuyPanelUIApi:Init()
