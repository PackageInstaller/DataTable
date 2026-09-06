-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/agent/PetVerifyBuffAgent.lua

module("logic.extensions.petverifybuff.agent.PetVerifyBuffAgent", package.seeall)

local PetVerifyBuffAgent = class("PetVerifyBuffAgent", BaseAgent)

PetVerifyBuffAgent.PM_PetVerifyInfoRes = "PetVerifyBuffAgent_PM_PetVerifyInfoRes"
PetVerifyBuffAgent.PM_SetPetVerifyRes = "PetVerifyBuffAgent_PM_SetPetVerifyRes"

function PetVerifyBuffAgent:ctor()
	return
end

function PetVerifyBuffAgent:setExtId(extId)
	PetVerifyBuffAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetVerifyBuffAgent:sendPM_PetVerifyInfoReq(planId, handler, handlerObj, errHandler)
	local req = PetVerifyBuffExtension_pb.PM_PetVerifyInfoReq()

	req.planId = planId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetVerifyBuffAgent.PM_PetVerifyInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PetVerifyBuffAgent:handlePM_PetVerifyInfoRes(status, msg)
	self:dispatch(PetVerifyBuffAgent.PM_PetVerifyInfoRes, status, msg)
end

function PetVerifyBuffAgent:sendPM_SetPetVerifyReq(planId, verifyPetId_i32_Ary, handler, handlerObj, errHandler)
	local req = PetVerifyBuffExtension_pb.PM_SetPetVerifyReq()

	req.planId = planId

	for i, v1 in ipairs(verifyPetId_i32_Ary) do
		req.verifyPetId:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetVerifyBuffAgent.PM_SetPetVerifyRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PetVerifyBuffAgent:handlePM_SetPetVerifyRes(status, msg)
	self:dispatch(PetVerifyBuffAgent.PM_SetPetVerifyRes, status, msg)
end

PetVerifyBuffAgent.instance = PetVerifyBuffAgent.New()

return PetVerifyBuffAgent
