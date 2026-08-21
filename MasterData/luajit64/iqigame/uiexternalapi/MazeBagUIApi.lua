-- chunkname: @IQIGame\\UIExternalApi\\MazeBagUIApi.lua

MazeBagUIApi = BaseLangApi:Extend()

function MazeBagUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
end

function MazeBagUIApi:GetTitleText()
	return self:GetCfgText(1234002)
end

function MazeBagUIApi:GetEmptyViewText()
	return self:GetCfgText(2300152)
end

MazeBagUIApi:Init()
