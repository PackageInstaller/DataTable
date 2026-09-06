-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/agent/SocialAgent.lua

module("logic.extensions.social.agent.SocialAgent", package.seeall)

local SocialAgent = class("SocialAgent", BaseAgent)

function SocialAgent:GetUserMailsReq()
	local req = MailBoxExtension_pb.GetUserMailsReq()

	self:sendMsg(req)
end

function SocialAgent:handleGetUserMailsRes(status, msg)
	if status == 0 then
		MailModel.instance:initUserMails(msg.userMails)
		GlobalDispatcher:dispatch(GlobalNotify.MailRefresh)
	end
end

function SocialAgent:ReadUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.ReadUserMailsReq()

	for i, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function SocialAgent:handleReadUserMailsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MailReOpen, msg.readIds)
	end
end

function SocialAgent:GainUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.GainUserMailsReq()

	for i, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function SocialAgent:handleGainUserMailsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MailGain, msg.gainedIds)
	end
end

function SocialAgent:DeleteUserMailsReq(mailIds)
	local req = MailBoxExtension_pb.DeleteUserMailsReq()

	for i, v in ipairs(mailIds) do
		table.insert(req.mailIds, v)
	end

	self:sendMsg(req)
end

function SocialAgent:handleDeleteUserMailsRes(status, msg)
	if status == 0 then
		MailModel.instance:refreshMailDelete(msg.deleteIds)
		GlobalDispatcher:dispatch(GlobalNotify.MailDelete, msg.deleteIds)
	end
end

function SocialAgent:handleNotifyNewMailsRes(status, msg)
	if status == 0 then
		MailModel.instance:AddUserMails(msg.mail)
		GlobalDispatcher:dispatch(GlobalNotify.MailNew)
		MailModel.instance:refreshMailDelete(msg.deletedIds)
		GlobalDispatcher:dispatch(GlobalNotify.MailDelete, msg.deletedIds)
	end
end

SocialAgent.instance = SocialAgent.New()

return SocialAgent
