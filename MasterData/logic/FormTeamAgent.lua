-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/agent/FormTeamAgent.lua

module("logic.extensions.formteam.agent.FormTeamAgent", package.seeall)

local FormTeamAgent = class("FormTeamAgent", BaseAgent)

function FormTeamAgent:sendPM_FT_QueryTeamsReq(groupId, typeId)
	local req = FormTeamExtension_pb.PM_FT_QueryTeamsReq()

	if groupId then
		req.groupId = groupId
	end

	if typeId then
		req.typeId = typeId
	end

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_QueryTeamsRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_JoinTeamReq(teamId, groupId, teamCode)
	local req = FormTeamExtension_pb.PM_FT_JoinTeamReq()

	req.teamId = teamId
	req.groupId = groupId
	req.teamCode = teamCode and teamCode or ""

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_JoinTeamRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_QuickJoinReq(quickJoinParam)
	local req = FormTeamExtension_pb.PM_FT_QuickJoinReq()

	if quickJoinParam then
		req.quickJoinParam:ParseFromString(quickJoinParam:SerializeToString())
	end

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_QuickJoinRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_CreateTeamReq(groupId, zdl, onlyInvite)
	local req = FormTeamExtension_pb.PM_FT_CreateTeamReq()

	req.groupId = groupId
	req.zdl = zdl
	req.onlyInvite = onlyInvite

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_CreateTeamRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_GetOnlineFamilyMembersReq()
	local req = FormTeamExtension_pb.PM_GetOnlineFamilyMembersReq()

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_GetOnlineFamilyMembersRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleGetOnlineFailyList(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_LeaveTeamReq()
	local req = FormTeamExtension_pb.PM_FT_LeaveTeamReq()

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_LeaveTeamRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleLeaveCurTeam(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_ReadyReq()
	local req = FormTeamExtension_pb.PM_FT_ReadyReq()

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_ReadyRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_KickReq(beKickUserId)
	local req = FormTeamExtension_pb.PM_FT_KickReq()

	req.beKickUserId = beKickUserId

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_KickRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_ChatReq(chatId)
	local req = FormTeamExtension_pb.PM_FT_ChatReq()

	req.chatId = chatId

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_ChatRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_JoinWithReq(teamId, teamCode)
	local req = FormTeamExtension_pb.PM_FT_JoinWithReq()

	req.teamId = teamId
	req.teamCode = teamCode

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_JoinWithRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_InviteReq(groupId, playerId, teamId, teamCode)
	local req = FormTeamExtension_pb.PM_FT_InviteReq()

	req.groupId = groupId
	req.playerId = playerId
	req.teamId = teamId
	req.teamCode = teamCode

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_InviteRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_LoadTabInfoReq()
	local req = FormTeamExtension_pb.PM_FT_LoadTabInfoReq()

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_LoadTabInfoRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleGetUnlockTabList(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyQuickJoinRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyQuickJoin(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyJoinTeamRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyJoinTeam(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyCreateTeamRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyCreateTeam(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyTeamChangeRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyTeamChange(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyInviteApplyRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyInviteApply(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyReadyRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyTeammateReady(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyStartRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyStart(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyBeKickRes(status, msg)
	FormTeamController.instance:handleNotifyBeKick(status, msg)
end

function FormTeamAgent:handlePM_FT_NotifyQueryTeamsRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyQueryTeams(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyChatRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleNotifyChat(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:handlePM_FT_NotifyReformInRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleGetReformTime(msg)
	end
end

function FormTeamAgent:sendPM_FT_ReformInReq(teamId)
	local req = FormTeamExtension_pb.PM_FT_ReformInReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_ReformInRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamError, status)
	end
end

function FormTeamAgent:sendPM_FT_QueryBuddiesZdlReq(buddies)
	local req = FormTeamExtension_pb.PM_FT_QueryBuddiesZdlReq()

	if buddies then
		for i, id in ipairs(buddies) do
			req.buddies:append(id)
		end
	end

	self:sendMsg(req)
end

function FormTeamAgent:handlePM_FT_QueryBuddiesZdlRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleGetBuddiesZdl(msg)
	end
end

FormTeamAgent.instance = FormTeamAgent.New()

return FormTeamAgent
