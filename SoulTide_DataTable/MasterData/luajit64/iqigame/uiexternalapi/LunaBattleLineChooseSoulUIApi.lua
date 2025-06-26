-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineChooseSoulUIApi.lua

LunaBattleLineChooseSoulUIApi = BaseLangApi:Extend()

function LunaBattleLineChooseSoulUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ChooseSoulLabel", self.GetChooseSoulLabel)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("RemoveBtnText", self.GetRemoveBtnText)
end

function LunaBattleLineChooseSoulUIApi:GetTitleText()
	return self:GetCfgText(3600221)
end

function LunaBattleLineChooseSoulUIApi:GetChooseSoulLabel()
	return self:GetCfgText(3600222)
end

function LunaBattleLineChooseSoulUIApi:GetConfirmBtnText()
	return self:GetCfgText(3600223)
end

function LunaBattleLineChooseSoulUIApi:GetRemoveBtnText()
	return self:GetCfgText(3600224)
end

LunaBattleLineChooseSoulUIApi:Init()
