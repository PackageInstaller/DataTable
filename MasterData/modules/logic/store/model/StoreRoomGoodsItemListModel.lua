-- chunkname: @modules/logic/store/model/StoreRoomGoodsItemListModel.lua

module("modules.logic.store.model.StoreRoomGoodsItemListModel", package.seeall)

local StoreRoomGoodsItemListModel = class("StoreRoomGoodsItemListModel", TreeScrollModel)

function StoreRoomGoodsItemListModel:setMOList(moList)
	self:clear()

	local rootSpace = 24
	local rootLength = 373 + rootSpace

	table.sort(moList, self.sortFunction)

	local treeRootParam = {}

	treeRootParam.rootType = 1
	treeRootParam.rootLength = rootLength

	for i = 1, #moList do
		if moList[i].children then
			local lines = math.ceil(#moList[i].children / 4)
			local treeRootParam = {}

			treeRootParam.rootType = 1
			treeRootParam.rootLength = rootLength
			treeRootParam.nodeType = lines + 1
			treeRootParam.nodeLength = 387 * lines + 30
			treeRootParam.nodeCountEachLine = 1
			treeRootParam.nodeStartSpace = 0
			treeRootParam.nodeEndSpace = 0
			treeRootParam.isExpanded = moList[i].isExpand or false
			moList[i].treeRootParam = treeRootParam
			moList[i].children.rootindex = i

			self:addRoot(moList[i], treeRootParam, i)
			self:addNode(moList[i].children, i, 1)
		else
			local treeRootParam = {}

			treeRootParam.rootType = 1
			treeRootParam.rootLength = rootLength

			self:addRoot(moList[i], treeRootParam, i)
		end
	end

	for _, mo in pairs(moList) do
		if mo.children then
			table.sort(mo.children, self.sortFunction)
		end
	end

	if next(moList) then
		self:addRoot({
			update = true,
			type = 0
		}, treeRootParam, #moList + 1)
	end
end

function StoreRoomGoodsItemListModel:getInfoList()
	return StoreRoomGoodsItemListModel.super.getInfoList(self)
end

function StoreRoomGoodsItemListModel.sortFunction(x, y)
	local xConfig = StoreConfig.instance:getGoodsConfig(x.goodsId)
	local yConfig = StoreConfig.instance:getGoodsConfig(y.goodsId)
	local xSoldOut = StoreNormalGoodsItemListModel._isStoreItemSoldOut(x.goodsId)
	local ySoldOut = StoreNormalGoodsItemListModel._isStoreItemSoldOut(y.goodsId)
	local xUnlock = StoreNormalGoodsItemListModel._isStoreItemUnlock(x.goodsId)
	local yUnlock = StoreNormalGoodsItemListModel._isStoreItemUnlock(y.goodsId)

	if not xSoldOut and ySoldOut then
		return true
	elseif xSoldOut and not ySoldOut then
		return false
	end

	if xUnlock and not yUnlock then
		return true
	elseif not xUnlock and yUnlock then
		return false
	end

	local xHas = x:alreadyHas()
	local yHas = y:alreadyHas()

	if xHas ~= yHas then
		return yHas
	end

	local xMaxLimit = xConfig.maxBuyCount
	local yMaxLimit = yConfig.maxBuyCount

	if xMaxLimit == 1 and xHas then
		xSoldOut = xSoldOut or true
	end

	if yMaxLimit == 1 and yHas then
		ySoldOut = ySoldOut or true
	end

	if xSoldOut ~= ySoldOut then
		return ySoldOut
	end

	local xWeekWalkLock = StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(x.goodsId)
	local yWeekWalkLock = StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(y.goodsId)

	if xWeekWalkLock ~= yWeekWalkLock then
		if xWeekWalkLock then
			return false
		end

		return true
	end

	if xConfig.order < yConfig.order then
		return true
	elseif xConfig.order > yConfig.order then
		return false
	end

	if xConfig.id < yConfig.id then
		return true
	elseif xConfig.id > yConfig.id then
		return false
	end
end

function StoreRoomGoodsItemListModel._isStoreItemUnlock(goodsId)
	local episodeId = StoreConfig.instance:getGoodsConfig(goodsId).needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function StoreRoomGoodsItemListModel.needWeekWalkLayerUnlock(goodsId)
	local needWeekwalkLayer = StoreConfig.instance:getGoodsConfig(goodsId).needWeekwalkLayer

	if needWeekwalkLayer <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	local maxLayer = WeekWalkModel.instance:getMaxLayerId()

	return maxLayer < needWeekwalkLayer
end

function StoreRoomGoodsItemListModel._isStoreItemSoldOut(goodsId)
	local mo = StoreModel.instance:getGoodsMO(goodsId)

	return mo:isSoldOut()
end

StoreRoomGoodsItemListModel.instance = StoreRoomGoodsItemListModel.New()

return StoreRoomGoodsItemListModel
