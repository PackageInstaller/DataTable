-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/agent/MailAgent.lua

module("logic.extensions.mail.agent.MailAgent", package.seeall)

local MailAgent = class("MailAgent", BaseAgent)

function MailAgent:ctor()
	MailAgent.super.ctor(self)
end

function MailAgent:sendGetMailInfoRequest()
	local req = MailExtension_pb.GetMailInfoRequest()

	self:sendMsg(req)
end

function MailAgent:handleGetMailInfoReply(status, mails)
	if status == 0 then
		MailMoList.instance:initCurMailByAgent(mails)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_CUR_MAIL)
	end
end

function MailAgent:sendMarkMailReadRequest(id)
	local req = MailExtension_pb.MarkMailReadRequest()

	req.id = id

	self:sendMsg(req)
end

function MailAgent:handleMarkMailReadReply(status)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.UPDAET_READ_MAIL)
	end
end

function MailAgent:sendTakeMailAttachmentRequest(id)
	local req = MailExtension_pb.TakeMailAttachmentRequest()

	req.id = id

	self:sendMsg(req)
end

function MailAgent:handleTakeMailAttachmentReply(status, msg)
	if status == 0 then
		local len = #msg.fullBackpacks

		if len > 0 then
			self:_parseFullPackError(msg.fullBackpacks)

			return
		end

		GlobalDispatcher:dispatchEvent(EventType.TAKE_MAIL_ATTACHMENT)
	end
end

function MailAgent:sendTakeAllMailAttachmentRequest()
	local req = MailExtension_pb.TakeAllMailAttachmentRequest()

	self:sendMsg(req)
end

function MailAgent:handleTakeAllMailAttachmentReply(status, msg)
	if status == 0 then
		local len = #msg.fullBackpacks

		if len > 0 then
			self:_parseFullPackError(msg.fullBackpacks)

			return
		end

		MailMoList.instance:takeAllMailAttachment(msg.ids)
		GlobalDispatcher:dispatchEvent(EventType.TAKE_ALL_MAIL_ATTACHMENT)
	end
end

function MailAgent:_parseFullPackError(fullBackpacks)
	local errorTips = lang("tip_warehouse_full")
	local packageNames = ""

	for i = 1, #fullBackpacks do
		if fullBackpacks[i] == GameEnum.ItemTypeEnum.EquipItemType then
			if string.nilorempty(packageNames) then
				packageNames = packageNames .. lang("tip_equip")
			else
				packageNames = packageNames .. "、" .. lang("tip_equip")
			end
		elseif fullBackpacks[i] == GameEnum.ItemTypeEnum.EchoItemType then
			if string.nilorempty(packageNames) then
				packageNames = packageNames .. lang("t_echo")
			else
				packageNames = packageNames .. "、" .. lang("t_echo")
			end
		elseif (fullBackpacks[i] == GameEnum.ItemTypeEnum.HouseItemType or fullBackpacks[i] == GameEnum.ItemTypeEnum.FurnitureItemType) and string.find(packageNames, lang("tip_house")) == nil then
			if string.nilorempty(packageNames) then
				packageNames = packageNames .. lang("tip_house")
			else
				packageNames = packageNames .. "、" .. lang("tip_house")
			end
		end
	end

	errorTips = string.format(errorTips, packageNames)

	local dialog = Dialog.showNotifyMessage(lang("tip_title"), errorTips)

	dialog:setConfirmButtonText(lang("tip_common_sure"))
end

function MailAgent:sendRemoveAllReadMailRequest()
	local req = MailExtension_pb.RemoveAllReadMailRequest()

	self:sendMsg(req)
end

function MailAgent:handleRemoveAllReadMailReply(status, msg)
	if status == 0 then
		MailMoList.instance:removeAllReadMail(msg.ids)
		GlobalDispatcher:dispatchEvent(EventType.REMOVE_ALL_READ_MAIL)
	end
end

function MailAgent:sendUnlockSecretMailRequest(id)
	local req = MailExtension_pb.UnlockSecretMailRequest()

	req.id = id

	self:sendMsg(req)
end

function MailAgent:handleUnlockSecretMailReply(status)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.UNLOCK_SECRET_MAIL)
	end
end

function MailAgent:sendGetHistoryMailInfoRequest()
	local req = MailExtension_pb.GetHistoryMailInfoRequest()

	self:sendMsg(req)
end

function MailAgent:handleGetHistoryMailInfoReply(status, mails)
	if status == 0 then
		MailMoList.instance:initHistoryMailByAgent(mails)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_HISTORY_MAIL)
	end
end

function MailAgent:handleNotifyNewMailPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ON_NOTIFY_NEW_MAIL_PUSH, msg.ids or {})
	end
end

MailAgent.instance = MailAgent.New()

return MailAgent
