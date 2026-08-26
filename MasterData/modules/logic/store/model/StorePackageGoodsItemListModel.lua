-- chunkname: @modules/logic/store/model/StorePackageGoodsItemListModel.lua

module("modules.logic.store.model.StorePackageGoodsItemListModel", package.seeall)

local StorePackageGoodsItemListModel = class("StorePackageGoodsItemListModel", ListScrollModel)

function StorePackageGoodsItemListModel:setMOList(storeMO, moList, excludeList)
	local tempList = {}
	local allPreGoodsIdDic = {}

	self._moList = {}

	for _, mo in pairs(moList) do
		if mo.config.preGoodsId then
			allPreGoodsIdDic[mo.config.preGoodsId] = true
		end

		if self:checkShow(mo, true) then
			table.insert(tempList, mo)
		end
	end

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			if mo.config.preGoodsId then
				allPreGoodsIdDic[mo.config.preGoodsId] = true
			end

			if self:checkShow(mo) then
				local goodsMO = StorePackageGoodsMO.New()

				goodsMO:init(storeMO.id, mo.goodsId, mo.buyCount, mo.offlineTime)
				table.insert(tempList, goodsMO)
			end
		end
	end

	local excludeDict = {}

	if excludeList then
		for _, mo in ipairs(excludeList) do
			excludeDict[mo.goodsId] = true
		end
	end

	for i, goodsMO in ipairs(tempList) do
		if not excludeDict[goodsMO.goodsId] and (allPreGoodsIdDic[goodsMO.goodsId] ~= true or (goodsMO.buyLevel > 0 and goodsMO:isSoldOut()) == false) then
			table.insert(self._moList, goodsMO)
		end
	end

	table.sort(self._moList, self._sortFunction)

	local curBuyPackageId = StoreModel.instance:getCurBuyPackageId()

	if #self._moList == 0 and curBuyPackageId == nil then
		StoreController.instance:dispatchEvent(StoreEvent.CurPackageListEmpty)
	end

	StoreController.instance:dispatchEvent(StoreEvent.BeforeUpdatePackageStore)
	self:setList(self._moList)

	if next(self._moList) then
		local scrollView = self._scrollViews[1]

		if not scrollView then
			return
		end

		scrollView:moveToByIndex(1)
	end

	StoreController.instance:dispatchEvent(StoreEvent.AfterUpdatePackageStore)
end

function StorePackageGoodsItemListModel:checkShow(goodsMO, isChargeGoods)
	isChargeGoods = isChargeGoods or false

	local show = true

	if goodsMO:isSoldOut() then
		if isChargeGoods and goodsMO.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			show = false
		end

		if isChargeGoods == false and goodsMO.config.refreshTime == StoreEnum.RefreshTime.Forever then
			show = false
		end

		if not show and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsMO.goodsId) then
			show = true
		end
	end

	show = show and self:checkPreGoodsId(goodsMO.config.preGoodsId)

	return show
end

function StorePackageGoodsItemListModel:checkPreGoodsId(goodsId)
	if goodsId == 0 then
		return true
	end

	local preGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

	if not preGoodsMO then
		return false
	end

	local isSoldOut = preGoodsMO:isSoldOut()
	local chargeConditionConfig = StoreConfig.instance:getChargeConditionalConfig(preGoodsMO.config.taskid)

	if chargeConditionConfig == nil then
		return isSoldOut
	end

	if chargeConditionConfig.clientType == StoreEnum.ChargeConditionalClientType.SP02 then
		return isSoldOut and StoreCharageConditionalHelper.isCharageTaskFinish(preGoodsMO.goodsId)
	else
		return isSoldOut
	end
end

function StorePackageGoodsItemListModel:moveToNewGoods()
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

function StorePackageGoodsItemListModel:findNewGoodsIndex()
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

		if hasInit and not isVisual and mo:needShowNew() then
			newIndex = i

			break
		end
	end

	return newIndex
end

function StorePackageGoodsItemListModel._sortFunction(x, y)
	local xConfig = x.config
	local yConfig = y.config
	local xCanTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(x.goodsId)
	local yCanTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(y.goodsId)

	if xCanTask ~= yCanTask then
		return xCanTask
	end

	local xSoldOut = x:isSoldOut()
	local ySoldOut = y:isSoldOut()

	if xSoldOut ~= ySoldOut then
		return ySoldOut
	end

	local xIsMothCard = x.goodsId == StoreEnum.MonthCardGoodsId
	local yIsMothCard = y.goodsId == StoreEnum.MonthCardGoodsId

	if xIsMothCard ~= yIsMothCard then
		local isMonthCardDaysEnough = StoreModel.instance:IsMonthCardDaysEnough()

		if isMonthCardDaysEnough then
			return yIsMothCard
		end
	end

	local xLevelOpen = x:isLevelOpen()
	local yLevelOpen = y:isLevelOpen()

	if xLevelOpen ~= yLevelOpen then
		return xLevelOpen
	end

	local xOrder = StorePackageGoodsItemListModel._getMOOrder(x)
	local yOrder = StorePackageGoodsItemListModel._getMOOrder(y)

	if xOrder ~= yOrder then
		return xOrder < yOrder
	end

	return xConfig.id < yConfig.id
end

function StorePackageGoodsItemListModel._getMOOrder(goodsMO)
	if goodsMO and goodsMO.config then
		if goodsMO.buyCount and goodsMO.buyCount > 0 and goodsMO.config.taskid ~= 0 then
			local condCfg = StoreConfig.instance:getChargeConditionalConfig(goodsMO.config.taskid)

			if condCfg and condCfg.order2 then
				return condCfg.order2
			end
		end

		return goodsMO.config.order
	end

	return -1
end

StorePackageGoodsItemListModel.instance = StorePackageGoodsItemListModel.New()

return StorePackageGoodsItemListModel
