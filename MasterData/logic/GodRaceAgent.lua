-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godrace/agent/GodRaceAgent.lua

module("logic.extensions.godrace.agent.GodRaceAgent", package.seeall)

local GodRaceAgent = class("GodRaceAgent", BaseAgent)

function GodRaceAgent:sendPM_GodRaceTypeGetInfoReq()
	local req = GodRaceTypeExtension_pb.PM_GodRaceTypeGetInfoReq()

	self:sendMsg(req)
end

function GodRaceAgent:handlePM_GodRaceTypeGetInfoRes(status, msg)
	if status == 0 then
		local havewakedraceidbefore = msg.haveWakedRaceIdBefore
		local withslotstatecanwakeinfo = msg.withSlotStateCanWakeInfo

		GodRaceModel.instance:setWaked(havewakedraceidbefore)
		GodRaceModel.instance:setCanWakeWithSlot(withslotstatecanwakeinfo)
	end
end

function GodRaceAgent:sendPM_GodRaceTypeWakeReq(petIdBefore, leftSlotPutPetId, rightSlotPutPetId)
	local req = GodRaceTypeExtension_pb.PM_GodRaceTypeWakeReq()

	req.petIdBefore = petIdBefore
	req.leftSlotPutPetId = leftSlotPutPetId or 0
	req.rightSlotPutPetId = rightSlotPutPetId or 0

	self:sendMsg(req)
end

function GodRaceAgent:handlePM_GodRaceTypeWakeRes(status, msg)
	if status == 0 then
		local wakedId = msg.raceIdBefore

		GodRaceModel.instance:addWaked(wakedId)
		GodRaceController.instance:localNotify("AwakeSuccess")
	end
end

function GodRaceAgent:sendPM_GodRaceTypeOneKeyWakeReq(petIdBefore)
	local req = GodRaceTypeExtension_pb.PM_GodRaceTypeOneKeyWakeReq()

	req.petIdBefore = petIdBefore

	self:sendMsg(req)
end

function GodRaceAgent:handlePM_GodRaceTypeOneKeyWakeRes(status, msg)
	if status == 0 then
		local wakedId = msg.raceIdBefore

		GodRaceModel.instance:addWaked(wakedId)
	end
end

function GodRaceAgent:sendPM_GodRaceTypeOneKeyPutSlotPetReq(petIdBefore, isLeftSlot)
	local req = GodRaceTypeExtension_pb.PM_GodRaceTypeOneKeyPutSlotPetReq()

	req.petIdBefore = petIdBefore
	req.isLeftSlot = isLeftSlot

	self:sendMsg(req)
end

function GodRaceAgent:handlePM_GodRaceTypeOneKeyPutSlotPetRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

GodRaceAgent.instance = GodRaceAgent.New()

return GodRaceAgent
