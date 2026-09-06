-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/agent/DecorationAgent.lua

module("logic.extensions.equipment.agent.DecorationAgent", package.seeall)

local DecorationAgent = class("DecorationAgent", BaseAgent)

DecorationAgent.PM_LoadAllDecorationRes = "DecorationAgent_PM_LoadAllDecorationRes"
DecorationAgent.PM_EquipDecorationRes = "DecorationAgent_PM_EquipDecorationRes"
DecorationAgent.PM_UnloadDecorationRes = "DecorationAgent_PM_UnloadDecorationRes"
DecorationAgent.PM_UpgradeDecorationRes = "DecorationAgent_PM_UpgradeDecorationRes"
DecorationAgent.PM_DecomposeDecorationRes = "DecorationAgent_PM_DecomposeDecorationRes"
DecorationAgent.PM_SetChcekBoxStatusRes = "DecorationAgent_PM_SetChcekBoxStatusRes"
DecorationAgent.PM_NotifyDecorationsChangeRes = "DecorationAgent_PM_NotifyDecorationsChangeRes"

function DecorationAgent:ctor()
	return
end

function DecorationAgent:setExtId(extId)
	DecorationAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DecorationAgent:sendPM_LoadAllDecorationReq(handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_LoadAllDecorationReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_LoadAllDecorationRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_LoadAllDecorationRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadAllPetDecorations===back")
	self:dispatch(DecorationAgent.PM_LoadAllDecorationRes, status, msg)
end

function DecorationAgent:sendPM_EquipDecorationReq(decorationId, petId, handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_EquipDecorationReq()

	req.decorationId = decorationId
	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_EquipDecorationRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_EquipDecorationRes(status, msg)
	self:dispatch(DecorationAgent.PM_EquipDecorationRes, status, msg)
end

function DecorationAgent:sendPM_UnloadDecorationReq(decorationId, petId, handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_UnloadDecorationReq()

	req.decorationId = decorationId
	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_UnloadDecorationRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_UnloadDecorationRes(status, msg)
	self:dispatch(DecorationAgent.PM_UnloadDecorationRes, status, msg)
end

function DecorationAgent:sendPM_UpgradeDecorationReq(decorationId, usedDecorationIds_i32_Ary, usedMaterials_pb_Ary, handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_UpgradeDecorationReq()

	req.decorationId = decorationId

	for i, v1 in ipairs(usedDecorationIds_i32_Ary) do
		req.usedDecorationIds:append(v1)
	end

	if usedMaterials_pb_Ary ~= nil then
		for i, v2 in ipairs(usedMaterials_pb_Ary) do
			local usedMaterials = req.usedMaterials:add()

			usedMaterials:ParseFromString(v2:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_UpgradeDecorationRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_UpgradeDecorationRes(status, msg)
	self:dispatch(DecorationAgent.PM_UpgradeDecorationRes, status, msg)
end

function DecorationAgent:sendPM_DecomposeDecorationReq(decorationIds_i32_Ary, handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_DecomposeDecorationReq()

	for i, v3 in ipairs(decorationIds_i32_Ary) do
		req.decorationIds:append(v3)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_DecomposeDecorationRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_DecomposeDecorationRes(status, msg)
	self:dispatch(DecorationAgent.PM_DecomposeDecorationRes, status, msg)
end

function DecorationAgent:sendPM_SetChcekBoxStatusReq(isCheck, handler, handlerObj, errHandler)
	local req = DecorationExtension_pb.PM_SetChcekBoxStatusReq()

	req.isCheck = isCheck

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DecorationAgent.PM_SetChcekBoxStatusRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DecorationAgent:handlePM_SetChcekBoxStatusRes(status, msg)
	self:dispatch(DecorationAgent.PM_SetChcekBoxStatusRes, status, msg)
end

function DecorationAgent:handlePM_NotifyDecorationsChangeRes(status, msg)
	self:dispatch(DecorationAgent.PM_NotifyDecorationsChangeRes, status, msg)
end

DecorationAgent.instance = DecorationAgent.New()

return DecorationAgent
