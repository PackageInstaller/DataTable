-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionSoulListUIApi.lua

EvilErosionSoulListUIApi = BaseLangApi:Extend()

function EvilErosionSoulListUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SelectBtnText", self.GetSelectBtnText)
	self:RegisterApi("RemoveBtnText", self.GetRemoveBtnText)
	self:RegisterApi("TipText", self.GetTipText)
end

function EvilErosionSoulListUIApi:GetTitleText()
	return self:GetCfgText(1213141)
end

function EvilErosionSoulListUIApi:GetSelectBtnText()
	return self:GetCfgText(1213142)
end

function EvilErosionSoulListUIApi:GetRemoveBtnText()
	return self:GetCfgText(1213143)
end

function EvilErosionSoulListUIApi:GetTipText(openInFormation)
	if openInFormation then
		return self:GetCfgText(1213145)
	else
		return self:GetCfgText(1213144)
	end
end

EvilErosionSoulListUIApi:Init()
