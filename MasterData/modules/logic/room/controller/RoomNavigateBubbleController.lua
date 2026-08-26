-- chunkname: @modules/logic/room/controller/RoomNavigateBubbleController.lua

module("modules.logic.room.controller.RoomNavigateBubbleController", package.seeall)

local RoomNavigateBubbleController = class("RoomNavigateBubbleController", BaseController)

function RoomNavigateBubbleController:onInit()
	return
end

function RoomNavigateBubbleController:reInit()
	self:clear()
end

function RoomNavigateBubbleController:clear()
	self:release()
end

function RoomNavigateBubbleController:init()
	self._isInited = true

	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, self.refreshData, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self.onItemChanged, self)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, self.onFaithChanged, self)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, self.onFaithChanged, self)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, self.onRoomGiftActUpdate, self)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, self.onRoomGiftActUpdate, self)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaith, self.gainAllFaithReward, self)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaithFull, self.focusFaithFullChar, self)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, self.onManufactureInfoUpdate, self)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, self.onManufactureInfoUpdate, self)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, self.startCheckTrainEventTask, self)
	self:refreshData()

	self._clickFaithCharacterDict = nil
end

function RoomNavigateBubbleController:release()
	self._isInited = false

	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, self.refreshData, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self.onItemChanged, self)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, self.onFaithChanged, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, self.onFaithChanged, self)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaith, self.gainAllFaithReward, self)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaithFull, self.focusFaithFullChar, self)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, self.onRoomGiftActUpdate, self)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, self.onRoomGiftActUpdate, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, self.onManufactureInfoUpdate, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, self.onManufactureInfoUpdate, self)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, self.startCheckTrainEventTask, self)
	RoomNavigateBubbleModel.instance:clear()

	self._clickFaithCharacterDict = nil
end

function RoomNavigateBubbleController:refreshData()
	if self._isInited then
		RoomNavigateBubbleModel.instance:buildCategory()
		self:sortData()
		self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function RoomNavigateBubbleController:onItemChanged()
	if self._isInited then
		RoomNavigateBubbleModel.instance:updateBuildingUpgrade()
		self:sortData()
		self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function RoomNavigateBubbleController:onFaithChanged()
	if self._isInited then
		RoomNavigateBubbleModel.instance:updateHeroFaith()
		self:sortData()
		self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function RoomNavigateBubbleController:onRoomGiftActUpdate()
	if not self._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateRoomGift()
	self:sortData()
	self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function RoomNavigateBubbleController:onManufactureInfoUpdate()
	if not self._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateManufacture()
	self:sortData()
	self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function RoomNavigateBubbleController:startCheckTrainEventTask()
	if not self._isHasCheckTrainEventTask then
		self._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(self._onRunCheckTrainEventTask, self, 0.1)
	end
end

function RoomNavigateBubbleController:_onRunCheckTrainEventTask()
	self._isHasCheckTrainEventTask = false

	if not self._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateCritterEvent()
	self:sortData()
	self:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function RoomNavigateBubbleController:sortData()
	RoomNavigateBubbleModel.instance:sortCategory()
end

function RoomNavigateBubbleController.sortProductProgress(bubbleDataA, bubbleDataB)
	local productionLineMoA = RoomProductionModel.instance:getById(bubbleDataA)
	local productionLineMoB = RoomProductionModel.instance:getById(bubbleDataB)

	if productionLineMoA ~= nil and productionLineMoB ~= nil then
		return RoomNavigateBubbleController.getFinishProgress(productionLineMoA) > RoomNavigateBubbleController.getFinishProgress(productionLineMoB)
	else
		return bubbleDataA < bubbleDataB
	end
end

function RoomNavigateBubbleController.sortProductLineUpgrade(bubbleDataA, bubbleDataB)
	if bubbleDataA == RoomNavigateBubbleEnum.HallId or bubbleDataB == RoomNavigateBubbleEnum.HallId then
		return bubbleDataA == RoomNavigateBubbleEnum.HallId
	end

	return bubbleDataA < bubbleDataB
end

function RoomNavigateBubbleController.sortManufacture(bubbleDataA, bubbleDataB)
	return bubbleDataA < bubbleDataB
end

function RoomNavigateBubbleController.sortCritter(bubbleDataA, bubbleDataB)
	local aCritterMO = CritterModel.instance:getCritterMOByUid(bubbleDataA)
	local bCritterMO = CritterModel.instance:getCritterMOByUid(bubbleDataB)

	if not aCritterMO or not bCritterMO then
		return false
	end

	local aIsCultivating = aCritterMO:isCultivating()
	local bIsCultivating = bCritterMO:isCultivating()

	if aIsCultivating ~= bIsCultivating then
		return aIsCultivating
	end

	return bubbleDataA < bubbleDataB
end

function RoomNavigateBubbleController.getFinishProgress(detailInfo)
	if detailInfo then
		return detailInfo:getReservePer()
	end

	return 0
end

RoomNavigateBubbleController.sortFunc = {
	[RoomNavigateBubbleEnum.CategoryType.Factory] = {
		[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = RoomNavigateBubbleController.sortProductProgress,
		[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = RoomNavigateBubbleController.sortProductLineUpgrade,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = RoomNavigateBubbleController.sortManufacture,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = RoomNavigateBubbleController.sortCritter
	}
}

function RoomNavigateBubbleController:onClickCall(bubbleMO)
	if bubbleMO and bubbleMO:getFirstBubble() then
		local firstBubble = bubbleMO:getFirstBubble()
		local func = RoomNavigateBubbleController.showFunc[bubbleMO.showType]

		if func then
			func(self, firstBubble, bubbleMO)
		end
	end
end

function RoomNavigateBubbleController:lookAtBuildingPart(firstBubbleId)
	local partId = RoomConfig.instance:getProductionPartByLineId(firstBubbleId)

	if partId ~= nil then
		RoomBuildingController.instance:tweenCameraFocusPart(partId)

		return
	end

	self:focusInitBuilding()
end

function RoomNavigateBubbleController:openBubbleUpgrade(firstBubbleId)
	if firstBubbleId == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomLevelUpView()
	else
		local mo = RoomProductionModel.instance:getById(firstBubbleId)

		ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
			lineMO = mo
		})
	end
end

function RoomNavigateBubbleController:gainAllFaithReward(firstBubbleId)
	RoomCharacterController.instance:gainAllCharacterFaith()
end

function RoomNavigateBubbleController:focusFaithFullChar(firstBubbleId)
	RoomCharacterController.instance:tweenCameraFocusCharacter(firstBubbleId, RoomEnum.CameraState.Normal)
	RoomCharacterController.instance:setCharacterFullFaithChecked(firstBubbleId)
end

function RoomNavigateBubbleController:focusInitBuilding()
	RoomBuildingController.instance:tweenCameraFocusPart()
end

function RoomNavigateBubbleController:openInitBuildingView(firstBubbleId)
	if firstBubbleId == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	else
		local lineId = firstBubbleId
		local partId = RoomProductionHelper.getPartIdByLineId(lineId)

		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = partId,
			lineId = lineId
		})
	end
end

function RoomNavigateBubbleController._sortFaithCharacter(x, y)
	local xCurrentInteractionId = x:getCurrentInteractionId()
	local yCurrentInteractionId = y:getCurrentInteractionId()

	if xCurrentInteractionId and not yCurrentInteractionId then
		return true
	elseif not xCurrentInteractionId and yCurrentInteractionId then
		return false
	end

	return x.currentFaith > y.currentFaith
end

function RoomNavigateBubbleController:checkNextCharacter()
	self._clickFaithCharacterDict = self._clickFaithCharacterDict or {}

	local roomCharacterMOList = RoomCharacterModel.instance:getList()
	local canGetFaithCharacterList = {}

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO.currentFaith > 0 then
			table.insert(canGetFaithCharacterList, roomCharacterMO)
		end
	end

	if #canGetFaithCharacterList <= 0 then
		return
	end

	table.sort(canGetFaithCharacterList, RoomNavigateBubbleController._sortFaithCharacter)

	local currentInteractionId = canGetFaithCharacterList[1]:getCurrentInteractionId()

	if currentInteractionId then
		RoomCharacterController.instance:startInteraction(currentInteractionId, true, true)
	elseif self:checkShowTimeBuildingInteraction() then
		-- block empty
	else
		local index = math.random(1, #canGetFaithCharacterList)
		local roomCharacterMO = canGetFaithCharacterList[index]

		roomCharacterMO:endMove(true)

		local pos = roomCharacterMO.currentPosition
		local heroId = roomCharacterMO.heroId
		local scene = GameSceneMgr.instance:getCurScene()

		local function callback()
			RoomCharacterController.instance:gainAllCharacterFaith(nil, nil, heroId)

			local curScene = GameSceneMgr.instance:getCurScene()
			local entity = curScene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

			if entity and entity.characterspine then
				entity.characterspine:touch(true)
			end
		end

		scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = pos.x,
			focusY = pos.z
		}, nil, callback, nil)
	end
end

function RoomNavigateBubbleController:checkShowTimeBuildingInteraction()
	local buildingInteractionMOList = {}

	tabletool.addValues(buildingInteractionMOList, RoomMapInteractionModel.instance:getBuildingInteractionMOList())
	RoomHelper.randomArray(buildingInteractionMOList)

	local canInactMOList = {}

	for i = 1, #buildingInteractionMOList do
		local interactionMO = buildingInteractionMOList[i]
		local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(interactionMO.config.heroId)

		if interactionMO.hasInteraction and roomCharacterMO then
			if roomCharacterMO.currentFaith > 0 then
				table.insert(canInactMOList, 1, interactionMO)
			else
				table.insert(canInactMOList, interactionMO)
			end
		end
	end

	for i = 1, #canInactMOList do
		if RoomInteractionController.instance:showTimeByInteractionMO(canInactMOList[i], RoomCharacterEnum.ShowTimeFaithOp.FaithAll) then
			return true
		end
	end

	return false
end

function RoomNavigateBubbleController:clickedCharacterFaithBubble()
	self:checkNextCharacter()
end

function RoomNavigateBubbleController:focusManufactureBuildingCanReceive(buildingUid)
	RoomBuildingController.instance:tweenCameraFocusBuilding(buildingUid)
end

function RoomNavigateBubbleController:clickCritterBubble(critterUid)
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

	if not critterMO then
		return
	end

	local isCultivating = critterMO:isCultivating()

	if isCultivating then
		local hasTrainEvent = critterMO.trainInfo:isHasEventTrigger()
		local isTrainFinish = critterMO.trainInfo:isTrainFinish()

		if hasTrainEvent or isTrainFinish then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, critterUid)

			return
		end
	end

	local noMoodWorking = critterMO:isNoMoodWorking()

	if noMoodWorking then
		local buildingUid = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)

		if buildingUid then
			RoomBuildingController.instance:tweenCameraFocusBuilding(buildingUid)
		else
			local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)

			if workingPathMO then
				local siteType = RoomTransportHelper.fromTo2SiteType(workingPathMO.fromType, workingPathMO.toType)

				RoomTransportController.instance:openTransportSiteView(siteType)
			end
		end
	end
end

RoomNavigateBubbleController.showFunc = {
	[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = RoomNavigateBubbleController.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = RoomNavigateBubbleController.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward] = RoomNavigateBubbleController.clickedCharacterFaithBubble,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull] = RoomNavigateBubbleController.focusFaithFullChar,
	[RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift] = RoomNavigateBubbleController.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = RoomNavigateBubbleController.focusManufactureBuildingCanReceive,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = RoomNavigateBubbleController.clickCritterBubble
}
RoomNavigateBubbleController.instance = RoomNavigateBubbleController.New()

return RoomNavigateBubbleController
