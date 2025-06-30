-- chunkname: @IQIGame\\UIExternalApi\\GuildIntroduceUIApi.lua

GuildIntroduceUIApi = BaseLangApi:Extend()

function GuildIntroduceUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TabBtnText", self.GetTabBtnText)
	self:RegisterApi("TextNum", self.GetTextNum)
	self:RegisterApi("ApplyNumber", self.GetApplyNumber)
	self:RegisterApi("TextNoneRecommend", self.GetTextNoneRecommend)
	self:RegisterApi("BtnRefreshLabel", self.GetBtnRefreshLabel)
	self:RegisterApi("ApplyBtn", self.GetApplyBtn)
	self:RegisterApi("ApplyText", self.GetApplyText)
	self:RegisterApi("GuildLv", self.GetGuildLv)
	self:RegisterApi("GuildPresident", self.GetGuildPresident)
	self:RegisterApi("GuildAuditType", self.GetGuildAuditType)
	self:RegisterApi("GuildMembers", self.GetGuildMembers)
	self:RegisterApi("GuildActivityPolicy", self.GetGuildActivityPolicy)
	self:RegisterApi("TextLV", self.GetTextLV)
	self:RegisterApi("EstablishTitle", self.GetEstablishTitle)
	self:RegisterApi("EstablishBtnLabel", self.GetEstablishBtnLabel)
	self:RegisterApi("EstablishTextCost", self.GetEstablishTextCost)
	self:RegisterApi("SearchTitle", self.GetSearchTitle)
	self:RegisterApi("SearchNoneText", self.GetSearchNoneText)
	self:RegisterApi("ApplyBtnCancel", self.GetApplyBtnCancel)
end

function GuildIntroduceUIApi:GetTextLV()
	return self:GetCfgText(9100501)
end

function GuildIntroduceUIApi:GetApplyBtnCancel()
	return self:GetCfgText(9100502)
end

function GuildIntroduceUIApi:GetApplyNumber(num1, num2)
	return string.format(self:GetCfgText(9100503), num1, num2)
end

function GuildIntroduceUIApi:GetSearchNoneText()
	return self:GetCfgText(9100504)
end

function GuildIntroduceUIApi:GetSearchTitle()
	return self:GetCfgText(9100505)
end

function GuildIntroduceUIApi:GetEstablishTextCost(num)
	return string.format("x%s", num)
end

function GuildIntroduceUIApi:GetEstablishBtnLabel()
	return self:GetCfgText(9100506)
end

function GuildIntroduceUIApi:GetEstablishTitle()
	return self:GetCfgText(9100507)
end

function GuildIntroduceUIApi:GetGuildActivityPolicy(type)
	if type == 1 then
		return self:GetCfgText(9100508)
	end

	return self:GetCfgText(9100509)
end

function GuildIntroduceUIApi:GetGuildMembers(num1, num2)
	return string.format("%s/%s", num1, num2)
end

function GuildIntroduceUIApi:GetGuildAuditType(type)
	if type == 1 then
		return self:GetCfgText(9100510)
	end

	return self:GetCfgText(9100511)
end

function GuildIntroduceUIApi:GetGuildPresident(name)
	return string.format(self:GetCfgText(9100512), name)
end

function GuildIntroduceUIApi:GetGuildLv(num)
	return string.format("%s", num)
end

function GuildIntroduceUIApi:GetApplyText()
	return self:GetCfgText(9100513)
end

function GuildIntroduceUIApi:GetApplyBtn()
	return self:GetCfgText(9100514)
end

function GuildIntroduceUIApi:GetTextNum(num, maxNum)
	return string.format(self:GetCfgText(9100522), num, maxNum)
end

function GuildIntroduceUIApi:GetBtnRefreshLabel()
	return self:GetCfgText(9100515)
end

function GuildIntroduceUIApi:GetTextNoneRecommend()
	return self:GetCfgText(9100516)
end

function GuildIntroduceUIApi:GetTabBtnText(index)
	if index == 1 then
		return self:GetCfgText(9100517)
	elseif index == 2 then
		return self:GetCfgText(9100518)
	elseif index == 3 then
		return self:GetCfgText(9100519)
	elseif index == 4 then
		return self:GetCfgText(9100520)
	else
		return ""
	end
end

function GuildIntroduceUIApi:GetTitleText()
	return self:GetCfgText(9100521)
end

GuildIntroduceUIApi:Init()
