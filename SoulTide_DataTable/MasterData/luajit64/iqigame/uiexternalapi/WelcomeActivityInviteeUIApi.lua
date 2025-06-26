-- chunkname: @IQIGame\\UIExternalApi\\WelcomeActivityInviteeUIApi.lua

WelcomeActivityInviteeUIApi = BaseLangApi:Extend()

function WelcomeActivityInviteeUIApi:Init()
	self:RegisterApi("OpenTime", self.GetOpenTime)
	self:RegisterApi("RewardTitle1", self.GetRewardTitle1)
	self:RegisterApi("RewardTitle2", self.GetRewardTitle2)
	self:RegisterApi("InputTitle", self.GetInputTitle)
	self:RegisterApi("BtnSubmitLabel", self.GetBtnSubmitLabel)
	self:RegisterApi("InvitedState", self.GetInvitedState)
	self:RegisterApi("InvitedTitle", self.GetInvitedTitle)
	self:RegisterApi("OpenTimeValue", self.GetOpenTimeValue)
	self:RegisterApi("Placeholder", self.GetPlaceholder)
end

function WelcomeActivityInviteeUIApi:GetPlaceholder()
	return self:GetCfgText(3300401)
end

function WelcomeActivityInviteeUIApi:GetOpenTimeValue(startTime, endTime)
	return string.format("%s~%s", startTime, endTime)
end

function WelcomeActivityInviteeUIApi:GetInvitedTitle()
	return self:GetCfgText(3300402)
end

function WelcomeActivityInviteeUIApi:GetInvitedState()
	return self:GetCfgText(3300403)
end

function WelcomeActivityInviteeUIApi:GetBtnSubmitLabel()
	return self:GetCfgText(3300404)
end

function WelcomeActivityInviteeUIApi:GetInputTitle()
	return self:GetCfgText(3300405)
end

function WelcomeActivityInviteeUIApi:GetRewardTitle2()
	return self:GetCfgText(3300406)
end

function WelcomeActivityInviteeUIApi:GetRewardTitle1()
	return self:GetCfgText(3300407)
end

function WelcomeActivityInviteeUIApi:GetOpenTime()
	return self:GetCfgText(3300408)
end

WelcomeActivityInviteeUIApi:Init()
