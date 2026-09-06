-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/agent/StarGodPlusAgent.lua

module("logic.extensions.stargodplus.agent.StarGodPlusAgent", package.seeall)

local StarGodPlusAgent = class("StarGodPlusAgent", BaseAgent)

StarGodPlusAgent.PM_LoadAllFillerRes = "StarGodPlusAgent_PM_LoadAllFillerRes"
StarGodPlusAgent.PM_EquipFillerRes = "StarGodPlusAgent_PM_EquipFillerRes"
StarGodPlusAgent.PM_UnloadFillerRes = "StarGodPlusAgent_PM_UnloadFillerRes"
StarGodPlusAgent.PM_UpgradeSlotRes = "StarGodPlusAgent_PM_UpgradeSlotRes"
StarGodPlusAgent.PM_OneKeyEquipFillersRes = "StarGodPlusAgent_PM_OneKeyEquipFillersRes"
StarGodPlusAgent.PM_NotifyFillersChangeRes = "StarGodPlusAgent_PM_NotifyFillersChangeRes"
StarGodPlusAgent.PM_OneKeyUnloadRes = "StarGodPlusAgent.PM_OneKeyUnloadRes"
StarGodPlusAgent.PM_SetStarGodAutoDecomposeRes = "StarGodPlusAgent.PM_SetStarGodAutoDecomposeRes"
StarGodPlusAgent.PM_StarGodUnbindRaceIdRes = "StarGodPlusAgent.PM_SetStarGodAutoDecomposeRes"

function StarGodPlusAgent:ctor()
	return
end

function StarGodPlusAgent:setExtId(extId)
	StarGodPlusAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function StarGodPlusAgent:sendPM_LoadAllFillerReq(handler, handlerObj, errHandler)
	local req = StarGodPlusExtension_pb.PM_LoadAllFillerReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarGodPlusAgent.PM_LoadAllFillerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function StarGodPlusAgent:handlePM_LoadAllFillerRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadStarGodPlusInfo===back")
	self:dispatch(StarGodPlusAgent.PM_LoadAllFillerRes, status, msg)
end

function StarGodPlusAgent:sendPM_EquipFillerReq(petId, slot, fillerId, handler, handlerObj, errHandler)
	local req = StarGodPlusExtension_pb.PM_EquipFillerReq()

	req.petId = petId
	req.slot = slot
	req.fillerId = fillerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarGodPlusAgent.PM_EquipFillerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function StarGodPlusAgent:handlePM_EquipFillerRes(status, msg)
	self:dispatch(StarGodPlusAgent.PM_EquipFillerRes, status, msg)
end

function StarGodPlusAgent:sendPM_UnloadFillerReq(petId, slot, handler, handlerObj, errHandler)
	local req = StarGodPlusExtension_pb.PM_UnloadFillerReq()

	req.petId = petId
	req.slot = slot

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarGodPlusAgent.PM_UnloadFillerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function StarGodPlusAgent:handlePM_UnloadFillerRes(status, msg)
	self:dispatch(StarGodPlusAgent.PM_UnloadFillerRes, status, msg)
end

function StarGodPlusAgent:sendPM_UpgradeSlotReq(petId, slot, usedFillerIds_i32_Ary, usedMaterials_pb_Ary, handler, handlerObj, errHandler)
	local req = StarGodPlusExtension_pb.PM_UpgradeSlotReq()

	req.petId = petId
	req.slot = slot

	for i, v1 in ipairs(usedFillerIds_i32_Ary) do
		req.usedFillerIds:append(v1)
	end

	if usedMaterials_pb_Ary ~= nil then
		for i, v2 in ipairs(usedMaterials_pb_Ary) do
			local usedMaterials = req.usedMaterials:add()

			usedMaterials:ParseFromString(v2:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarGodPlusAgent.PM_UpgradeSlotRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function StarGodPlusAgent:handlePM_UpgradeSlotRes(status, msg)
	self:dispatch(StarGodPlusAgent.PM_UpgradeSlotRes, status, msg)
end

function StarGodPlusAgent:sendPM_OneKeyEquipFillersReq(petId, slotAndFillers_pb_Ary, handler, handlerObj, errHandler)
	local req = StarGodPlusExtension_pb.PM_OneKeyEquipFillersReq()

	req.petId = petId

	if slotAndFillers_pb_Ary ~= nil then
		for i, v3 in ipairs(slotAndFillers_pb_Ary) do
			local slotAndFillers = req.slotAndFillers:add()

			slotAndFillers:ParseFromString(v3:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarGodPlusAgent.PM_OneKeyEquipFillersRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function StarGodPlusAgent:handlePM_OneKeyEquipFillersRes(status, msg)
	self:dispatch(StarGodPlusAgent.PM_OneKeyEquipFillersRes, status, msg)
end

function StarGodPlusAgent:handlePM_NotifyFillersChangeRes(status, msg)
	self:dispatch(StarGodPlusAgent.PM_NotifyFillersChangeRes, status, msg)
end

function StarGodPlusAgent:sendPM_OneKeyUnloadReq(petIdList)
	local req = StarGodPlusExtension_pb.PM_OneKeyUnloadReq()

	for _, v in ipairs(petIdList) do
		req.petId:append(v)
	end

	self:sendMsg(req)
end

function StarGodPlusAgent:handlePM_OneKeyUnloadRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("星神卸下成功")
	end

	self:dispatch(StarGodPlusAgent.PM_OneKeyUnloadRes, status, msg)
end

function StarGodPlusAgent:sendPM_SetStarGodAutoDecomposeReq(quality)
	local req = StarGodPlusExtension_pb.PM_SetStarGodAutoDecomposeReq()

	req.quality = quality

	self:sendMsg(req)
end

function StarGodPlusAgent:handlePM_SetStarGodAutoDecomposeRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("设置成功")
	end

	self:dispatch(StarGodPlusAgent.PM_SetStarGodAutoDecomposeRes, status, msg)
end

function StarGodPlusAgent:sendPM_StarGodUnbindRaceIdReq(fillerId)
	local req = StarGodPlusExtension_pb.PM_StarGodUnbindRaceIdReq()

	req.fillerId = fillerId

	self:sendMsg(req)
end

function StarGodPlusAgent:handlePM_StarGodUnbindRaceIdRes(status, msg)
	if status == 0 then
		self:dispatch(StarGodPlusAgent.PM_StarGodUnbindRaceIdRes, status, msg)
	end
end

StarGodPlusAgent.instance = StarGodPlusAgent.New()

return StarGodPlusAgent
