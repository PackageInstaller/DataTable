-- chunkname: @IQIGame\\UIExternalApi\\MailUIApi.lua

MailUIApi = BaseLangApi:Extend()

function MailUIApi:GetToggleStr(index)
	if index == 1 then
		return self:GetCfgText(1300032)
	elseif index == 2 then
		return self:GetCfgText(1300033)
	end

	return ""
end

function MailUIApi:GetMailTile(title, isRead)
	if isRead then
		return title
	end

	return title
end

function MailUIApi:GetTextMailSender(sender, isRead)
	if isRead then
		return sender
	end

	return sender
end

function MailUIApi:GetMailTime(type, time, isRead)
	if time == nil then
		time = ""
	end

	if type == 1 then
		if isRead then
			return self:GetCfgText(1300034) .. time
		else
			return self:GetCfgText(1300034) .. time
		end
	elseif type == 2 then
		if isRead then
			return self:GetCfgText(1300035) .. time
		else
			return self:GetCfgText(1300035) .. time
		end
	elseif type == 3 then
		if isRead then
			return self:GetCfgText(1300036) .. time
		else
			return self:GetCfgText(1300036) .. time
		end
	end

	return ""
end

function MailUIApi:GetNullText(index)
	if index == 1 then
		return self:GetCfgText(1300037)
	elseif index == 2 then
		return self:GetCfgText(1300038)
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
	return self:GetCfgText(1300032)
end

function MailUIApi:GetSendTimeTitle()
	return self:GetCfgText(1300039)
end

function MailUIApi:GetSenderTitle()
	return self:GetCfgText(1300040)
end

function MailUIApi:GetContentTitleText()
	return self:GetCfgText(1300041)
end

function MailUIApi:GetTipText()
	return self:GetCfgText(1300042)
end

function MailUIApi:GetTotalNumText(num, maxNum)
	return num .. "/" .. maxNum
end

function MailUIApi:GetUnreadNumText(num)
	if num > 0 then
		return self:GetCfgText(1300043)
	else
		return self:GetCfgText(1300043)
	end
end

function MailUIApi:GetBtnDeleteAllTxt()
	return self:GetCfgText(1300044)
end

function MailUIApi:GetBtnGetAllTxt()
	return self:GetCfgText(1300045)
end

function MailUIApi:GetBtnGetTxt()
	return self:GetCfgText(1300046)
end

function MailUIApi:GetBtnDeleteTxt()
	return self:GetCfgText(1300047)
end

function MailUIApi:GetCheckMailTitle()
	return self:GetCfgText(1300048)
end

function MailUIApi:GetCheckMailSpcaeEnoughText()
	return self:GetCfgText(1300049)
end

function MailUIApi:GetCheckMailExpiringSoonText()
	return self:GetCfgText(1300050)
end
