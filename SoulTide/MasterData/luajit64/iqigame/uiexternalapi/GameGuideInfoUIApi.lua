-- chunkname: @IQIGame\\UIExternalApi\\GameGuideInfoUIApi.lua

GameGuideInfoUIApi = BaseLangApi:Extend()

function GameGuideInfoUIApi:Init()
	self:RegisterApi("Text1", self.GetText1)
	self:RegisterApi("Text2", self.GetText2)
	self:RegisterApi("Text3", self.GetText3)
	self:RegisterApi("Text4", self.GetText4)
	self:RegisterApi("Text5", self.GetText5)
	self:RegisterApi("Text6", self.GetText6)
end

function GameGuideInfoUIApi:GetText6()
	return self:GetCfgText(6100002)
end

function GameGuideInfoUIApi:GetText5()
	return self:GetCfgText(6100001)
end

function GameGuideInfoUIApi:GetText4()
	return self:GetCfgText(6100003)
end

function GameGuideInfoUIApi:GetText3()
	return self:GetCfgText(6100001)
end

function GameGuideInfoUIApi:GetText2()
	return self:GetCfgText(6100004)
end

function GameGuideInfoUIApi:GetText1()
	return self:GetCfgText(6100001)
end

GameGuideInfoUIApi:Init()
