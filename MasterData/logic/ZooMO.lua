-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/ZooMO.lua

module("logic.extensions.petzoo.model.ZooMO", package.seeall)

local ZooMO = class("ZooMO")

ZooMO.absorbDeviceState_Cant = -1
ZooMO.absorbDeviceState_Ok = 0
ZooMO.absorbDeviceState_Absorbing = 1
ZooMO.absorbDeviceState_CD = 2
ZooMO.absorbDeviceState_FriendAbsorbed = 3
ZooMO.absorbDeviceState_NoPlace = 4
ZooMO.absorbDeviceState_MinAbaorbTimeLimit = 5
ZooMO.absorbDeviceState_NotFriend = 6
ZooMO.absorbDeviceState_AbaorbMax = 7

function ZooMO:ctor()
	self._userId = nil
	self._buildings = nil
	self._zooName = nil
	self._eggs = nil
	self._hasStealFriutsNum = 0
	self._hasBeenStealFriutsNum = 0
	self._lostAnimals = nil
	self._animalsMO = nil
	self._hasDigTreasureTimes = 0
	self._hasInZooInteractTimes = 0
	self._hasFeedBuddyAnimalTimes = 0
end

function ZooMO:isMyZoo()
	return self._userId == RoleModel.instance:getUserId()
end

function ZooMO:setAnimalsMO(animalsMO)
	self._animalsMO = animalsMO

	if self:isMyZoo() then
		self:_refreshAnimalsWorkingState()
	end
end

function ZooMO:getAnimalsMO(animalsMO)
	return self._animalsMO
end

function ZooMO:getZooName()
	return self._zooName
end

function ZooMO:setZooName(zooName)
	self._zooName = zooName
end

function ZooMO:getZooUserId()
	return self._userId
end

function ZooMO:setZooUserId(userId)
	self._userId = userId
end

function ZooMO:setEggs(animalEggInfo)
	self._eggs = {}

	for i, eggInfo in ipairs(animalEggInfo or {}) do
		local id = tonumber(eggInfo.id)

		self._eggs[id] = AnimalEggModel.New()

		self._eggs[id]:initData(eggInfo)
	end
end

function ZooMO:addEgg(eggMo)
	self._eggs[eggMo.id] = eggMo
end

function ZooMO:removeEggById(id)
	if self._eggs then
		self._eggs[id] = nil
	end
end

function ZooMO:getEggById(id)
	if self._eggs then
		return self._eggs[id]
	end
end

function ZooMO:getEggs()
	local result = {}

	for key, value in pairs(self._eggs or {}) do
		table.insert(result, value)
	end

	return result
end

function ZooMO:setHatchInfos(hatchSlotInfo)
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	eggMachine:setHatchInfos(hatchSlotInfo)
end

function ZooMO:getHatchInfos()
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	return eggMachine:getHatchInfos()
end

function ZooMO:resetAbsorbStates()
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	return eggMachine:resetAbsorbStates()
end

function ZooMO:setHatchInfoByIndex(index, slotInfo)
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	eggMachine:setHatchInfoByIndex(index, slotInfo)
end

function ZooMO:getHatchInfoByIndex(index)
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	return eggMachine:getHatchInfoByIndex(index)
end

function ZooMO:clearHatchInfoByIndex(index)
	local eggMachine = self:getBuildingByType(ZooBuildingType.EggsMachine)

	eggMachine:clearHatchInfoByIndex(index, slotInfo)
end

function ZooMO:setTravelerEndTime(travelEndTime)
	local taverler = self:getBuildingByType(ZooBuildingType.Traveler)

	taverler.travelEndTime = math.ceil(checknumber(travelEndTime or 0) / 1000)
end

function ZooMO:getTravelerEndTime()
	local taverler = self:getBuildingByType(ZooBuildingType.Traveler)

	return taverler.travelEndTime or 0
end

function ZooMO:setTreeRefreshTime(refreshTime)
	local tree = self:getBuildingByType(ZooBuildingType.Tree)

	tree.treeRefreshTime = math.ceil(checknumber(refreshTime or 0) / 1000)
end

function ZooMO:getTreeRefreshTime()
	local tree = self:getBuildingByType(ZooBuildingType.Tree)

	return tree.treeRefreshTime
end

function ZooMO:setTreeFruitsNum(fruitsNum)
	local tree = self:getBuildingByType(ZooBuildingType.Tree)

	tree.treeFruitNum = fruitsNum
end

function ZooMO:getTreeFruitsNum()
	local tree = self:getBuildingByType(ZooBuildingType.Tree)

	return tree.treeFruitNum
end

function ZooMO:setHasInZooInteractTimes(hasInZooInteractTimes)
	self._hasInZooInteractTimes = hasInZooInteractTimes
end

function ZooMO:getHasInZooInteractTimes(buildingType)
	return self._hasInZooInteractTimes
end

function ZooMO:setTreeInfo(treeLv, treeRefreshTime, treeFruitNum)
	local tree = self:getBuildingByType(ZooBuildingType.Tree)

	tree.buildingLevel = checknumber(treeLv)
	tree.treeRefreshTime = math.ceil(checknumber(treeRefreshTime or 0) / 1000)
	tree.treeFruitNum = treeFruitNum
end

function ZooMO:getTree()
	return self:getBuildingByType(ZooBuildingType.Tree)
end

function ZooMO:setStealFruitNum(num)
	self._hasStealFriutsNum = num
end

function ZooMO:getStealFruitNum()
	return self._hasStealFriutsNum
end

function ZooMO:setHasBeenStealFruitNum(num)
	self._hasBeenStealFriutsNum = num
end

function ZooMO:getHasBeenStealFruitNum()
	return self._hasBeenStealFriutsNum
end

function ZooMO:setHasFeedBuddyAnimalTimes(num)
	self._hasFeedBuddyAnimalTimes = num
end

function ZooMO:getHasFeedBuddyAnimalTimes()
	return self._hasFeedBuddyAnimalTimes
end

function ZooMO:setLostAnimals(lostAnimals)
	self._lostAnimals = {}

	if not lostAnimals then
		return
	end

	for i, v in ipairs(lostAnimals) do
		local animalMo = AnimalModel.New()

		animalMo:initData(v)

		animalMo.id = i * -1

		animalMo:updateName(lang("petzoo_building_lostanimal_name"))

		self._lostAnimals[animalMo.id] = {
			animalMo = animalMo,
			id = v.id
		}
	end
end

function ZooMO:getLostAnimals()
	return self._lostAnimals
end

function ZooMO:getLostAnimal(id)
	if self._lostAnimals then
		return self._lostAnimals[id]
	end
end

function ZooMO:getLostAnimalMo(id)
	if self._lostAnimals and self._lostAnimals[id] then
		return self._lostAnimals[id].animalMo
	end
end

function ZooMO:deleteLostAnimal(id)
	self._lostAnimals[id] = nil
end

function ZooMO:clearAllInZooAnimals()
	local animalList = self:getAnimalList()

	for index, value in pairs(animalList or {}) do
		value.place = false
	end
end

function ZooMO:addAnimal(animalMo)
	if self._animalsMO then
		self._animalsMO:addAnimal(animalMo)

		if self:isMyZoo() then
			self:getAllPetAttr(true)
		end
	end
end

function ZooMO:recycleAnimal(id)
	if self._animalsMO then
		self._animalsMO:recycleAnimal(id)

		if self:isMyZoo() then
			self:getAllPetAttr(true)
		end
	end
end

function ZooMO:setAnimalList(animalList)
	self._animalsMO = ZooAnimalsMO.New()

	self._animalsMO:setAnimalList(animalList)

	if self:isMyZoo() then
		self:_refreshAnimalsWorkingState()
		self:getAllPetAttr(true)
	end
end

function ZooMO:setAllAnimalsPlaced()
	if self._animalsMO then
		self._animalsMO:setAnimalsPlaced(true)
	end
end

function ZooMO:getAnimalById(animalId)
	if self._animalsMO then
		return self._animalsMO:getAnimalById(animalId)
	end
end

function ZooMO:getAnimalList()
	if self._animalsMO then
		return self._animalsMO:getAnimalList()
	end

	return {}
end

function ZooMO:isAnimalInWorking(id)
	for i = 1, #ZooModel.WorkBuildingTypes do
		local building = self:getBuildingByType(ZooModel.WorkBuildingTypes[i])

		if building.workAnimalIds and table.indexof(workAnimalIds, id) ~= false then
			return true
		end
	end

	return false
end

function ZooMO:getPlaceAnimalIds()
	local animalList, result = self:getAnimalList(), {}

	for index, value in pairs(animalList or {}) do
		if value.place then
			table.insert(result, value.id)
		end
	end

	return result
end

function ZooMO:getCanPlaceAnimalList()
	local animalList, result = self:getAnimalList(), {}

	for index, value in pairs(animalList or {}) do
		if value:isCanPlace() then
			table.insert(result, value)
		end
	end

	return result
end

function ZooMO:getCanWorkingAnimalList()
	local animalList, result = self:getAnimalList(), {}

	for index, value in pairs(animalList or {}) do
		if value:isCanWorking() then
			table.insert(result, value)
		end
	end

	return result
end

function ZooMO:getCanPairAnimalList(raceId)
	local animalList, result = self:getAnimalList(), {}
	local now = ServerTime.now()

	for i, animal in ipairs(animalList) do
		if not animal:isMatchCDByTime(now) and animal.restMatchTimes > 0 and animal.raceId == raceId then
			table.insert(result, animal)
		end
	end

	return result
end

function ZooMO:setAnimalFollowed(id, isFollow)
	if self._animalsMO then
		self._animalsMO:setAnimalFollowed(id, isFollow)
	end
end

function ZooMO:setHasDigTreasureTimes(hasDigTreasureTimes)
	self._hasDigTreasureTimes = hasDigTreasureTimes
end

function ZooMO:getHasDigTreasureTimes()
	return self._hasDigTreasureTimes
end

function ZooMO:getAbsorbDeviceStatus(friendId)
	local device = self:getAbsorbDevice()
	local absorbBuddyId = checknumber(device.absorbBuddyId)

	if absorbBuddyId == 0 then
		local absorbedTime = device:getAbsorbedTime()

		if absorbedTime > 0 and absorbedTime >= ZooConfig.instance:getMaxAbsorbTime() then
			return ZooMO.absorbDeviceState_AbaorbMax
		end
	end

	if friendId then
		if absorbBuddyId > 0 then
			return ZooMO.absorbDeviceState_Absorbing
		end

		local now = ServerTime.now()

		if now < device.absorbCdEndTime then
			return ZooMO.absorbDeviceState_CD
		end

		local friendZoo = ZooModel.instance:getZoo(friendId)

		if not friendId then
			return ZooMO.absorbDeviceState_Cant
		end

		local hatchSlots = friendZoo:getHatchInfos()

		for i = 1, #hatchSlots do
			local hatchInfo = hatchSlots[i]

			if checknumber(hatchInfo.absorbBuddyId) > 0 and hatchInfo.animalRace > 0 then
				return ZooMO.absorbDeviceState_FriendAbsorbed
			end
		end

		local friendMo = FriendModel.instance:getFriendMo(friendId)
		local isFriend = friendMo and friendMo:IsFriend()

		if not isFriend then
			return ZooMO.absorbDeviceState_NotFriend
		end

		local maxHatchTime = 0
		local isHatching = false

		for i = 1, #hatchSlots do
			local hatchInfo = hatchSlots[i]

			if hatchInfo.animalRace > 0 then
				local surplusTime = hatchInfo:getHatchSurplusTime()

				if maxHatchTime < surplusTime then
					maxHatchTime = surplusTime
				end

				isHatching = true
			end
		end

		if not isHatching then
			return ZooMO.absorbDeviceState_NoPlace
		end

		local deviceMinHatchTime = ZooConfig.instance:getAbsorbNeedRestHatchTime()

		if maxHatchTime < deviceMinHatchTime then
			return ZooMO.absorbDeviceState_MinAbaorbTimeLimit
		end

		return ZooMO.absorbDeviceState_Ok
	else
		return ZooMO.absorbDeviceState_Cant
	end
end

function ZooMO:setAbsorbDevice(absorbDevice)
	self._absorbDevice = nil

	if absorbDevice then
		self._absorbDevice = AbsorbDeviceMO.New()
		self._absorbDevice.absorbBuddyId = absorbDevice.absorbBuddyId
		self._absorbDevice.absorbStartTime = checknumber(absorbDevice.absorbStartTime) / 1000
		self._absorbDevice.absorbCdEndTime = checknumber(absorbDevice.absorbCdEndTime) / 1000
		self._absorbDevice.absorbAccumulateTime = checknumber(absorbDevice.absorbAccumulateTime) / 1000
	end
end

function ZooMO:getAbsorbDevice()
	return self._absorbDevice
end

function ZooMO:resetAbsorbDevice()
	if self._absorbDevice then
		self._absorbDevice.absorbBuddyId = 0
		self._absorbDevice.absorbStartTime = 0
		self._absorbDevice.absorbCdEndTime = ServerTime.now() + ZooConfig.instance:getAbsorbCDInterval()
		self._absorbDevice.absorbAccumulateTime = 0
	end
end

function ZooMO:buildAllBuildings()
	self._buildings = {}

	for k, v in pairs(ZooBuildingType) do
		if v ~= ZooBuildingType.None then
			self._buildings[v] = ZooBuildingFactory.createBuilding(self, v)
		end
	end
end

function ZooMO:setMainBuildingLevel(lv)
	self:setBuildingLevel(ZooBuildingType.Main, lv)
end

function ZooMO:getMainBuildingLevel()
	return self:getBuildingLevel(ZooBuildingType.Main)
end

function ZooMO:setShopBuildingLevel(lv)
	self:setBuildingLevel(ZooBuildingType.Shop, lv)
end

function ZooMO:getShopBuildingLevel()
	return self:getBuildingLevel(ZooBuildingType.Shop)
end

function ZooMO:setBuildingLevel(buildingType, lv)
	local building = self:getBuildingByType(buildingType)

	if building then
		building.buildingLevel = lv
	end
end

function ZooMO:getBuildingLevel(buildingType)
	local building = self:getBuildingByType(buildingType)

	if building then
		return building.buildingLevel
	end

	return 0
end

function ZooMO:onBuildingLevelup(buildingType)
	local building = self:getBuildingByType(buildingType)

	if building then
		building:onBuildingLevelup()
	end
end

function ZooMO:getBuildings()
	return self._buildings
end

function ZooMO:getMainBuilding()
	return self:getBuildingByType(ZooBuildingType.Main)
end

function ZooMO:getBuildingById(elemId)
	if not self._buildings then
		return
	end

	for k, v in pairs(self._buildings) do
		if v:getBuildingId() == elemId then
			return v
		end
	end
end

function ZooMO:getBuildingByType(buildingType)
	if not self._buildings then
		return
	end

	return self._buildings[buildingType]
end

function ZooMO:setBuildingUnlockInfo(unlockInfos)
	if not self._buildings then
		return
	end

	for k, v in pairs(self._buildings) do
		v.isUnlocked = false
	end

	if unlockInfos then
		for i = 1, #unlockInfos do
			local building = self:getBuildingById(unlockInfos[i])

			building.isUnlocked = true
		end
	end

	for k, v in pairs(self._buildings) do
		if not v.isUnlocked and checknumber(v:getUnlockNeedMainLv()) == 0 then
			v.isUnlocked = true
		end
	end
end

function ZooMO:setBuildingUnlocked(buildingId, isUnlock)
	if not self._buildings then
		return
	end

	local building = self:getBuildingById(buildingId)

	building.isUnlocked = isUnlock
end

function ZooMO:isBuildingUnlocked(buildingId)
	if not self._buildings then
		return false
	end

	local building = self:getBuildingById(buildingId)

	return building.isUnlocked
end

function ZooMO:updateWorkingBuildings(workBuildings)
	for i = 1, #workBuildings do
		local workBuilding = workBuildings[i]

		self:updateWorkingBuildingInfo(workBuilding.buildingId, workBuilding.level, workBuilding.curNum, workBuilding.refreshTime, workBuilding.workAnimalIds)
	end
end

function ZooMO:updateWorkingBuildingInfo(buildingId, level, curNum, refreshTime, workAnimalIds)
	if not self._buildings then
		return
	end

	local building = self:getBuildingById(buildingId)

	if building.workAnimalIds then
		for i = 1, #building.workAnimalIds do
			if building.workAnimalIds[i] > 0 then
				local animMo = self:getAnimalById(building.workAnimalIds[i])

				if animMo then
					animMo.working = false
				end
			end
		end
	end

	building.buildingLevel = level
	building.currScore = curNum
	building.workAnimalIds = workAnimalIds
	building.refreshTime = refreshTime / 1000
	building.currWorkerNum = 0

	for i = 1, #building.workAnimalIds do
		if building.workAnimalIds[i] > 0 then
			building.currWorkerNum = building.currWorkerNum + 1
		end
	end

	for i = 1, #workAnimalIds do
		if workAnimalIds[i] > 0 then
			local animMo = self:getAnimalById(workAnimalIds[i])

			if animMo then
				animMo.working = true
			end
		end
	end
end

function ZooMO:_refreshAnimalsWorkingState()
	for i = 1, #ZooModel.WorkBuildingTypes do
		local building = self:getBuildingByType(ZooModel.WorkBuildingTypes[i])

		if building.workAnimalIds then
			for i = 1, #building.workAnimalIds do
				if building.workAnimalIds[i] > 0 then
					local animMo = self:getAnimalById(building.workAnimalIds[i])

					if animMo then
						animMo.working = true
					end
				end
			end
		end
	end
end

function ZooMO:getPlacedMaxAnimalNum()
	local building = self:getMainBuilding()

	return building:getAnimalNum()
end

function ZooMO:getAllPetAttr(force)
	if self._animalsMO then
		return self._animalsMO:getAllPetAttr(force)
	end
end

function ZooMO:getPetAttrByProps(propertyGenes)
	if self._animalsMO then
		return self._animalsMO:getPetAttrByProps(propertyGenes)
	end
end

return ZooMO
