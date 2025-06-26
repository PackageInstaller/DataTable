-- chunkname: @IQIGame\\Net\\NetMailResponse.lua

function net_mail.getMailsResult(code, mailType, mails)
	if mailType == 1 then
		MailModule.GetAllMailsResult(mails)
	else
		MailModule.GetMailsByTypeResult(mails)
	end
end

function net_mail.readMailResult(code, mailId)
	MailModule.ReadMailResult(mailId)
end

function net_mail.pickUpResult(code, mails, getItems)
	MailModule.PickUpResult(mails, getItems)
end

function net_mail.delMailResult(code, mails)
	MailModule.DelMailResult(mails)
end

function net_mail.notifyNewMail(newMailCount)
	MailModule.NotifyNewMail(newMailCount)
end
