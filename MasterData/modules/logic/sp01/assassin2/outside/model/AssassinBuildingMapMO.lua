-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinBuildingMapMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingMapMO", package.seeall)

local AssassinBuildingMapMO = pureTable("AssassinBuildingMapMO")

function AssassinBuildingMapMO:clearData()
	self.unlockBuildIdMap = nil
	self.buildingDict = nil
end

function AssassinBuildingMapMO:setInfo(buildInfo)
	self:_onGetBuildingInfos(buildInfo.buildings)
	self:_onGetUnlockBuildIds(buildInfo.unlockBuildIds)
end

function AssassinBuildingMapMO:_onGetUnlockBuildIds(unlockBuildIds)
	self.unlockBuildIdMap = {}

	self:updateUnlockBuildIds(unlockBuildIds)
end

function AssassinBuildingMapMO:updateUnlockBuildIds(unlockBuildIds)
	for _, buildingId in ipairs(unlockBuildIds) do
		self:_updateUnlockBuildId(buildingId)
	end
end

function AssassinBuildingMapMO:_updateUnlockBuildId(buildingId)
	if not buildingId then
		return
	end

	local buildingCo = AssassinConfig.instance:getBuildingCo(buildingId)

	if not buildingCo then
		return
	end

	self.unlockBuildIdMap[buildingId] = true

	local buildingType = buildingCo.type
	local buildingMo, isCreate = self:getOrCreateBuildingMo(buildingType)

	if isCreate then
		buildingMo:initParams(buildingType, 0)
	end
end

function AssassinBuildingMapMO:_onGetBuildingInfos(buildingInfos)
	self.buildingDict = {}

	for _, buildingInfo in ipairs(buildingInfos) do
		self:updateBuildingInfo(buildingInfo)
	end
end

function AssassinBuildingMapMO:updateBuildingInfo(buildingInfo)
	local buildingMo = self:getOrCreateBuildingMo(buildingInfo.type)

	buildingMo:init(buildingInfo)
end

function AssassinBuildingMapMO:getBuildingMo(buildingType)
	if self.buildingDict then
		return self.buildingDict
	end
end

function AssassinBuildingMapMO:getOrCreateBuildingMo(buildingType)
	local buildingMo = self:getBuildingMo(buildingType)
	local isCreate = false

	if not buildingMo then
		buildingMo = AssassinBuildingMO.New()
		self.buildingDict[buildingType] = buildingMo
		isCreate = true
	end

	return buildingMo, isCreate
end

function AssassinBuildingMapMO:getBuildingStatus(buildingId)
	local status = AssassinEnum.BuildingStatus.Locked

	if self.unlockBuildIdMap[buildingId] then
		local buildingCo = AssassinConfig.instance:getBuildingCo(buildingId)
		local buildingMo = self:getBuildingMo(buildingCo.type)
		local buildingLv = buildingMo:getLv()

		if buildingLv >= buildingCo.level then
			status = AssassinEnum.BuildingStatus.LevelUp
		elseif buildingLv == buildingCo.level - 1 then
			status = AssassinEnum.BuildingStatus.Unlocked
		end
	end

	return status
end

function AssassinBuildingMapMO:isBuildingUnlocked(buildingId)
	return buildingId and self.unlockBuildIdMap[buildingId] == true
end

function AssassinBuildingMapMO:isBuildingTypeUnlocked(buildingType)
	local buildingMo = self:getBuildingMo(buildingType)

	return buildingMo ~= nil
end

function AssassinBuildingMapMO:isBuildingLevelUp2NextLv(buildingType)
	local buildingMo = self:getBuildingMo(buildingType)
	local buildingLv = buildingMo and buildingMo:getLv() or 0
	local targetLv = buildingLv + 1
	local isMaxLv = buildingMo and buildingMo:isMaxLv()

	if targetLv <= buildingLv or isMaxLv then
		return
	end

	local nextLvBuildingCo = AssassinConfig.instance:getBuildingLvCo(buildingType, targetLv)
	local nextLvBuildingId = nextLvBuildingCo and nextLvBuildingCo.id
	local isUnlocked = self:isBuildingUnlocked(nextLvBuildingId)

	if not isUnlocked then
		return
	end

	local targetCost = nextLvBuildingCo.cost
	local curCoin = AssassinController.instance:getCoinNum()

	if curCoin < targetCost then
		return
	end

	return true, nextLvBuildingId
end

function AssassinBuildingMapMO:isAnyBuildingLevelUp2NextLv()
	for _, buildingMo in pairs(self.buildingDict) do
		if self:isBuildingLevelUp2NextLv(buildingMo:getType()) then
			return true
		end
	end
end

return AssassinBuildingMapMO
