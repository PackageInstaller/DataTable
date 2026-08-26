-- chunkname: @modules/logic/store/model/StoreClothesGoodsItemListModel.lua

module("modules.logic.store.model.StoreClothesGoodsItemListModel", package.seeall)

local StoreClothesGoodsItemListModel = class("StoreClothesGoodsItemListModel", StoreNormalGoodsItemListModel)

function StoreClothesGoodsItemListModel:setMOList(moList)
	self._moList = {}

	if moList then
		for _, mo in pairs(moList) do
			table.insert(self._moList, mo)
		end

		if #self._moList > 1 then
			table.sort(self._moList, StoreNormalGoodsItemListModel._sortFunction)
		end
	end

	if next(self._moList) then
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	self:setList(self._moList)
end

function StoreClothesGoodsItemListModel:findMOByProduct(type, itemId)
	local moList = self:getList()
	local count = #moList

	for i = 1, count do
		local mo = moList[i]

		if mo and mo:hasProduct(type, itemId) then
			return mo
		end
	end

	return nil
end

function StoreClothesGoodsItemListModel:getGoodIndex(goodId)
	local moList = self:getList()

	for i = 1, #moList do
		if moList[i].goodsId == goodId then
			return i
		end
	end

	return 1
end

function StoreClothesGoodsItemListModel:initViewParam()
	self._isLive2d = false
	self._selectIndex = nil
	self.startTime = ServerTime.now()
end

function StoreClothesGoodsItemListModel:getSelectIndex()
	return self._selectIndex or 1
end

function StoreClothesGoodsItemListModel:getSelectGoods()
	local index = self:getSelectIndex()

	return self:getGoodsByIndex(index)
end

function StoreClothesGoodsItemListModel:getGoodsByIndex(index)
	local moList = self:getList()

	return moList[index]
end

function StoreClothesGoodsItemListModel:setSelectIndex(index, isDrag)
	local selectIndex = self:getSelectIndex()

	if selectIndex == index then
		return
	end

	local curTime = ServerTime.now()

	if self.startTime then
		local lastGoods = self:getGoodsByIndex(selectIndex)
		local afterGoods = self:getGoodsByIndex(index)
		local browseTime = curTime - self.startTime

		StatController.instance:track(StatEnum.EventName.SkinStoreSwitchSkin, {
			[StatEnum.EventProperties.SkinStoreBeforeGoodsId] = lastGoods and lastGoods.goodsId,
			[StatEnum.EventProperties.SkinStoreAfterGoodsId] = afterGoods and afterGoods.goodsId,
			[StatEnum.EventProperties.SkinStoreBrowseTime] = browseTime
		})
	end

	self.startTime = curTime
	self._selectIndex = index

	StoreController.instance:dispatchEvent(StoreEvent.SkinPreviewChanged, isDrag)
end

function StoreClothesGoodsItemListModel:getIsLive2d()
	return self._isLive2d
end

function StoreClothesGoodsItemListModel:switchIsLive2d()
	self._isLive2d = not self._isLive2d
end

function StoreClothesGoodsItemListModel:moveToNewGoods()
	local scrollView = self._scrollViews[1]

	if not scrollView then
		return
	end

	local newIndex = self:findNewGoodsIndex()

	if not newIndex then
		return
	end

	scrollView:moveToByIndex(newIndex, 0.1)
end

function StoreClothesGoodsItemListModel:findNewGoodsIndex()
	local scrollView = self._scrollViews[1]

	if not scrollView then
		return
	end

	local csList = scrollView:getCsListScroll()
	local moList = self:getList()
	local newIndex
	local hasInit = false
	local isVisual = false

	for i = 1, #moList do
		local mo = moList[i]

		isVisual = csList:IsVisual(i - 1)

		if not hasInit and isVisual then
			hasInit = true
		end

		if hasInit and not isVisual and mo:checkShowNewRedDot() then
			newIndex = i

			break
		end
	end

	return newIndex
end

function StoreClothesGoodsItemListModel:isEmpty()
	return self:getCount() == 0
end

StoreClothesGoodsItemListModel.instance = StoreClothesGoodsItemListModel.New()

return StoreClothesGoodsItemListModel
