-- chunkname: @IQIGame\\UIExternalApi\\SettingPlayerInfoViewApi.lua

SettingPlayerInfoViewApi = BaseLangApi:Extend()

function SettingPlayerInfoViewApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextID", self.GetTextID)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextTitle3", self.GetTextTitle3)
	self:RegisterApi("TextTitle4", self.GetTextTitle4)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("TextTitle5", self.GetTextTitle5)
	self:RegisterApi("TextTitle6", self.GetTextTitle6)
	self:RegisterApi("TextTitle7", self.GetTextTitle7)
	self:RegisterApi("ErrorMsg3", self.GetErrorMsg3)
	self:RegisterApi("ErrorMsg4", self.GetErrorMsg4)
	self:RegisterApi("ErrorMsg5", self.GetErrorMsg5)
	self:RegisterApi("ErrorMsg6", self.GetErrorMsg6)
	self:RegisterApi("TextPlaceHolder", self.GetTextPlaceHolder)
	self:RegisterApi("TextBtnCopy", self.GetTextBtnCopy)
	self:RegisterApi("TextTitleEng", self.GetTextTitleEng)
	self:RegisterApi("TextToggleFrame", self.GetTextToggleFrame)
	self:RegisterApi("TextToggleHead", self.GetTextToggleHead)
	self:RegisterApi("TextBtnClose", self.GetTextBtnClose)
	self:RegisterApi("TagText", self.GetTagText)
end

function SettingPlayerInfoViewApi:GetTagText()
	return self:GetCfgText(1111205)
end

function SettingPlayerInfoViewApi:GetTextBtnClose()
	return self:GetCfgText(1110023)
end

function SettingPlayerInfoViewApi:GetTextToggleHead()
	return self:GetCfgText(1114001)
end

function SettingPlayerInfoViewApi:GetTextToggleFrame()
	return self:GetCfgText(1114002)
end

function SettingPlayerInfoViewApi:GetTextTitleEng()
	return self:GetCfgText(1114003)
end

function SettingPlayerInfoViewApi:GetTextBtnCopy()
	return self:GetCfgText(1111118)
end

function SettingPlayerInfoViewApi:GetTextPlaceHolder()
	return self:GetCfgText(1111116)
end

function SettingPlayerInfoViewApi:GetErrorMsg6()
	return self:GetCfgText(1111117)
end

function SettingPlayerInfoViewApi:GetErrorMsg5()
	return self:GetCfgText(1111101)
end

function SettingPlayerInfoViewApi:GetErrorMsg4(name)
	return name .. self:GetCfgText(1111102)
end

function SettingPlayerInfoViewApi:GetErrorMsg3()
	return self:GetCfgText(1111103)
end

function SettingPlayerInfoViewApi:GetTextTitle7()
	return self:GetCfgText(1111104)
end

function SettingPlayerInfoViewApi:GetTextTitle6()
	return self:GetCfgText(1111105)
end

function SettingPlayerInfoViewApi:GetTextTitle5()
	return self:GetCfgText(1111106)
end

function SettingPlayerInfoViewApi:GetErrorMsg2()
	return self:GetCfgText(1111107)
end

function SettingPlayerInfoViewApi:GetErrorMsg1()
	return self:GetCfgText(1111108)
end

function SettingPlayerInfoViewApi:GetTextTitle4()
	return self:GetCfgText(1111109)
end

function SettingPlayerInfoViewApi:GetTextTitle3()
	return self:GetCfgText(1111110)
end

function SettingPlayerInfoViewApi:GetTextTitle2()
	return self:GetCfgText(1111111)
end

function SettingPlayerInfoViewApi:GetErrorMsg()
	return self:GetCfgText(1111112)
end

function SettingPlayerInfoViewApi:GetTextID(guId)
	return self:GetCfgText(1111113) .. " " .. guId
end

function SettingPlayerInfoViewApi:GetTextTitle1()
	return self:GetCfgText(1111114)
end

function SettingPlayerInfoViewApi:GetTextTitle()
	return self:GetCfgText(1111115)
end

SettingPlayerInfoViewApi:Init()
