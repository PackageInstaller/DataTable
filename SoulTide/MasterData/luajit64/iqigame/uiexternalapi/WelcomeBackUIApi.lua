-- chunkname: @IQIGame\\UIExternalApi\\WelcomeBackUIApi.lua

WelcomeBackUIApi = BaseLangApi:Extend()

function WelcomeBackUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("BtnMsgLabel", self.GetBtnMsgLabel)
	self:RegisterApi("Text01", self.GetText01)
	self:RegisterApi("Text02", self.GetText02)
	self:RegisterApi("Text03", self.GetText03)
	self:RegisterApi("TextNeedLv", self.GetTextNeedLv)
	self:RegisterApi("BtnGetRewardLabel1", self.GetBtnGetRewardLabel1)
	self:RegisterApi("BtnGetRewardLabel2", self.GetBtnGetRewardLabel2)
	self:RegisterApi("BtnGetRewardLabel3", self.GetBtnGetRewardLabel3)
	self:RegisterApi("OpenTimeValue", self.GetOpenTimeValue)
end

function WelcomeBackUIApi:GetOpenTimeValue(time)
	return string.format(self:GetCfgText(3300440), getCustomDateTimeText(time, "MonthToMinuteFormat"))
end

function WelcomeBackUIApi:GetBtnGetRewardLabel3()
	return self:GetCfgText(3300422)
end

function WelcomeBackUIApi:GetBtnGetRewardLabel2()
	return self:GetCfgText(3300420)
end

function WelcomeBackUIApi:GetBtnGetRewardLabel1()
	return self:GetCfgText(3300421)
end

function WelcomeBackUIApi:GetTextNeedLv(str, num1, num2)
	return string.format("%s<color=#206deb>(%s/%s)</color>", str, num1, num2)
end

function WelcomeBackUIApi:GetText03()
	return self:GetCfgText(3300441)
end

function WelcomeBackUIApi:GetText02(num)
	if num < 10 then
		return string.format("<Size=60>0%s</Size>", num)
	end

	return string.format("<Size=60>%s</Size>", num)
end

function WelcomeBackUIApi:GetText01()
	return self:GetCfgText(3300442)
end

function WelcomeBackUIApi:GetBtnMsgLabel()
	return self:GetCfgText(3300443)
end

function WelcomeBackUIApi:GetTitle()
	return self:GetCfgText(3300444)
end

WelcomeBackUIApi:Init()
