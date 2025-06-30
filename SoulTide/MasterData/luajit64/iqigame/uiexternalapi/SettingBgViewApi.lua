-- chunkname: @IQIGame\\UIExternalApi\\SettingBgViewApi.lua

SettingBgViewApi = BaseLangApi:Extend()

function SettingBgViewApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("ErrorMsg1", self.GetErrorMs1)
	self:RegisterApi("Msg", self.GetMsg)
end

function SettingBgViewApi:GetMsg()
	return self:GetCfgText(1111201)
end

function SettingBgViewApi:GetErrorMsg1()
	return self:GetCfgText(1111202)
end

function SettingBgViewApi:GetErrorMsg()
	return self:GetCfgText(1111203)
end

function SettingBgViewApi:GetTextTitle1()
	return self:GetCfgText(1111204)
end

function SettingBgViewApi:GetTextTitle()
	return self:GetCfgText(1111205)
end

SettingBgViewApi:Init()
