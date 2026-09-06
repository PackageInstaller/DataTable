-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/agent/DualDragonChallengeAgent.lua

module("logic.extensions.dualdragonchallenge.agent.DualDragonChallengeAgent", package.seeall)

local DualDragonChallengeAgent = class("DualDragonChallengeAgent", BaseAgent)

DualDragonChallengeAgent.DualDragonChallengeGetInfoRes = "DualDragonChallengeAgent.DualDragonChallengeGetInfoRes"
DualDragonChallengeAgent.DualDragonResetExtreme = "DualDragonChallengeAgent.DualDragonResetExtreme"
DualDragonChallengeAgent.DragonBuyUniversalChallengeTimes = "DualDragonChallengeAgent.DragonBuyUniversalChallengeTimes"
DualDragonChallengeAgent.DualDragonGainPrizeExtreme = "DualDragonChallengeAgent.DualDragonGainPrizeExtreme"

function DualDragonChallengeAgent:sendPM_DualDragonChallengeGetInfoReq(activityId)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonChallengeGetInfoRes(status, msg)
	if status == 0 then
		DualdragonchallengeModel.instance:setInfos(msg)
	end

	GlobalDispatcher:dispatch(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, status, msg)
end

function DualDragonChallengeAgent:sendPM_DualDragonUniversalChallengeReq(activityId, form)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonUniversalChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonUniversalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DualDragonChallengeAgent:handlePM_NotifyDualDragonUniversalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DualDragonChallengeAgent:sendPM_DualDragonBuyUniversalChallengeTimesReq(activityId)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonBuyUniversalChallengeTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonBuyUniversalChallengeTimesRes(status, msg)
	if status == 0 then
		DualdragonchallengeModel.instance:addUniversalChallengeTime()
		GlobalDispatcher:dispatch(DualDragonChallengeAgent.DragonBuyUniversalChallengeTimes)
	end
end

function DualDragonChallengeAgent:sendPM_DualDragonExtremeChallengeReq(activityId, groupId, stageId, form)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonExtremeChallengeReq()

	req.activityId = activityId
	req.groupId = groupId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonExtremeChallengeRes(status, msg)
	if status == 0 then
		DualdragonchallengeController.instance:handlePM_DualDragonExtremeChallengeRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DualDragonChallengeAgent:handlePM_NotifyDualDragonExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DualDragonChallengeAgent:sendPM_DualDragonResetExtremeReq(activityId, groupId, stageId)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonResetExtremeReq()

	req.activityId = activityId
	req.groupId = groupId
	req.stageId = stageId

	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonResetExtremeRes(status, msg)
	if status == 0 then
		DualdragonchallengeController.instance:resetExtreme()
		GlobalDispatcher:dispatch(DualDragonChallengeAgent.DualDragonResetExtreme)
	end
end

function DualDragonChallengeAgent:sendPM_DualDragonGainPrizeExtremeReq(activityId)
	local req = DualDragonChallengeExtension_pb.PM_DualDragonGainPrizeExtremeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualDragonChallengeAgent:handlePM_DualDragonGainPrizeExtremeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(DualDragonChallengeAgent.DualDragonGainPrizeExtreme)
	end
end

DualDragonChallengeAgent.instance = DualDragonChallengeAgent.New()

return DualDragonChallengeAgent
