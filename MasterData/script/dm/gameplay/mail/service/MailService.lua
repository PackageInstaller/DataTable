-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/service/MailService.lua

MailService = class("MailService", Service, _M)

local opType = {}

opType.getMailList = 10301
opType.readMail = 10302
opType.receiveMail = 10303
opType.receiveMailOneKey = 10304
opType.getUnreadMailCnt = 10305

function MailService:initialize()
	super.initialize(self)
end

function MailService:dispose()
	super.dispose(self)
end

function MailService:requestGetMailList(params, blockUI, callback)
	local params = {}
	local request = self:newRequest(opType.getMailList, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function MailService:requestReadMail(params, blockUI, callback)
	local request = self:newRequest(opType.readMail, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function MailService:requestReceiveMail(params, blockUI, callback)
	local request = self:newRequest(opType.receiveMail, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function MailService:requestReceiveMailOneKey(params, blockUI, callback)
	local params = {}
	local request = self:newRequest(opType.receiveMailOneKey, params, function(response)
		dump(response, "receiveMailOneKey")

		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function MailService:requestGetUnreadMailCnt(params, blockUI, callback)
	local request = self:newRequest(opType.getUnreadMailCnt, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end
