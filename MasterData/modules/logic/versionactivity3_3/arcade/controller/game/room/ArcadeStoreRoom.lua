-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/room/ArcadeStoreRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.room.ArcadeStoreRoom", package.seeall)

local ArcadeStoreRoom = class("ArcadeStoreRoom", ArcadeInteractRoom)

function ArcadeStoreRoom:onCtor()
	return
end

function ArcadeStoreRoom:onEnter()
	ArcadeGameModel.instance:clearGoodsHasResetTimes()
end

function ArcadeStoreRoom:resetGoods()
	ArcadeGameController.instance:removeEntityListByType(ArcadeGameEnum.EntityType.Goods)

	local goodsDataList = {}

	self:_fillInteractData(goodsDataList)
	ArcadeGameController.instance:tryAddEntityList(goodsDataList, true, false)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_dazhao_kjl)
end

function ArcadeStoreRoom:_fillInteractData(refDataList)
	local goodsList = {}
	local interactiveList = ArcadeConfig.instance:getRoomInitInteractiveList(self.id)

	for _, interactive in ipairs(interactiveList) do
		local interactiveId = interactive.id
		local isGoods = ArcadeConfig.instance:getIsGoodsInteractive(interactiveId)

		if isGoods then
			goodsList[#goodsList + 1] = interactive
		else
			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(interactiveId)

			refDataList[#refDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.BaseInteractive,
				id = interactiveId,
				x = interactive.x,
				y = interactive.y,
				sizeX = sizeX,
				sizeY = sizeY
			}
		end
	end

	self:_fillGoodsData(refDataList, goodsList)
end

function ArcadeStoreRoom:_fillGoodsData(refDataList, goodsList)
	local collectionList, totalWeight = self:_getCollectionList()
	local remainCount = #collectionList

	if remainCount <= 0 or totalWeight <= 0 then
		return
	end

	local hasFoundDict = {}
	local randomDiscountIndex = math.random(#goodsList)

	for i, goods in ipairs(goodsList) do
		local goodsInteractiveId = goods.id

		remainCount = #collectionList

		if #collectionList <= 0 or totalWeight <= 0 then
			collectionList, totalWeight = self:_getCollectionList(hasFoundDict)
		end

		local findCollectionId
		local sumWeight = 0
		local randomWeight = math.random(totalWeight)

		for j, collectionId in ipairs(collectionList) do
			local weight = ArcadeConfig.instance:getCollectionGoodsWeight(collectionId)

			sumWeight = sumWeight + weight

			if randomWeight <= sumWeight then
				totalWeight = totalWeight - weight
				findCollectionId = collectionId

				table.remove(collectionList, j)

				break
			end
		end

		if findCollectionId then
			hasFoundDict[findCollectionId] = true

			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(goodsInteractiveId)

			refDataList[#refDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.Goods,
				id = goodsInteractiveId,
				x = goods.x,
				y = goods.y,
				sizeX = sizeX,
				sizeY = sizeY,
				extraParam = {
					isDiscount = randomDiscountIndex == i,
					collectionId = findCollectionId
				}
			}
		end
	end
end

function ArcadeStoreRoom:_getCollectionList(hasFoundDict)
	local totalWeight = 0
	local collectionList = {}
	local allCollectionIdList = ArcadeConfig.instance:getCollectionIdList()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	for _, collectionId in ipairs(allCollectionIdList) do
		local isUnique = ArcadeConfig.instance:getCollectionIsUnique(collectionId)
		local alreadyFind = hasFoundDict and hasFoundDict[collectionId]
		local characterHas = characterMO and characterMO:getHasCollection(collectionId)
		local weight = ArcadeConfig.instance:getCollectionGoodsWeight(collectionId)

		if isUnique and (alreadyFind or characterHas) then
			weight = 0
		end

		if weight and weight > 0 then
			totalWeight = totalWeight + weight
			collectionList[#collectionList + 1] = collectionId
		end
	end

	return collectionList, totalWeight
end

function ArcadeStoreRoom:onExit()
	return
end

function ArcadeStoreRoom:onClear()
	return
end

return ArcadeStoreRoom
