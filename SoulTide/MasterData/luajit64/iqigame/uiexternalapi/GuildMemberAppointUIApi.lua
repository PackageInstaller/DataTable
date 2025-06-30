-- chunkname: @IQIGame\\UIExternalApi\\GuildMemberAppointUIApi.lua

GuildMemberAppointUIApi = BaseLangApi:Extend()

function GuildMemberAppointUIApi:Init()
	self:RegisterApi("AppointTitleText", self.GetAppointTitleText)
	self:RegisterApi("AppointContentText", self.GetAppointContentText)
	self:RegisterApi("AppointPresidentBtnLabel", self.GetAppointPresidentBtnLabel)
	self:RegisterApi("AppointVicePresidentBtnLabel", self.GetAppointVicePresidentBtnLabel)
	self:RegisterApi("AppointMemberBtnLabel", self.GetAppointMemberBtnLabel)
	self:RegisterApi("RemoveTitleText", self.GetRemoveTitleText)
	self:RegisterApi("RemoveContentText", self.GetRemoveContentText)
	self:RegisterApi("RemoveCancelBtnLabel", self.GetRemoveCancelBtnLabel)
	self:RegisterApi("RemoveSureBtnLabel", self.GetRemoveSureBtnLabel)
end

function GuildMemberAppointUIApi:GetRemoveSureBtnLabel()
	return self:GetCfgText(9100601)
end

function GuildMemberAppointUIApi:GetRemoveCancelBtnLabel()
	return self:GetCfgText(9100602)
end

function GuildMemberAppointUIApi:GetRemoveContentText(name)
	return string.format(self:GetCfgText(9100603), name)
end

function GuildMemberAppointUIApi:GetRemoveTitleText()
	return self:GetCfgText(9100604)
end

function GuildMemberAppointUIApi:GetAppointMemberBtnLabel()
	return self:GetCfgText(9100605)
end

function GuildMemberAppointUIApi:GetAppointVicePresidentBtnLabel()
	return self:GetCfgText(9100606)
end

function GuildMemberAppointUIApi:GetAppointPresidentBtnLabel()
	return self:GetCfgText(9100607)
end

function GuildMemberAppointUIApi:GetAppointContentText(name)
	return string.format(self:GetCfgText(9100608), name)
end

function GuildMemberAppointUIApi:GetAppointTitleText()
	return self:GetCfgText(9100609)
end

GuildMemberAppointUIApi:Init()
