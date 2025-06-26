-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreBagUIApi.lua

DualTeamExploreBagUIApi = BaseLangApi:Extend()

function DualTeamExploreBagUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
end

function DualTeamExploreBagUIApi:GetTitleText()
	return self:GetCfgText(1234002)
end

function DualTeamExploreBagUIApi:GetEmptyViewText()
	return self:GetCfgText(2300152)
end

DualTeamExploreBagUIApi:Init()
