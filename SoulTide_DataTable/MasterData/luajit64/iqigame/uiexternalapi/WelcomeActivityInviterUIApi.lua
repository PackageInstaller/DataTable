-- chunkname: @IQIGame\\UIExternalApi\\WelcomeActivityInviterUIApi.lua

WelcomeActivityInviterUIApi = BaseLangApi:Extend()

function WelcomeActivityInviterUIApi:Init()
	self:RegisterApi("OpenTime", self.GetOpenTime)
	self:RegisterApi("OpenTimeValue", self.GetOpenTimeValue)
	self:RegisterApi("BtnFriendListLabel", self.GetBtnFriendListLabel)
	self:RegisterApi("BtnCopyLabel", self.GetBtnCopyLabel)
	self:RegisterApi("InvitationCode", self.GetInvitationCode)
	self:RegisterApi("TextNeedLv", self.GetTextNeedLv)
	self:RegisterApi("BtnGetRewardLabel", self.GetBtnGetRewardLabel)
end

function WelcomeActivityInviterUIApi:GetBtnGetRewardLabel(state)
	if state == 0 then
		return self:GetCfgText(3300420)
	elseif state == 1 then
		return self:GetCfgText(3300421)
	end

	return self:GetCfgText(3300422)
end

function WelcomeActivityInviterUIApi:GetTextNeedLv(str, completeNum, needNum)
	return string.format("%s(%s/%s)", str, completeNum, needNum)
end

function WelcomeActivityInviterUIApi:GetInvitationCode(code)
	return string.format(self:GetCfgText(3300423), code)
end

function WelcomeActivityInviterUIApi:GetBtnCopyLabel()
	return self:GetCfgText(3300424)
end

function WelcomeActivityInviterUIApi:GetBtnFriendListLabel()
	return self:GetCfgText(3300425)
end

function WelcomeActivityInviterUIApi:GetOpenTimeValue(startTime, endTime)
	return string.format("%s~%s", startTime, endTime)
end

function WelcomeActivityInviterUIApi:GetOpenTime()
	return self:GetCfgText(3300426)
end

WelcomeActivityInviterUIApi:Init()
