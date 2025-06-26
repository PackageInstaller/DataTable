-- chunkname: @IQIGame\\UIExternalApi\\LoginUIApi.lua

LoginUIApi = BaseLangApi:Extend()

function LoginUIApi:Init()
	self:RegisterApi("IDText", self.SetID)
	self:RegisterApi("PswText", self.SetPassword)
	self:RegisterApi("goBtnGuestTxt", self.SetBtnGuestTxt)
	self:RegisterApi("goBtnLoginTxt", self.SetBtnLoginTxt)
	self:RegisterApi("goEnterTxt", self.SetEnterTxt)
	self:RegisterApi("CurrentServerName", self.SetServerName)
	self:RegisterApi("goViewTitle2", self.SetViewTitle2)
	self:RegisterApi("goViewTitle3", self.SetViewTitle3)
	self:RegisterApi("goSelectServerName", self.SetServerNameInSelectView)
	self:RegisterApi("IDTextTitle", self.GetIDTextTitle)
	self:RegisterApi("PassWord1Title", self.GetPassWord1Title)
	self:RegisterApi("PassWord2Title", self.GetPassWord2Title)
	self:RegisterApi("ActivationCodeTitle", self.GetActivationCodeTitle)
	self:RegisterApi("BtnTextBack", self.GetBtnTextBack)
	self:RegisterApi("BtnTextRegister", self.GetBtnTextRegister)
	self:RegisterApi("IDTextError", self.GetIDTextError)
	self:RegisterApi("PassWord1Error", self.GetPassWord1Error)
	self:RegisterApi("PassWord2Error", self.GetPassWord2Error)
	self:RegisterApi("ActivationCodeError", self.GetActivationCodeError)
	self:RegisterApi("PlaceholderID", self.GetPlaceholderID)
	self:RegisterApi("PlaceholderPass1", self.GetPlaceholderPass1)
	self:RegisterApi("PlaceholderPass2", self.GetPlaceholderPass2)
	self:RegisterApi("PlaceholderCode", self.GetPlaceholderCode)
	self:RegisterApi("ServerStateText", self.GetServerStateText)
	self:RegisterApi("ServerRecommendNodeText", self.GetServerRecommendNodeText)
	self:RegisterApi("ServerNewNodeText", self.GetServerNewNodeText)
	self:RegisterApi("TextBtnNotice", self.GetTextBtnNotice)
	self:RegisterApi("goBtnRegisterTxt", self.GetBtnRegisterTxt)
	self:RegisterApi("BtnCustomerServiceTxt", self.GetBtnCustomerServiceTxt)
	self:RegisterApi("VersionText", self.GetVersionText)
	self:RegisterApi("SDKLoginFailNotice", self.GetSDKLoginFailNotice)
	self:RegisterApi("VersionTooLowNotice", self.GetVersionTooLowNotice)
	self:RegisterApi("GameVersionTooLowNotice", self.GetGameVersionTooLowNotice)
	self:RegisterApi("LoginFailNotice", self.GetLoginFailNotice)
	self:RegisterApi("AccountActiveFail", self.GetAccountActiveFail)
	self:RegisterApi("IDInputPlaceholder", self.GetIDInputPlaceholder)
	self:RegisterApi("PswInputPlaceholder", self.GetPswInputPlaceholder)
end

function LoginUIApi:GetBtnRegisterTxt()
	return self:GetCfgText(1009023)
end

function LoginUIApi:GetTextBtnNotice()
	return self:GetCfgText(1009041)
end

function LoginUIApi:GetServerNewNodeText()
	return ""
end

function LoginUIApi:GetServerRecommendNodeText()
	return self:GetCfgText(1009029)
end

function LoginUIApi:GetServerStateText(state)
	if state == 1 then
		return self.TextColor[213] .. self:GetCfgText(1009030) .. self.TextColor[0]
	elseif state == 2 then
		return self:GetCfgText(1009031)
	elseif state == 3 then
		return self:GetCfgText(1009032)
	elseif state == 4 then
		return self:GetCfgText(1009032)
	end
end

function LoginUIApi:GetPlaceholderCode()
	return self:GetCfgText(1009015)
end

function LoginUIApi:GetPlaceholderPass2()
	return self:GetCfgText(1009016)
end

function LoginUIApi:GetPlaceholderPass1()
	return self:GetCfgText(1009017)
end

function LoginUIApi:GetPlaceholderID()
	return self:GetCfgText(1009018)
end

function LoginUIApi:GetActivationCodeError()
	return self:GetCfgText(1009019)
end

function LoginUIApi:GetPassWord2Error()
	return self:GetCfgText(1009020)
end

function LoginUIApi:GetPassWord1Error()
	return self:GetCfgText(1009021)
end

function LoginUIApi:GetIDTextError()
	return self:GetCfgText(1009022)
end

function LoginUIApi:GetBtnTextRegister()
	return self:GetCfgText(1009023)
end

function LoginUIApi:GetBtnTextBack()
	return self:GetCfgText(1009024)
end

function LoginUIApi:GetActivationCodeTitle()
	return self:GetCfgText(1009025)
end

function LoginUIApi:GetPassWord2Title()
	return self:GetCfgText(1009026)
end

function LoginUIApi:GetPassWord1Title()
	return self:GetCfgText(1009027)
end

function LoginUIApi:GetIDTextTitle()
	return self:GetCfgText(1009028)
end

function LoginUIApi:SetID(id)
	return id
end

function LoginUIApi:SetPassword(password)
	return password
end

function LoginUIApi:SetBtnGuestTxt()
	return self:GetCfgText(1009005)
end

function LoginUIApi:SetBtnLoginTxt()
	return self:GetCfgText(1009006)
end

function LoginUIApi:SetEnterTxt()
	return self:GetCfgText(1009012)
end

function LoginUIApi:SetServerName(server)
	return server
end

function LoginUIApi:SetViewTitle2()
	return self:GetCfgText(1009013)
end

function LoginUIApi:SetViewTitle3()
	return self:GetCfgText(1009014)
end

function LoginUIApi:SetServerNameInSelectView(server, state)
	if state == 1 then
		return self.TextColor[213] .. server .. self.TextColor[0]
	end

	return server
end

function LoginUIApi:GetBtnCustomerServiceTxt()
	return self:GetCfgText(1009042)
end

function LoginUIApi:GetVersionText(version, assetVersion)
	return string.format(self:GetCfgText(1009043) .. "%s(%s)", version, assetVersion)
end

function LoginUIApi:GetSDKLoginFailNotice()
	return self:GetCfgText(1009044)
end

function LoginUIApi:GetVersionTooLowNotice()
	return self:GetCfgText(1009045)
end

function LoginUIApi:GetGameVersionTooLowNotice()
	return self:GetCfgText(1009048)
end

function LoginUIApi:GetLoginFailNotice()
	return self:GetCfgText(1009046)
end

function LoginUIApi:GetAccountActiveFail()
	return self:GetCfgText(1009047)
end

function LoginUIApi:GetIDInputPlaceholder()
	return self:GetCfgText(1009033)
end

function LoginUIApi:GetPswInputPlaceholder()
	return self:GetCfgText(1009034)
end

LoginUIApi:Init()
