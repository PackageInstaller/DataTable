-- chunkname: @IQIGame\\UIExternalApi\\GuildMemberManageUIApi.lua

GuildMemberManageUIApi = BaseLangApi:Extend()

function GuildMemberManageUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CloseBtnLabel", self.GetCloseBtnLabel)
	self:RegisterApi("AllRefuseBtnLabel", self.GetAllRefuseBtnLabel)
	self:RegisterApi("NumText", self.GetNumText)
	self:RegisterApi("NoneText", self.GetNoneText)
	self:RegisterApi("NoneTipText", self.GetNoneTipText)
	self:RegisterApi("OnlineText", self.GetOnlineText)
	self:RegisterApi("OnlineTimeLabel", self.GetOnlineTimeLabel)
	self:RegisterApi("AgreeBtnLabel", self.GetAgreeBtnLabel)
	self:RegisterApi("RefuseBtnLabel", self.GetRefuseBtn)
end

function GuildMemberManageUIApi:GetRefuseBtn()
	return self:GetCfgText(9101101)
end

function GuildMemberManageUIApi:GetAgreeBtnLabel()
	return self:GetCfgText(9101102)
end

function GuildMemberManageUIApi:GetOnlineTimeLabel()
	return self:GetCfgText(9101103)
end

function GuildMemberManageUIApi:GetOnlineText()
	return self:GetCfgText(9101104)
end

function GuildMemberManageUIApi:GetNoneTipText()
	return self:GetCfgText(9101105)
end

function GuildMemberManageUIApi:GetNoneText()
	return self:GetCfgText(9101106)
end

function GuildMemberManageUIApi:GetNumText(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function GuildMemberManageUIApi:GetAllRefuseBtnLabel()
	return self:GetCfgText(9101107)
end

function GuildMemberManageUIApi:GetCloseBtnLabel()
	return self:GetCfgText(9101108)
end

function GuildMemberManageUIApi:GetTitleText()
	return self:GetCfgText(9101109)
end

GuildMemberManageUIApi:Init()
