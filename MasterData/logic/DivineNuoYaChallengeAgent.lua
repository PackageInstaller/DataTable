-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/agent/DivineNuoYaChallengeAgent.lua

module("logic.extensions.divinenuoyachallenge.agent.DivineNuoYaChallengeAgent", package.seeall)

local DivineNuoYaChallengeAgent = class("DivineNuoYaChallengeAgent", BaseAgent)

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgGetInfoReq(activityId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgGetInfoRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgGetInfoRes)
	end
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgNormalFightReq(activityId, form, supportPetPlanId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgNormalFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.supportPetPlanId = supportPetPlanId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgNormalFightRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgNormalFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgNormalFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgNotifyNormalFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgNotifyNormalFightResultRes)
	end
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgSelectPetsReq(activityId, petId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgSelectPetsReq()

	req.activityId = activityId

	if petId then
		for i, v in ipairs(petId) do
			req.petId:append(v)
		end
	end

	self._selectPets = petId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgSelectPetsRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgSelectPetsRes(msg, self._selectPets)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgSelectPetsRes)
	end

	self._selectPets = nil
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgExtremeFightReq(activityId, form)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgExtremeFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)

	local petIds = {}

	for i, v in ipairs(form.pos) do
		if v > 0 then
			table.insert(petIds, v)
		end
	end

	self._extremePetIds = petIds
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgExtremeFightRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgExtremeFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgExtremeFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgNotifyExtremeFightResultRes(msg, self._extremePetIds)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgNotifyExtremeFightResultRes)
	end

	self._extremePetIds = nil
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgGainNormalPrizeReq(activityId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgGainNormalPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgGainNormalPrizeRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgGainNormalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgGainNormalPrizeRes)
	end
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaClgGainExtremePrizeReq(activityId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaClgGainExtremePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaClgGainExtremePrizeRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaClgGainExtremePrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaClgGainExtremePrizeRes)
	end
end

function DivineNuoYaChallengeAgent:sendPM_DivineNuoYaExtremeClgResetStageReq(activityId)
	local req = DivineNuoYaChallengeExtension_pb.PM_DivineNuoYaExtremeClgResetStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineNuoYaChallengeAgent:handlePM_DivineNuoYaExtremeClgResetStageRes(status, msg)
	if status == 0 then
		DivineNuoYaChallengeModel.instance:onDivineNuoYaExtremeClgResetStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineNuoYaExtremeClgResetStageRes)
	end
end

DivineNuoYaChallengeAgent.instance = DivineNuoYaChallengeAgent.New()

return DivineNuoYaChallengeAgent
