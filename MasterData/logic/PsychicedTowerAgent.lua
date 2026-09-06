-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/agent/PsychicedTowerAgent.lua

module("logic.extensions.psychicedtower.agent.PsychicedTowerAgent", package.seeall)

local PsychicedTowerAgent = class("PsychicedTowerAgent", BaseAgent)

function PsychicedTowerAgent:sendPM_PsychicedTowerInfoReq(activityId)
	local req = PsychicedTowerExtension_pb.PM_PsychicedTowerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PsychicedTowerAgent:handlePM_PsychicedTowerInfoRes(status, msg)
	if status == 0 then
		PsychicedTowerController.instance:handlePM_PsychicedTowerInfoRes(msg)
	end
end

function PsychicedTowerAgent:sendPM_PsychicedTowerChallengeReq(activityId, towerId, stageId, buffs, form)
	local req = PsychicedTowerExtension_pb.PM_PsychicedTowerChallengeReq()

	req.activityId = activityId
	req.towerId = towerId
	req.stageId = stageId

	for i, v1 in ipairs(buffs) do
		local buffs = req.buffs:add()

		buffs:ParseFromString(v1:SerializeToString())
	end

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function PsychicedTowerAgent:handlePM_PsychicedTowerChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PsychicedTowerAgent:handlePM_NotifyPsychicedTowerChallengeFinishRes(status, msg)
	if status == 0 then
		PsychicedTowerController.instance:handlePM_NotifyPsychicedTowerChallengeFinishRes(msg)
	end
end

function PsychicedTowerAgent:sendPM_PsychicedTowerGainBuffReq(activityId, towerId)
	local req = PsychicedTowerExtension_pb.PM_PsychicedTowerGainBuffReq()

	req.activityId = activityId
	req.towerId = towerId

	self:sendMsg(req)
end

function PsychicedTowerAgent:handlePM_PsychicedTowerGainBuffRes(status, msg)
	if status == 0 then
		PsychicedTowerController.instance:handlePM_PsychicedTowerGainBuffRes(msg)
	end
end

function PsychicedTowerAgent:sendPM_PsychicedTowerRankInfoReq(activityId, towerId)
	local req = PsychicedTowerExtension_pb.PM_PsychicedTowerRankInfoReq()

	req.activityId = activityId
	req.towerId = towerId

	self:sendMsg(req)
end

function PsychicedTowerAgent:handlePM_PsychicedTowerRankInfoRes(status, msg)
	if status == 0 then
		PsychicedTowerController.instance:handlePM_PsychicedTowerRankInfoRes(msg)
	end
end

function PsychicedTowerAgent:sendPM_PsychicedTowerTotalRankInfoReq(activityId)
	local req = PsychicedTowerExtension_pb.PM_PsychicedTowerTotalRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PsychicedTowerAgent:handlePM_PsychicedTowerTotalRankInfoRes(status, msg)
	if status == 0 then
		PsychicedTowerController.instance:handlePM_PsychicedTowerTotalRankInfoRes(msg)
	end
end

PsychicedTowerAgent.instance = PsychicedTowerAgent.New()

return PsychicedTowerAgent
