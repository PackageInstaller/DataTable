-- chunkname: @IQIGame\\UIExternalApi\\MailUIApi.lua

MailUIApi = BaseLangApi:Extend()

function MailUIApi:Init()
	self:RegisterApi("mailTitle", self.GetMailTile)
	self:RegisterApi("mailTime", self.GetMailTime)
	self:RegisterApi("mailTitle2", self.GetMailTile2)
	self:RegisterApi("createTime", self.GetCreateTime)
	self:RegisterApi("sender", self.GetSender)
	self:RegisterApi("content", self.GetContent)
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("goSendTimeTitle", self.GetSendTimeTitle)
	self:RegisterApi("goSenderTitle", self.GetSenderTitle)
	self:RegisterApi("TextMailSender", self.GetTextMailSender)
	self:RegisterApi("goBtnDeleteAll", self.GetBtnDeleteAllTxt)
	self:RegisterApi("goBtnGetAll", self.GetBtnGetAllTxt)
	self:RegisterApi("goBtnGet", self.GetBtnGetTxt)
	self:RegisterApi("goBtnDeleteOnce", self.GetBtnDeleteTxt)
	self:RegisterApi("ContentTitleText", self.GetContentTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("TotalNumText", self.GetTotalNumText)
	self:RegisterApi("UnreadNumText", self.GetUnreadNumText)
	self:RegisterApi("NullText", self.GetNullText)
	self:RegisterApi("ToggleStr", self.GetToggleStr)
end

function MailUIApi:GetToggleStr(index)
	if index == 1 then
		return self:GetCfgText(1216021)
	elseif index == 2 then
		return self:GetCfgText(1216022)
	end

	return ""
end

function MailUIApi:GetMailTile(title, isRead)
	if isRead then
		return self.TextColor[214] .. title .. self.TextColor[0]
	end

	return self.TextColor[12] .. title .. self.TextColor[0]
end

function MailUIApi:GetTextMailSender(sender, isRead)
	if isRead then
		return self.TextColor[213] .. self:GetCfgText(1216007) .. sender .. self.TextColor[0]
	end

	return self.TextColor[31] .. self:GetCfgText(1216007) .. sender .. self.TextColor[0]
end

function MailUIApi:GetMailTime(type, time, isRead)
	if type == 1 then
		if isRead then
			return self.TextColor[214] .. self:GetCfgText(1216001) .. self.TextColor[0]
		else
			return self.TextColor[213] .. self:GetCfgText(1216001) .. self.TextColor[0]
		end
	elseif type == 2 then
		if isRead then
			return self.TextColor[214] .. self:GetCfgText(1216002) .. time .. self.TextColor[0]
		else
			return self.TextColor[213] .. self:GetCfgText(1216002) .. time .. self.TextColor[0]
		end
	elseif type == 3 then
		if isRead then
			return self.TextColor[214] .. self:GetCfgText(1216003) .. self.TextColor[0]
		else
			return self.TextColor[213] .. self:GetCfgText(1216003) .. self.TextColor[0]
		end
	end

	return ""
end

function MailUIApi:GetNullText(index)
	if index == 1 then
		return self:GetCfgText(1216020)
	elseif index == 2 then
		return self:GetCfgText(1216020)
	end

	return ""
end

function MailUIApi:GetMailTile2(title)
	return title
end

function MailUIApi:GetCreateTime(time)
	return time
end

function MailUIApi:GetSender(sender)
	return sender
end

function MailUIApi:GetContent(content)
	return content
end

function MailUIApi:GetViewTitle()
	return self:GetCfgText(1216005)
end

function MailUIApi:GetSendTimeTitle()
	return self:GetCfgText(1216006)
end

function MailUIApi:GetSenderTitle()
	return self:GetCfgText(1216007)
end

function MailUIApi:GetContentTitleText()
	return self:GetCfgText(1216008)
end

function MailUIApi:GetTipText()
	return self.TextColor[31] .. self:GetCfgText(1216009) .. self.TextColor[0]
end

function MailUIApi:GetTotalNumText(num, maxNum)
	if num == maxNum then
		return self.TextColor[28] .. num .. self.TextColor[0] .. "/" .. maxNum
	else
		return num .. "/" .. maxNum
	end
end

function MailUIApi:GetUnreadNumText(num)
	if num > 0 then
		return self:GetCfgText(1216010) .. self.TextColor[35] .. num .. self.TextColor[0]
	else
		return self:GetCfgText(1216011) .. num
	end
end

function MailUIApi:GetBtnDeleteAllTxt()
	return self:GetCfgText(1216012)
end

function MailUIApi:GetBtnGetAllTxt()
	return self:GetCfgText(1216013)
end

function MailUIApi:GetBtnGetTxt()
	return self:GetCfgText(1216014)
end

function MailUIApi:GetBtnDeleteTxt()
	return self:GetCfgText(1216015)
end

MailUIApi:Init()
