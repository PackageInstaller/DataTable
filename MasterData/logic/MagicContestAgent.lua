-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/agent/MagicContestAgent.lua

module("logic.extensions.magiccontest.agent.MagicContestAgent", package.seeall)

local MagicContestAgent = class("MagicContestAgent", BaseAgent)

function MagicContestAgent:sendPM_MagicContestGetInfoReq(activityId)
	local req = MagicContestExtension_pb.PM_MagicContestGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestGetInfoRes(status, msg)
	if status == 0 then
		MagicContestController.instance:handlePM_MagicContestGetInfoRes(msg)
	end
end

function MagicContestAgent:sendPM_MagicContestSetDefenseFormReq(activityId, batType, simpleForm)
	local req = MagicContestExtension_pb.PM_MagicContestSetDefenseFormReq()

	req.activityId = activityId
	req.type = batType

	req.form:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestSetDefenseFormRes(status, msg)
	MagicContestController.instance:handlePM_MagicContestSetDefenseFormRes(status, msg)
end

function MagicContestAgent:sendPM_MagicContestStartMatchReq(activityId, type)
	local req = MagicContestExtension_pb.PM_MagicContestStartMatchReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestStartMatchRes(status, msg)
	MagicContestController.instance:handlePM_MagicContestStartMatchRes(status, msg)
end

function MagicContestAgent:sendPM_MagicContestChallengeReq(activityId, batType, simpleForm)
	local req = MagicContestExtension_pb.PM_MagicContestChallengeReq()

	req.activityId = activityId
	req.type = batType

	req.form:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestChallengeRes(status, msg)
	if status == 0 then
		MagicContestController.instance:handlePM_MagicContestChallengeRes(msg)
	end
end

function MagicContestAgent:sendPM_MagicContestSelectBuffReq(activityId, batType, buffIds)
	local req = MagicContestExtension_pb.PM_MagicContestSelectBuffReq()

	req.activityId = activityId
	req.type = batType

	if buffIds then
		for _, buffId in ipairs(buffIds) do
			req.buffIds:append(buffId)
		end
	end

	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestSelectBuffRes(status, msg)
	MagicContestController.instance:handlePM_MagicContestSelectBuffRes(status, msg)
end

function MagicContestAgent:sendPM_MagicContestGetRankInfoReq(activityId, type)
	local req = MagicContestExtension_pb.PM_MagicContestGetRankInfoReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function MagicContestAgent:handlePM_MagicContestGetRankInfoRes(status, msg)
	if status == 0 then
		MagicContestController.instance:handlePM_MagicContestGetRankInfoRes(msg)
	end
end

function MagicContestAgent:handlePM_Notify_MagicContestChallengeResult(status, msg)
	if status == 0 then
		MagicContestController.instance:handlePM_Notify_MagicContestChallengeResult(msg)
	end
end

MagicContestAgent.instance = MagicContestAgent.New()

return MagicContestAgent
