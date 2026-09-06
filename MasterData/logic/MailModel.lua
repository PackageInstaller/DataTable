-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/model/MailModel.lua

module("logic.extensions.social.model.MailModel", package.seeall)

local MailModel = class("MailModel", BaseModel)

function MailModel:ctor()
	MailModel.super.ctor(self)

	self._mailList = Array.New()
	self._newMailList = {}
	self.isDataInit = false
end

function MailModel:onInit()
	self._newMailList = {}
end

function MailModel:onGetUserMailsRes(mails)
	self.isDataInit = true
	self._newMailList = {}

	for _, v in ipairs(mails) do
		self._newMailList[v.mailId] = MailMo.New(v)
	end
end

function MailModel:onReadUserMails(mailIds)
	for _, v in ipairs(mailIds) do
		local mo = self._newMailList[v]

		if mo then
			mo.read = true
		end
	end
end

function MailModel:onDeleteMails(mailIds)
	for _, v in ipairs(mailIds) do
		self._newMailList[v] = nil
	end
end

function MailModel:onAddMails(mails)
	for _, mail in ipairs(mails) do
		self._newMailList[mail.mailId] = MailMo.New(mail)
	end
end

function MailModel:onReceiveMails(mailIds)
	for _, v in ipairs(mailIds) do
		self._newMailList[v].gained = true
		self._newMailList[v].read = true
	end
end

function MailModel:getAllMails()
	local t = {}

	for _, v in pairs(self._newMailList) do
		table.insert(t, v)
	end

	return t
end

function MailModel:getAllMailIds()
	return table.keys(self._newMailList)
end

function MailModel:getMailMoById(id)
	return self._newMailList[id]
end

function MailModel.sortMail(a, b)
	local flagA = a:getHasAttachment() and a:getIsNearInvalid()
	local flagB = b:getHasAttachment() and b:getIsNearInvalid()

	if flagA ~= flagB then
		return flagA
	elseif a.sendTime == b.sendTime then
		return a.mailId > b.mailId
	else
		return a.sendTime > b.sendTime
	end
end

MailModel.instance = MailModel.New()

return MailModel
