-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/agent/CutePetGardenAgent.lua

module("logic.extensions.cutepetgarden.agent.CutePetGardenAgent", package.seeall)

local CutePetGardenAgent = class("CutePetGardenAgent", BaseAgent)

function CutePetGardenAgent:sendPM_EnterGameLoadInfoReq()
	local req = CutePetGardenExtension_pb.PM_EnterGameLoadInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_EnterGameLoadInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_EnterGameLoadInfoResp(status, msg)
	end
end

function CutePetGardenAgent:sendPM_OpenGardenLoadInfoReq()
	local req = CutePetGardenExtension_pb.PM_OpenGardenLoadInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_OpenGardenLoadInfoResp(status, msg)
	if status == 0 then
		-- block empty
	end

	CutePetController.instance:_handlePM_OpenGardenLoadInfoResp(status, msg)
end

function CutePetGardenAgent:sendPM_LoadCutePetInteractInfoReq()
	local req = CutePetGardenExtension_pb.PM_LoadCutePetInteractInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadCutePetInteractInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadCutePetInteractInfoResp(msg)
	end
end

function CutePetGardenAgent:sendPM_HappinessInteractReq(costType, num)
	local req = CutePetGardenExtension_pb.PM_HappinessInteractReq()

	req.costType = costType
	req.num = num

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_HappinessInteractResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_HappinessInteractResp(msg)
	end
end

function CutePetGardenAgent:sendPM_GainHappinessInteractPrizeReq()
	local req = CutePetGardenExtension_pb.PM_GainHappinessInteractPrizeReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_GainHappinessInteractPrizeResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_GainHappinessInteractPrizeResp(msg)
	end
end

function CutePetGardenAgent:sendPM_OpenGuestHouseLoadInfoReq()
	local req = CutePetGardenExtension_pb.PM_OpenGuestHouseLoadInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_OpenGuestHouseLoadInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_OpenGuestHouseLoadInfoResp(msg)
	end
end

function CutePetGardenAgent:sendPM_ViewGuestHouseSlotCutePetReq(slotId)
	local req = CutePetGardenExtension_pb.PM_ViewGuestHouseSlotCutePetReq()

	req.slotId = slotId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_ViewGuestHouseSlotCutePetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_ViewGuestHouseSlotCutePetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_GainOrFreeGuestHouseSlotCutePetReq(slotId, gain, newName)
	local req = CutePetGardenExtension_pb.PM_GainOrFreeGuestHouseSlotCutePetReq()

	req.slotId = slotId
	req.gain = gain

	if not string.nilorempty(newName) then
		req.newName = newName
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_GainOrFreeGuestHouseSlotCutePetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_GainOrFreeGuestHouseSlotCutePetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_BatchGainGuestHouseSlotCutePetReq(slotIds)
	local req = CutePetGardenExtension_pb.PM_BatchGainGuestHouseSlotCutePetReq()

	for i, v in ipairs(slotIds) do
		req.slotId:append(v)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_BatchGainGuestHouseSlotCutePetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_GainOrFreeGuestHouseSlotCutePetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_SpeedUpGuestHouseSlotReq(costType, num)
	local req = CutePetGardenExtension_pb.PM_SpeedUpGuestHouseSlotReq()

	req.costType = costType
	req.num = num

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SpeedUpGuestHouseSlotResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_SpeedUpGuestHouseSlotResp(msg)
	end
end

function CutePetGardenAgent:sendPM_LoadAdventureBuildingInfoReq()
	local req = CutePetGardenExtension_pb.PM_LoadAdventureBuildingInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadAdventureBuildingInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadAdventureBuildingInfoResp(msg)
	end
end

function CutePetGardenAgent:sendPM_LvlUpAdventureBuildingReq(buildingId)
	local req = CutePetGardenExtension_pb.PM_LvlUpAdventureBuildingReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LvlUpAdventureBuildingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LvlUpAdventureBuildingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_PutCutePet2AdventureBuildingReq(buildingId, cutePetId)
	local req = CutePetGardenExtension_pb.PM_PutCutePet2AdventureBuildingReq()

	req.buildingId = buildingId
	req.cutePetId = cutePetId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_PutCutePet2AdventureBuildingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_PutCutePet2AdventureBuildingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_TakeBackCutePetFromAdventureBuildingReq(buildingId)
	local req = CutePetGardenExtension_pb.PM_TakeBackCutePetFromAdventureBuildingReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_TakeBackCutePetFromAdventureBuildingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_TakeBackCutePetFromAdventureBuildingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_GainSingleBuildingOutputRespReq(buildingId)
	local req = CutePetGardenExtension_pb.PM_GainSingleBuildingOutputResReq()

	req.buildingId = buildingId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_GainSingleBuildingOutputResResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_GainSingleBuildingOutputResResp(msg)
	end
end

function CutePetGardenAgent:sendPM_GainAllBuildingOutputResReq()
	local req = CutePetGardenExtension_pb.PM_GainAllBuildingOutputResReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_GainAllBuildingOutputResResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_GainAllBuildingOutputResResp(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainAllBuildingOutputResResp, status, msg)
	end
end

function CutePetGardenAgent:sendPM_LoadCutePetCommunityNewsReq()
	local req = CutePetGardenExtension_pb.PM_LoadCutePetCommunityNewsReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadCutePetCommunityNewsResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadCutePetCommunityNewsResp(msg)
	end
end

function CutePetGardenAgent:sendPM_PublishCommunityNewsReq(cutePetId, travelCountNeeds, cutePetTypeNeeds)
	local req = CutePetGardenExtension_pb.PM_PublishCommunityNewsReq()

	req.cutePetId = cutePetId
	req.travelCountNeeds = travelCountNeeds
	req.cutePetTypeNeeds = cutePetTypeNeeds

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_PublishCommunityNewsResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_PublishCommunityNewsResp(msg)
	end
end

function CutePetGardenAgent:sendPM_LoadTravelInfoReq()
	local req = CutePetGardenExtension_pb.PM_LoadTravelInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadTravelInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadTravelInfoResp(msg)
	end
end

function CutePetGardenAgent:sendPM_LoadBuddyTravelInfoReq(buddyIds)
	local req = CutePetGardenExtension_pb.PM_LoadBuddyTravelInfoReq()

	for i, v in ipairs(buddyIds) do
		req.buddyId:append(v)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadBuddyTravelInfoResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadBuddyTravelInfoResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelMySelfPairingReq(cutePetId)
	local req = CutePetGardenExtension_pb.PM_CutePetTravelMySelfPairingReq()

	for i, v in ipairs(cutePetId) do
		req.cutePetId:append(v)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelMySelfPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelMySelfPairingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelInviteBuddyPairingReq(cutePetId, buddyUserId)
	local req = CutePetGardenExtension_pb.PM_CutePetTravelInviteBuddyPairingReq()

	req.cutePetId = cutePetId
	req.buddyUserId = buddyUserId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelInviteBuddyPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelInviteBuddyPairingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelCancelBuddyPairingReq()
	local req = CutePetGardenExtension_pb.PM_CutePetTravelCancelBuddyPairingReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelCancelBuddyPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelCancelBuddyPairingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelReceiverHandleInviteMsgReq(pairingToken, accept)
	local req = CutePetGardenExtension_pb.PM_CutePetTravelReceiverHandleInviteMsgReq()

	req.pairingToken = pairingToken
	req.accept = accept

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelReceiverHandleInviteMsgResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelReceiverHandleInviteMsgResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelReceiverPutPairingCutePetReq(pairingToken, cutePetId)
	local req = CutePetGardenExtension_pb.PM_CutePetTravelReceiverPutPairingCutePetReq()

	req.pairingToken = pairingToken
	req.cutePetId = cutePetId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelReceiverPutPairingCutePetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelReceiverPutPairingCutePetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelInviterConfirmPairingReq(pairingToken)
	local req = CutePetGardenExtension_pb.PM_CutePetTravelInviterConfirmPairingReq()

	req.pairingToken = pairingToken

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelInviterConfirmPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelInviterConfirmPairingResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyReceiverHasReadyResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyReceiverHasReadyResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyCancelPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyCancelPairingResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyInviterConfirmPairingResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyInviterConfirmPairingResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetLvlUpReq(cutePetId, times)
	local req = CutePetGardenExtension_pb.PM_CutePetLvlUpReq()

	req.cutePetId = cutePetId
	req.times = times

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetLvlUpResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetLvlUpResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetStarUpReq(cutePetId, usingCutePetIds)
	local req = CutePetGardenExtension_pb.PM_CutePetStarUpReq()

	req.cutePetId = cutePetId

	for i, v in ipairs(usingCutePetIds) do
		req.usingCutePetIds:append(v)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetStarUpResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetStarUpResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetQualityUpReq(cutePetId)
	local req = CutePetGardenExtension_pb.PM_CutePetQualityUpReq()

	req.cutePetId = cutePetId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetQualityUpResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetQualityUpResp(msg)
	end
end

function CutePetGardenAgent:sendPM_StrengthInitialPropReq(cutePetId, times)
	local req = CutePetGardenExtension_pb.PM_StrengthInitialPropReq()

	req.cutePetId = cutePetId
	req.times = times

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_StrengthInitialPropResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_StrengthInitialPropResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetEquipOnPetReq(cutePetId, petId)
	local req = CutePetGardenExtension_pb.PM_CutePetEquipOnPetReq()

	req.cutePetId = cutePetId
	req.petId = petId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetEquipOnPetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetEquipOnPetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetUnloadFromPetReq(petId)
	local req = CutePetGardenExtension_pb.PM_CutePetUnloadFromPetReq()

	req.petId = petId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetUnloadFromPetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetUnloadFromPetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetRenameReq(cutePetId, newName)
	local req = CutePetGardenExtension_pb.PM_CutePetRenameReq()

	req.cutePetId = cutePetId
	req.newName = newName

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetRenameResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetRenameResp(msg)
	end
end

function CutePetGardenAgent:sendPM_ReleaseCutePetReq(cutePetIds)
	local req = CutePetGardenExtension_pb.PM_ReleaseCutePetReq()

	for i, v in ipairs(cutePetIds) do
		req.cutePetId:append(v)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_ReleaseCutePetResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_ReleaseCutePetResp(msg)
	end
end

function CutePetGardenAgent:sendPM_SetCutePetFollowStateReq(cutePetId, isFollow)
	local req = CutePetGardenExtension_pb.PM_SetCutePetFollowStateReq()

	req.cutePetId = cutePetId
	req.isFollow = isFollow

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SetCutePetFollowStateResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_SetCutePetFollowStateResp(msg)
	end
end

function CutePetGardenAgent:sendPM_SetCutePetGardenShowStateReq(cutePetId, isShow)
	local req = CutePetGardenExtension_pb.PM_SetCutePetGardenShowStateReq()

	req.cutePetId = cutePetId
	req.isShow = isShow

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SetCutePetGardenShowStateResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_SetCutePetGardenShowStateResp(msg)
	end
end

function CutePetGardenAgent:sendPM_SetCutePetLockStateReq(cutePetId, isLock)
	local req = CutePetGardenExtension_pb.PM_SetCutePetLockStateReq()

	req.cutePetId = cutePetId
	req.isLock = isLock

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SetCutePetLockStateResp(status, msg)
	CutePetController.instance:_handlePM_SetCutePetLockStateResp(status, msg)
end

function CutePetGardenAgent:sendPM_CutePetChangeReadyToDiscardReq(setIds, unSetIds)
	local req = CutePetGardenExtension_pb.PM_CutePetChangeReadyToDiscardReq()

	for _, id in ipairs(setIds or {}) do
		req.setIds:append(id)
	end

	for _, id in ipairs(unSetIds or {}) do
		req.unSetIds:append(id)
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetChangeReadyToDiscardRes(status, msg)
	CutePetController.instance:_handlePM_CutePetChangeReadyToDiscardRes(status, msg)
end

function CutePetGardenAgent:sendPM_LoadEverGainedCutePetRaceReq()
	local req = CutePetGardenExtension_pb.PM_LoadEverGainedCutePetRaceReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LoadEverGainedCutePetRaceResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LoadEverGainedCutePetRaceResp(msg)
	end
end

function CutePetGardenAgent:sendPM_SetMyCurIllusionCutePetRaceReq(race)
	local req = CutePetGardenExtension_pb.PM_SetMyCurIllusionCutePetRaceReq()

	req.race = race

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SetMyCurIllusionCutePetRaceResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_SetMyCurIllusionCutePetRaceResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyCutePetChangedResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyCutePetChangedResp(msg)
	end
end

function CutePetGardenAgent:sendPM_LvlUpGardenReq()
	local req = CutePetGardenExtension_pb.PM_LvlUpGardenReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_LvlUpGardenResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_LvlUpGardenResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyReceiveNewInvitePairingMsgResp(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_NotifyReceiveNewInvitePairingMsgResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyReceiverRespInviteMsgResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyReceiverRespInviteMsgResp(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyCutePetIllusionChangedResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_NotifyCutePetIllusionChangedResp(msg)
	end
end

function CutePetGardenAgent:sendPM_UnLockIllusionCutePetRaceReq(raceId)
	local req = CutePetGardenExtension_pb.PM_UnLockIllusionCutePetRaceReq()

	req.race = raceId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_UnLockIllusionCutePetRaceResp(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_UnLockIllusionCutePetRaceResp(msg)
	end
end

function CutePetGardenAgent:sendPM_CutePetTravelInfoReq()
	local req = CutePetGardenExtension_pb.PM_CutePetTravelInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_CutePetTravelInfoRes(status, msg)
	if status == 0 then
		CutePetController.instance:_handlePM_CutePetTravelInfoRes(msg)
	end
end

function CutePetGardenAgent:sendPM_PresetCutePetInfoReq()
	local req = CutePetGardenExtension_pb.PM_PresetCutePetInfoReq()

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_PresetCutePetInfoRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_PresetCutePetInfoRes(msg)
	end
end

function CutePetGardenAgent:sendPM_AddPresetCuteReq(PresetCutePet_pb)
	local req = CutePetGardenExtension_pb.PM_AddPresetCuteReq()

	if PresetCutePet_pb ~= nil then
		req.PresetCutePet:ParseFromString(PresetCutePet_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_AddPresetCuteRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_AddPresetCuteRes(msg)
	end
end

function CutePetGardenAgent:sendPM_RemovePresetCutePetReq(removeCutePetId)
	local req = CutePetGardenExtension_pb.PM_RemovePresetCutePetReq()

	req.removeCutePetId = removeCutePetId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_RemovePresetCutePetRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_RemovePresetCutePetRes(msg)
	end
end

function CutePetGardenAgent:sendPM_SetPresetPublicReq(presetPublic)
	local req = CutePetGardenExtension_pb.PM_SetPresetPublicReq()

	req.presetPublic = presetPublic

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_SetPresetPublicRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_SetPresetPublicRes(msg)
	end
end

function CutePetGardenAgent:sendPM_QuickPairingTravelReq(buddyId, myCutePetUniqueId, buddyCutePetUniqueId)
	local req = CutePetGardenExtension_pb.PM_QuickPairingTravelReq()

	req.buddyId = buddyId
	req.myCutePetUniqueId = myCutePetUniqueId
	req.buddyCutePetUniqueId = buddyCutePetUniqueId

	self:sendMsg(req)
end

function CutePetGardenAgent:handlePM_QuickPairingTravelRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CutePetGardenAgent:handlePM_NotifyCasterQuickPairingTravelResultRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_NotifyCasterQuickPairingTravelResultRes(msg)
	end
end

function CutePetGardenAgent:handlePM_NotifyReceiverQuickPairingTravelResultRes(status, msg)
	if status == 0 then
		CutePetController.instance:handlePM_NotifyReceiverQuickPairingTravelResultRes(msg)
	end
end

CutePetGardenAgent.instance = CutePetGardenAgent.New()

return CutePetGardenAgent
