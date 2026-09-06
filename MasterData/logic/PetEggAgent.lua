-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petegg/agent/PetEggAgent.lua

module("logic.extensions.petegg.agent.PetEggAgent", package.seeall)

local PetEggAgent = class("PetEggAgent", BaseAgent)

function PetEggAgent:sendGetUserHatchInfosReq()
	local req = PetExtension_pb.GetUserHatchInfosReq()

	self:sendMsg(req)
end

function PetEggAgent:handleGetUserHatchInfosRes(status, msg)
	if status == 0 then
		local hatchinfos = msg.hatchInfos

		PetEggModel.instance:setHatchInfo(hatchinfos)
		PetEggController.instance:localNotify("RefreshHatch", hatchInfos)
		GlobalDispatcher:dispatch(GlobalNotify.HatchPetEggInfo)
	end
end

function PetEggAgent:sendHatchPetEggReq(hatcherId, petEggId)
	local req = PetExtension_pb.HatchPetEggReq()

	req.hatcherId = hatcherId
	req.petEggId = petEggId

	self:sendMsg(req)
end

function PetEggAgent:handleHatchPetEggRes(status, msg)
	if status == 0 then
		self:sendGetUserHatchInfosReq()
	end
end

function PetEggAgent:sendCancelHatchPetReq(hatcherId)
	local req = PetExtension_pb.CancelHatchPetReq()

	req.hatcherId = hatcherId

	self:sendMsg(req)
end

function PetEggAgent:handleCancelHatchPetRes(status, msg)
	if status == 0 then
		self:sendGetUserHatchInfosReq()
	end
end

function PetEggAgent:sendSpeedUpHatchPetEggReq(hatcherId)
	local req = PetExtension_pb.SpeedUpHatchPetEggReq()

	req.hatcherId = hatcherId

	self:sendMsg(req)
end

function PetEggAgent:handleSpeedUpHatchPetEggRes(status, msg)
	if status == 0 then
		self:sendGetUserHatchInfosReq()
	end
end

function PetEggAgent:sendGetHatchOutPetReq(hatcherId)
	local req = PetExtension_pb.GetHatchOutPetReq()

	req.hatcherId = hatcherId

	self:sendMsg(req)
end

function PetEggAgent:handleGetHatchOutPetRes(status, msg)
	if status == 0 then
		print(msg.hatcherId)

		local hatcherId = msg.hatcherId

		PetEggModel.instance:onHatcherEmptyed(hatcherId)
		PetEggController.instance:localNotify("RefreshHatch", hatchInfos)
	end
end

PetEggAgent.instance = PetEggAgent.New()

return PetEggAgent
