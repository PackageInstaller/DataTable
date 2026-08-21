-- chunkname: @IQIGame\\UIExternalApi\\SoulListUIApi.lua

SoulListUIApi = BaseLangApi:Extend()

function SoulListUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("bottomDesc_1", self.GetBottomDesc1)
	self:RegisterApi("bottomDesc_2", self.GetBottomDesc2)
	self:RegisterApi("bottomDesc_3", self.GetBottomDesc3)
	self:RegisterApi("goBtnRecoverTxt", self.GetBtnRecoverTxt)
	self:RegisterApi("goOathText", self.GetGoOathText)
end

function SoulListUIApi:GetGoOathText()
	return self:GetCfgText(1229083)
end

function SoulListUIApi:GetBtnRecoverTxt()
	return self:GetCfgText(1109030)
end

function SoulListUIApi:GetTitle()
	return self:GetCfgText(1223001)
end

function SoulListUIApi:GetBottomDesc1()
	return self:GetCfgText(1229080)
end

function SoulListUIApi:GetBottomDesc2()
	return self:GetCfgText(1229081)
end

function SoulListUIApi:GetBottomDesc3()
	return self:GetCfgText(1229082)
end

SoulListUIApi:Init()
