-- chunkname: @modules/logic/store/view/decorate/DecorateStoreGoodTabComp.lua

module("modules.logic.store.view.decorate.DecorateStoreGoodTabComp", package.seeall)

local DecorateStoreGoodTabComp = class("DecorateStoreGoodTabComp", LuaCompBase)
local CELL_WIDTH = 201.3
local CELL_HEIGHT = 168
local CELL_SPACE_V = 16
local START_SPACE = 50
local END_SPACE = 50

function DecorateStoreGoodTabComp.Get(go, viewContainer)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreGoodTabComp, viewContainer)
end

function DecorateStoreGoodTabComp:ctor(viewContainer)
	self.viewContainer = viewContainer
end

function DecorateStoreGoodTabComp:init(go)
	self.go = go
	self._goscrollview = gohelper.findChild(go, "root/Scrollview")
	self._gocontent = gohelper.findChild(go, "root/Scrollview/Viewport/Content")
	self._goitem = gohelper.findChild(go, "root/Scrollview/Viewport/Content/#go_Tabitem")
	self._showGoods = {}

	self:_initList()
	self:_addEvents()
end

function DecorateStoreGoodTabComp:_initList()
	local param = SimpleListParam.New()

	param.cellClass = DecorateStoreGoodTabCompItem
	param.cellWidth = CELL_WIDTH
	param.cellHeight = CELL_HEIGHT
	param.cellSpaceV = CELL_SPACE_V
	param.startSpace = START_SPACE
	param.endSpace = END_SPACE
	self._listComp = GameFacade.createSimpleListComp(self._goscrollview, param, self._goitem, self.viewContainer)

	self._listComp:setData({})
	self._listComp:setOnClickItem(self._onClickItem, self)
end

function DecorateStoreGoodTabComp:getShowGoods()
	local showGoods = {}
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._goodId)

	for _, good in ipairs(goods) do
		local isSold = DecorateStoreModel.instance:isDecorateGoodItemHas(good.id)

		if not isSold then
			table.insert(showGoods, good)
		end
	end

	return showGoods
end

function DecorateStoreGoodTabComp:_getCurGoodIndex()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	for index, good in ipairs(self._showGoods) do
		if good.id == curGoodId then
			return index
		end
	end
end

function DecorateStoreGoodTabComp:_getContentHeight()
	local count = #self._showGoods

	if count <= 0 then
		return 0
	end

	return (CELL_HEIGHT + CELL_SPACE_V) * count - CELL_SPACE_V + START_SPACE + END_SPACE
end

function DecorateStoreGoodTabComp:_refreshSelect()
	local index = self:_getCurGoodIndex()

	self._listComp:setSelect(index)

	if not index then
		return
	end

	local viewHeight = recthelper.getHeight(self._goscrollview.transform)

	if viewHeight >= self:_getContentHeight() then
		return
	end

	local itemTop = START_SPACE + (CELL_HEIGHT + CELL_SPACE_V) * (index - 1)
	local scrollPixel = self._listComp:getScrollPixel()

	if scrollPixel <= itemTop and itemTop + CELL_HEIGHT <= scrollPixel + viewHeight then
		return
	end

	self._listComp:moveTo(index)
end

function DecorateStoreGoodTabComp:_addEvents()
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabComp:_removeEvents()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabComp:_onGoodItemClick()
	self:_refreshSelect()
end

function DecorateStoreGoodTabComp:_onClickItem(item)
	if item.data then
		if not item.data then
			return
		end

		DecorateStoreModel.instance:setCurGood(item.data)
		StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, item.data)
		self:_refreshSelect()
	end
end

function DecorateStoreGoodTabComp:hide(hide)
	gohelper.setActive(self.go, not hide)
end

function DecorateStoreGoodTabComp:refresh(goodId)
	self._goodId = goodId
	self._goodCo = StoreConfig.instance:getGoodsConfig(goodId)
	self._storeId = self._goodCo and tonumber(self._goodCo.storeId) or StoreEnum.StoreId.SpiritualityDecorateStore

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self._showGoods = self:getShowGoods()

	if #self._showGoods <= 1 then
		self:hide(true)

		return
	end

	self:hide(false)

	local isBundleChange = self._lastGoodId ~= self._goodId

	self._lastGoodId = self._goodId

	self._listComp:setData(self._showGoods)

	if isBundleChange then
		self._listComp:moveTo(1)
	end

	self:_refreshSelect()
end

function DecorateStoreGoodTabComp:destroy()
	self:_removeEvents()
	MonoHelper.removeLuaComFromGo(self.go, DecorateStoreGoodTabComp)
end

return DecorateStoreGoodTabComp
