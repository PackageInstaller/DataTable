-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/controller/CutePetController.lua

module("logic.extensions.cutepet.controller.CutePetController", package.seeall)

local CutePetController = class("CutePetController", BaseController)

CutePetController.OPEN_CUTE_PET_GARDEN = "opencutepetgarden"
CutePetController.DEFAULT_CUTE_PET_TYPE_1 = 101
CutePetController.DEFAULT_CUTE_PET_TYPE_2 = 102

function CutePetController:onInit()
	GlobalDispatcher:addListener(CutePetController.OPEN_CUTE_PET_GARDEN, self.enterScene, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickGuest, self._onClickGuest, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickManagement, self._onClickManagement, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickTravel, self._onClickTravel, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickAdventure, self._onClickAdventure, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickShop, self._onClickShop, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetClickPet, self._onClickPet, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._onGetFriendInfos, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetTravelEndOnScene, self._onTravelEndOnScene, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetEnterSceneDone, self._onEnterSceneDone, self)
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._onFriendInfoGeted, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LoadBuddyTravelInfoResp, self._onhandlePM_LoadBuddyTravelInfoResp, self)
	self:onReset()
end

function CutePetController:onReset()
	self._teamInvateCDList = {}
	self.msgMap = {}
	self.msgCdMap = {}
	self._beInvateMsgs = {}
	self._needBeInvateOnGetFriendMos = false

	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_CUTEPET_INTRODUCE_TAB_1)
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_CUTEPET_INTRODUCE_TAB_2)
	RedPointController.instance:regMasterServantRed(RedPointModel.ID_CUTEPET_INTRODUCE, false, RedPointModel.ID_CUTEPET_INTRODUCE_TAB_1, RedPointModel.ID_CUTEPET_INTRODUCE_TAB_2)

	self._autoHandleOnClickChatItem = false
	self._chatMsgMo = nil
	self._isGetBuddyOnlineList = false
	self._isSynBuddyInfoList = false
	self._buddyOnlineUserIdList = {}
	self._syncBuddyStartIndex = 1
end

function CutePetController:enterScene()
	CutePetEnterSceneSequenceController.instance:enterScene()
	self:setSceneId(100)
end

function CutePetController:leaveScene()
	if self._sceneId ~= 0 then
		SceneStatusMgr.instance:popStatus(ViewName.MainUI)
		self:setSceneId(0)
	end
end

function CutePetController:setSceneId(id)
	self._sceneId = id

	if self._sceneId == 0 then
		CutePetEnterSceneSequenceController.instance:onReset()
	end
end

function CutePetController:openBagPetView(petId, page, petList)
	CutePetModel.instance:SetCurPetId(petId)
	UIStateManager.instance:push(ViewName.CutePetShowView, page, nil, petList)
end

function CutePetController:GetCurPetMo()
	return
end

function CutePetController:openCutePetSelectView(onlyoneOrCount, title, descStr, selectPetList, funcList)
	local onlyOne, selectedLimit

	if type(onlyoneOrCount) == "boolean" then
		onlyOne = onlyoneOrCount
		selectedLimit = 1

		if onlyoneOrCount == false then
			selectedLimit = -1
		end
	elseif type(onlyoneOrCount) == "number" then
		onlyoneOrCount = math.max(1, onlyoneOrCount)
		onlyOne = onlyoneOrCount == 1
		selectedLimit = onlyoneOrCount
	end

	UIStateManager.instance:push(ViewName.CutePetSelectView, onlyOne, selectedLimit, title, descStr, funcList or {}, selectPetList or {})
end

function CutePetController:_onClickGuest()
	UIStateManager.instance:push(ViewName.CutePetGuestView)
end

function CutePetController:_onClickManagement()
	UIStateManager.instance:push(ViewName.CutepetmgrView)
end

function CutePetController:_onClickTravel()
	UIStateManager.instance:push(ViewName.CutepettravelmainView)
end

function CutePetController:_onClickAdventure()
	UIStateManager.instance:push(ViewName.CutePetAdventureView)
end

function CutePetController:_onClickShop()
	GotoMgr.gotoByString(CutePetConfig.instance:getCommonValue("ShopJumpTo", false))
end

function CutePetController:_onClickPet(petId)
	if petId > 0 and CutePetModel.instance:getCutePeMo(petId) ~= nil then
		CutePetController.instance:openBagPetView(petId)
	end
end

function CutePetController:_onEnterSceneDone()
	if self._enterFinishedHandler then
		self._enterFinishedHandler(self._enterFinishedObj)
	end

	self._enterFinishedHandler = nil
	self._enterFinishedObj = nil
end

function CutePetController:_onTravelEndOnScene(index)
	if self._travelCutePetInScene then
		local scene = SceneMgr.instance:getCurScene()

		if scene then
			if scene:getSceneType() == SceneType.CutePet then
				scene:removeTravelCutePet(index)
			else
				return
			end
		end

		local isEnd = true

		for i, v in pairs(self._travelCutePetInScene) do
			if v == true then
				isEnd = false
			end
		end

		if isEnd == true then
			self:endTravel()
			scene:removeAllTravelCutePet()
		end
	end
end

function CutePetController:travelSkipOnScene()
	local scene = SceneMgr.instance:getCurScene()

	if scene then
		if scene:getSceneType() == SceneType.CutePet then
			scene:removeAllTravelCutePet()
		else
			return
		end
	end

	if self._travelCutePetInScene then
		for i, v in pairs(self._travelCutePetInScene) do
			self._travelCutePetInScene[i] = false
		end
	end

	self:endTravel()
end

function CutePetController:fixCamera()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		scene.camera:setFix()
	end
end

function CutePetController:releaseCamera()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		scene.camera:setRelease()
	end
end

function CutePetController:setTempCutePetList(list)
	self._tempCutePetList = list
end

function CutePetController:createTravelCutePet(raceId1, raceId2)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		local raceCfg1 = CutePetConfig.instance:getCutePetById(raceId1)
		local raceCfg2 = CutePetConfig.instance:getCutePetById(raceId2)

		if raceCfg1 == nil then
			raceId1 = CutePetController.DEFAULT_CUTE_PET_TYPE_1
		end

		if raceCfg2 == nil then
			raceId2 = CutePetController.DEFAULT_CUTE_PET_TYPE_2
		end

		self._travelCutePetInScene = scene:createTravelCutePet(raceId1, raceId2)

		local scene = SceneMgr.instance:getCurScene()

		scene:hideAllBuildingHud(true)
		scene.camera:setFix()
		GlobalDispatcher:dispatch(GlobalNotify.CutePetReadyTravelAnim)
		settimer(0.1, function()
			scene.petMgr:hideAllPet()
		end, self, false)
	else
		self:endTravel()
	end
end

function CutePetController:startMoveTravelCutePet()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		scene:startMoveTravelCutePet()
	end
end

function CutePetController:_setEndTravel(handle, handleTarget)
	self._endTravelHandle = handle
	self._endTravelHandleTarget = handleTarget
end

function CutePetController:endTravel()
	if self._endTravelHandle ~= nil and self._endTravelHandleTarget ~= nil then
		self._endTravelHandle(self._endTravelHandleTarget)
	elseif self._endTravelHandle ~= nil then
		self._endTravelHandle()
	end

	self._endTravelHandle = nil
	self._endTravelHandleTarget = nil

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		scene.camera:setRelease()
		scene:hideAllBuildingHud(false)
		scene.petMgr:showAllPet()
	end

	GlobalDispatcher:dispatch(GlobalNotify.CutePetTotalTravelEndOnScene)
end

function CutePetController:showTravelGetPet(petId, changeSetId, surpriseChengeSetId)
	local mo = CutePetModel.instance:getCutePeMo(petId)

	UIStateManager.instance:push(ViewName.CutePetGetPetView, mo, function(name)
		if mo.name ~= name then
			self:sendPM_CutePetRenameReq(mo.id, name)
		end

		MaterialController.instance:showChangeSetInTemp(changeSetId)

		if surpriseChengeSetId then
			ItemGetController.instance:setTitleType(surpriseChengeSetId, ItemGetController.TITLE_SURPRISE)
			MaterialController.instance:setChangeSetPopup(surpriseChengeSetId)
			MaterialController.instance:showItemsGetWindow(surpriseChengeSetId)
		end

		return true
	end, function()
		self:sendPM_ReleaseCutePetReq({
			mo.id
		})

		if surpriseChengeSetId then
			ItemGetController.instance:setTitleType(surpriseChengeSetId, ItemGetController.TITLE_SURPRISE)
			MaterialController.instance:setChangeSetPopup(surpriseChengeSetId)
			MaterialController.instance:showItemsGetWindow(surpriseChengeSetId)
		end

		return true
	end)
end

function CutePetController:sendPM_EnterGameLoadInfoReq()
	CutePetGardenAgent.instance:sendPM_EnterGameLoadInfoReq()
	self:sendPM_LoadEverGainedCutePetRaceReq()
end

function CutePetController:_handlePM_EnterGameLoadInfoResp(status, msg)
	CutePetModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_EnterGameLoadInfoResp, status)
end

function CutePetController:_handlePM_OpenGardenLoadInfoResp(status, msg)
	CutePetModel.instance:setFirstEnter(false)

	if checknumber(msg.changeSetId) > 0 then
		CutePetModel.instance:setFirstEnter(true, msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OpenGardenLoadInfoResp, status)
end

function CutePetController:sendPM_LoadCutePetInteractInfoReq()
	CutePetGardenAgent.instance:sendPM_LoadCutePetInteractInfoReq()
end

function CutePetController:_handlePM_LoadCutePetInteractInfoResp(msg)
	CutePetModel.instance:setPetInteractHasGet(msg.hasGainPrize)
	CutePetModel.instance:setPetInteractInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadCutePetInteractInfoResp)
end

function CutePetController:sendPM_HappinessInteractReq(costType, num)
	CutePetGardenAgent.instance:sendPM_HappinessInteractReq(costType, num)
end

function CutePetController:_handlePM_HappinessInteractResp(msg)
	CutePetModel.instance:setPetInteractInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_HappinessInteractResp)
end

function CutePetController:sendPM_GainHappinessInteractPrizeReq(costType, num)
	CutePetGardenAgent.instance:sendPM_GainHappinessInteractPrizeReq(costType, num)
end

function CutePetController:_handlePM_GainHappinessInteractPrizeResp(msg)
	CutePetModel.instance:setPetInteractHasGet(true)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainHappinessInteractPrizeResp)
end

function CutePetController:_handlePM_OpenGuestHouseLoadInfoResp(msg)
	CutePetModel.instance:setGuestInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OpenGuestHouseLoadInfoResp)
end

function CutePetController:sendPM_ViewGuestHouseSlotCutePetReq(slotId)
	self._tempSlotId = slotId

	CutePetGardenAgent.instance:sendPM_ViewGuestHouseSlotCutePetReq(slotId)
end

function CutePetController:_handlePM_ViewGuestHouseSlotCutePetResp(msg)
	local mo = CutePetMo.New()

	mo:initData(msg.cutePet)

	local targetSlotId = self._tempSlotId

	UIStateManager.instance:push(ViewName.CutePetGetPetView, mo, function(name)
		if CutePetModel.instance:getCutePetsCount() >= self:getCutePetCapacity() then
			FloatWordMgr.instance:show(lang("宠物数量已满"))

			return false
		end

		CutePetController.instance:sendPM_GainOrFreeGuestHouseSlotCutePetReq(targetSlotId, true, name)

		return true
	end, function()
		CutePetController.instance:sendPM_GainOrFreeGuestHouseSlotCutePetReq(targetSlotId, false)

		return true
	end)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_ViewGuestHouseSlotCutePetResp)
end

function CutePetController:sendPM_GainOrFreeGuestHouseSlotCutePetReq(slotId, gain, newName)
	CutePetGardenAgent.instance:sendPM_GainOrFreeGuestHouseSlotCutePetReq(slotId, gain, newName)
end

function CutePetController:_handlePM_GainOrFreeGuestHouseSlotCutePetResp(msg)
	CutePetModel.instance:setGuestInfo(msg.guestHouseRefreshInfo)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainOrFreeGuestHouseSlotCutePetResp)
end

function CutePetController:sendPM_SpeedUpGuestHouseSlotReq(costType, num)
	CutePetGardenAgent.instance:sendPM_SpeedUpGuestHouseSlotReq(costType, num)
end

function CutePetController:_handlePM_SpeedUpGuestHouseSlotResp(msg)
	CutePetModel.instance:setGuestInfo(msg.guestHouseRefreshInfo)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SpeedUpGuestHouseSlotResp)
end

function CutePetController:sendPM_LoadAdventureBuildingInfoReq(buildingCount)
	CutePetModel.instance:initAdventureBuilding(buildingCount)
	CutePetGardenAgent.instance:sendPM_LoadAdventureBuildingInfoReq()
end

function CutePetController:_handlePM_LoadAdventureBuildingInfoResp(msg)
	CutePetModel.instance:setAdventureInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadAdventureBuildingInfoResp)
end

function CutePetController:_handlePM_LvlUpAdventureBuildingResp(msg)
	CutePetModel.instance:setAdventureInfo(msg.building)

	local passcfg = CutePetConfig.instance:getAdventureBuildingCfg(msg.building.buildingId, msg.building.buildingLvl - 1)
	local passMatType, passMatId, passMatNum = MaterialMgr.getMatParams(passcfg.unitTimeOutputResource)
	local nowcfg = CutePetConfig.instance:getAdventureBuildingCfg(msg.building.buildingId, msg.building.buildingLvl)
	local nowMatType, nowMatId, nowMatNum = MaterialMgr.getMatParams(nowcfg.unitTimeOutputResource)

	UIStateManager.instance:push(ViewName.CutePetAdvBuildingLvUpView, passMatNum * passcfg.buildCapacityFen, nowMatNum * nowcfg.buildCapacityFen, passMatNum * (3600 / passcfg.outputUnitSecd), nowMatNum * (3600 / nowcfg.outputUnitSecd))
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LvlUpAdventureBuildingResp)
end

function CutePetController:sendPM_PutCutePet2AdventureBuildingReq(buildingId, cutePetId)
	local allBuildingInfo = CutePetModel.instance:getAdvAllBuildingInfo()

	for i, v in pairs(allBuildingInfo) do
		if v.cutePetId == cutePetId then
			allBuildingInfo[i].cutePetId = 0
		end
	end

	local buildingInfo = CutePetModel.instance:getAdvBuildingInfo(buildingId)

	if buildingInfo.cutePetId > 0 and buildingInfo.cutePetId ~= cutePetId then
		local lastPetMo = CutePetModel.instance:getCutePeMo(buildingInfo.cutePetId)

		lastPetMo:setState(CutePetMo.STATE_IN_ADVENTURE)
	end

	local petMo = CutePetModel.instance:getCutePeMo(cutePetId)

	petMo:setState(CutePetMo.STATE_IN_ADVENTURE)
	CutePetGardenAgent:sendPM_PutCutePet2AdventureBuildingReq(buildingId, cutePetId)
end

function CutePetController:_handlePM_PutCutePet2AdventureBuildingResp(msg)
	CutePetModel.instance:setAdventureInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_PutCutePet2AdventureBuildingResp)
end

function CutePetController:sendPM_TakeBackCutePetFromAdventureBuildingReq(buildingId)
	local buildingInfo = CutePetModel.instance:getAdvBuildingInfo(buildingId)
	local petMo = CutePetModel.instance:getCutePeMo(buildingInfo.cutePetId)

	petMo:setState(CutePetMo.STATE_IN_ADVENTURE)
	CutePetGardenAgent.instance:sendPM_TakeBackCutePetFromAdventureBuildingReq(buildingId)
end

function CutePetController:_handlePM_TakeBackCutePetFromAdventureBuildingResp(msg)
	CutePetModel.instance:setAdventureInfo(msg.building)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_TakeBackCutePetFromAdventureBuildingResp)
end

function CutePetController:_handlePM_GainSingleBuildingOutputResResp(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	CutePetModel.instance:setAdventureInfo(msg.building)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainSingleBuildingOutputResResp)
end

function CutePetController:_handlePM_GainAllBuildingOutputResResp(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	CutePetModel.instance:setAdventureInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainAllBuildingOutputResResp, 0, msg)
end

function CutePetController:_handlePM_LoadCutePetCommunityNewsResp(msg)
	CutePetModel.instance:setCommunityNewsInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadCutePetCommunityNewsResp)
end

function CutePetController:_handlePM_PublishCommunityNewsResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_PublishCommunityNewsResp)
end

function CutePetController:_handlePM_LoadTravelInfoResp(msg)
	CutePetModel.instance:setTravelTimeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadTravelInfoResp)

	if self._autoHandleOnClickChatItem then
		self:_handleOnClickChatItem()
	end
end

function CutePetController:_handlePM_LoadBuddyTravelInfoResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadBuddyTravelInfoResp, msg)
end

function CutePetController:sendPM_CutePetTravelMySelfPairingReq(cutePetIds)
	self._tempCutePetList = cutePetIds

	CutePetGardenAgent.instance:sendPM_CutePetTravelMySelfPairingReq(cutePetIds)
end

function CutePetController:_handlePM_CutePetTravelMySelfPairingResp(msg)
	UIStateManager.instance:popByName(ViewName.CutepettravelsingleView)
	UIStateManager.instance:popByName(ViewName.CutepettravelmainView)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self._setEndTravel(self, function(...)
		self:showTravelGetPet(msg.newCutePetId, msg.changeSetId)
	end, self)

	if self._tempCutePetList then
		local raceId1, raceId2 = 1, 2

		for i, v in ipairs(self._tempCutePetList) do
			local useMo = CutePetModel.instance:getCutePeMo(v)

			useMo.travelCount = useMo.travelCount + 1

			if i == 1 then
				raceId1 = useMo.raceId
			elseif i == 2 then
				raceId2 = useMo.raceId
			end
		end

		self:createTravelCutePet(raceId1, raceId2)
	else
		self:createTravelCutePet(1, 2)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelMySelfPairingResp)
end

function CutePetController:sendPM_CutePetTravelReceiverHandleInviteMsgReq(pairingToken, accept)
	CutePetModel.instance:setCurPairingToken(nil)

	if accept == true then
		CutePetModel.instance:setCurPairingToken(pairingToken)
	end

	CutePetGardenAgent.instance:sendPM_CutePetTravelReceiverHandleInviteMsgReq(pairingToken, accept)
end

function CutePetController:_handlePM_CutePetTravelReceiverHandleInviteMsgResp(msg)
	if checknumber(CutePetModel.instance:getCurPairingToken()) > 0 then
		local scene = SceneMgr.instance:getCurScene()

		if scene then
			if scene:getSceneType() ~= SceneType.CutePet then
				self:enterScene()

				function self._enterFinishedHandler()
					UIStateManager.instance:push(ViewName.CutePetTravelTeamSelectView, false)
				end

				self._enterFinishedObj = self
			else
				UIStateManager.instance:push(ViewName.CutePetTravelTeamSelectView, false)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelReceiverHandleInviteMsgResp)
end

function CutePetController:sendPM_CutePetTravelReceiverPutPairingCutePetReq(cutePetId)
	local pairingToken = CutePetModel.instance:getCurPairingToken()

	if pairingToken then
		CutePetGardenAgent.instance:sendPM_CutePetTravelReceiverPutPairingCutePetReq(pairingToken, cutePetId)
	end
end

function CutePetController:_handlePM_CutePetTravelReceiverPutPairingCutePetResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelReceiverPutPairingCutePetResp)
end

function CutePetController:sendPM_CutePetTravelInviterConfirmPairingReq(raceId1, raceId2)
	self._tempCutePetList = {
		raceId1 or 1,
		raceId2 or 2
	}

	local pairingToken = CutePetModel.instance:getCurPairingToken()

	CutePetGardenAgent.instance:sendPM_CutePetTravelInviterConfirmPairingReq(pairingToken)
end

function CutePetController:_handlePM_CutePetTravelInviterConfirmPairingResp(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	UIStateManager.instance:popByName(ViewName.CutePetTravelTeamSelectView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteaminvateView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
	UIStateManager.instance:popByName(ViewName.CutepettravelmainView)

	local useMo = CutePetModel.instance:getCutePeMo(msg.decTravelCountCutePetId)

	useMo.travelCount = useMo.travelCount + 1

	self._setEndTravel(self, function()
		self:showTravelGetPet(msg.newCutePetId, msg.changeSetId, msg.surprisePrizeChangesetId)
	end, self)

	if self._tempCutePetList then
		self:createTravelCutePet(self._tempCutePetList[1] or 1, self._tempCutePetList[2] or 2)
	else
		self:createTravelCutePet(1, 2)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelInviterConfirmPairingResp)
end

function CutePetController:_handlePM_NotifyReceiverRespInviteMsgResp(msg)
	if msg.accept == true then
		CutePetModel.instance:setCurPairingToken(msg.pairingToken)
		UIStateManager.instance:push(ViewName.CutePetTravelTeamSelectView, true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyReceiverRespInviteMsgResp, msg)
end

function CutePetController:_handlePM_CutePetTravelCancelBuddyPairingResp()
	CutePetModel.instance:setCurPairingToken(nil)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelCancelBuddyPairingResp)
end

function CutePetController:_handlePM_NotifyReceiverHasReadyResp(msg)
	CutePetModel.instance:setTeamTravelReceiveMo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyReceiverHasReadyResp)
end

function CutePetController:_handlePM_NotifyCancelPairingResp(msg)
	CutePetModel.instance:setCurPairingToken(nil)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyCancelPairingResp, msg)
end

function CutePetController:_handlePM_NotifyInviterConfirmPairingResp(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	UIStateManager.instance:popByName(ViewName.CutePetTravelTeamSelectView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteaminvateView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
	UIStateManager.instance:popByName(ViewName.CutepettravelmainView)

	local useMo = CutePetModel.instance:getCutePeMo(msg.decTravelCountCutePetId)

	useMo.travelCount = useMo.travelCount + 1

	self._setEndTravel(self, function()
		self:showTravelGetPet(msg.newCutePetId, msg.changeSetId, msg.surprisePrizeChangesetId)
	end, self)

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		if scene:getSceneType() == SceneType.CutePet then
			if self._tempCutePetList then
				self:createTravelCutePet(self._tempCutePetList[1] or 1, self._tempCutePetList[2] or 2)
			else
				self:createTravelCutePet(1, 2)
			end
		else
			self:endTravel()
		end
	else
		self:endTravel()
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyInviterConfirmPairingResp)
end

function CutePetController:_handlePM_CutePetLvlUpResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetLvlUpResp)
end

function CutePetController:_handlePM_CutePetStarUpResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetStarUpResp)
end

function CutePetController:_handlePM_CutePetQualityUpResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetQualityUpResp)
end

function CutePetController:_handlePM_StrengthInitialPropResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_StrengthInitialPropResp, msg)
end

function CutePetController:_handlePM_CutePetEquipOnPetResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetEquipOnPetResp)
end

function CutePetController:_handlePM_CutePetUnloadFromPetResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetUnloadFromPetResp)
end

function CutePetController:sendPM_CutePetRenameReq(id, name)
	self._tempId = id

	CutePetGardenAgent.instance:sendPM_CutePetRenameReq(self._tempId, name)
end

function CutePetController:_handlePM_CutePetRenameResp(msg)
	if checknumber(self._tempId) > 0 then
		local mo = CutePetModel.instance:getCutePeMo(self._tempId)

		mo.name = msg.newName
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		if scene:getSceneType() == SceneType.CutePet then
			scene.petMgr:refreshPetUI()
		else
			return
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetRenameResp)
end

function CutePetController:sendPM_ReleaseCutePetReq(cutePetIds)
	self.releaseCutePetIds = cutePetIds

	CutePetGardenAgent.instance:sendPM_ReleaseCutePetReq(cutePetIds)
end

function CutePetController:_handlePM_ReleaseCutePetResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_ReleaseCutePetResp, self.releaseCutePetIds)
end

function CutePetController:sendPM_SetCutePetFollowStateReq(cutePetMo, isFollow)
	local state = CutePetMo.STATE_SCENE_FOLLOW

	cutePetMo:setState(state, isFollow)
	CutePetGardenAgent.instance:sendPM_SetCutePetFollowStateReq(cutePetMo:getId(), isFollow)
end

function CutePetController:_handlePM_SetCutePetFollowStateResp(msg)
	if not msg.otherCutePetCancelFollowed then
		for i, v in ipairs(msg.otherCutePetCancelFollowed) do
			local cutePetMo = CutePetModel.instance:getCutePeMo(v)

			if cutePetMo then
				local isFollow = false
				local state = CutePetMo.STATE_SCENE_FOLLOW

				cutePetMo:setState(state, isFollow)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.handlePM_SetCutePetFollowStateResp)
	end
end

function CutePetController:sendPM_SetCutePetGardenShowStateReq(cutePetMo, isShow)
	if not self._lock then
		self._lock = true

		local state = CutePetMo.STATE_GARDEN_SHOW

		cutePetMo:setState(state, isShow)

		self.needShowCutePetId = cutePetMo:getId()

		if isShow == true then
			CutePetModel.instance:setShowCount(CutePetModel.instance:getShowCount() + 1)
		else
			CutePetModel.instance:setShowCount(CutePetModel.instance:getShowCount() - 1)
		end

		CutePetGardenAgent.instance:sendPM_SetCutePetGardenShowStateReq(cutePetMo:getId(), isShow)
	end
end

function CutePetController:_handlePM_SetCutePetGardenShowStateResp(msg)
	self._lock = false

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SetCutePetGardenShowStateResp, {
		self.needShowCutePetId
	})
end

function CutePetController:sendPM_SetCutePetLockStateReq(cutePetMo, isLock)
	if not self._lock then
		self._lock = true
		self._tempCutePet = cutePetMo
		self._tempState = isLock

		CutePetGardenAgent.instance:sendPM_SetCutePetLockStateReq(cutePetMo:getId(), isLock)
	end
end

function CutePetController:_handlePM_SetCutePetLockStateResp(status, msg)
	self._lock = false

	if status == 0 and self._tempCutePet then
		local state = CutePetMo.LOCKED

		self._tempCutePet:setState(state, self._tempState)
		GlobalDispatcher:dispatch(GlobalNotify.handlePM_SetCutePetLockStateResp)
	end

	self._tempCutePet = nil
	self._tempState = nil
end

function CutePetController:sendPM_CutePetChangeReadyToDiscardReq(cutePetMo, isDiscard)
	if not self._lock then
		self._lock = true
		self._tempCutePet = cutePetMo
		self._tempDiscardState = isDiscard == true

		local setIds, unSetIds

		if isDiscard then
			setIds = {
				cutePetMo:getId()
			}
		else
			unSetIds = {
				cutePetMo:getId()
			}
		end

		CutePetGardenAgent.instance:sendPM_CutePetChangeReadyToDiscardReq(setIds, unSetIds)
	end
end

function CutePetController:_handlePM_CutePetChangeReadyToDiscardRes(status, msg)
	self._lock = false

	if status == 0 and self._tempCutePet then
		self._tempCutePet:setReadyToDiscard(self._tempDiscardState)
		GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self._tempCutePet:getId(), self._tempDiscardState)
	end

	self._tempCutePet = nil
	self._tempDiscardState = nil
end

function CutePetController:sendPM_LoadEverGainedCutePetRaceReq()
	CutePetGardenAgent.instance:sendPM_LoadEverGainedCutePetRaceReq()
end

function CutePetController:_handlePM_LoadEverGainedCutePetRaceResp(msg)
	CutePetModel.instance:updateCuteSuit(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LoadEverGainedCutePetRaceResp)
end

function CutePetController:sendPM_SetMyCurIllusionCutePetRaceReq(race)
	local varObj
	local userVar = SceneMainPlayer.instance.userVar

	if race == 0 and userVar:deleteVar(UserVarKey.ILLUSION_CUTE_PET_RACE, race) or userVar:setNumber(UserVarKey.ILLUSION_CUTE_PET_RACE, race) then
		SceneMainPlayer.instance:updateVariablesView()
	end

	CutePetGardenAgent.instance:sendPM_SetMyCurIllusionCutePetRaceReq(race)
end

function CutePetController:_handlePM_SetMyCurIllusionCutePetRaceResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SetMyCurIllusionCutePetRaceResp)
end

function CutePetController:_handlePM_NotifyCutePetIllusionChangedResp(msg)
	CutePetModel.instance:updateCuteSuit(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyCutePetIllusionChangedResp)
end

function CutePetController:sendPM_UnLockIllusionCutePetRaceReq(race)
	CutePetModel.instance:unLockCuteSuit(race)
	CutePetGardenAgent.instance:sendPM_UnLockIllusionCutePetRaceReq(race)
end

function CutePetController:_handlePM_UnLockIllusionCutePetRaceResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_UnLockIllusionCutePetRaceResp)
end

function CutePetController:_handlePM_NotifyCutePetChangedResp(msg)
	local list = CutePetModel.instance:addCutePetMos(msg.changes)

	if list then
		for i, cutePetMo in ipairs(list) do
			local boo = CutePetModel.instance:checkAndSetGardenShowState(cutePetMo)

			if boo then
				self:sendPM_SetCutePetGardenShowStateReq(cutePetMo, true)
			else
				break
			end
		end
	end

	local deletedList = {}

	for i, v in ipairs(msg.changes) do
		if v.deleted == true then
			table.insert(deletedList, v.uniqueId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyCutePetChangedResp, deletedList)
end

function CutePetController:_handlePM_LvlUpGardenResp(msg)
	CutePetModel.instance:gardenLevelUp()

	local mgrLv = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)
	local nowCfg = CutePetConfig.instance:getGardenCfg(mgrLv)
	local proCfg = CutePetConfig.instance:getGardenCfg(mgrLv - 1)

	UIStateManager.instance:push(ViewName.CutePetMgrLvUpView, proCfg.cutePetCapacity, nowCfg.cutePetCapacity)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LvlUpGardenResp)
end

function CutePetController:_handlePM_CutePetTravelInviteBuddyPairingResp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelInviteBuddyPairingResp)
end

function CutePetController:sendPM_CutePetTravelInviteBuddyPairingReq(cutePetId, buddyUserId)
	local lastTime = self._teamInvateCDList[buddyUserId]
	local now = ServerTime.now()

	if lastTime and now < lastTime then
		return
	end

	self._teamInvateCDList[buddyUserId] = now + CutePetConfig.instance:getCommonValue("TravelBuddyPairingWaitInviteMsgTimeoutSecd", true)

	CutePetGardenAgent.instance:sendPM_CutePetTravelInviteBuddyPairingReq(cutePetId, buddyUserId)
end

function CutePetController:getTeamInvateCDList()
	return self._teamInvateCDList
end

function CutePetController:handlePM_NotifyReceiveNewInvitePairingMsgResp(msg)
	self:_addBeInvate(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyReceiveNewInvitePairingMsgResp)
end

function CutePetController:_addBeInvate(msg)
	local mo = FriendModel.instance:getFriendMo(msg.inviterUserId)

	if not mo then
		self._needBeInvateOnGetFriendMos = true

		table.insert(self._beInvateMsgs, msg)
		FriendAgent.instance:sendGetBuddyInfoReq()

		return
	end

	local headInfo = mo.headInfo

	if headInfo then
		local cd = 20

		self:_tryUnregPopupMsg(headInfo.userId)

		self.msgMap[headInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
			bTimeOutReject = true,
			tag = "cutepetteamtravel",
			showInitCD = cd,
			acceptFunc = self._tryAcceptInvite,
			rejectFunc = self._tryRejectInvite,
			thisArg = self,
			desc = langPara("邀请您参与宠物出游"),
			headInfo = headInfo,
			inviterCutePet = msg
		})
		self.msgCdMap[headInfo.userId] = ServerTime.now()
	end
end

function CutePetController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
	self.msgCdMap[userId] = nil
end

function CutePetController:_tryAcceptInvite(data)
	local params = data.info

	CutePetModel.instance:setTeamTravelReceiveMo(params.inviterCutePet)
	self:sendPM_CutePetTravelReceiverHandleInviteMsgReq(params.inviterCutePet.pairingToken, true)
end

function CutePetController:_tryRejectInvite(data)
	local params = data.info

	self:sendPM_CutePetTravelReceiverHandleInviteMsgReq(params.inviterCutePet.pairingToken, false)
end

function CutePetController:_onGetFriendInfos()
	if self._needBeInvateOnGetFriendMos then
		for i, msg in ipairs(self._beInvateMsgs) do
			self:_addBeInvate(msg)
		end

		self._beInvateMsgs = {}
	end
end

function CutePetController:updateTimeTip(privilegeCommonValue)
	local planList = string.splitToNumber(privilegeCommonValue, ",")
	local isInTime = false
	local txt = ""
	local cfgs = CutePetConfig.instance:getPrivilegeTimePlanCfgs()

	for i, v in ipairs(planList) do
		if GameUtil.checkIsInTimePeriod(cfgs[v].startTime, cfgs[v].endTime) then
			isInTime = true
			txt = GameUtil.getTimeTxtByStr(cfgs[v].startTime, cfgs[v].endTime, GameEnum.TimeTxt.M_D_H)

			break
		end
	end

	return isInTime, txt
end

function CutePetController:_handlePM_CutePetTravelInfoRes(msg)
	CutePetModel.instance:setMyPetTravelInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetTravelInfoRes)
end

function CutePetController:_onChatItemClick(tpId, chatMsgMo)
	self._chatMsgMo = nil

	if tpId == 91 then
		self._autoHandleOnClickChatItem = true
		self._chatMsgMo = chatMsgMo

		CutePetGardenAgent.instance:sendPM_LoadTravelInfoReq()
	end
end

function CutePetController:_handleOnClickChatItem()
	self._autoHandleOnClickChatItem = false

	if not self._chatMsgMo then
		return
	end

	local chatMsgMo = self._chatMsgMo

	self._chatMsgMo = nil

	local leftTime = self:getTravelTimeParams()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("今日无出游次数")

		return
	end

	local userId = chatMsgMo:getParam("userId", true)

	if userId == checknumber(RoleModel.instance:getUserId()) then
		return
	end

	if userId > 0 then
		FriendAgent.instance:sendSearchUserReq(nil, userId, function()
			local mos = FriendModel.instance:GetSearchs()
			local groupType = FriendModel.instance:getGroupTypeById(userId)

			if #mos == 1 then
				local data = {
					cutePetRaceId = chatMsgMo:getParam("cutePetRaceId", true),
					cutePetTypeNeeds = chatMsgMo:getParam("cutePetTypeNeeds", true),
					travelCountNeeds = chatMsgMo:getParam("travelCountNeeds", true)
				}

				UIStateManager.instance:push(ViewName.CutePetCommunityInfoView, mos[1], groupType, data)
			end
		end)
	end
end

function CutePetController:getTravelTimeParams()
	local totalCount = CutePetConfig.instance:getCommonValue("TravelDailyMaxCount", true)
	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

	if isInTime == true then
		totalCount = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_TravelDailyMaxCount", true)
	end

	local leftTime = math.max(totalCount - CutePetModel.instance:getTravelTime(), 0)

	return leftTime, totalCount
end

function CutePetController:handlePM_PresetCutePetInfoRes(msg)
	CutePetModel.instance:setMyPetPresetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetPresetInfoRes)
end

function CutePetController:handlePM_AddPresetCuteRes(msg)
	CutePetModel.instance:onAddPresetCute(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetPresetAddPetsRes)
end

function CutePetController:handlePM_RemovePresetCutePetRes(msg)
	CutePetModel.instance:onRemovePresetCute(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetPresetRemovePetsRes)
end

function CutePetController:handlePM_SetPresetPublicRes(msg)
	CutePetModel.instance:onSetPresetPublic(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetPresetSetPublicRes)
end

function CutePetController:resetAllOnlineBuddyInfo(isForce)
	if isForce then
		-- block empty
	elseif self._isGetBuddyOnlineList or self._isSynBuddyInfoList then
		return
	end

	CutePetModel.instance:clearBuddyInfoMap()

	self._isGetBuddyOnlineList = true
	self._isSynBuddyInfoList = true
	self._syncBuddyStartIndex = 1

	table.clear(self._buddyOnlineUserIdList)
	FriendAgent.instance:sendGetBuddyInfoReq()
end

function CutePetController:_onFriendInfoGeted()
	if self._isGetBuddyOnlineList then
		local mos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)
		local result = {}

		for i, v in ipairs(mos) do
			if v:getIsOnline() then
				table.insert(result, checknumber(v.headInfo.userId))
			end
		end

		self._buddyOnlineUserIdList = result
		self._isGetBuddyOnlineList = false

		self:_syncBuddyInfoList()
	end
end

function CutePetController:_syncBuddyInfoList()
	if not self._isSynBuddyInfoList then
		return
	end

	if self._syncBuddyStartIndex > #self._buddyOnlineUserIdList then
		self._isSynBuddyInfoList = false

		GlobalDispatcher:dispatch(GlobalNotify.CutePetBuddyInfoSyncComplete)

		return
	end

	local startIndex = self._syncBuddyStartIndex
	local endIndex = math.min(startIndex + 19, #self._buddyOnlineUserIdList)
	local userIdList = {}

	for i = startIndex, endIndex do
		table.insert(userIdList, self._buddyOnlineUserIdList[i])
	end

	CutePetGardenAgent.instance:sendPM_LoadBuddyTravelInfoReq(userIdList)

	self._syncBuddyStartIndex = endIndex + 1
end

function CutePetController:_onhandlePM_LoadBuddyTravelInfoResp(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.buddyTravelInfo then
		for i, v in ipairs(info.buddyTravelInfo) do
			CutePetModel.instance:updateBuddyTravelInfo(v)
		end

		self:_syncBuddyInfoList()
	end
end

function CutePetController:isInSyncBuddyInfoList()
	return self._isSynBuddyInfoList or self._isGetBuddyOnlineList
end

function CutePetController:handlePM_NotifyCasterQuickPairingTravelResultRes(msg)
	local result = msg.result

	if result == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		UIStateManager.instance:popByName(ViewName.CutePetSelectMatchView)
		UIStateManager.instance:popByName(ViewName.CutePetPresetBuddyView)
		UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
		UIStateManager.instance:popByName(ViewName.CutepettravelmainView)

		local useMo = CutePetModel.instance:getCutePeMo(msg.decTravelCountCutePetId)

		useMo.travelCount = useMo.travelCount + 1

		self._setEndTravel(self, function()
			self:showTravelGetPet(msg.newCutePetId, msg.changeSetId, msg.surprisePrizeChangesetId)
		end, self)

		if self._tempCutePetList then
			self:createTravelCutePet(self._tempCutePetList[1] or 1, self._tempCutePetList[2] or 2)
		else
			self:createTravelCutePet(1, 2)
		end

		GlobalDispatcher:dispatch(GlobalNotify.handlePM_CutePetTravelInviterConfirmPairingResp)
	elseif result == -1 then
		UIStateManager.instance:popByName(ViewName.CutePetSelectMatchView)
		FloatWordMgr.instance:show("好友预设宠物信息已经改变,重新刷新列表")
		self:resetAllOnlineBuddyInfo(true)
	elseif result == -2 then
		UIStateManager.instance:popByName(ViewName.CutePetSelectMatchView)
		FloatWordMgr.instance:show("好友正在双人出行，请稍后重试")
		self:resetAllOnlineBuddyInfo(true)
	elseif result == -3 then
		FloatWordMgr.instance:show("宠物仓库满了，或是选择了出游次数不足的宠物")
		UIStateManager.instance:popByName(ViewName.CutePetSelectMatchView)
		UIStateManager.instance:popByName(ViewName.CutePetPresetBuddyView)
		UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
		UIStateManager.instance:popByName(ViewName.CutepettravelmainView)
	else
		FloatWordMgr.instance:show("出游失败，请稍后重试")
		UIStateManager.instance:popByName(ViewName.CutePetSelectMatchView)
		UIStateManager.instance:popByName(ViewName.CutePetPresetBuddyView)
		UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
		UIStateManager.instance:popByName(ViewName.CutepettravelmainView)
	end
end

function CutePetController:sendPM_CutePetTravelQuickPairingReq(buddyId, buddyPetId, buddyRaceId, selfCutePetId)
	local mo = CutePetModel.instance:getCutePeMo(selfCutePetId)

	self._tempCutePetList = {
		buddyRaceId,
		mo.raceId
	}

	CutePetGardenAgent.instance:sendPM_QuickPairingTravelReq(buddyId, selfCutePetId, buddyPetId)
end

function CutePetController:handlePM_NotifyReceiverQuickPairingTravelResultRes(msg)
	UIStateManager.instance:popByName(ViewName.CutePetTravelTeamSelectView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteaminvateView)
	UIStateManager.instance:popByName(ViewName.CutepettravelteamView)
	UIStateManager.instance:popByName(ViewName.CutepettravelmainView)

	local useMo = CutePetModel.instance:getCutePeMo(msg.decTravelCountCutePetId)

	useMo.travelCount = useMo.travelCount + 1
end

function CutePetController:getCutePetCapacity()
	local managementLevel = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)
	local managementCfg = CutePetConfig.instance:getGardenCfg(managementLevel)

	if managementCfg then
		local GardenMaxCapacityLimit = checknumber(CutePetConfig.instance:getCommonValue("GardenMaxCapacityLimit"))

		if GardenMaxCapacityLimit <= managementCfg.cutePetCapacity then
			local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()
			local total, addPercent = CutePetModel.instance:getLimitTotalNum(petCount, GardenMaxCapacityLimit)

			return total
		else
			return managementCfg.cutePetCapacity
		end
	end

	return 0
end

CutePetController.instance = CutePetController.New()

return CutePetController
