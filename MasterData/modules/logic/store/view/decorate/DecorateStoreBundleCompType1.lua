-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType1.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType1", package.seeall)

local DecorateStoreBundleCompType1 = class("DecorateStoreBundleCompType1", LuaCompBase)
local LINE_COUNT = 3
local CELL_WIDTH = 128
local CELL_HEIGHT = 130
local START_SPACE = 10
local END_SPACE = 10

function DecorateStoreBundleCompType1.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType1)
end

function DecorateStoreBundleCompType1:init(go)
	self.go = go
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._goscrollview = gohelper.findChild(go, "scroll_products")
	self._gocontent = gohelper.findChild(go, "scroll_products/viewport/content")
	self._goitem = gohelper.findChild(go, "scroll_products/viewport/content/#go_item")

	self:_initList()
end

function DecorateStoreBundleCompType1:_initList()
	local param = SimpleListParam.New()

	param.cellClass = DecorateStoreBundleCompType1Item
	param.lineCount = LINE_COUNT
	param.cellWidth = CELL_WIDTH
	param.cellHeight = CELL_HEIGHT
	param.startSpace = START_SPACE
	param.endSpace = END_SPACE
	self._listComp = GameFacade.createSimpleListComp(self._goscrollview, param, self._goitem)

	self._listComp:setData({})
	self._listComp:setOnClickItem(self._onClickItem, self)
end

function DecorateStoreBundleCompType1:refresh(goodId)
	self._goodId = goodId

	local goodCo = StoreConfig.instance:getGoodsConfig(goodId)

	self._storeId = tonumber(goodCo.storeId)

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self:_refreshType()
	self:_refreshItems()
end

function DecorateStoreBundleCompType1:_refreshType()
	self._txtdesc.text = ""
end

function DecorateStoreBundleCompType1:_getCurGoodIndex()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	for index, good in ipairs(self._goods) do
		if good.id == curGoodId then
			return index
		end
	end
end

function DecorateStoreBundleCompType1:_refreshItems()
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._goodId)

	if not goods then
		return
	end

	local isBundleChange = self._lastGoodId ~= self._goodId

	self._lastGoodId = self._goodId
	self._goods = goods

	self._listComp:setData(goods)

	if isBundleChange then
		self._listComp:moveTo(1)
	end

	self._listComp:setSelect(self:_getCurGoodIndex())
end

function DecorateStoreBundleCompType1:_onClickItem(item)
	if item.data then
		if not item.data then
			return
		end

		DecorateStoreModel.instance:setCurGood(item.data)
		StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, item.data, true)
	end
end

function DecorateStoreBundleCompType1:destroy()
	if self.go then
		gohelper.destroy(self.go)
	end
end

return DecorateStoreBundleCompType1
