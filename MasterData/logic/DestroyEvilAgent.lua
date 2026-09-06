-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/agent/DestroyEvilAgent.lua

module("logic.extensions.destroyevil.agent.DestroyEvilAgent", package.seeall)

local DestroyEvilAgent = class("DestroyEvilAgent", BaseAgent)

function DestroyEvilAgent:sendPM_DestroyEvilGetInfoReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilGetInfoRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilGetInfoRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilChallengeReq(actId, targetPlayerId, monsterUniqueId, form, strongChallenge, isNoPaid)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilChallengeReq()

	req.actId = actId
	req.targetPlayerId = targetPlayerId
	req.monsterUniqueId = monsterUniqueId

	req.form:ParseFromString(form:SerializeToString())

	req.strongChallenge = strongChallenge
	req.isNoPaid = isNoPaid

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilChallengeRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilChallengeRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	if status < 0 then
		FloatWordMgr.instance:show(lang("恶灵已消失"))
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilMasterDeadByOther)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilRefreshMonsterReq(actId, ticketId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilRefreshMonsterReq()

	req.actId = actId
	req.ticketId = ticketId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilRefreshMonsterRes(status, msg)
	if status == 0 then
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
		DestroyEvilModel.instance:onDestroyEvilRefreshMonsterRes(msg.myMonsterInfo)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilRefreshMonsterRes, msg.ticketId)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilGetReportInfoReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilGetReportInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilGetReportInfoRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilGetReportInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilGetReportInfoRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilConveneBuddyReq(actId, buddyIds)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilConveneBuddyReq()

	req.actId = actId

	if buddyIds then
		for i, v in ipairs(buddyIds) do
			req.buddyIds:append(v)
		end
	end

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilConveneBuddyRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilConveneBuddyRes(GameUtil.pbToTable(msg.buddyIds) or {})
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilConveneBuddyRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilViewBuddyScoreReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilViewBuddyScoreReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilViewBuddyScoreRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilViewBuddyScoreRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilViewBuddyScoreRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilGainBuddyPrizeReq(actId, buddyIds)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilGainBuddyPrizeReq()

	req.actId = actId

	if buddyIds then
		for i, v in ipairs(buddyIds) do
			req.buddyIds:append(v)
		end
	end

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilGainBuddyPrizeRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilGainBuddyPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilGainBuddyPrizeRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilBuyTicketReq(actId, ticketId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilBuyTicketReq()

	req.actId = actId
	req.ticketId = ticketId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilBuyTicketRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilBuyTicketRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilBuyTicketRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilGetRecommendListReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilGetRecommendListReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilGetRecommendListRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilGetRecommendListRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilGetRecommendListRes)
	elseif status == -1902 then
		FloatWordMgr.instance:show("推荐列表刷新至少间隔10秒")
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilSetPublicBossReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilSetPublicBossReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilSetPublicBossRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilSetPublicBossRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilSetPublicBossRes, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilSetPublicBossRes, false)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilBuyStrengthReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilBuyStrengthReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilBuyStrengthRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilBuyStrengthRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilBuyStrengthRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilViewHelpRankReq(actId)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilViewHelpRankReq()

	req.actId = actId

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilViewHelpRankRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onDestroyEvilViewRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilViewHelpRankRes)
	end
end

function DestroyEvilAgent:sendPM_DestroyEvilSelectDifficultyReq(actId, difficultyStar)
	local req = DestroyEvilExtension_pb.PM_DestroyEvilSelectDifficultyReq()

	req.actId = actId
	req.difficultyStar = difficultyStar

	self:sendMsg(req)
end

function DestroyEvilAgent:handlePM_DestroyEvilSelectDifficultyRes(status, msg)
	if status == 0 then
		DestroyEvilModel.instance:onSelectDifficulty(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilSelectDifficultyRes)
	end
end

DestroyEvilAgent.instance = DestroyEvilAgent.New()

return DestroyEvilAgent
