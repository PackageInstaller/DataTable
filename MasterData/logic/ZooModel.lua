-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/ZooModel.lua

module("logic.extensions.zoo.model.ZooModel", package.seeall)

local ZooModel = class("ZooModel", BaseModel)

ZooModel.WorkBuildingTypes = {
	ZooBuildingType.Restaurant,
	ZooBuildingType.Cafe,
	ZooBuildingType.AmusementPark,
	ZooBuildingType.FossilQuarry
}

function ZooModel:onInit()
	self:onReset()
end

function ZooModel:onReset()
	self._avatarShowIndex = 0
	self._zooMos = nil
	self._animalMo = nil
	self._currZooMo = nil
end

function ZooModel:switchZoo(userId)
	if self._zooMos then
		self._currZooMo = self._zooMos[userId] or nil
	end
end

function ZooModel:isElemBuilding(elemId)
	return self:getElemBuildingType(elemId) ~= ZooBuildingType.None
end

function ZooModel:getElemBuildingType(elemId)
	local buildingCo = ZooConfig.instance:getBuildingCo(elemId)

	if buildingCo then
		return buildingCo.buildingType
	end

	return ZooBuildingType.None
end

function ZooModel:removeZoo(userId)
	if not self._zooMos then
		return
	end

	self._zooMos[userId] = nil
end

function ZooModel:getZoo(userId)
	if not self._zooMos then
		return
	end

	return self._zooMos[userId]
end

function ZooModel:getCurrZoo()
	return self._currZooMo
end

function ZooModel:isMyZoo()
	return self._currZooMo and self._currZooMo:isMyZoo()
end

function ZooModel:getCurZooUserId()
	return self._currZooMo and self._currZooMo:getZooUserId() or nil
end

function ZooModel:getMyZoo()
	local userId = RoleModel.instance:getUserId()

	return self:getZoo(userId)
end

function ZooModel:setZooInfo(userId, zooInfo)
	local zooMo = ZooMO.New()

	zooMo:buildAllBuildings()
	zooMo:setHatchInfos(zooInfo.hatchSlotInfo)
	zooMo:setTravelerEndTime(zooInfo.travelManEndTime)
	zooMo:setTreeInfo(zooInfo.treeLv, zooInfo.treeRefreshTime, zooInfo.treeFruitNum)
	zooMo:setStealFruitNum(zooInfo.hasStealNum or 0)
	zooMo:setHasBeenStealFruitNum(zooInfo.hasBeenStolenNum or 0)
	zooMo:setAbsorbDevice(zooInfo.absorbDevice)
	zooMo:setMainBuildingLevel(zooInfo.mainbuildingLv)
	zooMo:setShopBuildingLevel(zooInfo.shopLv or 0)
	zooMo:setBuildingUnlockInfo(zooInfo.unlockBuildingIds)
	zooMo:updateWorkingBuildings(zooInfo.workBuildings)
	zooMo:setHasDigTreasureTimes(zooInfo.hasDigTreasureTimes or 0)
	zooMo:setHasInZooInteractTimes(zooInfo.hasInZooInteractTimes or 0)
	zooMo:setZooUserId(userId)
	zooMo:setLostAnimals(zooInfo.lostAnimals)
	zooMo:setHasFeedBuddyAnimalTimes(zooInfo.hasFeedBuddyAnimalTimes or 0)

	if userId == RoleModel.instance:getUserId() then
		zooMo:setAnimalsMO(self._animalMo)
	else
		zooMo:setAnimalList(zooInfo.animalInfo)
		zooMo:setAllAnimalsPlaced()
	end

	local eggTab = {}

	for i, eggInfo in ipairs(zooInfo.animalEggInfo or {}) do
		eggTab[i] = {}
		eggTab[i].id = eggInfo.id
		eggTab[i].raceId = eggInfo.animalRace
		eggTab[i].geneInfo = eggInfo.gene
	end

	zooMo:setEggs(eggTab)

	self._zooMos = self._zooMos or {}
	self._zooMos[userId] = zooMo
end

function ZooModel:getZooLevel()
	local zooMo = self:getCurrZooInfo()

	if zooMo then
		return zooMo:getMainBuildingLevel()
	end

	return 0
end

function ZooModel:updateWorkingBuilding(building)
	local zooMo = self:getMyZoo()

	if zooMo then
		zooMo:updateWorkingBuildingInfo(building.buildingId, building.level, building.curNum, building.refreshTime, building.workAnimalIds)
	end
end

function ZooModel:isAnimalInWorking(id)
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:isAnimalInWorking(id)
	end

	return false
end

function ZooModel:getEggById(id)
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:getEggById(id)
	end
end

function ZooModel:setMyAnimalList(animalList)
	self._animalMo = ZooAnimalsMO.New()

	self._animalMo:setAnimalList(animalList)

	local zooInfo = self:getMyZoo()

	if zooInfo then
		zooInfo:setAnimalsMO(self._animalMo)
	end
end

function ZooModel:getMyAnimalList()
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:getAnimalList()
	end

	if self._animalMo then
		return self._animalMo:getAnimalList()
	end

	return {}
end

function ZooModel:getMyAnimalById(animalId)
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:getAnimalById(animalId)
	end
end

function ZooModel:getAllPetAttr(force)
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:getAllPetAttr(force)
	end
end

function ZooModel:getPetAttrByProps(propertyGenes)
	local zooMo = self:getMyZoo()

	if zooMo then
		return zooMo:getPetAttrByProps(propertyGenes)
	end
end

function ZooModel:getAvatarShowIndex()
	self._avatarShowIndex = (self._avatarShowIndex + 2) % 2048

	return self._avatarShowIndex
end

function ZooModel:onBuildingUnlock(buildingId)
	local myZoo = self:getMyZoo()

	if myZoo then
		myZoo:setBuildingUnlocked(buildingId, true)
	end
end

function ZooModel:onBuildingLevelup(buildingType)
	local myZoo = self:getMyZoo()

	if myZoo then
		myZoo:onBuildingLevelup(buildingType)
	end
end

function ZooModel:onBuildingTreeLevelup(msg)
	local myZoo = self:getMyZoo()

	if myZoo then
		myZoo:setTreeInfo(msg.newLevel, msg.treeRefreshTime, msg.treeFruitNum)
	end
end

function ZooModel:onWorkBuildingLevelup(building)
	local myZoo = self:getMyZoo()

	if myZoo then
		myZoo:updateWorkingBuildingInfo(building.buildingId, building.level, building.curNum, building.refreshTime, building.workAnimalIds)
	end
end

ZooModel.instance = ZooModel.New()

return ZooModel
