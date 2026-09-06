-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/agent/MiyaChallengeAgent.lua

module("logic.extensions.miyachallenge.agent.MiyaChallengeAgent", package.seeall)

local MiyaChallengeAgent = class("MiyaChallengeAgent", BaseAgent)

MiyaChallengeAgent.PM_MiyaChallengeGetInfoRes = "MiyaChallengeAgent.PM_MiyaChallengeGetInfoRes"
MiyaChallengeAgent.PM_MiyaChallengeGetStageInfoRes = "MiyaChallengeAgent.PM_MiyaChallengeGetStageInfoRes"
MiyaChallengeAgent.PM_MiyaChallengeBuyAndRandomRes = "MiyaChallengeAgent.PM_MiyaChallengeBuyAndRandomRes"
MiyaChallengeAgent.PM_MiyaChallengeChoiceRes = "MiyaChallengeAgent.PM_MiyaChallengeChoiceRes"
MiyaChallengeAgent.PM_MiyaChallengeBossRes = "MiyaChallengeAgent.PM_MiyaChallengeBossRes"
MiyaChallengeAgent.PM_MiyaBossChallengeEndRes = "MiyaChallengeAgent.PM_MiyaBossChallengeEndRes"
MiyaChallengeAgent.PM_MiyaFormChallengeRes = "MiyaChallengeAgent.PM_MiyaFormChallengeRes"
MiyaChallengeAgent.PM_MiyaFormChallengeEndRes = "MiyaChallengeAgent.PM_MiyaFormChallengeEndRes"

function MiyaChallengeAgent:sendPM_MiyaChallengeGetInfoReq(activityId)
	local req = MiyaChallengeExtension_pb.PM_MiyaChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaChallengeGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaChallengeGetInfoRes, msg, status)
	end
end

function MiyaChallengeAgent:sendPM_MiyaChallengeGetStageInfoReq(activityId, tierId, bigStage, stageId)
	local req = MiyaChallengeExtension_pb.PM_MiyaChallengeGetStageInfoReq()

	req.activityId = activityId
	req.tierId = tierId
	req.bigStage = bigStage
	req.stageId = stageId

	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaChallengeGetStageInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaChallengeGetStageInfoRes, msg, status)
	end
end

function MiyaChallengeAgent:sendPM_MiyaChallengeBuyAndRandomReq(activityId, bigStage, stageId)
	local req = MiyaChallengeExtension_pb.PM_MiyaChallengeBuyAndRandomReq()

	req.activityId = activityId
	req.bigStage = bigStage
	req.stageId = stageId

	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaChallengeBuyAndRandomRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaChallengeBuyAndRandomRes, msg, status)
	end
end

function MiyaChallengeAgent:sendPM_MiyaChallengeChoiceReq(activityId, bigStage, stageId, finalParam)
	local req = MiyaChallengeExtension_pb.PM_MiyaChallengeChoiceReq()

	req.activityId = activityId
	req.bigStage = bigStage
	req.stageId = stageId

	req.finalParam:ParseFromString(finalParam:SerializeToString())
	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaChallengeChoiceRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaChallengeChoiceRes, msg, status)
	end
end

function MiyaChallengeAgent:sendPM_MiyaChallengeBossReq(activityId, stageId)
	local req = MiyaChallengeExtension_pb.PM_MiyaChallengeBossReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaChallengeBossRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaChallengeBossRes, msg, status)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiyaChallengeAgent:handlePM_MiyaBossChallengeEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaBossChallengeEndRes, msg, status)
	end
end

function MiyaChallengeAgent:sendPM_MiyaFormChallengeReq(activityId, bigStage, stageId)
	local req = MiyaChallengeExtension_pb.PM_MiyaFormChallengeReq()

	req.activityId = activityId
	req.bigStage = bigStage
	req.stageId = stageId

	self:sendMsg(req)
end

function MiyaChallengeAgent:handlePM_MiyaFormChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaFormChallengeRes, msg, status)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiyaChallengeAgent:handlePM_MiyaFormChallengeEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MiyaChallengeAgent.PM_MiyaFormChallengeEndRes, msg, status)
	end
end

MiyaChallengeAgent.instance = MiyaChallengeAgent.New()

return MiyaChallengeAgent
