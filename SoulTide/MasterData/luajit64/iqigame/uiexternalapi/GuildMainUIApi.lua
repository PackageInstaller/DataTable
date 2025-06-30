-- chunkname: @IQIGame\\UIExternalApi\\GuildMainUIApi.lua

GuildMainUIApi = BaseLangApi:Extend()

function GuildMainUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("GuildLv", self.GetGuildLv)
	self:RegisterApi("GuildID", self.GetGuildID)
	self:RegisterApi("GuildMembers", self.GetGuildMembers)
	self:RegisterApi("GuildType", self.GetGuildType)
	self:RegisterApi("LevelText", self.GetLevelText)
	self:RegisterApi("TextType1", self.GetTextType1)
	self:RegisterApi("TextType2", self.GetTextType2)
	self:RegisterApi("TextGuildFundsTicket", self.GetTextGuildFundsTicket)
	self:RegisterApi("GuildBoardTitle", self.GetGuildBoardTitle)
	self:RegisterApi("BanNotice", self.GetBanNotice)
end

function GuildMainUIApi:GetBanNotice()
	return self:GetCfgText(9101213)
end

function GuildMainUIApi:GetGuildBoardTitle()
	return self:GetCfgText(9101214)
end

function GuildMainUIApi:GetTextGuildFundsTicket(num, maxNum)
	return string.format(self:GetCfgText(9100301), num, maxNum)
end

function GuildMainUIApi:GetTextType2()
	return self:GetCfgText(9100302)
end

function GuildMainUIApi:GetTextType1()
	return self:GetCfgText(9100303)
end

function GuildMainUIApi:GetLevelText(lv)
	return string.format("Lv.%s", lv)
end

function GuildMainUIApi:GetGuildType(type)
	if type == 1 then
		return self:GetCfgText(9100304)
	end

	return self:GetCfgText(9100305)
end

function GuildMainUIApi:GetGuildMembers(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function GuildMainUIApi:GetGuildID(id)
	return string.format("ID:%s", id)
end

function GuildMainUIApi:GetGuildLv(lv)
	return string.format("%s", lv)
end

function GuildMainUIApi:GetTextTitle()
	return self:GetCfgText(9100306)
end

GuildMainUIApi:Init()
