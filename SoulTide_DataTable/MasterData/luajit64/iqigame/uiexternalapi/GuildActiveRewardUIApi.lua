-- chunkname: @IQIGame\\UIExternalApi\\GuildActiveRewardUIApi.lua

GuildActiveRewardUIApi = BaseLangApi:Extend()

function GuildActiveRewardUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBottom", self.GetTextBottom)
	self:RegisterApi("TextPoint", self.GetTextPoint)
	self:RegisterApi("TextGuildGold", self.GetTextGuildGold)
	self:RegisterApi("TextCurrent", self.GetTextCurrent)
	self:RegisterApi("TextEmptyCurrent", self.GetTextEmptyCurrent)
end

function GuildActiveRewardUIApi:GetTextEmptyCurrent()
	return self:GetCfgText(9100401)
end

function GuildActiveRewardUIApi:GetTextCurrent()
	return self:GetCfgText(9100402)
end

function GuildActiveRewardUIApi:GetTextGuildGold(num)
	return string.format("%s", num)
end

function GuildActiveRewardUIApi:GetTextPoint(num)
	return string.format("%s", num)
end

function GuildActiveRewardUIApi:GetTextBottom()
	return self:GetCfgText(9100403)
end

function GuildActiveRewardUIApi:GetTextTitle()
	return self:GetCfgText(9100404)
end

GuildActiveRewardUIApi:Init()
