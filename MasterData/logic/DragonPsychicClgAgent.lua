-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/agent/DragonPsychicClgAgent.lua

module("logic.extensions.dragonpsychicclg.agent.DragonPsychicClgAgent", package.seeall)

local DragonPsychicClgAgent = class("DragonPsychicClgAgent", BaseAgent)

function DragonPsychicClgAgent:sendPM_DPClgGetUniversalInfoReq(activityId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgGetUniversalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgGetUniversalInfoRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgGetUniversalInfoRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgUniversalChallengeReq(activityId, form, stageId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgUniversalChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgUniversalChallengeRes(status, msg)
	DragonPsychicClgController.instance:handlePM_DPClgUniversalChallengeRes(status, msg)
end

function DragonPsychicClgAgent:sendPM_DPClgHatchReq(activityId, creepsId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgHatchReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgHatchRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgHatchRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgDecHatchTimeReq(activityId, times)
	local req = DragonPsychicClgExtension_pb.PM_DPClgDecHatchTimeReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgDecHatchTimeRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgDecHatchTimeRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgGainHatchPetReq(activityId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgGainHatchPetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgGainHatchPetRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgGainHatchPetRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgSelectPetReq(activityId, creepsIds)
	local req = DragonPsychicClgExtension_pb.PM_DPClgSelectPetReq()

	req.activityId = activityId

	for _, v in ipairs(creepsIds) do
		req.creepsIds:append(v)
	end

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgSelectPetRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgSelectPetRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgGetExtremeInfoReq(activityId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgGetExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgGetExtremeInfoRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgGetExtremeInfoRes(msg)
	end
end

function DragonPsychicClgAgent:sendPM_DPClgExtremeChallengeReq(activityId, form, stageId, teamId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgExtremeChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgExtremeChallengeRes(status, msg)
	DragonPsychicClgController.instance:handlePM_DPClgExtremeChallengeRes(status, msg)
end

function DragonPsychicClgAgent:sendPM_DPClgResetReq(activityId, stageId, teamId)
	local req = DragonPsychicClgExtension_pb.PM_DPClgResetReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function DragonPsychicClgAgent:handlePM_DPClgResetRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgResetRes(msg)
	end
end

function DragonPsychicClgAgent:handlePM_DPClgNotifyUniversalChallengeRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgNotifyUniversalChallengeRes(msg)
	end
end

function DragonPsychicClgAgent:handlePM_DPClgNotifyExtremeChallengeRes(status, msg)
	if status == 0 then
		DragonPsychicClgController.instance:handlePM_DPClgNotifyExtremeChallengeRes(msg)
	end
end

DragonPsychicClgAgent.instance = DragonPsychicClgAgent.New()

return DragonPsychicClgAgent
