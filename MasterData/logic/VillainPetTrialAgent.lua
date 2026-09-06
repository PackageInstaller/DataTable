-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/agent/VillainPetTrialAgent.lua

module("logic.extensions.villainpettrial.agent.VillainPetTrialAgent", package.seeall)

local VillainPetTrialAgent = class("VillainPetTrialAgent", BaseAgent)

function VillainPetTrialAgent:sendPM_VillainPetTrialGetInfoReq(actId)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialGetInfoRes(status, msg)
	if status == 0 then
		VillaintrialModel.instance:setVillaintrialMainInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.VillaintrialMain)
	end
end

function VillainPetTrialAgent:sendPM_VillainPetTrialGetRankInfoReq(actId)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialGetRankInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialGetRankInfoRes(status, msg)
	if status == 0 then
		VillaintrialModel.instance:setVillaintrialRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.VillaintrialRank)
	end
end

function VillainPetTrialAgent:sendPM_VillainPetTrialChallengeReq(actId, stageId, simpleForm)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialChallengeReq()

	req.actId = actId
	req.stageId = stageId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialChallengeRes(status, msg)
	if status == 0 then
		VillaintrialController.instance:startBattle(msg)
	elseif ViewMgr.instance:isOpen(ViewName.CustomMissionView) then
		UIStateManager.instance:clear(true)
	end
end

function VillainPetTrialAgent:sendPM_VillainPetTrialGetSpiritLineInfoReq(actId, stageId)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialGetSpiritLineInfoReq()

	req.actId = actId
	req.stageId = stageId

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialGetSpiritLineInfoRes(status, msg)
	if status == 0 then
		VillaintrialModel.instance:setVillaintrialEquipInfo(msg.infos)
		GlobalDispatcher:dispatch(GlobalNotify.VillaintrialSpiritLine)
	end
end

function VillainPetTrialAgent:sendPM_VillainPetTrialChangeSpiritLineReq(actId, petId, stageId, spiritLineId)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialChangeSpiritLineReq()

	req.actId = actId
	req.petId = petId
	req.stageId = stageId
	req.spiritLineId = spiritLineId

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialChangeSpiritLineRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function VillainPetTrialAgent:sendPM_VillainPetTrialGainPrizeReq(actId, index)
	local req = VillainPetTrialExtension_pb.PM_VillainPetTrialGainPrizeReq()

	req.actId = actId
	req.index = index

	self:sendMsg(req)
end

function VillainPetTrialAgent:handlePM_VillainPetTrialGainPrizeRes(status, msg)
	if status == 0 then
		VillaintrialController.instance:sendPM_VillainPetTrialGetInfoReq()
	end
end

VillainPetTrialAgent.instance = VillainPetTrialAgent.New()

return VillainPetTrialAgent
