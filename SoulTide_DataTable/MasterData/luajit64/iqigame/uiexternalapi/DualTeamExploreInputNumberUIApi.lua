-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreInputNumberUIApi.lua

DualTeamExploreInputNumberUIApi = BaseLangApi:Extend()

function DualTeamExploreInputNumberUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CleanBtnText", self.GetCleanBtnText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function DualTeamExploreInputNumberUIApi:GetTitleText()
	return self:GetCfgText(3410821)
end

function DualTeamExploreInputNumberUIApi:GetCleanBtnText()
	return self:GetCfgText(3410822)
end

function DualTeamExploreInputNumberUIApi:GetCancelBtnText()
	return self:GetCfgText(3410823)
end

function DualTeamExploreInputNumberUIApi:GetConfirmBtnText()
	return self:GetCfgText(3410824)
end

DualTeamExploreInputNumberUIApi:Init()
