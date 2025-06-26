-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGMazeBagUIApi.lua

HorizontalRPGMazeBagUIApi = BaseLangApi:Extend()

function HorizontalRPGMazeBagUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
end

function HorizontalRPGMazeBagUIApi:GetTitleText()
	return self:GetCfgText(1234002)
end

function HorizontalRPGMazeBagUIApi:GetEmptyViewText()
	return self:GetCfgText(2300152)
end

HorizontalRPGMazeBagUIApi:Init()
