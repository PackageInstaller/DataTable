-- chunkname: @IQIGame\\UIExternalApi\\AccountTransferUIApi.lua

AccountTransferUIApi = BaseLangApi:Extend()

function AccountTransferUIApi:Init()
	self:RegisterApi("TextID", self.GetTextID)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextSendCD", self.GetTextSendCD)
	self:RegisterApi("UserProtocolUrl", self.GetUserProtocolUrl)
	self:RegisterApi("PrivacyPolicyUrl", self.GetPrivacyPolicyUrl)
	self:RegisterApi("UserProtocolTitle", self.GetUserProtocolTitle)
	self:RegisterApi("PrivacyPolicyTitle", self.GetPrivacyPolicyTitle)
	self:RegisterApi("TextTransferPhone", self.GetTextTransferPhone)
end

function AccountTransferUIApi:GetTextTransferPhone(phone)
	return string.format("*已绑定手机号：%s", phone)
end

function AccountTransferUIApi:GetUserProtocolTitle()
	return self:GetCfgText(1009037)
end

function AccountTransferUIApi:GetPrivacyPolicyTitle()
	return self:GetCfgText(1009038)
end

function AccountTransferUIApi:GetUserProtocolUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E6%B8%B8%E6%88%8F%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE.html"
end

function AccountTransferUIApi:GetPrivacyPolicyUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E4%BF%9D%E6%8A%A4%E6%94%BF%E7%AD%96.html"
end

function AccountTransferUIApi:GetTextSendCD(cd)
	return string.format("%s秒后可重发", cd)
end

function AccountTransferUIApi:GetTextLv(lv)
	return string.format("人偶师等级：%s", lv)
end

function AccountTransferUIApi:GetTextName(name)
	return string.format("人偶师昵称：%s", name)
end

function AccountTransferUIApi:GetTextID(id, name, lv)
	return string.format("人偶师ID：%s\n人偶师昵称：%s\n人偶师等级：%s", id, name, lv)
end

AccountTransferUIApi:Init()
