-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/agent/GoddessCompetitionAgent.lua

module("logic.extensions.goddesscompetition.agent.GoddessCompetitionAgent", package.seeall)

local GoddessCompetitionAgent = class("GoddessCompetitionAgent", BaseAgent)

function GoddessCompetitionAgent:sendPM_GoddessCompetitionGetInfoReq(activityId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionGetInfoRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessCompetitionError, status)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionVoteReq(activityId, faceId, voteCount)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionVoteReq()

	req.activityId = activityId
	req.faceId = faceId
	req.voteCount = voteCount

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionVoteRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleVote(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionSendRedPackReq(activityId, faceId, redPackDefineId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionSendRedPackReq()

	req.activityId = activityId
	req.faceId = faceId
	req.redPackDefineId = redPackDefineId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionSendRedPackRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handlePM_GoddessCompetitionSendRedPackRes(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionGrabRedPackReq(activityId, redPackDefineId, redPackId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionGrabRedPackReq()

	req.activityId = activityId
	req.redPackDefineId = redPackDefineId
	req.redPackId = redPackId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionGrabRedPackRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleGrabRedPack(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionRedPackListReq(activityId, redPackType)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionRedPackListReq()

	req.activityId = activityId
	req.redPackType = redPackType

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionRedPackListRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleRedPackList(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionRedPackInfoReq(activityId, redPackType, redPackId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionRedPackInfoReq()

	req.activityId = activityId
	req.redPackType = redPackType
	req.redPackId = redPackId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionRedPackInfoRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleGetRedPackInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessCompetitionError, status)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionPopularityRankViewReq(activityId, stepId, goddessFaceId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionPopularityRankViewReq()

	req.activityId = activityId
	req.stepId = stepId
	req.goddessFaceId = goddessFaceId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionPopularityRankViewRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handlePM_GoddessCompetitionPopularityRankViewRes(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionRedPackRankViewReq(activityId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionRedPackRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionRedPackRankViewRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handlePM_GoddessCompetitionRedPackRankViewRes(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionRedPackRecordReq(activityId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionRedPackRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionRedPackRecordRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleGetRedPackRecord(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionSuperFansRankViewReq(activityId, stepId, goddessFaceId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionSuperFansRankViewReq()

	req.activityId = activityId
	req.stepId = stepId
	req.goddessFaceId = goddessFaceId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionSuperFansRankViewRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handlePM_GoddessCompetitionSuperFansRankViewRes(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionGainProgressPrizeReq(activityId, prizeIds)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionGainProgressPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionGainProgressPrizeRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleGainProgressPrize(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionUseDoubleCardReq(activityId, doubleCardId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionUseDoubleCardReq()

	req.activityId = activityId
	req.doubleCardId = doubleCardId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionUseDoubleCardRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleUseDoubleCard(msg)
	end
end

function GoddessCompetitionAgent:sendPM_GoddessCompetitionAllGoddessPopularityRankReq(activityId, stepId)
	local req = GoddessCompetitionExtension_pb.PM_GoddessCompetitionAllGoddessPopularityRankReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionAllGoddessPopularityRankRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleAllGoddessRank(msg)
	end
end

function GoddessCompetitionAgent:handlePM_GoddessCompetitionDoubleCardRes(status, msg)
	if status == 0 then
		GoddessCompetitionController.instance:handleDoubleCardNotify(msg)
	end
end

GoddessCompetitionAgent.instance = GoddessCompetitionAgent.New()

return GoddessCompetitionAgent
