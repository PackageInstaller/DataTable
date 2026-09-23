MailProto = {}

----------------------------------邮件--------------------------------------

function MailProto:QueryMail()
	local proto = {"MailProto:QueryMail"}
	NetMgr.net:Send(proto)
end  

function MailProto:QueryMailRet()

end  


function MailProto:GetMailsDataRet(proto)
	MailMgr:GetMailsDataRet(proto)
end

function MailProto:MailsOperateRet(proto)
	MailMgr:MailsOperateRet(proto)
end

function MailProto:MailAddNotice(proto)
	MailMgr:MailAddNotice(proto)
end  


