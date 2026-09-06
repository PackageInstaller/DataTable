-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/agent/GodHyurChallengeAgent.lua

module("logic.extensions.godxiuerchallenge.agent.GodHyurChallengeAgent", package.seeall)

local GodHyurChallengeAgent = class("GodHyurChallengeAgent", BaseAgent)

function GodHyurChallengeAgent:sendPM_GodHyurChallengeScoreInfoReq(challengeId)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurChallengeScoreInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function GodHyurChallengeAgent:handlePM_GodHyurChallengeScoreInfoRes(status, msg)
	if status == 0 then
		GodXiuerChallengeModel.instance:onChallengeScoreInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurChallengeScoreInfoRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurChallengeOneKeyPassReq(challengeId)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurChallengeOneKeyPassReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:_setChallengeId("OneKeyPassReq", challengeId)
end

function GodHyurChallengeAgent:handlePM_GodHyurChallengeOneKeyPassRes(status, msg)
	if status == 0 then
		local challengeId = self:_getChallengeId("OneKeyPassReq")

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GodXiuerChallengeModel.instance:onChallengeOneKeyPassRes(msg, challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurChallengeOneKeyPassRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurLimitChallengeInfoReq(challengeId)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurLimitChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:_setChallengeId("LimitChallengeInfoReq", challengeId)
end

function GodHyurChallengeAgent:handlePM_GodHyurLimitChallengeInfoRes(status, msg)
	if status == 0 then
		local challengeId = self:_getChallengeId("LimitChallengeInfoReq")

		GodXiuerChallengeModel.instance:onLimitChallengeInfoRes(msg, challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurLimitChallengeInfoRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurLimitChallengeFormReq(challengeId, id)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurLimitChallengeFormReq()

	req.challengeId = challengeId
	req.id = id

	self:sendMsg(req)
	self:_setChallengeId("LimitChallengeFormReq", challengeId)
end

function GodHyurChallengeAgent:handlePM_GodHyurLimitChallengeFormRes(status, msg)
	if status == 0 then
		local challengeId = self:_getChallengeId("LimitChallengeFormReq")

		GodXiuerChallengeModel.instance:onLimitChallengeFormRes(msg, challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurLimitChallengeFormRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurWholePeopleChallengeInfoReq(challengeId)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurWholePeopleChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:_setChallengeId("WholePeopleChallengeInfoReq", challengeId)
end

function GodHyurChallengeAgent:handlePM_GodHyurWholePeopleChallengeInfoRes(status, msg)
	if status == 0 then
		local challengeId = self:_getChallengeId("WholePeopleChallengeInfoReq")

		GodXiuerChallengeModel.instance:onWholePeopleChallengeInfoRes(msg, challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurWholePeopleChallengeInfoRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurLimitChallengeReq(challengeId, id, form)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurLimitChallengeReq()

	req.challengeId = challengeId
	req.id = id

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function GodHyurChallengeAgent:handlePM_GodHyurLimitChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurLimitChallengeRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurWholePeopleChallengeReq(challengeId, form, stage)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurWholePeopleChallengeReq()

	req.challengeId = challengeId
	req.stage = stage

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function GodHyurChallengeAgent:handlePM_GodHyurWholePeopleChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurWholePeopleChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurLimitChallengeResetReq(challengeId)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurLimitChallengeResetReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:_setChallengeId("LimitChallengeResetReq", challengeId)
end

function GodHyurChallengeAgent:handlePM_GodHyurLimitChallengeResetRes(status, msg)
	if status == 0 then
		local challengeId = self:_getChallengeId("LimitChallengeResetReq")

		GodXiuerChallengeModel.instance:onLimitChallengeResetRes(challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurLimitChallengeResetRes)
	end
end

function GodHyurChallengeAgent:sendPM_GodHyurLimitChallengeOverlapReq(challengeId, id, overlap)
	local req = GodHyurChallengeExtension_pb.PM_GodHyurLimitChallengeOverlapReq()

	req.challengeId = challengeId
	req.id = id
	req.overlap = overlap

	self:sendMsg(req)
end

function GodHyurChallengeAgent:handlePM_GodHyurLimitChallengeOverlapRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GodHyurLimitChallengeOverlapRes)
	end
end

function GodHyurChallengeAgent:handlePM_NotifyGodHyurLimitChallengeEndRes(status, msg)
	if status == 0 then
		GodXiuerChallengeModel.instance:onLimitChallengeEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyGodHyurLimitChallengeEndRes)
	end
end

function GodHyurChallengeAgent:handlePM_NotifyGodHyurWholePeopleChallengeEndRes(status, msg)
	if status == 0 then
		GodXiuerChallengeModel.instance:onWholePeopleChallengeEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyGodHyurWholePeopleChallengeEndRes)
	end
end

function GodHyurChallengeAgent:_setChallengeId(key, challengeId)
	self._challengeIds = self._challengeIds or {}
	self._challengeIds[key] = challengeId
end

function GodHyurChallengeAgent:_getChallengeId(key)
	self._challengeIds = self._challengeIds or {}
	self._challengeIds[key] = nil

	return self._challengeIds[key]
end

GodHyurChallengeAgent.instance = GodHyurChallengeAgent.New()

return GodHyurChallengeAgent
