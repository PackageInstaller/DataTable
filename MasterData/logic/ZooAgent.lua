-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/agent/ZooAgent.lua

module("logic.extensions.zoo.agent.ZooAgent", package.seeall)

local ZooAgent = class("ZooAgent", BaseAgent)

function ZooAgent:sendPM_ZooGetAllInfoReq()
	local req = ZooExtension_pb.PM_ZooGetAllInfoReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetAllInfoRes(status, msg)
	if status == 0 then
		ZooController.instance:onGetMyZooAllInfo(msg)
	end
end

function ZooAgent:sendPM_ZooHatchUseSpeedUpCardReq(slotId, cardId)
	local req = ZooExtension_pb.PM_ZooHatchUseSpeedUpCardReq()

	req.slotId = slotId
	req.cardId = cardId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooHatchUseSpeedUpCardRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooHatchUseSpeedUpCard(msg)
	end
end

function ZooAgent:sendPM_PutEggIntoSlotReq(slotId, eggId)
	local req = ZooExtension_pb.PM_PutEggIntoSlotReq()

	req.slotId = slotId
	req.eggId = eggId

	self:sendMsg(req)
end

function ZooAgent:handlePM_PutEggIntoSlotRes(status, msg)
	if status == 0 then
		ZooController.instance:onPutEggIntoSlot(msg)
	end
end

function ZooAgent:sendPM_TakeAnimalOutFromSlotReq(slotId, animalName)
	local req = ZooExtension_pb.PM_TakeAnimalOutFromSlotReq()

	req.slotId = slotId
	req.animalName = animalName

	self:sendMsg(req)
end

function ZooAgent:handlePM_TakeAnimalOutFromSlotRes(status, msg)
	if status == 0 then
		ZooController.instance:onTakeAnimalOutFromSlot(msg)
	end
end

function ZooAgent:sendPM_ClearAllInZooStateReq()
	local req = ZooExtension_pb.PM_ClearAllInZooStateReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ClearAllInZooStateRes(status, msg)
	if status == 0 then
		ZooController.instance:onClearAllInZooState(msg)
	end
end

function ZooAgent:sendPM_AnimalSetFollowStateReq(animalId, isFollow)
	local req = ZooExtension_pb.PM_AnimalSetFollowStateReq()

	req.animalId = animalId
	req.isFollow = isFollow

	self:sendMsg(req)
end

function ZooAgent:handlePM_AnimalSetFollowStateRes(status, msg)
	if status == 0 then
		ZooController.instance:onAnimalSetFollowState(msg)
	end
end

function ZooAgent:sendPM_AnimalSetInZooStateReq(animalId, isInZoo)
	local req = ZooExtension_pb.PM_AnimalSetInZooStateReq()

	req.animalId = animalId
	req.isInZoo = isInZoo

	self:sendMsg(req)
end

function ZooAgent:handlePM_AnimalSetInZooStateRes(status, msg)
	if status == 0 then
		ZooController.instance:onAnimalSetInZooState(msg)
	end
end

function ZooAgent:sendPM_GetZooAnimalInfoReq()
	local req = ZooExtension_pb.PM_GetZooAnimalInfoReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_GetZooAnimalInfoRes(status, msg)
	if status == 0 then
		ZooController.instance:onGetMyAnimals(msg)
	end
end

function ZooAgent:sendPM_ZooSetAnimalNameReq(animalId, name)
	local req = ZooExtension_pb.PM_ZooSetAnimalNameReq()

	req.animalId = animalId
	req.name = name

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooSetAnimalNameRes(status, msg)
	ZooController.instance:onZooSetAnimalName(status, msg)
end

function ZooAgent:sendPM_ZooRecycleAnimalReq(animalId)
	local req = ZooExtension_pb.PM_ZooRecycleAnimalReq()

	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooRecycleAnimalRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooRecycleAnimal(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyGainEggRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooNotifyGainEgg(msg)
	end
end

function ZooAgent:sendPM_ZooFeedAnimalReq(animalId)
	local req = ZooExtension_pb.PM_ZooFeedAnimalReq()

	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooFeedAnimalRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooFeedAnimal(msg)
	end
end

function ZooAgent:sendPM_ZooShareAnimalReq(animalId)
	local req = ZooExtension_pb.PM_ZooShareAnimalReq()

	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooShareAnimalRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ZooAgent:sendPM_ZooShowSharedAnimalReq(otherUserId, animalId)
	local req = ZooExtension_pb.PM_ZooShowSharedAnimalReq()

	req.otherUserId = otherUserId
	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooShowSharedAnimalRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooShowSharedAnimal(msg)
	end
end

function ZooAgent:sendPM_ZooGetFaceGeneManualReq()
	local req = ZooExtension_pb.PM_ZooGetFaceGeneManualReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetFaceGeneManualRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnZooGetFaceGeneManual, msg)
	end
end

function ZooAgent:sendPM_ZooHandleLostAnimalReq(animalId, handleType)
	local req = ZooExtension_pb.PM_ZooHandleLostAnimalReq()

	req.animalId = animalId
	req.handleType = handleType

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooHandleLostAnimalRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooHandleLostAnimal(msg)
	end
end

function ZooAgent:sendPM_ZooGetEggFromTravelManReq()
	local req = ZooExtension_pb.PM_ZooGetEggFromTravelManReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetEggFromTravelManRes(status, msg)
	if status == 0 then
		ZooController.instance:onGetEggFromTravelMan(msg)
	end
end

function ZooAgent:sendPM_ZooCancelHatchEggReq(slotId)
	local req = ZooExtension_pb.PM_ZooCancelHatchEggReq()

	req.slotId = slotId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooCancelHatchEggRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooCancelHatchEgg(msg)
	end
end

function ZooAgent:sendPM_ZooInviteBuddyMatchReq(buddyId, animalId)
	local req = ZooExtension_pb.PM_ZooInviteBuddyMatchReq()

	req.buddyId = buddyId
	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooInviteBuddyMatchRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooInviteBuddyMatch(msg)
	end
end

function ZooAgent:sendPM_ZooCancelBuddyMatchReq()
	local req = ZooExtension_pb.PM_ZooCancelBuddyMatchReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooCancelBuddyMatchRes(status, msg)
	ZooMatchController.instance:onZooCancelBuddyMatch(status, msg)
end

function ZooAgent:sendPM_ZooHandleBuddyMatchRequestReq(buddyId, accept)
	local req = ZooExtension_pb.PM_ZooHandleBuddyMatchRequestReq()

	req.buddyId = buddyId
	req.accept = accept

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooHandleBuddyMatchRequestRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooHandleBuddyMatchRequestRes(msg)
	end
end

function ZooAgent:sendPM_ZooPutBuddyMatchAnimalReq(animalId)
	local req = ZooExtension_pb.PM_ZooPutBuddyMatchAnimalReq()

	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooPutBuddyMatchAnimalRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooPutBuddyMatchAnimalRes(msg)
	end
end

function ZooAgent:sendPM_ZooConfirmBuddyMatchReq()
	local req = ZooExtension_pb.PM_ZooConfirmBuddyMatchReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooConfirmBuddyMatchRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooConfirmBuddyMatchRes(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchInviteRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchInvite(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchAccpetRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchAccpet(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchRejectRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchReject(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchCancelRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchCancel(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchReadyRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchReady(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBuddyMatchFinishRes(status, msg)
	if status == 0 then
		ZooMatchController.instance:onZooNotifyBuddyMatchFinish(msg)
	end
end

function ZooAgent:sendPM_ZooGetOtherZooReq(buddyId)
	local req = ZooExtension_pb.PM_ZooGetOtherZooReq()

	req.buddyId = buddyId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetOtherZooRes(status, msg)
	if status == 0 then
		ZooController.instance:onFriendZooInfo(msg)
	end
end

function ZooAgent:sendPM_ZooStealFruitReq(buddyId)
	local req = ZooExtension_pb.PM_ZooStealFruitReq()

	req.buddyId = buddyId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooStealFruitRes(status, msg)
	if status == 0 then
		ZooController.instance:onStealFruit(msg)
	end
end

function ZooAgent:sendPM_ZooGainFruitReq()
	local req = ZooExtension_pb.PM_ZooGainFruitReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGainFruitRes(status, msg)
	if status == 0 then
		ZooController.instance:onGainFriuts(msg)
	end
end

function ZooAgent:sendPM_ZooDigTreasureReq()
	local req = ZooExtension_pb.PM_ZooDigTreasureReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooDigTreasureRes(status, msg)
	if status == 0 then
		ZooController.instance:onDigTreasure(msg)
	end
end

function ZooAgent:sendPM_ZooFeedBuddyAnimalReq()
	local req = ZooExtension_pb.PM_ZooFeedBuddyAnimalReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooFeedBuddyAnimalRes(status, msg)
	if status == 0 then
		ZooController.instance:onFeedBuddyAnimal(msg)
	end
end

function ZooAgent:sendPM_ZooGetInteractionLogReq()
	local req = ZooExtension_pb.PM_ZooGetInteractionLogReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetInteractionLogRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnZooGetInteractionLog, msg)
	end
end

function ZooAgent:sendPM_ZooSetAbsorbDeviceReq(buddyId)
	local req = ZooExtension_pb.PM_ZooSetAbsorbDeviceReq()

	req.buddyId = buddyId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooSetAbsorbDeviceRes(status, msg)
	if status == 0 then
		ZooController.instance:onSetAbsorbDevice(msg)
	end
end

function ZooAgent:sendPM_ZooUninstallAbsorbDeviceReq()
	local req = ZooExtension_pb.PM_ZooUninstallAbsorbDeviceReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUninstallAbsorbDeviceRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooUninstallAbsorbDevice(msg)
	end
end

function ZooAgent:sendPM_ZooGainAbsorbDevicePrizeReq()
	local req = ZooExtension_pb.PM_ZooGainAbsorbDevicePrizeReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGainAbsorbDevicePrizeRes(status, msg)
	if status == 0 then
		ZooController.instance:onGainAbsorbDevicePrize(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyInstallAbsorbDeviceRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooNotifyInstallAbsorbDevice(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyUnistallAbsorbDeviceRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooNotifyUnistallAbsorbDevice(msg)
	end
end

function ZooAgent:sendPM_ZooGetBuddyAbsorbStateReq()
	local req = ZooExtension_pb.PM_ZooGetBuddyAbsorbStateReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGetBuddyAbsorbStateRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooFriendAbsorbStates, status, msg)
end

function ZooAgent:sendPM_ZooUnlockBuildingReq(buildingId)
	local req = ZooExtension_pb.PM_ZooUnlockBuildingReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUnlockBuildingRes(status, msg)
	if status == 0 then
		ZooController.instance:onBuildingUnlock()
	end
end

function ZooAgent:sendPM_ZooUpgradeMainBuildingReq()
	local req = ZooExtension_pb.PM_ZooUpgradeMainBuildingReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUpgradeMainBuildingRes(status, msg)
	if status == 0 then
		ZooController.instance:onBuildingLevelup(ZooBuildingType.Main)
	end
end

function ZooAgent:sendPM_ZooUpgradeResourceTreeReq()
	local req = ZooExtension_pb.PM_ZooUpgradeResourceTreeReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUpgradeResourceTreeRes(status, msg)
	if status == 0 then
		ZooController.instance:onBuildingTreeLevelup(msg)
	end
end

function ZooAgent:sendPM_ZooUpgradeWorkBuildingReq(buildingId)
	local req = ZooExtension_pb.PM_ZooUpgradeWorkBuildingReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUpgradeWorkBuildingRes(status, msg)
	if status == 0 then
		ZooController.instance:onWorkBuildingLevelup(msg.building)
	end
end

function ZooAgent:sendPM_ZooUpgradeExchangeShopReq()
	local req = ZooExtension_pb.PM_ZooUpgradeExchangeShopReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooUpgradeExchangeShopRes(status, msg)
	if status == 0 then
		ZooController.instance:onBuildingLevelup(ZooBuildingType.Shop)
	end
end

function ZooAgent:sendPM_ZooInZooAnimalInteractReq(animalId)
	local req = ZooExtension_pb.PM_ZooInZooAnimalInteractReq()

	req.animalId = animalId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooInZooAnimalInteractRes(status, msg)
	if status == 0 then
		ZooController.instance:onInZooAnimalInteract()
	end
end

function ZooAgent:sendPM_ZooPutAnimalToWorkReq(buildingId, slotId, animalId)
	local req = ZooExtension_pb.PM_ZooPutAnimalToWorkReq()

	req.buildingId = buildingId
	req.animalId = animalId
	req.slotId = slotId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooPutAnimalToWorkRes(status, msg)
	if status == 0 then
		local building = msg.building

		ZooController.instance:onPutAnimalToWork(building)
	end
end

function ZooAgent:sendPM_ZooGainWorkBuildingProductionReq(buildingId)
	local req = ZooExtension_pb.PM_ZooGainWorkBuildingProductionReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGainWorkBuildingProductionRes(status, msg)
	if status == 0 then
		ZooController.instance:onGainWorkBuildingProduction(msg)
	end
end

function ZooAgent:handlePM_ZooNotifyBeStolenFruitRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooNotifyBeStolenFruit(msg)
	end
end

function ZooAgent:sendPM_ZooGainBuildingProductionReq()
	local req = ZooExtension_pb.PM_ZooGainBuildingProductionReq()

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooGainBuildingProductionRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooGainBuildingsProduction(msg)
	end
end

function ZooAgent:sendPM_ZooExchangeItemReq(itemId)
	local req = ZooExtension_pb.PM_ZooExchangeItemReq()

	req.itemId = itemId

	self:sendMsg(req)
end

function ZooAgent:handlePM_ZooExchangeItemRes(status, msg)
	if status == 0 then
		ZooController.instance:onZooExchangeItem(msg)
	end
end

ZooAgent.instance = ZooAgent.New()

return ZooAgent
