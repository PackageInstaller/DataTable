-- chunkname: @modules/logic/equip/rpc/EquipRpc.lua

module("modules.logic.equip.rpc.EquipRpc", package.seeall)

local EquipRpc = class("EquipRpc", BaseRpc)

function EquipRpc:sendGetEquipInfoRequest(callback, callbackObj)
	local req = EquipModule_pb.GetEquipInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function EquipRpc:onReceiveGetEquipInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local equips = msg.equips

	EquipModel.instance:addEquips(equips)
end

function EquipRpc:onReceiveEquipUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local equips = msg.equips

	EquipModel.instance:addEquips(equips)
end

function EquipRpc:onReceiveEquipDeletePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local uids = msg.uids

	EquipModel.instance:removeEquips(uids)
end

function EquipRpc:sendEquipStrengthenRequest(targetUid, eatEquips)
	local req = EquipModule_pb.EquipStrengthenRequest()

	req.targetUid = targetUid

	local equipMO = EquipModel.instance:getEquip(targetUid)

	for i, v in ipairs(eatEquips) do
		local equip = EquipModule_pb.EatEquip()

		equip.eatUid = v[1]
		equip.count = v[2]

		table.insert(req.eatEquips, equip)
	end

	self:sendMsg(req)
end

function EquipRpc:onReceiveEquipStrengthenReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.EquipStrengthen)
	EquipController.instance:dispatchEvent(EquipEvent.onEquipStrengthenReply)
end

function EquipRpc:sendEquipBreakRequest(targetUid)
	local req = EquipModule_pb.EquipBreakRequest()

	req.targetUid = targetUid

	self:sendMsg(req)
end

function EquipRpc:onReceiveEquipBreakReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onBreakSuccess)
end

function EquipRpc:sendEquipLockRequest(targetUid, lock)
	local equipMo = EquipModel.instance:getEquip(tostring(targetUid))

	if not equipMo or EquipHelper.isSpRefineEquip(equipMo.config) then
		return
	end

	local req = EquipModule_pb.EquipLockRequest()

	req.targetUid = targetUid
	req.lock = lock

	self:sendMsg(req)
end

function EquipRpc:onReceiveEquipLockReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local targetUid = msg.targetUid
	local lock = msg.lock

	EquipController.instance:dispatchEvent(EquipEvent.onEquipLockChange, {
		uid = targetUid,
		isLock = lock
	})

	if lock then
		GameFacade.showToast(ToastEnum.EquipLock)
	else
		GameFacade.showToast(ToastEnum.EquipUnLock)
	end
end

function EquipRpc:sendEquipDecomposeRequest()
	local req = EquipModule_pb.EquipDecomposeRequest()

	for uid, _ in pairs(EquipDecomposeListModel.instance.selectedEquipDict) do
		table.insert(req.equipUids, uid)
	end

	self:sendMsg(req)
end

function EquipRpc:onReceiveEquipDecomposeReply(resultCode, msg)
	if resultCode == 0 then
		EquipController.instance:dispatchEvent(EquipEvent.onDecomposeSuccess)
	end
end

function EquipRpc:sendEquipRefineRequest(targetUid, eatUids)
	local req = EquipModule_pb.EquipRefineRequest()

	req.targetUid = targetUid

	for i, v in ipairs(eatUids) do
		table.insert(req.eatUids, v)
	end

	self:sendMsg(req)
end

function EquipRpc:onReceiveEquipRefineReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onEquipRefineReply)
end

EquipRpc.instance = EquipRpc.New()

return EquipRpc
