-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/agent/HoshigamiAgent.lua

module("logic.extensions.hoshigami.agent.HoshigamiAgent", package.seeall)

local HoshigamiAgent = class("HoshigamiAgent", BaseAgent)

HoshigamiAgent.PM_LoadAllHoshigamiRes = "HoshigamiAgent_PM_LoadAllHoshigamiRes"
HoshigamiAgent.PM_EquipHoshigamiRes = "HoshigamiAgent_PM_EquipHoshigamiRes"
HoshigamiAgent.PM_UnloadHoshigamiRes = "HoshigamiAgent_PM_UnloadHoshigamiRes"
HoshigamiAgent.PM_UpgradeHoshigamiRes = "HoshigamiAgent_PM_UpgradeHoshigamiRes"
HoshigamiAgent.PM_DecomposeHoshigamisRes = "HoshigamiAgent_PM_DecomposeHoshigamisRes"
HoshigamiAgent.PM_GetAllHoshigamiPrefabSuitRes = "HoshigamiAgent_PM_GetAllHoshigamiPrefabSuitRes"
HoshigamiAgent.PM_SaveHoshigamiPrefabSuitRes = "HoshigamiAgent_PM_SaveHoshigamiPrefabSuitRes"
HoshigamiAgent.PM_UseHoshigamiPrefabSuitRes = "HoshigamiAgent_PM_UseHoshigamiPrefabSuitRes"
HoshigamiAgent.PM_NotifyHoshigamisChangeRes = "HoshigamiAgent_PM_NotifyHoshigamisChangeRes"

function HoshigamiAgent:ctor()
	return
end

function HoshigamiAgent:setExtId(extId)
	HoshigamiAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function HoshigamiAgent:sendPM_LoadAllHoshigamiReq(handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_LoadAllHoshigamiReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_LoadAllHoshigamiRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_LoadAllHoshigamiRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadHoshigamiInfo===back")
	self:dispatch(HoshigamiAgent.PM_LoadAllHoshigamiRes, status, msg)
end

function HoshigamiAgent:sendPM_EquipHoshigamiReq(petId, hoshigamiId, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_EquipHoshigamiReq()

	req.petId = petId
	req.hoshigamiId = hoshigamiId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_EquipHoshigamiRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_EquipHoshigamiRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_EquipHoshigamiRes, status, msg)
end

function HoshigamiAgent:sendPM_UnloadHoshigamiReq(petId, hoshigamiId, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_UnloadHoshigamiReq()

	req.petId = petId
	req.hoshigamiId = hoshigamiId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_UnloadHoshigamiRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_UnloadHoshigamiRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_UnloadHoshigamiRes, status, msg)
end

function HoshigamiAgent:sendPM_UpgradeHoshigamiReq(hoshigamiId, lv, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_UpgradeHoshigamiReq()

	req.hoshigamiId = hoshigamiId
	req.lv = lv

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_UpgradeHoshigamiRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_UpgradeHoshigamiRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_UpgradeHoshigamiRes, status, msg)
end

function HoshigamiAgent:sendPM_DecomposeHoshigamisReq(hoshigamiIds_i32_Ary, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_DecomposeHoshigamisReq()

	for i, v1 in ipairs(hoshigamiIds_i32_Ary) do
		req.hoshigamiIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_DecomposeHoshigamisRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_DecomposeHoshigamisRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_DecomposeHoshigamisRes, status, msg)
end

function HoshigamiAgent:sendPM_GetAllHoshigamiPrefabSuitReq(handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_GetAllHoshigamiPrefabSuitReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_GetAllHoshigamiPrefabSuitRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_GetAllHoshigamiPrefabSuitRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_GetAllHoshigamiPrefabSuitRes, status, msg)
end

function HoshigamiAgent:sendPM_SaveHoshigamiPrefabSuitReq(suitId, hoshigamiIds_i32_Ary, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_SaveHoshigamiPrefabSuitReq()

	req.suitId = suitId

	for i, v2 in ipairs(hoshigamiIds_i32_Ary) do
		req.hoshigamiIds:append(v2)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_SaveHoshigamiPrefabSuitRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_SaveHoshigamiPrefabSuitRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_SaveHoshigamiPrefabSuitRes, status, msg)
end

function HoshigamiAgent:sendPM_UseHoshigamiPrefabSuitReq(petId, suitId, handler, handlerObj, errHandler)
	local req = HoshigamiExtension_pb.PM_UseHoshigamiPrefabSuitReq()

	req.petId = petId
	req.suitId = suitId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HoshigamiAgent.PM_UseHoshigamiPrefabSuitRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HoshigamiAgent:handlePM_UseHoshigamiPrefabSuitRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_UseHoshigamiPrefabSuitRes, status, msg)
end

function HoshigamiAgent:handlePM_NotifyHoshigamisChangeRes(status, msg)
	self:dispatch(HoshigamiAgent.PM_NotifyHoshigamisChangeRes, status, msg)
end

HoshigamiAgent.instance = HoshigamiAgent.New()

return HoshigamiAgent
