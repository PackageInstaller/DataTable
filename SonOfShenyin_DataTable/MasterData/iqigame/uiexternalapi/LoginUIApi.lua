-- chunkname: @IQIGame\\UIExternalApi\\LoginUIApi.lua

LoginUIApi = BaseLangApi:Extend()

function LoginUIApi:GetServerNewNodeText()
	return ""
end

function LoginUIApi:GetServerRecommendNodeText()
	return self:GetCfgText(1210013)
end

function LoginUIApi:GetServerStateText(state)
	if state == 1 then
		return self.TextColor[213] .. self:GetCfgText(12) .. self.TextColor[0]
	elseif state == 2 then
		return self:GetCfgText(3010003)
	elseif state == 3 then
		return self:GetCfgText(3010004)
	elseif state == 4 then
		return self:GetCfgText(1200027)
	end
end

function LoginUIApi:GetStateTitle(index)
	if index == 1 then
		return self:GetCfgText(1600042)
	elseif index == 2 then
		return self:GetCfgText(1600043)
	elseif index == 3 then
		return self:GetCfgText(1200027)
	elseif index == 4 then
		return self:GetCfgText(1600044)
	else
		return ""
	end
end

function LoginUIApi:GetPlaceholderCode()
	return ""
end

function LoginUIApi:GetPlaceholderPass2()
	return self:GetCfgText(1220003)
end

function LoginUIApi:GetPlaceholderPass1()
	return self:GetCfgText(1220002)
end

function LoginUIApi:GetPlaceholderCode()
	return self:GetCfgText(1220004)
end

function LoginUIApi:GetPlaceholderID()
	return self:GetCfgText(1220001)
end

function LoginUIApi:GetActivationCodeError()
	return self:GetCfgText(4000001)
end

function LoginUIApi:GetPassWord2Error()
	return self:GetCfgText(4000002)
end

function LoginUIApi:GetPassWord1Error()
	return self:GetCfgText(4000003)
end

function LoginUIApi:GetIDTextError()
	return self:GetCfgText(4000004)
end

function LoginUIApi:GetBtnTextRegister()
	return self:GetCfgText(1220005)
end

function LoginUIApi:GetBtnTextBack()
	return self:GetCfgText(3060004)
end

function LoginUIApi:GetActivationCodeTitle()
	return self:GetCfgText(3060005)
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
	return self:GetCfgText(1210006)
end

function LoginUIApi:SetBtnLoginTxt()
	return self:GetCfgText(1210004)
end

function LoginUIApi:SetBtnLogin1Txt()
	return self:GetCfgText(1210003)
end

function LoginUIApi:SetBtnRegisterTxt()
	return self:GetCfgText(1210005)
end

function LoginUIApi:SetEnterTxt()
	return self:GetCfgText(1210012)
end

function LoginUIApi:SetServerName(server)
	return server
end

function LoginUIApi:SetViewTitle2()
	return self:GetCfgText(3010002)
end

function LoginUIApi:SetViewTitle3()
	return self:GetCfgText(3010001)
end

function LoginUIApi:SetServerNameInSelectView(server, state)
	if state == 1 then
		return self.TextColor[5] .. server .. self.TextColor[0]
	end

	return server
end

function LoginUIApi:GetProtocolLabel1()
	return self:GetCfgText(1210010)
end

function LoginUIApi:GetProtocolLabel2()
	return self:GetCfgText(1210011)
end

function LoginUIApi:GetUserProtocolBtnText()
	return self:GetCfgText(1210007)
end

function LoginUIApi:GetPrivacyPolicyBtnText()
	return self:GetCfgText(1210008)
end

function LoginUIApi:GetChildPrivacyBtnText()
	return ""
end

function LoginUIApi:GetUserProtocolUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E6%B8%B8%E6%88%8F%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE.html"
end

function LoginUIApi:GetPrivacyPolicyUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E4%BF%9D%E6%8A%A4%E6%94%BF%E7%AD%96.html"
end

function LoginUIApi:GetChildPrivacyUrl()
	return "https://lhcx.iqigame.net/p/per_child.html"
end

function LoginUIApi:GetUserProtocolTitleText()
	return self:GetCfgText(1210007)
end

function LoginUIApi:GetPrivacyPolicyTitleText()
	return self:GetCfgText(1210008)
end

function LoginUIApi:GetChildPrivacyTitleText()
	return ""
end

function LoginUIApi:GetOtherBtnInfo(index)
	if index == 1 then
		return self:GetCfgText(1210008)
	elseif index == 2 then
		return self:GetCfgText(1210007)
	elseif index == 3 then
		return self:GetCfgText(1210009)
	else
		return self:GetCfgText(1110001)
	end
end

function LoginUIApi:GetServerListInfo()
	return "获取服务器列表失败,请重启客户端！"
end

function LoginUIApi:GetSDKLoginFailInfo(code)
	if code == 2007 then
		return self:GetCfgText(1210021)
	else
		return self:GetCfgText(1210022)
	end
end

function LoginUIApi:GetUpBugBtnText()
	return self:GetCfgText(1210015)
end

function LoginUIApi:GetLogOutBtnText()
	return self:GetCfgText(1210016)
end

function LoginUIApi:GetTestTips()
	return ""
end

function LoginUIApi:GetCheckResourcesSuccessText()
	return self:GetCfgText(1210018)
end

function LoginUIApi:GetCheckResourcesFailText()
	return self:GetCfgText(1210019)
end

function LoginUIApi:GetServerMainTainTips()
	return self:GetCfgText(1210020)
end
