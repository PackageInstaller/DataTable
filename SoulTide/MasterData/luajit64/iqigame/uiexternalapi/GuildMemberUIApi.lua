-- chunkname: @IQIGame\\UIExternalApi\\GuildMemberUIApi.lua

GuildMemberUIApi = BaseLangApi:Extend()

function GuildMemberUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("NumText", self.GetNumText)
	self:RegisterApi("CloseBtnLabel", self.GetCloseBtnLabel)
	self:RegisterApi("QuitGuildBtnLabel", self.GetQuitGuildBtnLabel)
	self:RegisterApi("ExamineBtnLabel", self.GetExamineBtnLabel)
	self:RegisterApi("OnLineTimeTextTitle", self.GetOnLineTimeTextTitle)
	self:RegisterApi("OnlineText", self.GetOnlineText)
	self:RegisterApi("ActivityText", self.GetActivityText)
	self:RegisterApi("PositionText", self.GetPositionText)
end

function GuildMemberUIApi:GetPositionText(position)
	if position == 1 then
		return self:GetCfgText(9101201)
	elseif position == 2 then
		return self:GetCfgText(9101202)
	end

	return self:GetCfgText(9101203)
end

function GuildMemberUIApi:GetActivityText(num)
	return string.format(self:GetCfgText(9101204), num)
end

function GuildMemberUIApi:GetOnlineText()
	return self:GetCfgText(9101205)
end

function GuildMemberUIApi:GetOnLineTimeTextTitle()
	return self:GetCfgText(9101206)
end

function GuildMemberUIApi:GetExamineBtnLabel()
	return self:GetCfgText(9101207)
end

function GuildMemberUIApi:GetQuitGuildBtnLabel(num)
	if num > 1 then
		return self:GetCfgText(9101208)
	end

	return self:GetCfgText(9101200)
end

function GuildMemberUIApi:GetCloseBtnLabel()
	return self:GetCfgText(9101209)
end

function GuildMemberUIApi:GetNumText(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function GuildMemberUIApi:GetTitleText()
	return self:GetCfgText(9101210)
end

GuildMemberUIApi:Init()
