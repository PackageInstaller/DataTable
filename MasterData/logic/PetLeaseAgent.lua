-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/agent/PetLeaseAgent.lua

module("logic.extensions.petlease.agent.PetLeaseAgent", package.seeall)

local PetLeaseAgent = class("PetLeaseAgent", BaseAgent)

PetLeaseAgent.PM_LoadHasRentPetRes = "PetLeaseAgent_PM_LoadHasRentPetRes"
PetLeaseAgent.PM_LeasePetGetInfoRes = "PetLeaseAgent_PM_LeasePetGetInfoRes"
PetLeaseAgent.PM_LeasePetRes = "PetLeaseAgent_PM_LeasePetRes"
PetLeaseAgent.PM_RentPetRes = "PetLeaseAgent_PM_RentPetRes"
PetLeaseAgent.PM_NotifyRentPetUseTimesChangeRes = "PetLeaseAgent_PM_NotifyRentPetUseTimesChangeRes"
PetLeaseAgent.PM_SetRentPetFormRes = "PetLeaseAgent_PM_SetRentPetFormRes"
PetLeaseAgent.PM_PetLeaseTakeOffPetRes = "PetLeaseAgent_PM_PetLeaseTakeOffPetRes"

function PetLeaseAgent:ctor()
	return
end

function PetLeaseAgent:setExtId(extId)
	PetLeaseAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetLeaseAgent:sendPM_LoadHasRentPetReq(handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_LoadHasRentPetReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_LoadHasRentPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_LoadHasRentPetRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestHirePets===back")
	self:dispatch(PetLeaseAgent.PM_LoadHasRentPetRes, status, msg)
end

function PetLeaseAgent:sendPM_LeasePetGetInfoReq(handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_LeasePetGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_LeasePetGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_LeasePetGetInfoRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_LeasePetGetInfoRes, status, msg)
end

function PetLeaseAgent:sendPM_LeasePetReq(leaseReqList_pb_Ary, handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_LeasePetReq()

	if leaseReqList_pb_Ary ~= nil then
		for i, v1 in ipairs(leaseReqList_pb_Ary) do
			local leaseReqList = req.leaseReqList:add()

			leaseReqList:ParseFromString(v1:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_LeasePetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_LeasePetRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_LeasePetRes, status, msg)
end

function PetLeaseAgent:sendPM_RentPetReq(rentReqList_pb_Ary, handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_RentPetReq()

	if rentReqList_pb_Ary ~= nil then
		for i, v2 in ipairs(rentReqList_pb_Ary) do
			local rentReqList = req.rentReqList:add()

			rentReqList:ParseFromString(v2:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_RentPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_RentPetRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_RentPetRes, status, msg)
end

function PetLeaseAgent:handlePM_NotifyRentPetUseTimesChangeRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_NotifyRentPetUseTimesChangeRes, status, msg)
end

function PetLeaseAgent:sendPM_SetRentPetFormReq(usageId, simpleForm_pb, handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_SetRentPetFormReq()

	req.usageId = usageId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_SetRentPetFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_SetRentPetFormRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_SetRentPetFormRes, status, msg)
end

function PetLeaseAgent:sendPM_PetLeaseTakeOffPetReq(slotId, handler, handlerObj, errHandler)
	local req = PetLeaseExtension_pb.PM_PetLeaseTakeOffPetReq()

	req.slotId = slotId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetLeaseAgent.PM_PetLeaseTakeOffPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetLeaseAgent:handlePM_PetLeaseTakeOffPetRes(status, msg)
	self:dispatch(PetLeaseAgent.PM_PetLeaseTakeOffPetRes, status, msg)
end

PetLeaseAgent.instance = PetLeaseAgent.New()

return PetLeaseAgent
