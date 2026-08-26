-- chunkname: @modules/logic/sodache/view/inside/SodacheBagView.lua

module("modules.logic.sodache.view.inside.SodacheBagView", package.seeall)

local SodacheBagView = class("SodacheBagView", BaseView)
local isSortAsc = false
local SortType = {
	Value = 1,
	Price = 2
}

function SodacheBagView:onInitView()
	self._btnValue = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Sort/#btn_value")
	self._goValueSelect = gohelper.findChild(self.viewGO, "#go_Sort/#btn_value/#go_selected")
	self._transValueArrow = gohelper.findChild(self.viewGO, "#go_Sort/#btn_value/#go_selected/txt/arrow").transform
	self._btnPrice = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Sort/#btn_price")
	self._goPriceSelect = gohelper.findChild(self.viewGO, "#go_Sort/#btn_price/#go_selected")
	self._transPriceArrow = gohelper.findChild(self.viewGO, "#go_Sort/#btn_price/#go_selected/txt/arrow").transform
	self._txtvalue = gohelper.findChildTextMesh(self.viewGO, "top/value/#txt_num")
	self._txtcostcur = gohelper.findChildTextMesh(self.viewGO, "top/cost/layout/#txt_current")
	self._txtcosttotal = gohelper.findChildTextMesh(self.viewGO, "top/cost/layout/#txt_total")
	self._goscroll = gohelper.findChild(self.viewGO, "#scroll_bag")
	self._goscrolltitle = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/title")
	self._goscrollcardgrid = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/grid")
	self._goscrollspace = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/space")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	gohelper.setActive(self._goscrolltitle, false)
	gohelper.setActive(self._goscrollcardgrid, false)
	gohelper.setActive(self._goscrollspace, false)
end

function SodacheBagView:addEvents()
	self._btnValue:AddClickListener(self._onClickValue, self)
	self._btnPrice:AddClickListener(self._onClickPrice, self)
end

function SodacheBagView:removeEvents()
	self._btnValue:RemoveClickListener()
	self._btnPrice:RemoveClickListener()
end

function SodacheBagView:onOpen()
	local priceTotal = 0
	local costTotal = 0
	local winCost = SodacheUtil.getAttr(SodacheEnum.AttrId.WinCost) + SodacheUtil.getAttr(SodacheEnum.AttrId.WinCostEx)

	self._mixScroll = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SodacheMixScrollPart)

	self._mixScroll:setCellUpdateCallback(self._onCellUpdate, self)

	local showTypes = {
		SodacheEnum.CardType.Offering,
		SodacheEnum.CardType.Supplies
	}
	local datas = {}

	for _, cardType in ipairs(showTypes) do
		local items = SodacheUtil.getItemsByCardType(cardType, SodacheEnum.BagType.Inside)
		local list = {}

		for _, v in ipairs(items) do
			if v.itemCo.disappear == 0 then
				priceTotal = priceTotal + SodacheConfig.instance:getItemPrice(v.configId) * v.count
				costTotal = costTotal + v.itemCo.cost * v.count

				table.insert(list, v:toCardMo())
			end
		end

		if #list > 0 then
			table.insert(datas, {
				list = list,
				title = luaLang("sodache_cardtype_" .. cardType),
				cardType = cardType
			})
		end
	end

	self._txtvalue.text = priceTotal
	self._txtcostcur.text = costTotal
	self._txtcosttotal.text = winCost

	local isEmpty = #datas == 0

	self.datas = datas

	self:setCurSortType(SortType.Value, false)
	gohelper.setActive(self._goempty, isEmpty)
end

function SodacheBagView:_onClickValue()
	if self._curSortType == SortType.Value then
		self:setCurSortType(self._curSortType, not isSortAsc)
	else
		self:setCurSortType(SortType.Value, false)
	end
end

function SodacheBagView:_onClickPrice()
	if self._curSortType == SortType.Price then
		self:setCurSortType(self._curSortType, not isSortAsc)
	else
		self:setCurSortType(SortType.Price, false)
	end
end

function SodacheBagView:setCurSortType(type, isAsc)
	self._curSortType = type
	isSortAsc = isAsc

	gohelper.setActive(self._goPriceSelect, self._curSortType == SortType.Price)
	gohelper.setActive(self._goValueSelect, self._curSortType == SortType.Value)
	transformhelper.setLocalScale(self._transPriceArrow, 1, isSortAsc and -1 or 1, 1)
	transformhelper.setLocalScale(self._transValueArrow, 1, isSortAsc and -1 or 1, 1)

	for i, v in ipairs(self.datas) do
		table.sort(v.list, SodacheBagView["sort" .. self._curSortType])
	end

	local allDatas = {}
	local lineCardNum = 8

	for i, v in ipairs(self.datas) do
		table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(1, 100, {
			data = v,
			go = self._goscrolltitle
		}))

		local len = math.ceil(#v.list / lineCardNum)

		for j = 1, len do
			local mixData = {
				unpack(v.list, 1 + (j - 1) * lineCardNum, math.min(j * lineCardNum, #v.list))
			}

			table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(2, 306, {
				data = mixData,
				go = self._goscrollcardgrid
			}))

			if j ~= len then
				table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(3, 30, {
					data = {},
					go = self._goscrollspace
				}))
			end
		end

		if i ~= #self.datas then
			table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(3, 8, {
				data = {},
				go = self._goscrollspace
			}))
		end
	end

	self._mixScroll:setData(allDatas)
end

function SodacheBagView:_onCellUpdate(obj, type, data)
	if type == 1 then
		self:_createTitle(obj, data)
	elseif type == 2 then
		self:_createItem(obj, data)
	end
end

function SodacheBagView:_createTitle(obj, data)
	local title = gohelper.findChildTextMesh(obj, "titletxt")
	local imageType = gohelper.findChildImage(obj, "#image_icon")

	title.text = data.title

	UISpriteSetMgr.instance:setSodache2Sprite(imageType, "sodache_handbook_icon_" .. tostring(data.cardType))
end

function SodacheBagView:_createItem(obj, data)
	local item = gohelper.findChild(obj, "#go_item")

	gohelper.CreateObjList(self, self._createItems, data, nil, item)
end

function SodacheBagView:_createItems(obj, data, index)
	local cardGo = gohelper.findChild(obj, "go_card/sodache_carditem")
	local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, SodacheCardItem)

	cardItem:updateMo(data)
end

function SodacheBagView.sort1(a, b)
	local priceA = SodacheConfig.instance:getItemPrice(a.serverMo.configId)
	local priceB = SodacheConfig.instance:getItemPrice(b.serverMo.configId)

	if priceA ~= priceB then
		if isSortAsc then
			return priceA < priceB
		else
			return priceB < priceA
		end
	end

	if a.serverMo.itemCo.quality ~= b.serverMo.itemCo.quality then
		return a.serverMo.itemCo.quality > b.serverMo.itemCo.quality
	end

	if a.serverMo.itemCo.cost ~= b.serverMo.itemCo.cost then
		return a.serverMo.itemCo.cost < b.serverMo.itemCo.cost
	end

	return a.serverMo.configId < b.serverMo.configId
end

function SodacheBagView.sort2(a, b)
	local priceA = SodacheConfig.instance:getItemPrice(a.serverMo.configId) / a.serverMo.itemCo.cost
	local priceB = SodacheConfig.instance:getItemPrice(b.serverMo.configId) / b.serverMo.itemCo.cost

	if priceA ~= priceB then
		if isSortAsc then
			return priceA < priceB
		else
			return priceB < priceA
		end
	end

	if a.serverMo.itemCo.quality ~= b.serverMo.itemCo.quality then
		return a.serverMo.itemCo.quality > b.serverMo.itemCo.quality
	end

	return a.serverMo.configId < b.serverMo.configId
end

return SodacheBagView
