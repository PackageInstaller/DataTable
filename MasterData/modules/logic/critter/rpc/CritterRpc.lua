-- chunkname: @modules/logic/critter/rpc/CritterRpc.lua

module("modules.logic.critter.rpc.CritterRpc", package.seeall)

local CritterRpc = class("CritterRpc", BaseRpc)

function CritterRpc:sendCritterGetInfoRequest(callback, callbackObj)
	local req = CritterModule_pb.CritterGetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveCritterGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:critterGetInfoReply(msg)
	end
end

function CritterRpc:onReceiveCritterInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CritterController.instance:critterInfoPush(msg)

	local dict = {}

	for _, critterInfo in ipairs(msg.critterInfos) do
		dict[critterInfo.uid] = true
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterInfoPushUpdate, dict)
end

function CritterRpc:sendStartTrainCritterRequest(uid, heroId, guideId, step, callback, callbackObj)
	local req = CritterModule_pb.StartTrainCritterRequest()

	req.uid = uid
	req.heroId = heroId
	req.guideId = guideId or 0
	req.step = step or 0

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveStartTrainCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:startTrainCritterReply(msg)
		ManufactureController.instance:removeRestingCritter(msg.uid)
	end
end

function CritterRpc:sendCancelTrainRequest(uid, callback, callbackObj)
	local req = CritterModule_pb.CancelTrainRequest()

	req.uid = uid

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveCancelTrainReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:cancelTrainReply(msg)
	end
end

function CritterRpc:sendSelectEventOptionRequest(uid, eventId, optionId, callback, callbackObj)
	local req = CritterModule_pb.SelectEventOptionRequest()

	req.uid = uid
	req.eventId = eventId
	req.optionId = optionId

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveSelectEventOptionReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:selectEventOptionReply(msg)
	end
end

function CritterRpc:sendSelectMultiEventOptionRequest(uid, eventId, optionInfos, callback, callbackObj)
	local req = CritterModule_pb.SelectMultiEventOptionRequest()

	req.uid = uid
	req.eventId = eventId

	for _, info in ipairs(optionInfos) do
		local reqInfo = CritterModule_pb.EventOptionInfo()

		reqInfo.optionId = info.optionId
		reqInfo.count = info.count

		table.insert(req.infos, reqInfo)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveSelectMultiEventOptionReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CritterRpc:sendFastForwardTrainRequest(uid, itemId, count, callback, callbackObj)
	local req = CritterModule_pb.FastForwardTrainRequest()

	req.uid = uid
	req.itemId = itemId
	req.count = count or 1

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveFastForwardTrainReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:fastForwardTrainReply(msg)
	end
end

function CritterRpc:sendFinishTrainCritterRequest(uid, callback, callbackObj)
	local req = CritterModule_pb.FinishTrainCritterRequest()

	req.uid = uid

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveFinishTrainCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:finishTrainCritterReply(msg)
	end
end

function CritterRpc:sendBanishCritterRequest(uids, callback, callbackObj)
	local req = CritterModule_pb.BanishCritterRequest()

	for _, uid in ipairs(uids) do
		table.insert(req.uids, uid)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveBanishCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:banishCritterReply(msg)
	end
end

function CritterRpc:sendLockCritterRequest(uid, lock, callback, callbackObj)
	local req = CritterModule_pb.LockCritterRequest()

	req.uid = uid
	req.lock = lock == true

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveLockCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:lockCritterRequest(msg)
	end
end

function CritterRpc:sendIncubateCritterRequest(parent1, parent2, callback, callbackObj)
	local req = CritterModule_pb.IncubateCritterRequest()

	req.parent1 = parent1
	req.parent2 = parent2

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveIncubateCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterIncubateController.instance:incubateCritterReply(msg)
	end
end

function CritterRpc:sendIncubateCritterPreviewRequest(parent1, parent2, callback, callbackObj)
	local req = CritterModule_pb.IncubateCritterPreviewRequest()

	req.parent1 = parent1
	req.parent2 = parent2

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveIncubateCritterPreviewReply(resultCode, msg)
	if resultCode == 0 then
		CritterIncubateController.instance:onIncubateCritterPreviewReply(msg)
	end
end

function CritterRpc:sendSummonCritterInfoRequest(callback, callbackObj)
	local req = CritterModule_pb.SummonCritterInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveSummonCritterInfoReply(resultCode, msg)
	if resultCode == 0 then
		CritterSummonController.instance:summonCritterInfoReply(msg)
	end
end

function CritterRpc:sendSummonCritterRequest(poolId, count, callback, callbackObj)
	local req = CritterModule_pb.SummonCritterRequest()

	req.poolId = poolId
	req.count = count

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveSummonCritterReply(resultCode, msg)
	if resultCode == 0 then
		CritterSummonController.instance:summonCritterReply(msg)
	end
end

function CritterRpc:sendResetSummonCritterPoolRequest(poolId, callback, callbackObj)
	local req = CritterModule_pb.ResetSummonCritterPoolRequest()

	req.poolId = poolId

	return self:sendMsg(req, callback, callbackObj)
end

function CritterRpc:onReceiveResetSummonCritterPoolReply(resultCode, msg)
	if resultCode == 0 then
		CritterSummonController.instance:resetSummonCritterPoolReply(msg)
	end
end

function CritterRpc:sendGainGuideCritterRequest(guideId, step)
	local req = CritterModule_pb.GainGuideCritterRequest()

	req.guideId = guideId
	req.step = step

	self:sendMsg(req)
end

function CritterRpc:onReceiveGainGuideCritterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterGuideReply, msg)
end

function CritterRpc:sendGetCritterBookInfoRequest()
	local req = CritterModule_pb.GetCritterBookInfoRequest()

	self:sendMsg(req)
end

function CritterRpc:onReceiveGetCritterBookInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomHandBookModel.instance:onGetInfo(msg)
end

function CritterRpc:sendSetCritterBookBackgroundRequest(critterId, backgroundId)
	local req = CritterModule_pb.SetCritterBookBackgroundRequest()

	req.id = critterId
	req.Background = backgroundId

	self:sendMsg(req)
end

function CritterRpc:onReceiveSetCritterBookBackgroundReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomHandBookModel.instance:setBackGroundId({
		id = msg.id,
		backgroundId = msg.Background
	})
	RoomStatController.instance:critterBookBgSwitch(msg.id, msg.Background)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function CritterRpc:sendSetCritterBookUseSpecialSkinRequest(critterId, useSpecialSkin)
	local req = CritterModule_pb.SetCritterBookUseSpecialSkinRequest()

	req.id = critterId
	req.UseSpecialSkin = useSpecialSkin

	self:sendMsg(req)
end

function CritterRpc:onReceiveSetCritterBookUseSpecialSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomHandBookListModel.instance:setMutate(msg)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.showMutate, msg)
end

function CritterRpc:sendMarkCritterBookNewReadRequest(critterId)
	local req = CritterModule_pb.MarkCritterBookNewReadRequest()

	req.id = critterId

	self:sendMsg(req)
end

function CritterRpc:onReceiveMarkCritterBookNewReadReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomHandBookListModel.instance:clearItemNewState(msg.id)
end

function CritterRpc:sendGetRealCritterAttributeRequest(buildingId, critterUidList, isPreview, cb, cbObj)
	local req = CritterModule_pb.GetRealCritterAttributeRequest()

	req.buildingId = buildingId
	req.isPreview = isPreview

	for _, uid in ipairs(critterUidList) do
		table.insert(req.critterUids, uid)
	end

	self:sendMsg(req, cb, cbObj)
end

function CritterRpc:onReceiveGetRealCritterAttributeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureCritterListModel.instance:setAttrPreview(msg.attributeInfos, msg.buildingId, msg.isPreview)

	local dict = {}

	for _, attrInfo in ipairs(msg.attributeInfos) do
		dict[attrInfo.critterUid] = true
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, dict)
end

function CritterRpc:onReceiveRealCritterAttributePush(resultCode, msg)
	if resultCode == 0 then
		ManufactureCritterListModel.instance:setAttrPreview(msg.attributeInfos, msg.buildingId, msg.isPreview)

		local dict = {}

		for _, attrInfo in ipairs(msg.attributeInfos) do
			dict[attrInfo.critterUid] = true
		end

		CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, dict)
	end
end

function CritterRpc:sendStartTrainCritterPreviewRequest(critterUid, heroId, cb, cbObj)
	local req = CritterModule_pb.StartTrainCritterPreviewRequest()

	req.uid = critterUid
	req.heroId = heroId

	self:sendMsg(req, cb, cbObj)
end

function CritterRpc:onReceiveStartTrainCritterPreviewReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:startTrainCritterPreviewReply(msg)
	end
end

function CritterRpc:sendCritterRenameRequest(critterUid, name, cb, cbObj)
	local req = CritterModule_pb.CritterRenameRequest()

	req.uid = critterUid
	req.name = name

	self:sendMsg(req, cb, cbObj)
end

function CritterRpc:onReceiveCritterRenameReply(resultCode, msg)
	if resultCode == 0 then
		CritterController.instance:critterRenameReply(msg)
	end
end

CritterRpc.instance = CritterRpc.New()

return CritterRpc
