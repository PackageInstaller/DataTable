-- chunkname: @IQIGame\\UIExternalApi\\WelcomeInvitedHistoryUIApi.lua

WelcomeInvitedHistoryUIApi = BaseLangApi:Extend()

function WelcomeInvitedHistoryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("NameLabel", self.GetNameLabel)
	self:RegisterApi("MsgLabel", self.GetMsgLabel)
	self:RegisterApi("TextNoRecord", self.GetTextNoRecord)
	self:RegisterApi("Value1Text", self.GetValue1Text)
end

function WelcomeInvitedHistoryUIApi:GetValue1Text(num1, num2)
	if num1 == 1 then
		if num2 <= 3 then
			return "0-" .. num2
		else
			return num1 .. "-" .. num2 - 3
		end
	else
		return num1 .. "-" .. num2
	end

	return string.format("%s-%s", num1, num2)
end

function WelcomeInvitedHistoryUIApi:GetTextNoRecord()
	return self:GetCfgText(3300430)
end

function WelcomeInvitedHistoryUIApi:GetMsgLabel()
	return self:GetCfgText(3300431)
end

function WelcomeInvitedHistoryUIApi:GetNameLabel()
	return self:GetCfgText(3300432)
end

function WelcomeInvitedHistoryUIApi:GetTitleText()
	return self:GetCfgText(3300433)
end

WelcomeInvitedHistoryUIApi:Init()
