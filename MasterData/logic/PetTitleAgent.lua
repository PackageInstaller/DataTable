-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/agent/PetTitleAgent.lua

module("logic.extensions.pettitle.agent.PetTitleAgent", package.seeall)

local PetTitleAgent = class("PetTitleAgent", BaseAgent)

function PetTitleAgent:sendPM_PetTitleGetPetTitlesReq(otherUserId)
	local req = PetTitleExtension_pb.PM_PetTitleGetPetTitlesReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	self:sendMsg(req)
end

function PetTitleAgent:handlePM_PetTitleGetPetTitlesRes(status, msg)
	PetTitleController.instance:handleGetPetTitlesRes(status, msg)
end

function PetTitleAgent:sendPM_PetTitleChangeReq(petId, titleId)
	local req = PetTitleExtension_pb.PM_PetTitleChangeReq()

	req.petId = petId
	req.titleId = titleId

	self:sendMsg(req)
end

function PetTitleAgent:handlePM_PetTitleChangeRes(status, msg)
	PetTitleController.instance:handleChangeRes(status, msg)
end

function PetTitleAgent:handlePM_PetTitleGainNotifyRes(status, msg)
	if status == 0 then
		PetTitleController.instance:handleNotifyPetTitleChangeRes(msg)
	end
end

PetTitleAgent.instance = PetTitleAgent.New()

return PetTitleAgent
