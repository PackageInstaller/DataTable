-- chunkname: @IQIGame\\UIExternalApi\\DreamlandPerfectFinishUIApi.lua

DreamlandPerfectFinishUIApi = BaseLangApi:Extend()

function DreamlandPerfectFinishUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function DreamlandPerfectFinishUIApi:GetTitleText()
	return self:GetCfgText(3700151), self:GetCfgText(3700152)
end

DreamlandPerfectFinishUIApi:Init()
