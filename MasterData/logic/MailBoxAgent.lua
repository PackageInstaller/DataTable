-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/agent/MailBoxAgent.lua

module("logic.extensions.mailbox.agent.MailBoxAgent", package.seeall)

local MailBoxAgent = class("MailBoxAgent", BaseAgent)

function MailBoxAgent:sendGetUserMailsReq()
	local req = MailBoxExtension_pb.GetUserMailsReq()

	self:sendMsg(req)
end

function MailBoxAgent:handleGetUserMailsRes(status, msg)
	printInfo("status = " .. status)

	if status == 0 then
		MailModel.instance:onGetUserMailsRes(msg.userMails)
		MailController.instance:localNotify("getMailDatas")
	end
end

function MailBoxAgent:sendReadUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.ReadUserMailsReq()

	for _, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function MailBoxAgent:handleReadUserMailsRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MailBoxAgent:sendGainUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.GainUserMailsReq()

	for _, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function MailBoxAgent:handleGainUserMailsRes(status, msg)
	if status == 0 then
		MailModel.instance:onReceiveMails(msg.gainedIds)
		MailController.instance:localNotify("receivePartMails", msg.changeSetId, msg.overflowMp)
	end
end

function MailBoxAgent:sendDeleteUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.DeleteUserMailsReq()

	for _, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function MailBoxAgent:handleDeleteUserMailsRes(status, msg)
	if status == 0 then
		local deleteids = msg.deleteIds

		MailModel.instance:onDeleteMails(deleteids)
		MailController.instance:localNotify("deleteMails", deleteids)
	end
end

function MailBoxAgent:handleNotifyNewMailsRes(status, msg)
	if status == 0 then
		local mails = msg.mails
		local deletedids = msg.deletedIds

		MailModel.instance:onAddMails(mails)
		MailModel.instance:onDeleteMails(deletedids)
	end
end

function MailBoxAgent:handleNotifyWillOutDateMailRes(status, msg)
	if status == 0 then
		MailController.instance:notifyOutDateTips()
	end
end

MailBoxAgent.instance = MailBoxAgent.New()

return MailBoxAgent
