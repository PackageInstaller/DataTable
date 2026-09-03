-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/controller/MailSystem.lua

EVT_GET_MAIL_LIST_SUCC = "EVT_GET_MAIL_LIST_SUCC"
EVT_READ_MAIL_SUCC = "EVT_READ_MAIL_SUCC"
EVT_UPDATA_VIEW = "EVT_MAILBOX_UPDATA_VIEW"
EVT_RECEIVE_MAIL_SUCC = "EVT_RECEIVE_MAIL_SUCC"
EVT_UPDATA_UNREAD_NUM = "EVT_UPDATA_UNREAD_NUM"
EVT_RECEIVE_MAIL_ONEKEY_SUCC = "EVT_RECEIVE_MAIL_ONEKEY_SUCC"
MailSystem = class("MailSystem", Facade, _M)

MailSystem:has("_mailService", {
	is = "r"
}):injectWith("MailService")
MailSystem:has("_mailModel", {
	is = "r"
}):injectWith("Mail")

function MailSystem:initialize()
	super.initialize(self)
end

function MailSystem:queryRedPointState()
	local unreadCnt = self:getMailUnreadCnt()

	return unreadCnt > 0
end

function MailSystem:requestGetMailList(blockUI, callback)
	self._mailService:requestGetMailList({}, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self._mailModel._mailsList = {}

			self._mailModel:synchronizeModel(response.data.mails, true)
			self:updateUnreadMailCnt()
			self:dispatch(Event:new(EVT_UPDATA_UNREAD_NUM))
		end

		if callback then
			callback(response)
		end
	end)
end

function MailSystem:requestReadMail(mailIds, blockUI, callback)
	local params = {}

	params.mailId = mailIds

	self._mailService:requestReadMail(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self._mailModel:synchronizeMailById(response.data.mails)
			self:updateUnreadMailCnt()
			self:dispatch(Event:new(EVT_UPDATA_UNREAD_NUM))
			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 1
			}))
		end

		if callback then
			callback(response)
		end
	end)
end

function MailSystem:requestReceiveMail(mailIds, blockUI, callback)
	local params = {}

	params.mailId = mailIds

	self._mailService:requestReceiveMail(params, {}, function(response)
		if response.resCode == GS_SUCCESS then
			self._mailModel:synchronizeMailById(response.data.mails)
			self:dispatch(Event:new(EVT_RECEIVE_MAIL_SUCC, {
				rewards = response.data.rewards
			}))
			self:updateUnreadMailCnt()
			self:dispatch(Event:new(EVT_UPDATA_UNREAD_NUM))
			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 1
			}))
		end

		if callback then
			callback(response)
		end
	end)
end

function MailSystem:requestReceiveMailOneKey(blockUI, callback)
	self._mailService:requestReceiveMailOneKey({}, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self._mailModel:synchronizeModel(response.data.mails)
			self:updateUnreadMailCnt()
			self:dispatch(Event:new(EVT_UPDATA_UNREAD_NUM))
			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 1
			}))

			if callback then
				callback(response)
			end
		end
	end)
end

function MailSystem:requestUnreadMailCnt(blockUI, callback)
	self._mailService:requestGetUnreadMailCnt({}, blockUI, function(response)
		if response.resCode == GS_SUCCESS and response.data then
			self._mailModel:setMailUnreadCnt(response.data.unRead)
		end

		if callback then
			callback(response)
		end
	end)
end

function MailSystem:updateUnreadMailCnt()
	if self._mailModel then
		local mailList = self._mailModel:getMails()
		local unreadCnt = 0
		local unreadCanOneKeyMailCnt = 0

		for key, mailmodel in pairs(mailList) do
			if mailmodel:getIsRead() == false then
				unreadCnt = unreadCnt + 1

				if mailmodel:getQuickGet() == 1 then
					unreadCanOneKeyMailCnt = unreadCanOneKeyMailCnt + 1
				end
			end
		end

		self._mailModel:setMailUnreadCnt(unreadCnt)
		self._mailModel:setOneKeyMailUnreadCnt(unreadCanOneKeyMailCnt)
	end
end

function MailSystem:getClickMailId()
	local mailList = self._mailModel:getMails()
	local curClickId = self._mailModel:getClickMailId()

	for k, v in pairs(mailList) do
		if v:getId() == curClickId then
			return k
		end
	end

	return 1
end

function MailSystem:hasQuickReceiveMails()
	local mailList = self._mailModel:getMails()

	for k, v in pairs(mailList) do
		if v:getReceiveMailItems() == false and v:getQuickGet() == 1 then
			return true
		end
	end

	return false
end

function MailSystem:getMailsNumber()
	return self:getMailModel():getMailsNumber()
end

function MailSystem:getMailByIndex(index)
	return self:getMailModel():getMailByIndex(index)
end

function MailSystem:getReceiveExpireMail()
	return self:getMailModel():getReceiveExpireMail()
end

function MailSystem:getMailUnreadCnt()
	return self:getMailModel():getMailUnreadCnt()
end

function MailSystem:setReceiveExpireMail(isExpireMail)
	self:getMailModel():setReceiveExpireMail(isExpireMail)
end

function MailSystem:getMails()
	self:getMailModel():getMails()
end

function MailSystem:resetMailsIds()
	self:getMailModel():resetMailsIds()
end

function MailSystem:isNeedUpdateVersion(mailData)
	if not mailData then
		return false
	end

	if mailData:getMailType() == MailType.kVersion then
		local baseVersion = app.pkgConfig.packJobId
		local mailVersion = mailData:getVersion()

		if baseVersion and mailVersion[device.platform] and baseVersion < mailVersion[device.platform] then
			return true
		end
	end

	return false
end
