-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/agent/EquipmentComposeAgent.lua

module("logic.extensions.equipment.agent.EquipmentComposeAgent", package.seeall)

local EquipmentComposeAgent = class("EquipmentComposeAgent", BaseAgent)

EquipmentComposeAgent.PM_ComposeEquipmentRes = "EquipmentComposeAgent_PM_ComposeEquipmentRes"
EquipmentComposeAgent.PM_DecompseEquipmentRes = "EquipmentComposeAgent_PM_DecompseEquipmentRes"
EquipmentComposeAgent.PM_ComposeThroneRes = "EquipmentComposeAgent_PM_ComposeThroneRes"
EquipmentComposeAgent.PM_ComposeStarGodFillerRes = "EquipmentComposeAgent_PM_ComposeStarGodFillerRes"

function EquipmentComposeAgent:ctor()
	return
end

function EquipmentComposeAgent:setExtId(extId)
	EquipmentComposeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function EquipmentComposeAgent:sendPM_ComposeEquipmentReq(tabId, costQuality, equipmentIds_i32_Ary, curTimes, choiceId, handler, handlerObj, errHandler)
	local req = EquipmentComposeExtension_pb.PM_ComposeEquipmentReq()

	req.tabId = tabId
	req.costQuality = costQuality

	for i, v1 in ipairs(equipmentIds_i32_Ary) do
		req.equipmentIds:append(v1)
	end

	req.curTimes = curTimes
	req.choiceId = choiceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentComposeAgent.PM_ComposeEquipmentRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentComposeAgent:handlePM_ComposeEquipmentRes(status, msg)
	self:dispatch(EquipmentComposeAgent.PM_ComposeEquipmentRes, status, msg)
end

function EquipmentComposeAgent:sendPM_DecompseEquipmentReq(equipmentIds_i32_Ary, handler, handlerObj, errHandler)
	local req = EquipmentComposeExtension_pb.PM_DecompseEquipmentReq()

	for i, v2 in ipairs(equipmentIds_i32_Ary) do
		req.equipmentIds:append(v2)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentComposeAgent.PM_DecompseEquipmentRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentComposeAgent:handlePM_DecompseEquipmentRes(status, msg)
	self:dispatch(EquipmentComposeAgent.PM_DecompseEquipmentRes, status, msg)
end

function EquipmentComposeAgent:sendPM_ComposeThroneReq(tabId, costQuality, throneIds, curTimes, choiceId, handler, handlerObj, errHandler)
	local req = EquipmentComposeExtension_pb.PM_ComposeThroneReq()

	req.tabId = tabId
	req.costQuality = costQuality

	for i, v1 in ipairs(throneIds) do
		req.throneIds:append(v1)
	end

	req.curTimes = curTimes
	req.choiceId = choiceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentComposeAgent.PM_ComposeThroneRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentComposeAgent:handlePM_ComposeThroneRes(status, msg)
	self:dispatch(EquipmentComposeAgent.PM_ComposeThroneRes, status, msg)
end

function EquipmentComposeAgent:sendPM_ComposeStarGodFillerReq(tabId, costQuality, fillerIds, choiceId, curTimes, handler, handlerObj, errHandler)
	local req = EquipmentComposeExtension_pb.PM_ComposeStarGodFillerReq()

	req.tabId = tabId
	req.costQuality = costQuality

	for i, v1 in ipairs(fillerIds) do
		req.fillerIds:append(v1)
	end

	req.choiceId = choiceId
	req.curTimes = curTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentComposeAgent.PM_ComposeStarGodFillerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentComposeAgent:handlePM_ComposeStarGodFillerRes(status, msg)
	self:dispatch(EquipmentComposeAgent.PM_ComposeStarGodFillerRes, status, msg)
end

function EquipmentComposeAgent:sendPM_GetComposeTimesReq()
	local req = EquipmentComposeExtension_pb.PM_GetComposeTimesReq()

	self:sendMsg(req)
end

function EquipmentComposeAgent:handlePM_GetComposeTimesRes(status, msg)
	if status == 0 then
		PetEquipController.instance:scSendComposeTimes(msg)
	end
end

EquipmentComposeAgent.instance = EquipmentComposeAgent.New()

return EquipmentComposeAgent
