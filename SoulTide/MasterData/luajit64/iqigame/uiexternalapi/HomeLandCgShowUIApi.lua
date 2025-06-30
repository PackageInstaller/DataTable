-- chunkname: @IQIGame\\UIExternalApi\\HomeLandCgShowUIApi.lua

HomeLandCgShowUIApi = BaseLangApi:Extend()

function HomeLandCgShowUIApi:Init()
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("TextMsg", self.GetTextMsg)
end

function HomeLandCgShowUIApi:GetTextMsg()
	return self:GetCfgText(1015499)
end

function HomeLandCgShowUIApi:GetTextBtnTitle()
	return self:GetCfgText(1015500)
end

HomeLandCgShowUIApi:Init()
