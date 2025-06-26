-- chunkname: @IQIGame\\UIExternalApi\\GuildDevelopBuyEffectUIApi.lua

GuildDevelopBuyEffectUIApi = BaseLangApi:Extend()

function GuildDevelopBuyEffectUIApi:Init()
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("BuyEffectBtn", self.GetBuyEffectBtn)
	self:RegisterApi("TextCostName", self.GetTextCostName)
	self:RegisterApi("TextCostNum", self.GetTextCostNum)
	self:RegisterApi("TextEffectState", self.GetTextEffectState)
	self:RegisterApi("TextEffectTime", self.GetTextEffectTime)
end

function GuildDevelopBuyEffectUIApi:GetTextEffectTime(timeStr)
	return string.format(self:GetCfgText(9100701), timeStr)
end

function GuildDevelopBuyEffectUIApi:GetTextEffectState(top)
	if top then
		return self:GetCfgText(9100702)
	end

	return self:GetCfgText(9100703)
end

function GuildDevelopBuyEffectUIApi:GetTextCostNum(num, maxNum, top)
	if top then
		return string.format("%s/%s", num, maxNum)
	end

	return string.format("%s/%s", num, maxNum)
end

function GuildDevelopBuyEffectUIApi:GetTextCostName(name, top)
	if top then
		return name
	end

	return name
end

function GuildDevelopBuyEffectUIApi:GetBuyEffectBtn()
	return self:GetCfgText(9100704)
end

function GuildDevelopBuyEffectUIApi:GetTextTip()
	return self:GetCfgText(9100705)
end

GuildDevelopBuyEffectUIApi:Init()
