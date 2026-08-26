-- chunkname: @modules/logic/mail/rpc/MailRpc.lua

module("modules.logic.mail.rpc.MailRpc", package.seeall)

local MailRpc = class("MailRpc", BaseRpc)

function MailRpc:sendGetAllMailsRequest(callback, callbackObj)
	local req = MailModule_pb.GetAllMailsRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function MailRpc:onReceiveGetAllMailsReply(resultCode, msg)
	if resultCode == 0 then
		local co = {}

		for _, v in ipairs(msg.mails) do
			table.insert(co, v)
		end

		MailModel.instance:onGetMailItemList(co, true)
		MailController.instance:initInfo()
	end
end

function MailRpc:sendReadMailRequest(id)
	local req = MailModule_pb.ReadMailRequest()

	req.incrId = id

	self:sendMsg(req)
end

function MailRpc:onReceiveReadMailReply(resultCode, msg)
	if resultCode == 0 then
		local incrId = tonumber(msg.incrId)

		MailModel.instance:readMail(incrId)
	end
end

function MailRpc:sendReadMailBatchRequest(mailType)
	local req = MailModule_pb.ReadMailBatchRequest()

	req.type = mailType

	self:sendMsg(req)
end

function MailRpc:onReceiveReadMailBatchReply(resultCode, msg)
	if resultCode == 0 then
		local co = {}

		for _, v in ipairs(msg.incrIds) do
			table.insert(co, tonumber(v))
		end

		MailModel.instance:readAllMail(co)
	end
end

function MailRpc:onReceiveNewMailPush(resultCode, msg)
	if resultCode == 0 then
		local co = {
			msg.mail
		}

		MailModel.instance:addMailModel(co)
	end
end

function MailRpc:onReceiveDeleteMailsPush(resultCode, msg)
	if resultCode == 0 then
		local co = {}

		for _, v in ipairs(msg.incrIds) do
			table.insert(co, tonumber(v))
		end

		MailModel.instance:delMail(co)
	end
end

function MailRpc:sendDeleteMailBatchRequest(mailType)
	local req = MailModule_pb.DeleteMailBatchRequest()

	req.type = mailType

	self:sendMsg(req)
end

function MailRpc:onReceiveDeleteMailBatchReply(resultCode, msg)
	if resultCode == 0 then
		local co = {}

		for _, v in ipairs(msg.incrIds) do
			table.insert(co, tonumber(v))
		end

		MailModel.instance:delMail(co)
	end
end

function MailRpc:sendMarkMailJumpRequest(incrId)
	local req = MailModule_pb.MarkMailJumpRequest()

	req.incrId = incrId

	self:sendMsg(req)
end

function MailRpc:onReceiveMarkMailJumpReply(resultCode, msg)
	return
end

function MailRpc:onReceiveAutoReadMailPush(resultCode, msg)
	if resultCode == 0 then
		for _, incrId in ipairs(msg.incrIds) do
			MailModel.instance:readMail(tonumber(incrId))
		end
	end
end

function MailRpc:sendMailLockRequest(incrId, isLock)
	local req = MailModule_pb.MailLockRequest()

	req.incrId = incrId
	req.lock = isLock

	self:sendMsg(req)
end

function MailRpc:onReceiveMailLockReply(resultCode, msg)
	MailController.instance:onReceiveMailLockReply(resultCode, msg)
end

MailRpc.instance = MailRpc.New()

return MailRpc
