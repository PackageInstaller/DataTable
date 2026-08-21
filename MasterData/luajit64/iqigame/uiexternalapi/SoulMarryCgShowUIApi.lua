-- chunkname: @IQIGame\\UIExternalApi\\SoulMarryCgShowUIApi.lua

SoulMarryCgShowUIApi = BaseLangApi:Extend()

function SoulMarryCgShowUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextSuccess", self.GetTextSuccess)
	self:RegisterApi("TextBtnContinue", self.GetTextBtnContinue)
end

function SoulMarryCgShowUIApi:GetTextBtnContinue()
	return self:GetCfgText(1009012)
end

function SoulMarryCgShowUIApi:GetTextSuccess()
	return self:GetCfgText(1239302)
end

function SoulMarryCgShowUIApi:GetTextMsg()
	return string.format(self:GetCfgText(1239300), "")
end

function SoulMarryCgShowUIApi:GetTextTitle()
	return self:GetCfgText(1239301)
end

SoulMarryCgShowUIApi:Init()
