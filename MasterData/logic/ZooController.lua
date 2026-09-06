-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/controller/ZooController.lua

module("logic.extensions.zoo.controller.ZooController", package.seeall)

local ZooController = class("ZooController", BaseController)

ZooController.ANIMALTYPE = 1
ZooController.EGGTYPE = 2
ZooController.Once = 3
ZooController.Plural = 4

local resultCode = {}

resultCode[0] = lang("petzoo_rename_name_fmt")
resultCode[-1] = lang("petzoo_rename_cantemtpy")
resultCode[-2605] = lang("petzoo_rename_name_exist")
resultCode[-2606] = lang("petzoo_rename_name_tooshort")
resultCode[-2607] = lang("petzoo_rename_name_toolong")
resultCode[-2608] = lang("petzoo_rename_name_invalid")
resultCode[-2609] = lang("petzoo_rename_name_sensitive")
resultCode[-2612] = lang("petzoo_rename_all_number")
resultCode[-2613] = lang("petzoo_rename_all_underline")

function ZooController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GMAgent.PM_GmZooHatchSlotProcessRes, self._gmZooHatchSlotProcess, self)
end

function ZooController:onReset()
	self._initeTime = 0
	self._lastUnlockBuildingId = 0
	self._workBuildingId = 0
	self._workAnimalSlotId = 0
	self._workAnimalId = 0
	self._lastStealFriutFriendId = 0
	self._lastSetAbsorbDeviceFriendId = 0
	self._lastFeedBuddyAnimalFriend = 0
	self._lastReqFriendZooId = 0
	self._lastGainAbsorbFriend = 0
	self._lastFeedAnimalId = 0
	self._cancelInZooAnimalId = 0
	self._replaceInZooAnimalId = 0
	self._lastInZooAnimalId = 0
	self._lastSetInZooStatues = false
	self._lastFollowAnimalId = 0
	self._lastAnimFollowState = false
	self._recycleAnimalId = 0
	self._changeNameAnimalId = nil
	self._changeAnimalName = nil
	self._lastShowSharedSenderId = 0
	self._lastTakeAnimalOutFromSlotId = 0
	self._lastPutEggIntoSlotId = 0
	self._lastPutEggIntoSlotEggId = 0
	self._lastCancelEggSlotId = 0
	self._lastLostAnimalId = 0
	self._lastLostAnimalHandleType = 0
	self._lastLostAnimalActualId = 0
	self._lastUsedSpeedCardSlot = 0
	self._lastUsedSpeedCardId = 0
	self._replaceWorkingAnimalId = 0
	self._cancelWorkingAnimalId = 0
	self._replaceWorkingBuildingId = 0
	self._replaceWorkingSlotId = 0
	self._lastGainProductionBuildingId = 0
end

function ZooController:getMyZooInfo()
	ZooAgent.instance:sendPM_ZooGetAllInfoReq()
end

function ZooController:onGetMyZooAllInfo(msg)
	local userId = RoleModel.instance:getUserId()

	ZooModel.instance:setZooInfo(userId, msg)

	if ZooSceneController.instance:isEnteringMyZoo() then
		self:switchZoo(userId)
	else
		local enteringFriendId = ZooSceneController.instance:getEnteringFriendId()

		if enteringFriendId ~= 0 then
			self:getFriendZooInfo(enteringFriendId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnGetMyZooInfo)
end

function ZooController:getFriendZooInfo(friendId)
	if self._lastReqFriendZooId ~= 0 then
		return
	end

	self._lastReqFriendZooId = friendId

	ZooAgent.instance:sendPM_ZooGetOtherZooReq(friendId)
end

function ZooController:onFriendZooInfo(msg)
	if self._lastReqFriendZooId == 0 then
		return
	end

	local friendId = self._lastReqFriendZooId

	self._lastReqFriendZooId = 0

	local enteringFriendId = ZooSceneController.instance:getEnteringFriendId()

	if friendId ~= enteringFriendId then
		return
	end

	ZooModel.instance:setZooInfo(friendId, msg)
	self:switchZoo(friendId)
end

function ZooController:switchZoo(userId)
	ZooModel.instance:switchZoo(userId)
	ZooSceneController.instance:enterZooScene()
	GlobalDispatcher:dispatch(GlobalNotify.OnZooChange, userId)
end

function ZooController:loadAnimalInfo()
	ZooAgent.instance:sendPM_GetZooAnimalInfoReq()
end

function ZooController:onGetMyAnimals(msg)
	ZooModel.instance:setMyAnimalList(msg.animalInfo)
	GlobalDispatcher:dispatch(GlobalNotify.ZooGetAnimalsInfo)
end

function ZooController:sendPM_ZooHatchUseSpeedUpCardReq(slodId, cardId)
	self._lastUsedSpeedCardSlot = slodId
	self._lastUsedSpeedCardId = cardId

	ZooAgent.instance:sendPM_ZooHatchUseSpeedUpCardReq(slodId, cardId)
end

function ZooController:onZooHatchUseSpeedUpCard(msg)
	if self._lastUsedSpeedCardSlot == 0 then
		return
	end

	local slotId = self._lastUsedSpeedCardSlot
	local cardId = self._lastUsedSpeedCardId

	self._lastUsedSpeedCardSlot = 0
	self._lastUsedSpeedCardId = 0

	local myZoo = ZooModel.instance:getMyZoo()
	local hatchInfo = myZoo:getHatchInfoByIndex(msg.slotId)

	hatchInfo.hatchEndTime = tonumber(msg.hatchEndTime) / 1000

	GlobalDispatcher:dispatch(GlobalNotify.OnZooHatchUseSpeedUpCard, slotId, cardId)
end

function ZooController:sendPM_PutEggIntoSlotReq(slotId, eggId)
	self._lastPutEggIntoSlotId = slotId
	self._lastPutEggIntoSlotEggId = eggId

	ZooAgent.instance:sendPM_PutEggIntoSlotReq(slotId, eggId)
end

function ZooController:onPutEggIntoSlot(msg)
	if self._lastPutEggIntoSlotEggId == 0 then
		return
	end

	local slotId = msg.slotInfo.id
	local eggId = self._lastPutEggIntoSlotEggId

	self._lastPutEggIntoSlotId = 0
	self._lastPutEggIntoSlotEggId = 0

	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setHatchInfoByIndex(slotId, msg.slotInfo)
	myZoo:removeEggById(eggId)
	GlobalDispatcher:dispatch(GlobalNotify.OnPutEggIntoSlot, slotId)
end

function ZooController:sendPM_ZooCancelHatchEggReq(slotId)
	self._lastCancelEggSlotId = slotId

	ZooAgent.instance:sendPM_ZooCancelHatchEggReq(slotId)
end

function ZooController:onZooCancelHatchEgg(msg)
	if self._lastCancelEggSlotId == 0 then
		return
	end

	local slotId = self._lastCancelEggSlotId

	self._lastCancelEggSlotId = 0

	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setHatchInfoByIndex(slotId, nil)
	GlobalDispatcher:dispatch(GlobalNotify.ZooCancelHatch, slotId)
end

function ZooController:sendPM_TakeAnimalOutFromSlotReq(slotId, animalName)
	self._lastTakeAnimalOutFromSlotId = slotId

	ZooAgent.instance:sendPM_TakeAnimalOutFromSlotReq(slotId, animalName)
end

function ZooController:onTakeAnimalOutFromSlot(msg)
	if self._lastTakeAnimalOutFromSlotId == 0 then
		return
	end

	local slotId = self._lastTakeAnimalOutFromSlotId

	self._lastTakeAnimalOutFromSlotId = 0

	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = AnimalModel.New()

	animalMo:initData(msg.animalInfo)
	myZoo:addAnimal(animalMo)
	myZoo:clearHatchInfoByIndex(slotId)

	local animalNum = myZoo:getPlacedMaxAnimalNum()
	local placeAnimalList = myZoo:getPlaceAnimalIds()

	if animalNum > #placeAnimalList then
		self:setAnimalInZoo(animalMo.id, true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ZooTakeAnimalOutFromHatch, slotId, animalMo.id)
end

function ZooController:onClearAllInZooState(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:clearAllInZooAnimals()
	GlobalDispatcher:dispatch(GlobalNotify.OnClearAllInZooState)
end

function ZooController:sendPM_AnimalSetFollowStateReq(animalId, isFollow)
	self._lastFollowAnimalId = animalId
	self._lastAnimFollowState = isFollow

	ZooAgent.instance:sendPM_AnimalSetFollowStateReq(animalId, isFollow)
end

function ZooController:onAnimalSetFollowState(msg)
	if self._lastFollowAnimalId == 0 then
		return
	end

	local animalId = self._lastFollowAnimalId

	self._lastFollowAnimalId = 0

	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = myZoo:getAnimalById(animalId)

	myZoo:setAnimalFollowed(animalId, self._lastAnimFollowState)

	if animalMo.place then
		self:setAnimalInZoo(animalMo.id, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ZooPetFollowStaus, animalId)
end

function ZooController:replaceAnimalWorking(buildingId, slotId, animalId, currAnimId)
	self._replaceWorkingBuildingId = buildingId
	self._replaceWorkingSlotId = slotId
	self._replaceWorkingAnimalId = animalId
	self._cancelWorkingAnimalId = checknumber(currAnimId)

	if self._cancelWorkingAnimalId > 0 then
		self._cancelWorkingAnimalId = 0

		self:putAnimalToWork(buildingId, slotId, -1)
	else
		self._replaceWorkingBuildingId = 0
		self._replaceWorkingSlotId = 0
		self._replaceWorkingAnimalId = 0
		self._cancelWorkingAnimalId = 0

		self:putAnimalToWork(buildingId, slotId, animalId)
	end
end

function ZooController:putAnimalToWork(buildingId, slotId, animalId)
	self._workBuildingId = buildingId
	self._workAnimalId = animalId
	self._workAnimalSlotId = slotId

	ZooAgent.instance:sendPM_ZooPutAnimalToWorkReq(buildingId, slotId, animalId)
end

function ZooController:onPutAnimalToWork(building)
	if building.buildingId == self._workBuildingId then
		local workAnimalId = self._workAnimalId
		local workBuildingId = self._workBuildingId
		local slotId = self._workAnimalSlotId
		local replaceWorkingAnimalId = self._replaceWorkingAnimalId
		local replaceWorkingSlotId = self._replaceWorkingSlotId
		local replaceWorkingBuildingId = self._replaceWorkingBuildingId

		self._workBuildingId = 0
		self._workAnimalId = 0
		self._workAnimalSlotId = 0
		self._replaceWorkingBuildingId = 0
		self._replaceWorkingSlotId = 0
		self._replaceWorkingAnimalId = 0
		self._cancelWorkingAnimalId = 0

		ZooModel.instance:updateWorkingBuilding(building)
		GlobalDispatcher:dispatch(GlobalNotify.OnPutAnimalToWork, workBuildingId, slotId, workAnimalId)

		if replaceWorkingAnimalId > 0 then
			self:putAnimalToWork(replaceWorkingBuildingId, replaceWorkingSlotId, replaceWorkingAnimalId)
		end
	end
end

function ZooController:replaceAnimalInZoo(animalId, currAnimId)
	self._replaceInZooAnimalId = animalId
	self._cancelInZooAnimalId = checknumber(currAnimId)

	if self._cancelInZooAnimalId ~= 0 then
		self:sendPM_AnimalSetInZooStateReq(self._cancelInZooAnimalId, false)
	else
		self:sendPM_AnimalSetInZooStateReq(self._replaceInZooAnimalId, true)
	end
end

function ZooController:setAnimalInZoo(animalId, isInZoo)
	self._replaceInZooAnimalId = 0
	self._cancelInZooAnimalId = 0

	self:sendPM_AnimalSetInZooStateReq(animalId, isInZoo)
end

function ZooController:sendPM_AnimalSetInZooStateReq(animalId, isInZoo)
	self._lastInZooAnimalId = animalId
	self._lastSetInZooStatues = isInZoo

	ZooAgent.instance:sendPM_AnimalSetInZooStateReq(animalId, isInZoo)
end

function ZooController:onAnimalSetInZooState(msg)
	if self._lastInZooAnimalId == 0 then
		return
	end

	local animalId = self._lastInZooAnimalId
	local myZoo = ZooModel.instance:getMyZoo()
	local animal = myZoo:getAnimalById(animalId)

	animal.place = self._lastSetInZooStatues or false

	local replaceAnimalId = self._replaceInZooAnimalId

	self._replaceInZooAnimalId = 0
	self._lastInZooAnimalId = 0
	self._cancelInZooAnimalId = 0

	if self._lastSetInZooStatues then
		ZooSceneController.instance:createPet(animal.id)
		GlobalDispatcher:dispatch(GlobalNotify.OnZooSetAnimalInZoo, animal.id)
	else
		ZooSceneController.instance:removePet(animal.id)
		GlobalDispatcher:dispatch(GlobalNotify.OnZooCancelAnimalInZoo, animal.id)
	end

	if animalId ~= replaceAnimalId and replaceAnimalId ~= 0 then
		self:sendPM_AnimalSetInZooStateReq(replaceAnimalId, true)
	end
end

function ZooController:sendPM_ZooSetAnimalNameReq(animalId, name)
	self._changeNameAnimalId = animalId
	self._changeAnimalName = name

	ZooAgent.instance:sendPM_ZooSetAnimalNameReq(animalId, name)
end

function ZooController:onZooSetAnimalName(status, msg)
	if self._changeNameAnimalId == 0 then
		return
	end

	local animalId = self._changeNameAnimalId
	local name = self._changeAnimalName

	self._changeNameAnimalId = 0
	self._changeAnimalName = nil

	if status == 0 then
		local myZoo = ZooModel.instance:getMyZoo()
		local animMo = myZoo:getAnimalById(animalId)

		animMo:updateName(name)
		FloatWordMgr.instance:show(lang("petzoo_rename_success"))
		GlobalDispatcher:dispatch(GlobalNotify.OnZooUpdateAnimalData)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnZooChangeAnimalName, animalId, status)
end

function ZooController:sendPM_ZooRecycleAnimalReq(animalId)
	self._recycleAnimalId = animalId

	ZooAgent.instance:sendPM_ZooRecycleAnimalReq(animalId)
end

function ZooController:onZooRecycleAnimal(msg)
	if self._recycleAnimalId == 0 then
		return
	end

	local animalId = self._recycleAnimalId

	self._recycleAnimalId = 0

	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:recycleAnimal(animalId)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooUpdateAnimalData)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooRecycleAnimal, animalId)
end

function ZooController:sendPM_ZooHandleLostAnimalReq(animalId, handleType, actualId)
	self._lastLostAnimalId = animalId
	self._lastLostAnimalHandleType = handleType
	self._lastLostAnimalActualId = actualId

	ZooAgent.instance:sendPM_ZooHandleLostAnimalReq(actualId, handleType)
end

function ZooController:onZooHandleLostAnimal(msg)
	if self._lastLostAnimalId == 0 then
		return
	end

	local animalId = self._lastLostAnimalId
	local handleType = self._lastLostAnimalHandleType

	self._lastLostAnimalId = 0
	self._lastLostAnimalHandleType = 0
	self._lastLostAnimalActualId = 0

	if handleType == AnimalModel.LostAnimalHandleType_Feed then
		FloatWordMgr.instance:show(ZooConfig.instance:getGoodActIncMoralString())
		ZooSceneController.instance:removePet(animalId)
	elseif handleType == AnimalModel.LostAnimalHandleType_SendHomd then
		FloatWordMgr.instance:show(ZooConfig.instance:getGoodActIncMoralString())
		ZooSceneController.instance:removePet(animalId)
	elseif handleType == AnimalModel.LostAnimalHandleType_Ingore then
		FloatWordMgr.instance:show(ZooConfig.instance:getBadActIncMoralString())
		ZooSceneController.instance:setLostAnimalTimer(animalId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnZooHandleLostAnimal, animalId, handleType)
end

function ZooController:onGetEggFromTravelMan(msg)
	local myZoo = ZooModel.instance:getMyZoo()
	local newTime = ServerTime.now() + ZooConfig.instance:getTravelManCD()

	myZoo:setTravelerEndTime(newTime * 1000)
	UIStateManager.instance:push(ViewName.ZoogetanimaleggView, ZooModel.instance:getEggById(msg.eggId))
	GlobalDispatcher:dispatch(GlobalNotify.OnZooGetEggFromTraveler)
end

function ZooController:sendPM_ZooStealFruitReq(friendId)
	self._lastStealFriutFriendId = friendId

	ZooAgent.instance:sendPM_ZooStealFruitReq(friendId)
end

function ZooController:onStealFruit(msg)
	if self._lastStealFriutFriendId == 0 then
		return
	end

	local friendId = self._lastStealFriutFriendId

	self._lastStealFriutFriendId = 0

	if msg.stealNum > 0 then
		local myZoo = ZooModel.instance:getMyZoo()

		myZoo:setStealFruitNum(myZoo:getStealFruitNum() + msg.stealNum)

		local zooInfo = ZooModel.instance:getZoo(friendId)

		if zooInfo then
			FloatWordMgr.instance:show(ZooConfig.instance:getBadActIncMoralString())
			zooInfo:setTreeRefreshTime(checknumber(msg.treeRefreshTime))
			zooInfo:setTreeFruitsNum(checknumber(msg.treeFruitNum))
			zooInfo:setHasBeenStealFruitNum(zooInfo:getHasBeenStealFruitNum() + msg.stealNum)
		end
	else
		FloatWordMgr.instance:show(lang("petzoo_stealfriuts_stolenover"))
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnStealFriendFruits, self._lastStealFriutFriendId)
end

function ZooController:onGainFriuts(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setTreeRefreshTime(ServerTime.now() * 1000)
	myZoo:setTreeFruitsNum(0)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooGainFriuts)
end

function ZooController:sendPM_ZooDigTreasureReq(friendId, triggerId)
	ZooSceneController.instance:setHasDiggedTreasure(friendId, triggerId)
	ZooAgent.instance:sendPM_ZooDigTreasureReq()
end

function ZooController:onDigTreasure(msg)
	local myZoo = ZooModel.instance:getMyZoo()
	local hasDigTimes = myZoo:getHasDigTreasureTimes()

	myZoo:setHasDigTreasureTimes(hasDigTimes + 1)
	FloatWordMgr.instance:show(ZooConfig.instance:getBadActIncMoralString())
	GlobalDispatcher:dispatch(GlobalNotify.ZooDigEd)
end

function ZooController:sendPM_ZooFeedBuddyAnimalReq(friendId)
	self._lastFeedBuddyAnimalFriend = friendId

	ZooAgent.instance:sendPM_ZooFeedBuddyAnimalReq()
end

function ZooController:onFeedBuddyAnimal(msg)
	if self._lastFeedBuddyAnimalFriend == 0 then
		return
	end

	local friendId = self._lastFeedBuddyAnimalFriend

	self._lastFeedBuddyAnimalFriend = 0

	local myZooInfo = ZooModel.instance:getMyZoo()
	local currTimes = myZooInfo:getHasFeedBuddyAnimalTimes()

	myZooInfo:setHasFeedBuddyAnimalTimes(currTimes + 1)
	GlobalDispatcher:dispatch(GlobalNotify.OnFeedBuddyAnimal, friendId)
end

function ZooController:sendPM_ZooFeedAnimalReq(animalId)
	self._lastFeedAnimalId = animalId

	ZooAgent.instance:sendPM_ZooFeedAnimalReq(animalId)
end

function ZooController:onZooFeedAnimal(msg)
	if self._lastFeedAnimalId == 0 then
		return
	end

	local animalId = self._lastFeedAnimalId

	self._lastFeedAnimalId = 0

	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = myZoo:getAnimalById(animalId)

	animalMo:setExp(msg.exp)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooUpdateAnimalData)
	GlobalDispatcher:dispatch(GlobalNotify.OnFeedAnimal, animalId)
end

function ZooController:sendPM_ZooSetAbsorbDeviceReq(friendId)
	self._lastSetAbsorbDeviceFriendId = friendId

	ZooAgent.instance:sendPM_ZooSetAbsorbDeviceReq(friendId)
end

function ZooController:onSetAbsorbDevice(msg)
	if self._lastSetAbsorbDeviceFriendId == 0 then
		return
	end

	local friendId = self._lastSetAbsorbDeviceFriendId

	self._lastSetAbsorbDeviceFriendId = 0

	local zooInfo = ZooModel.instance:getZoo(friendId)

	if not zooInfo then
		return
	end

	local absorbDevice = {}

	absorbDevice.absorbBuddyId = friendId
	absorbDevice.absorbCdEndTime = 0
	absorbDevice.absorbStartTime = ServerTime.now() * 1000
	absorbDevice.absorbAccumulateTime = 0

	if msg:HasField("absorbMaxEndTime") then
		absorbDevice.absorbAccumulateTime = math.max(0, ZooConfig.instance:getMaxAbsorbTime() * 1000 - (msg.absorbMaxEndTime - ServerTime.now() * 1000))
	end

	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setAbsorbDevice(absorbDevice)
	zooInfo:setHatchInfos(msg.hatchSlotInfo)
	FloatWordMgr.instance:show(ZooConfig.instance:getBadActIncMoralString())
	GlobalDispatcher:dispatch(GlobalNotify.OnSetAbsorbDevice, friendId)
end

function ZooController:onZooUninstallAbsorbDevice(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setHatchInfos(msg.hatchSlotInfo)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooUninstallAbsorbDevice)
end

function ZooController:sendPM_ZooGainAbsorbDevicePrizeReq(friendId)
	self._lastGainAbsorbFriend = friendId or 0

	ZooAgent.instance:sendPM_ZooGainAbsorbDevicePrizeReq()
end

function ZooController:onGainAbsorbDevicePrize(msg)
	local friendId = self._lastGainAbsorbFriend

	self._lastGainAbsorbFriend = 0

	local zooInfo = ZooModel.instance:getMyZoo()

	if zooInfo then
		zooInfo:resetAbsorbDevice()
	end

	if friendId and friendId ~= 0 then
		local friendZooInfo = ZooModel.instance:getZoo(friendId)

		if friendZooInfo then
			friendZooInfo:resetAbsorbStates()
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnZooGainFriendAbsorbPrize, friendId)
end

function ZooController:_gmZooHatchSlotProcess(status, msg)
	if status == 0 then
		local myZoo = ZooModel.instance:getMyZoo()

		for i, value in ipairs(msg.animalInfo) do
			local animalMo = AnimalModel.New()

			animalMo:initData(value)
			myZoo:addAnimal(animalMo)
		end

		myZoo:setAbsorbDevice(msg.absorbDevice)
		GlobalDispatcher:dispatch(GlobalNotify.OnZooUpdateAnimalData)
	end
end

function ZooController:getEffectiveGeneByGeneInfo(geneInfo)
	local effectiveGene = {}

	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.headGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.headWearGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.expressionGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.foreheadGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.tailWearGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.backWearGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.weaponGenes))
	table.insert(effectiveGene, self:getEffectiveGene(geneInfo.clothesGenes))

	return effectiveGene
end

function ZooController:getEffectiveGene(genes)
	local priority, geneId = 0

	if genes and type(genes) == "table" and #genes > 0 then
		for i, id in ipairs(genes) do
			local cfg = ZooConfig.instance:getGene(id)

			if cfg == nil then
				printError(string.format(ZooConfig.GENENULLERRORTIP, id))
			elseif priority < cfg.priority then
				priority = cfg.priority
				geneId = id
			elseif cfg.priority == priority and geneId < id then
				geneId = id
			end
		end
	end

	return geneId
end

function ZooController:openSelectView(selectType, callBack, list, model, maxNum, tipText)
	UIStateManager.instance:push(ViewName.ZooselectView, selectType or ZooController.ANIMALTYPE, callBack, list, model or ZooController.Once, tonumber(maxNum) or 8, tipText or "进行孵化")
end

function ZooController:checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$") then
		self:_updateTips(-2608)
	elseif realLen < 2 then
		self:_updateTips(-2606)
	elseif isAllNum then
		self:_updateTips(-2612)
	elseif isAllUnderLine then
		self:_updateTips(-2613)
	elseif realLen > 7 then
		self:_updateTips(-2607)
	else
		isValid = true
	end

	return isValid
end

function ZooController:_updateTips(status)
	if not resultCode[status] then
		FloatWordMgr.instance:show(resultCode[status])
	end
end

function ZooController:onZooNotifyInstallAbsorbDevice(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setHatchInfos(msg.hatchSlotInfo)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyInstallAbsorbDevice, friendId)
end

function ZooController:onZooNotifyUnistallAbsorbDevice(msg)
	local myZoo = ZooModel.instance:getMyZoo()
	local absorbDevice = myZoo:getAbsorbDevice()
	local friendId = absorbDevice.absorbBuddyId

	myZoo:setAbsorbDevice(msg.absorbDevice)

	local friendZoo = ZooModel.instance:getZoo(friendId)

	if friendZoo then
		friendZoo:setHatchInfos(msg.hatchSlotInfo)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnNotifyZooUnistallAbsorbDevice, friendId)
end

function ZooController:unlockBuilding(buildingId)
	self._lastUnlockBuildingId = buildingId

	ZooAgent.instance:sendPM_ZooUnlockBuildingReq(buildingId)
end

function ZooController:onBuildingUnlock()
	if checknumber(self._lastUnlockBuildingId) == 0 then
		return
	end

	local buildingId = self._lastUnlockBuildingId

	self._lastUnlockBuildingId = 0

	ZooModel.instance:onBuildingUnlock(buildingId)
	GlobalDispatcher:dispatch(GlobalNotify.OnUnlockBuilding, buildingId)
end

function ZooController:onBuildingLevelup(buildingType)
	ZooModel.instance:onBuildingLevelup(buildingType)
	GlobalDispatcher:dispatch(GlobalNotify.OnLevelupBuilding, buildingType)
end

function ZooController:onBuildingTreeLevelup(msg)
	ZooModel.instance:onBuildingTreeLevelup(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnLevelupBuilding, ZooBuildingType.Tree)
end

function ZooController:onWorkBuildingLevelup(building)
	local buildingType = ZooModel.instance:getElemBuildingType(building.buildingId)

	ZooModel.instance:onWorkBuildingLevelup(building)
	GlobalDispatcher:dispatch(GlobalNotify.OnLevelupBuilding, buildingType)
end

function ZooController:onInZooAnimalInteract()
	local myZoo = ZooModel.instance:getMyZoo()
	local inZooInteractTimes = myZoo:getHasInZooInteractTimes()

	myZoo:setHasInZooInteractTimes(inZooInteractTimes + 1)
end

function ZooController:sendPM_ZooShowSharedAnimalReq(senderId, animalId)
	self._lastShowSharedSenderId = senderId

	ZooAgent.instance:sendPM_ZooShowSharedAnimalReq(senderId, animalId)
end

function ZooController:onZooShowSharedAnimal(msg)
	if self._lastShowSharedSenderId == 0 then
		return
	end

	local senderId = self._lastShowSharedSenderId

	self._lastShowSharedSenderId = 0

	local animalMo = AnimalModel.New()

	animalMo:initData(msg.info)
	UIStateManager.instance:push(ViewName.ZooOtherAnimalInfoView, animalMo, senderId)
end

function ZooController:gainWorkBuildingProduction(buildingId)
	self._lastGainProductionBuildingId = buildingId

	ZooAgent.instance:sendPM_ZooGainWorkBuildingProductionReq(buildingId)
end

function ZooController:onGainWorkBuildingProduction(msg)
	if self._lastGainProductionBuildingId == 0 then
		return
	end

	local buildingId = self._lastGainProductionBuildingId

	self._lastGainProductionBuildingId = 0

	local myZoo = ZooModel.instance:getMyZoo()
	local building = myZoo:getBuildingById(buildingId)

	if building then
		myZoo:updateWorkingBuildingInfo(buildingId, building.buildingLevel, 0, ServerTime.nowMs(), building.workAnimalIds or {})
	end
end

function ZooController:onZooNotifyBeStolenFruit(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	myZoo:setTreeInfo(msg.treeLv, msg.treeRefreshTime, msg.treeFruitNum)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyFriutsStolen)
end

function ZooController:onZooNotifyGainEgg(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	if not myZoo then
		return
	end

	for i, eggInfo in ipairs(msg.eggInfos) do
		local eggMo = AnimalEggModel.New()

		eggMo:initData({
			id = eggInfo.id,
			raceId = eggInfo.animalRace,
			geneInfo = eggInfo.gene
		})
		myZoo:addEgg(eggMo)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ZooGainEgg)
end

function ZooController:onZooGainBuildingsProduction(msg)
	local myZoo = ZooModel.instance:getMyZoo()

	if msg:HasField("treeFruitNum") then
		myZoo:setTreeFruitsNum(msg.treeFruitNum)
	end

	if msg:HasField("treeRefreshTime") then
		myZoo:setTreeRefreshTime(msg.treeRefreshTime)
	end

	for i = 1, #msg.workBuildings do
		ZooModel.instance:updateWorkingBuilding(msg.workBuildings[i])
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnZooGainBuildingsProduction)
end

function ZooController:onZooExchangeItem(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooExchangeItem)
end

ZooController.instance = ZooController.New()

return ZooController
