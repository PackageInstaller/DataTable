-- chunkname: @IQIGame\\UIExternalApi\\GuildDevelopUIApi.lua

GuildDevelopUIApi = BaseLangApi:Extend()

function GuildDevelopUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ToggleBaseLabel", self.GetToggleBaseLabel)
	self:RegisterApi("ToggleFightLabel", self.GetToggleFightLabel)
	self:RegisterApi("TextMaxLevel", self.GetTextMaxLevel)
	self:RegisterApi("EffectBtnLabel", self.GetEffectBtnLabel)
end

function GuildDevelopUIApi:GetEffectBtnLabel()
	return self:GetCfgText(9100801)
end

function GuildDevelopUIApi:GetTextMaxLevel()
	return self:GetCfgText(9100802)
end

function GuildDevelopUIApi:GetToggleFightLabel()
	return self:GetCfgText(9100803)
end

function GuildDevelopUIApi:GetToggleBaseLabel()
	return self:GetCfgText(9100804)
end

function GuildDevelopUIApi:GetTitleText()
	return self:GetCfgText(9100805)
end

GuildDevelopUIApi:Init()
