-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/agent/RuneAgent.lua

module("logic.extensions.rune.agent.RuneAgent", package.seeall)

local RuneAgent = class("RuneAgent", BaseAgent)

RuneAgent.PM_RuneSuitInfoRes = "RuneAgent_PM_RuneSuitInfoRes"
RuneAgent.PM_RunePetEquipSuitRes = "RuneAgent_PM_RunePetEquipSuitRes"
RuneAgent.PM_RunePetUnEquipSuitRes = "RuneAgent_PM_RunePetUnEquipSuitRes"
RuneAgent.PM_RuneInstallRes = "RuneAgent_PM_RuneInstallRes"
RuneAgent.PM_RuneUninstallRes = "RuneAgent_PM_RuneUninstallRes"
RuneAgent.PM_RuneLevelUpRes = "RuneAgent_PM_RuneLevelUpRes"
RuneAgent.PM_RuneLockRes = "RuneAgent_PM_RuneLockRes"
RuneAgent.PM_RuneUnLockRes = "RuneAgent_PM_RuneUnLockRes"
RuneAgent.PM_RuneDecomposeRes = "RuneAgent_PM_RuneDecomposeRes"
RuneAgent.PM_RuneOneKeyInstallRes = "RuneAgent_PM_RuneOneKeyInstallRes"
RuneAgent.PM_RuneBatchEquipSuitRes = "RuneAgent_PM_RuneBatchEquipSuitRes"
RuneAgent.PM_RuneOneKeyUninstallRes = "RuneAgent_PM_RuneOneKeyUninstallRes"
RuneAgent.PM_RuneDiamondLevelUpRes = "RuneAgent_PM_RuneDiamondLevelUpRes"
RuneAgent.PM_notifyRuneChangedRes = "RuneAgent_PM_notifyRuneChangedRes"
RuneAgent.PM_notifyRuneSuitChangedRes = "RuneAgent_PM_notifyRuneSuitChangedRes"

function RuneAgent:ctor()
	return
end

function RuneAgent:setExtId(extId)
	RuneAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function RuneAgent:sendPM_RuneSuitInfoReq(handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneSuitInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneSuitInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneSuitInfoRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneSuitInfoRes, status, msg)
end

function RuneAgent:sendPM_RunePetEquipSuitReq(petId, suitId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RunePetEquipSuitReq()

	req.petId = petId
	req.suitId = suitId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RunePetEquipSuitRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RunePetEquipSuitRes(status, msg)
	self:dispatch(RuneAgent.PM_RunePetEquipSuitRes, status, msg)
end

function RuneAgent:sendPM_RunePetUnEquipSuitReq(petId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RunePetUnEquipSuitReq()

	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RunePetUnEquipSuitRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RunePetUnEquipSuitRes(status, msg)
	self:dispatch(RuneAgent.PM_RunePetUnEquipSuitRes, status, msg)
end

function RuneAgent:sendPM_RuneInstallReq(suitId, runeId, posId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneInstallReq()

	req.suitId = suitId
	req.runeId = runeId
	req.posId = posId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneInstallRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneInstallRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneInstallRes, status, msg)
end

function RuneAgent:sendPM_RuneUninstallReq(suitId, posId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneUninstallReq()

	req.suitId = suitId
	req.posId = posId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneUninstallRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneUninstallRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneUninstallRes, status, msg)
end

function RuneAgent:sendPM_RuneLevelUpReq(runeId, materials_pb_Ary, eatRuneIds_i32_Ary, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneLevelUpReq()

	req.runeId = runeId

	if materials_pb_Ary ~= nil then
		for i, v1 in ipairs(materials_pb_Ary) do
			local materials = req.materials:add()

			materials:ParseFromString(v1:SerializeToString())
		end
	end

	for i, v2 in ipairs(eatRuneIds_i32_Ary) do
		req.eatRuneIds:append(v2)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneLevelUpRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneLevelUpRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneLevelUpRes, status, msg)
end

function RuneAgent:sendPM_RuneLockReq(runeId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneLockReq()

	req.runeId = runeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneLockRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneLockRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneLockRes, status, msg)
end

function RuneAgent:sendPM_RuneUnLockReq(runeId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneUnLockReq()

	req.runeId = runeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneUnLockRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneUnLockRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneUnLockRes, status, msg)
end

function RuneAgent:sendPM_RuneDecomposeReq(runeIds_i32_Ary, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneDecomposeReq()

	for i, v3 in ipairs(runeIds_i32_Ary) do
		req.runeIds:append(v3)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneDecomposeRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneDecomposeRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneDecomposeRes, status, msg)
end

function RuneAgent:sendPM_RuneOneKeyInstallReq(suitId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneOneKeyInstallReq()

	req.suitId = suitId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneOneKeyInstallRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneOneKeyInstallRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneOneKeyInstallRes, status, msg)
end

function RuneAgent:sendPM_RuneBatchEquipSuitReq(suitId, petIds_i32_Ary, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneBatchEquipSuitReq()

	req.suitId = suitId

	for i, v4 in ipairs(petIds_i32_Ary) do
		req.petIds:append(v4)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneBatchEquipSuitRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneBatchEquipSuitRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneBatchEquipSuitRes, status, msg)
end

function RuneAgent:sendPM_RuneOneKeyUninstallReq(suitId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneOneKeyUninstallReq()

	req.suitId = suitId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneOneKeyUninstallRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneOneKeyUninstallRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneOneKeyUninstallRes, status, msg)
end

function RuneAgent:sendPM_RuneDiamondLevelUpReq(runeId, handler, handlerObj, errHandler)
	local req = RuneExtension_pb.PM_RuneDiamondLevelUpReq()

	req.runeId = runeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RuneAgent.PM_RuneDiamondLevelUpRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function RuneAgent:handlePM_RuneDiamondLevelUpRes(status, msg)
	self:dispatch(RuneAgent.PM_RuneDiamondLevelUpRes, status, msg)
end

function RuneAgent:handlePM_notifyRuneChangedRes(status, msg)
	self:dispatch(RuneAgent.PM_notifyRuneChangedRes, status, msg)
end

function RuneAgent:handlePM_notifyRuneSuitChangedRes(status, msg)
	self:dispatch(RuneAgent.PM_notifyRuneSuitChangedRes, status, msg)
end

RuneAgent.instance = RuneAgent.New()

return RuneAgent
