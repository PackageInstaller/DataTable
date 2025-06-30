-- chunkname: @IQIGame\\UIExternalApi\\SettingInputViewApi.lua

SettingInputViewApi = BaseLangApi:Extend()

function SettingInputViewApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextInput", self.GetTextInput)
	self:RegisterApi("TextBtnExchange", self.GetTextBtnExchange)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("TextSettingInputTitle", self.GetTextSettingInputTitle)
end

function SettingInputViewApi:GetTextSettingInputTitle()
	return self:GetCfgText(1111006)
end

function SettingInputViewApi:GetErrorMsg()
	return self:GetCfgText(1111301)
end

function SettingInputViewApi:GetTextBtnExchange()
	return self:GetCfgText(1111302)
end

function SettingInputViewApi:GetTextInput()
	return self:GetCfgText(1111303)
end

function SettingInputViewApi:GetTextTitle()
	return self:GetCfgText(1111304)
end

SettingInputViewApi:Init()
