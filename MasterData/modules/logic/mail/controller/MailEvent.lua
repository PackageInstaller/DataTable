-- chunkname: @modules/logic/mail/controller/MailEvent.lua

module("modules.logic.mail.controller.MailEvent", package.seeall)

local MailEvent = _M

MailEvent.OnMailCountChange = 1
MailEvent.UpdateSelectMail = 2
MailEvent.OnMailRead = 3
MailEvent.OnMailDel = 4
MailEvent.OnMailLockReply = 1001

return MailEvent
