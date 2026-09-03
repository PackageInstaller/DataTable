-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/model/Mail.lua

require("dm.gameplay.mail.model.MailItem")

Mail = class("Mail", objectlua.Object, _M)

Mail:has("_receiveExpireMail", {
	is = "rw"
})
Mail:has("_mailUnreadCnt", {
	is = "rw"
})
Mail:has("_oneKeyMailUnreadCnt", {
	is = "rw"
})

function Mail:initialize()
	super.initialize(self)

	self._mailsList = {}
	self._mailsIds = {}
	self._expireMail = false
	self._mailUnreadCnt = 0
	self._oneKeyMailUnreadCnt = 0
	self._curClickMailId = 0
end

function Mail:sortMails(a, b)
	if a._mailConfigId == "Mail_First_LogOn" and not a:isReceive() then
		return true
	elseif b._mailConfigId == "Mail_First_LogOn" and not b:isReceive() then
		return false
	end

	if a:getIsRead() ~= b:getIsRead() then
		return a:getIsRead() == false
	elseif a:isReceive() ~= b:isReceive() then
		return not a:isReceive()
	elseif a:getTopStatus() ~= b:getTopStatus() then
		return a:getTopStatus() > b:getTopStatus()
	else
		return a:getSendDate() > b:getSendDate()
	end
end

function Mail:sortMailsSimple(a, b)
	return a:getSendDate() < b:getSendDate()
end

function Mail:synchronizeModel(data, isOpen)
	if #self._mailsList == 0 then
		for id, _ in pairs(data) do
			if data[id].mailType and data[id].mailType == MailType.kVersion then
				if data[id].version and data[id].version[device.platform] ~= 0 then
					local mailBoxModel = MailItem:new()

					mailBoxModel:synchronizeModel(data[id])

					self._mailsList[#self._mailsList + 1] = mailBoxModel
				end
			else
				local mailBoxModel = MailItem:new()

				mailBoxModel:synchronizeModel(data[id])

				self._mailsList[#self._mailsList + 1] = mailBoxModel
			end
		end

		table.sort(self._mailsList, function(a, b)
			if isOpen == true then
				return self:sortMails(a, b)
			else
				return self:sortMailsSimple(a, b)
			end
		end)
	else
		for id, _ in pairs(data) do
			local mailBoxModel = MailItem:new()

			mailBoxModel:synchronizeModel(data[id])

			local v, k = self:getMailsById(id)

			if k == -1 then
				self._mailsList[#self._mailsList + 1] = mailBoxModel
			else
				self._mailsList[k] = mailBoxModel
			end
		end
	end
end

function Mail:getMails()
	return self._mailsList
end

function Mail:getMailsNumber()
	return #self._mailsList
end

function Mail:getMailByIndex(index)
	return self._mailsList[index]
end

function Mail:getMailsById(id)
	for k, v in ipairs(self._mailsList) do
		if v._id == id then
			return v, k
		end
	end

	return nil, -1
end

function Mail:resetMailsIds()
	self._mailsIds = {}

	for k, v in ipairs(self._mailsList) do
		self._mailsIds[k] = v._id
	end
end

function Mail:synchronizeMailById(data)
	local mail = self:getMailsById(data.id)

	mail:synchronizeModel(data)
end
