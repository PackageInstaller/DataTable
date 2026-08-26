-- chunkname: @modules/logic/sp02/atomic/rpc/AtomicRpc.lua

module("modules.logic.sp02.atomic.rpc.AtomicRpc", package.seeall)

local AtomicRpc = class("AtomicRpc", BaseRpc)

function AtomicRpc:sendAtomicGetInfoRequest(callback, callbackObj)
	local req = AtomicModule_pb.AtomicGetInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicGetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicModel.instance:updateInfo(msg.info)
	AtomicDungeonModel.instance:updateInfo(msg.info)
end

function AtomicRpc:onReceiveAtomicUpdateInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicModel.instance:updateInfo(msg.info)
	AtomicDungeonModel.instance:updateInfo(msg.info)
end

function AtomicRpc:sendAtomicTalentNodeUnlockRequest(nodeId, callback, callbackObj)
	local req = AtomicModule_pb.AtomicTalentNodeUnlockRequest()

	req.nodeId = nodeId

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicTalentNodeUnlockReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local data = AtomicModel.instance:getData()
	local talentMo = data:getTalentInfo()

	talentMo:unlockTalent(msg.nodeId)
	AtomicTalentController.instance:onUnlockTalent()
end

function AtomicRpc:sendAtomicTalentResetRequest(branchId, nodeId, callback, callbackObj)
	local req = AtomicModule_pb.AtomicTalentResetRequest()

	req.branchId = branchId
	req.nodeId = nodeId or 0

	local ids, installIds = AtomicTalentViewModel.instance:getResetIds(branchId, nodeId)

	AtomicDungeonStatHelper.instance:senTalentInfo(ids, AtomicDungeonEnum.OptionType.Reset, installIds)
	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicTalentResetReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local data = AtomicModel.instance:getData()
	local talentMo = data:getTalentInfo()

	talentMo:updateInfo(msg.info)
	AtomicTalentController.instance:onResetTalent()
end

function AtomicRpc:sendAtomicTalentSkillChooseRequest(ids, callback, callbackObj)
	local req = AtomicModule_pb.AtomicTalentSkillChooseRequest()

	if ids then
		for _, id in ipairs(ids) do
			table.insert(req.skillNodeIds, id)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicTalentSkillChooseReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local data = AtomicModel.instance:getData()
	local talentMo = data:getTalentInfo()

	talentMo:updateEquipList(msg.skillNodeIds)
	AtomicTalentController.instance:notifyUpdateView()
end

function AtomicRpc:onReceiveAtomicTalentUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local data = AtomicModel.instance:getData()
	local talentMo = data:getTalentInfo()

	talentMo:updateInfo(msg.talentInfo)
	AtomicTalentController.instance:notifyUpdateView()
end

function AtomicRpc:onReceiveAtomicUnlockLibraryPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local data = AtomicModel.instance:getData()

	data:unlockLibraryList(msg.unlockLibraryIds)
	AtomicDataBaseController.instance:notifyUpdateView()
	AtomicDungeonModel.instance:setNewUnlockDataBaseList(msg.unlockLibraryIds)
end

function AtomicRpc:onReceiveAtomicUpdateAlarmPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:updateAlarmPush(msg)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnAlarmValueChange)
	AtomicDungeonController.instance:checkShowAlarmTipToastDirectly()
end

function AtomicRpc:sendAtomicMapSetCurrElementRequest(elementId, callback, callbackObj)
	local req = AtomicModule_pb.AtomicMapSetCurrElementRequest()

	req.eleId = elementId

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicMapSetCurrElementReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:setCurInElementId(msg.eleId)
end

function AtomicRpc:sendAtomicMapInteractRequest(elementId, optionParam, callback, callbackObj)
	local isFinish = AtomicDungeonModel.instance:isElementFinish(elementId)

	if isFinish then
		return
	end

	local req = AtomicModule_pb.AtomicMapInteractRequest()

	req.eleId = elementId

	if optionParam.optionId and optionParam.optionId > 0 then
		req.optionParam.optionId = optionParam.optionId
	end

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicMapInteractReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:updateElementInfo(msg.element)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnElementFinish, msg.element.id)
end

function AtomicRpc:onReceiveAtomicMapElementUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:addNewElement(msg.updates)
	AtomicDungeonModel.instance:setAllElementInfo(msg.updates)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnUpdateElementPush, true)
	AtomicDungeonController.instance:checkShowTipToastDirectly()
end

function AtomicRpc:onReceiveAtomicMapUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:setMapData(msg.maps, true)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnMapUpdate)
end

function AtomicRpc:onReceiveAtomicPolygonUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:updatePolygonInfo(msg.polygonInfo)
end

function AtomicRpc:onReceiveAtomicFightResultPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:setFightResultData(msg)
end

function AtomicRpc:sendAtomicMapSaveElementRequest(elementId, record, callback, callbackObj)
	local req = AtomicModule_pb.AtomicMapSaveElementRequest()

	req.eleId = elementId
	req.record = record

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicMapSaveElementReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.eleId

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonKeyElementPutFinish, elementId)
end

function AtomicRpc:sendAtomicUpdateEmergencyTimeRequest(elementIdList, addSeconds, callback, callbackObj)
	local req = AtomicModule_pb.AtomicUpdateEmergencyTimeRequest()

	for _, elementId in ipairs(elementIdList) do
		table.insert(req.eleIds, elementId)
	end

	req.incSeconds = addSeconds

	self:sendMsg(req, callback, callbackObj)
end

function AtomicRpc:onReceiveAtomicUpdateEmergencyTimeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AtomicDungeonModel.instance:cleanEmergencyAddSeconds(msg.eleIds)
end

AtomicRpc.instance = AtomicRpc.New()

return AtomicRpc
