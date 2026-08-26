-- chunkname: @modules/logic/mail/defines/MailEnum.lua

module("modules.logic.mail.defines.MailEnum", package.seeall)

local MailEnum = _M

MailEnum.SpecialTag = {
	MonthExpired = 1,
	ModifyName = 2
}
MailEnum.ReadStatus = {
	Read = 1,
	Unread = 0
}

return MailEnum
