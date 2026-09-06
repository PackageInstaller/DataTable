-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/agent/TeshamuChallengeAgent.lua

module("logic.extensions.teshamuchallenge.agent.TeshamuChallengeAgent", package.seeall)

local TeshamuChallengeAgent = class("TeshamuChallengeAgent", BaseAgent)

function TeshamuChallengeAgent:sendPM_TeshamuGetInfoReq(activityId)
	local req = TeshamuChallengeExtension_pb.PM_TeshamuGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeshamuChallengeAgent:handlePM_TeshamuGetInfoRes(status, msg)
	if status == 0 then
		TeShaMuChallengeController.instance:handlePM_TeshamuGetInfoRes(status, msg)
	end
end

function TeshamuChallengeAgent:sendPM_TeshamuChallengeReq(activityId, stageId, blockId, form)
	local req = TeshamuChallengeExtension_pb.PM_TeshamuChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.blockId = blockId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TeshamuChallengeAgent:handlePM_TeshamuChallengeRes(status, msg)
	if status == 0 then
		TeShaMuChallengeController.instance:handlePM_TeshamuChallengeRes(status, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function TeshamuChallengeAgent:sendPM_TeshamuResetReq(activityId, stageId)
	local req = TeshamuChallengeExtension_pb.PM_TeshamuResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function TeshamuChallengeAgent:handlePM_TeshamuResetRes(status, msg)
	if status == 0 then
		TeShaMuChallengeController.instance:handlePM_TeshamuResetRes(status, msg)
	end
end

function TeshamuChallengeAgent:handlePM_TeshamuNotifyChallengeResultRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end
end

function TeshamuChallengeAgent:sendPM_TeshamuUpgradeSignInBuffReq(activityId)
	local req = TeshamuChallengeExtension_pb.PM_TeshamuUpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeshamuChallengeAgent:handlePM_TeshamuUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		TeShaMuChallengeController.instance:handlePM_TeshamuUpgradeSignInBuffRes(status, msg)
	end
end

TeshamuChallengeAgent.instance = TeshamuChallengeAgent.New()

return TeshamuChallengeAgent
