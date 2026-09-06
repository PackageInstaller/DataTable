-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/agent/TrainCampQieCuoAgent.lua

module("logic.extensions.traincampqiecuo.agent.TrainCampQieCuoAgent", package.seeall)

local TrainCampQieCuoAgent = class("TrainCampQieCuoAgent", BaseAgent)

TrainCampQieCuoAgent.TC_QueryTeamsRes = "TrainCampQieCuoAgent.TC_QueryTeamsRes"
TrainCampQieCuoAgent.TC_JoinTeamRes = "TrainCampQieCuoAgent.TC_JoinTeamRes"
TrainCampQieCuoAgent.TC_QuickJoinRes = "TrainCampQieCuoAgent.TC_QuickJoinRes"
TrainCampQieCuoAgent.TC_CreateTeamRes = "TrainCampQieCuoAgent.TC_CreateTeamRes"
TrainCampQieCuoAgent.TC_LeaveTeamRes = "TrainCampQieCuoAgent.TC_LeaveTeamRes"
TrainCampQieCuoAgent.TC_ReadyRes = "TrainCampQieCuoAgent.TC_ReadyRes"
TrainCampQieCuoAgent.TC_KickRes = "TrainCampQieCuoAgent.TC_KickRes"
TrainCampQieCuoAgent.TC_ChatRes = "TrainCampQieCuoAgent.TC_ChatRes"
TrainCampQieCuoAgent.TC_SetDefenseFormRes = "TrainCampQieCuoAgent.TC_SetDefenseFormRes"
TrainCampQieCuoAgent.TC_ReadyFightRes = "TrainCampQieCuoAgent.TC_ReadyFightRes"
TrainCampQieCuoAgent.TC_LeaveGameRes = "TrainCampQieCuoAgent.TC_LeaveGameRes"
TrainCampQieCuoAgent.TC_NotifyTeamChangeRes = "TrainCampQieCuoAgent.TC_NotifyTeamChangeRes"
TrainCampQieCuoAgent.TC_NotifyQueryTeamsRes = "TrainCampQieCuoAgent.TC_NotifyQueryTeamsRes"
TrainCampQieCuoAgent.TC_NotifyJoinTeamRes = "TrainCampQieCuoAgent.TC_NotifyJoinTeamRes"
TrainCampQieCuoAgent.TC_CancelFightRes = "TrainCampQieCuoAgent.TC_CancelFightRes"
TrainCampQieCuoAgent.TC_RefuseInviteRes = "TrainCampQieCuoAgent.TC_RefuseInviteRes"
TrainCampQieCuoAgent.TC_GetBattleRecordRes = "TrainCampQieCuoAgent.TC_GetBattleRecordRes"
TrainCampQieCuoAgent.TC_GetBattleVideoRes = "TrainCampQieCuoAgent.TC_GetBattleVideoRes"
TrainCampQieCuoAgent.TC_GetShareBattleResultRes = "TrainCampQieCuoAgent.TC_GetShareBattleResultRes"
TrainCampQieCuoAgent.TC_FightSwitchInfoRes = "TrainCampQieCuoAgent.TC_FightSwitchInfoRes"
TrainCampQieCuoAgent.TC_SetSwitchRes = "TrainCampQieCuoAgent.TC_SetSwitchRes"
TrainCampQieCuoAgent.TC_PveRes = "TrainCampQieCuoAgent.TC_PveRes"
TrainCampQieCuoAgent.TC_NotifyPveRes = "TrainCampQieCuoAgent.TC_NotifyPveRes"
TrainCampQieCuoAgent.TC_NotifyQuickJoinRes = "TrainCampQieCuoAgent.TC_NotifyQuickJoinRes"
TrainCampQieCuoAgent.TC_NotifyCreateTeamRes = "TrainCampQieCuoAgent.TC_NotifyCreateTeamRes"
TrainCampQieCuoAgent.TC_NotifyBeKickRes = "TrainCampQieCuoAgent.TC_NotifyBeKickRes"
TrainCampQieCuoAgent.TC_NotifyReadyRes = "TrainCampQieCuoAgent.TC_NotifyReadyRes"
TrainCampQieCuoAgent.TC_NotifyChatRes = "TrainCampQieCuoAgent.TC_NotifyChatRes"
TrainCampQieCuoAgent.TC_NotifyTeamSucRes = "TrainCampQieCuoAgent.TC_NotifyTeamSucRes"
TrainCampQieCuoAgent.TC_NotifyStartRes = "TrainCampQieCuoAgent.TC_NotifyStartRes"
TrainCampQieCuoAgent.TC_NotifyOpDefenseReadyRes = "TrainCampQieCuoAgent.TC_NotifyOpDefenseReadyRes"
TrainCampQieCuoAgent.TC_NotifyChangeToAttackRes = "TrainCampQieCuoAgent.TC_NotifyChangeToAttackRes"
TrainCampQieCuoAgent.TC_NotifyOpReadyFightRes = "TrainCampQieCuoAgent.TC_NotifyOpReadyFightRes"
TrainCampQieCuoAgent.TC_NotifyGameResultRes = "TrainCampQieCuoAgent.TC_NotifyGameResultRes"
TrainCampQieCuoAgent.TC_NotifyBeInviteRes = "TrainCampQieCuoAgent.TC_NotifyBeInviteRes"
TrainCampQieCuoAgent.TC_NotifyRefuseInviteRes = "TrainCampQieCuoAgent.TC_NotifyRefuseInviteRes"
TrainCampQieCuoAgent.TC_NotifyCancelReadyRes = "TrainCampQieCuoAgent.TC_NotifyCancelReadyRes"
TrainCampQieCuoAgent.TC_NotifyReadyFailRes = "TrainCampQieCuoAgent.TC_NotifyReadyFailRes"
TrainCampQieCuoAgent.TC_ReformInRes = "TrainCampQieCuoAgent.TC_ReformInRes"
TrainCampQieCuoAgent.TC_NotifyBack2ReformRes = "TrainCampQieCuoAgent.TC_NotifyBack2ReformRes"

function TrainCampQieCuoAgent:sendPM_TC_QueryTeamsReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_QueryTeamsReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_QueryTeamsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_QueryTeamsRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_JoinTeamReq(teamId, teamCode)
	local req = TrainCampQieCuoExtension_pb.PM_TC_JoinTeamReq()

	req.teamId = teamId
	req.teamCode = teamCode

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_JoinTeamRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_JoinTeamRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_QuickJoinReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_QuickJoinReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_QuickJoinRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_QuickJoinRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_CreateTeamReq(teamNameId, onlyInvite, fullPublicStrengthens, invitedPlayerId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_CreateTeamReq()

	req.teamNameId = teamNameId
	req.onlyInvite = onlyInvite
	req.fullPublicStrengthens = fullPublicStrengthens

	if invitedPlayerId then
		req.invitedPlayerId = invitedPlayerId
	end

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_CreateTeamRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_CreateTeamRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_LeaveTeamReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_LeaveTeamReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_LeaveTeamRes(status, msg)
	if status == 0 then
		TraincampqiecuoModel.instance:setIsInPk(false)
		TraincampqiecuoModel.instance:clearReadyPlayerIds()
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_LeaveTeamRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_ReadyReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_ReadyReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_ReadyRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_ReadyRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_CancelReadyReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_CancelReadyReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_CancelReadyRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_CancelReadyRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_KickReq(beKickUserId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_KickReq()

	req.beKickUserId = beKickUserId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_KickRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_KickRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_ChatReq(chatId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_ChatReq()

	req.chatId = chatId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_ChatRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_ChatRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_SetDefenseFormReq(form)
	local req = TrainCampQieCuoExtension_pb.PM_TC_SetDefenseFormReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_SetDefenseFormRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_SetDefenseFormRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_ReadyFightReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_ReadyFightReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_ReadyFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_ReadyFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_LeaveGameReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_LeaveGameReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_LeaveGameRes(status, msg)
	if status == 0 then
		TraincampqiecuoModel.instance:setIsInPk(false)
		TraincampqiecuoModel.instance:clearReadyPlayerIds()
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_LeaveGameRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyTeamChangeRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:notifyTeamChange(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyTeamChangeRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyQueryTeamsRes(status, msg)
	if status == 0 then
		local teamviews = msg.teamViews

		TraincampqiecuoModel.instance:setTeamViews(teamviews)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyQueryTeamsRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyJoinTeamRes(status, msg)
	if status == 0 then
		TraincampqiecuoModel.instance:setIsInPk(true)
		TraincampqiecuoController.instance:notifyJoinTeamRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyJoinTeamRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_CancelFightReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_CancelFightReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_CancelFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_CancelFightRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_RefuseInviteReq(teamId, invitorId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_RefuseInviteReq()

	req.teamId = teamId
	req.invitorId = invitorId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_RefuseInviteRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_RefuseInviteRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_GetBattleRecordReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_GetBattleRecordReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_GetBattleRecordRes(status, msg)
	if status == 0 then
		local battlerecords = msg.battleRecords

		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_GetBattleRecordRes, battlerecords)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_GetBattleVideoReq(myAttackBattleId, opAttackBattleId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_GetBattleVideoReq()

	req.myAttackBattleId = myAttackBattleId
	req.opAttackBattleId = opAttackBattleId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_GetBattleVideoRes(status, msg)
	if status == 0 then
		if TraincampqiecuoController.instance.formShareBattleResult then
			TraincampqiecuoController.instance:getBattleVideoRes(msg)
		end

		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_GetBattleVideoRes, msg)
	else
		TraincampqiecuoController.instance.formShareBattleResult = false
	end
end

function TrainCampQieCuoAgent:sendPM_TC_GetShareBattleResultReq(recordOwnerId, recordId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_GetShareBattleResultReq()

	req.recordOwnerId = recordOwnerId
	req.recordId = recordId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_GetShareBattleResultRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:getShareBattleResultRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_GetShareBattleResultRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_FightSwitchInfoReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_FightSwitchInfoReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_FightSwitchInfoRes(status, msg)
	if status == 0 then
		local all = msg.all
		local stranger = msg.stranger

		TraincampqiecuoModel.instance:setPkSwitch(all, stranger)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_FightSwitchInfoRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_SetSwitchReq(all, stranger)
	local req = TrainCampQieCuoExtension_pb.PM_TC_SetSwitchReq()

	req.all = all
	req.stranger = stranger

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_SetSwitchRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:SetSwitchRes()
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_SetSwitchRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_PveReq(singlePetZdl, myForm, opForm, teamNameId)
	local req = TrainCampQieCuoExtension_pb.PM_TC_PveReq()

	req.singlePetZdl = singlePetZdl

	req.myForm:ParseFromString(myForm:SerializeToString())
	req.opForm:ParseFromString(opForm:SerializeToString())

	req.teamNameId = teamNameId

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_PveRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_PveRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyPveRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyPveRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyQuickJoinRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyQuickJoinRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyCreateTeamRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("创建房间成功")
		UIStateManager.instance:popByName(ViewName.PkroomView)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyCreateTeamRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyBeKickRes(status, msg)
	TraincampqiecuoModel.instance:clearReadyPlayerIds()
	GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyBeKickRes)
	TraincampqiecuoModel.instance:setIsInPk(false)
	UIJumper.instance:removeTopState(ViewName.PkroomView)
	UIStateManager.instance:popByName(ViewName.PkroomView)

	if status == 0 then
		FloatWordMgr.instance:show("队伍解散了")
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyReadyRes(status, msg)
	if status == 0 then
		local playerid = msg.playerId

		TraincampqiecuoModel.instance:setReadyPlayerId(playerid)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyReadyRes, playerid)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyChatRes(status, msg)
	if status == 0 then
		local chatplayerid = msg.chatPlayerId
		local chatid = msg.chatId

		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyChatRes, chatplayerid, chatid)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyTeamSucRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyTeamSucRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyStartRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:notifyStartRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyStartRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyOpDefenseReadyRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("对方布阵完成")
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyOpDefenseReadyRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyChangeToAttackRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:notifyChangeToAttackRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyChangeToAttackRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyOpReadyFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyOpReadyFightRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyGameResultRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:notifyGameResultRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyGameResultRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyBeInviteRes(status, msg)
	if status == 0 then
		TraincampqiecuoController.instance:notifyBeInviteRes(msg)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyBeInviteRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyRefuseInviteRes(status, msg)
	if status == 0 then
		if msg.reason == 1 then
			FloatWordMgr.instance:show("对方拒绝切磋")
		elseif msg.reason == 2 then
			FloatWordMgr.instance:show("对方正在护送中")
		elseif msg.reason == 3 then
			FloatWordMgr.instance:show("对方切磋功能未开启")
		end

		TraincampqiecuoModel.instance:clearInvateId()
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyRefuseInviteRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyReadyFailRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyReadyFailRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyCancelReadyRes(status, msg)
	if status == 0 then
		local playerid = msg.playerId

		TraincampqiecuoModel.instance:setReadyPlayerId(playerid, false)
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyCancelReadyRes)
	end
end

function TrainCampQieCuoAgent:sendPM_TC_ReformInReq()
	local req = TrainCampQieCuoExtension_pb.PM_TC_ReformInReq()

	self:sendMsg(req)
end

function TrainCampQieCuoAgent:handlePM_TC_ReformInRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_ReformInRes)
	end
end

function TrainCampQieCuoAgent:handlePM_TC_NotifyBack2ReformRes(status, msg)
	if status == 0 then
		TraincampqiecuoModel.instance:back2Reform(msg.playerId)

		local userId = RoleModel.instance:getUserId()

		if msg.playerId ~= userId then
			FloatWordMgr.instance:show("对方已回到房间内")
		end

		GlobalDispatcher:dispatch(TrainCampQieCuoAgent.TC_NotifyBack2ReformRes)
	end
end

TrainCampQieCuoAgent.instance = TrainCampQieCuoAgent.New()

return TrainCampQieCuoAgent
