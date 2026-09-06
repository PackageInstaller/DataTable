-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/agent/PetAwakenVerificationAgent.lua

module("logic.extensions.petawakenverification.agent.PetAwakenVerificationAgent", package.seeall)

local PetAwakenVerificationAgent = class("PetAwakenVerificationAgent", BaseAgent)

function PetAwakenVerificationAgent:ctor()
	return
end

function PetAwakenVerificationAgent:sendPM_PetAwakenVerificationGetInfoReq(activityId)
	local req = PetAwakenVerificationExtension_pb.PM_PetAwakenVerificationGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PetAwakenVerificationAgent:handlePM_PetAwakenVerificationGetInfoRes(status, msg)
	if status == 0 then
		PetAwakenVerificationController.instance:onHandlePetAwakenVerificationGetInfoRes(msg)
	end
end

function PetAwakenVerificationAgent:sendPM_PetAwakenVerificationGainPrizeReq(activityId, id, prizeId, petId)
	local req = PetAwakenVerificationExtension_pb.PM_PetAwakenVerificationGainPrizeReq()

	req.activityId = activityId
	req.id = id
	req.prizeId = prizeId
	req.petId = petId

	self:sendMsg(req)
end

function PetAwakenVerificationAgent:handlePM_PetAwakenVerificationGainPrizeRes(status, msg)
	if status == 0 then
		PetAwakenVerificationController.instance:onHandlePetAwakenVerificationGainPrizeRes(msg)
	end
end

PetAwakenVerificationAgent.instance = PetAwakenVerificationAgent.New()

return PetAwakenVerificationAgent
