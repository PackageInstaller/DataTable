-- chunkname: @modules/logic/room/model/mainview/RoomNavigateBubbleModel.lua

module("modules.logic.room.model.mainview.RoomNavigateBubbleModel", package.seeall)

local RoomNavigateBubbleModel = class("RoomNavigateBubbleModel", BaseModel)

function RoomNavigateBubbleModel:onInit()
	self:clear()
end

function RoomNavigateBubbleModel:reInit()
	self:clear()
end

function RoomNavigateBubbleModel:clear()
	self._categoryMap = nil

	RoomNavigateBubbleModel.super.clear(self)
end

function RoomNavigateBubbleModel:buildCategory()
	self:clear()

	self._categoryMap = {}

	self:updateFactoryProgress()
	self:updateBuildingUpgrade()
	self:updateHeroFaith()
	self:updateRoomGift()
	self:updateManufacture()
	self:updateCritterEvent()
end

function RoomNavigateBubbleModel:checkCreateCategory(categoryType)
	local mo = self._categoryMap[categoryType]

	if mo == nil then
		mo = RoomNavigateBubbleCategoryMO.New()

		mo:init(categoryType)

		self._categoryMap[categoryType] = mo
	end

	return mo
end

function RoomNavigateBubbleModel:updateFactoryProgress()
	local categoryMO = self:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	categoryMO:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)
	categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)

	local productions = RoomProductionModel.instance:getList()

	for _, mo in ipairs(productions) do
		self:collectFactoryProductProgress(mo)
	end
end

function RoomNavigateBubbleModel:updateBuildingUpgrade()
	local categoryMO = self:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	categoryMO:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	self:collectHallUpgrade()

	local productions = RoomProductionModel.instance:getList()

	for _, mo in ipairs(productions) do
		self:collectFactoryUpgrade(mo)
	end
end

function RoomNavigateBubbleModel:updateHeroFaith()
	local categoryMO = self:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	categoryMO:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	categoryMO:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull)

	local heroes = RoomCharacterModel.instance:getList()

	for _, mo in ipairs(heroes) do
		self:collectHeroFaithReward(mo)
	end
end

function RoomNavigateBubbleModel:updateRoomGift()
	local roomGiftBubbleType = RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift
	local categoryMO = self:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	categoryMO:cleanBubble(roomGiftBubbleType)
	self:collectRoomGift()
end

function RoomNavigateBubbleModel:updateManufacture()
	local manufactureBubbleType = RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture
	local categoryMO = self:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	categoryMO:cleanBubble(manufactureBubbleType)
	self:collectManufacture()
end

function RoomNavigateBubbleModel:collectFactoryProductProgress(productionLineMO)
	local cfg = productionLineMO.config
	local type = cfg and cfg.type

	if type ~= RoomProductLineEnum.ProductItemType.ProductExp and type ~= RoomProductLineEnum.ProductItemType.ProductGold then
		return
	end

	if productionLineMO.finishCount ~= 0 then
		local per, per100 = productionLineMO:getReservePer()

		if per100 >= 100 then
			local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
			local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)
			local productionLineId = productionLineMO.id

			bubbleMO:addBubbleData(productionLineId)
		end
	end
end

function RoomNavigateBubbleModel:collectHallUpgrade()
	local canLevelUp, errorCode = RoomInitBuildingHelper.canLevelUp()

	if canLevelUp then
		local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
		local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)

		bubbleMO:addBubbleData(RoomNavigateBubbleEnum.HallId)
	end
end

function RoomNavigateBubbleModel:collectFactoryUpgrade(mo)
	local canLevelUp = RoomProductionHelper.canLevelUp(mo)

	if canLevelUp then
		local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
		local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
		local productionLineId = mo.id

		bubbleMO:addBubbleData(productionLineId)
	end
end

function RoomNavigateBubbleModel:collectHeroFaithReward(mo)
	if mo.currentFaith > 0 then
		local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
		local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
		local heroId = mo.heroId

		bubbleMO:addBubbleData(heroId)
	end
end

function RoomNavigateBubbleModel:collectHeroFaithFull(mo)
	local heroId = mo.heroId

	if RoomCharacterController.instance:isCharacterFaithFull(heroId) and RoomCharacterModel.instance:isShowFaithFull(heroId) then
		local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
		local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull)

		bubbleMO:addBubbleData(heroId)
	end
end

function RoomNavigateBubbleModel:collectRoomGift()
	local canGetRoomGift = RoomGiftModel.instance:isCanGetBonus()

	if not canGetRoomGift then
		return
	end

	local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
	local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift)

	bubbleMO:addBubbleData(RoomNavigateBubbleEnum.HallId)
end

function RoomNavigateBubbleModel:collectManufacture()
	local canClaimBuildingList = ManufactureModel.instance:getAllBuildingCanClaimProducts()

	if not canClaimBuildingList or #canClaimBuildingList <= 0 then
		return
	end

	local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
	local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture)

	for _, buildingMO in ipairs(canClaimBuildingList) do
		bubbleMO:addBubbleData(buildingMO.uid)
	end
end

function RoomNavigateBubbleModel:updateCritterEvent()
	local critterMOList = CritterModel.instance:getAllCritters()
	local categoryMO = self._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]
	local bubbleMO = categoryMO:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Critter)
	local eventMOs

	for i = 1, #critterMOList do
		local critterMO = critterMOList[i]
		local isNoMoodWorking = critterMO:isNoMoodWorking()
		local isCultivating = critterMO:isCultivating()
		local hasEvent = critterMO.trainInfo:isHasEventTrigger()
		local isTrainFinish = critterMO.trainInfo:isTrainFinish()

		if isNoMoodWorking or isCultivating and (hasEvent or isTrainFinish) then
			eventMOs = eventMOs or {}

			table.insert(eventMOs, critterMO)
		end
	end

	bubbleMO:clear()

	if eventMOs then
		table.sort(eventMOs, CritterHelper.sortEvent)

		for _, critterMO in ipairs(eventMOs) do
			bubbleMO:addBubbleData(critterMO.id)
		end
	end
end

function RoomNavigateBubbleModel:sortCategory()
	for categoryType, categoryMO in pairs(self._categoryMap) do
		categoryMO:sort()
	end
end

function RoomNavigateBubbleModel:getCategoryMap()
	return self._categoryMap
end

RoomNavigateBubbleModel.instance = RoomNavigateBubbleModel.New()

return RoomNavigateBubbleModel
