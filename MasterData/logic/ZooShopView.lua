-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooShopView.lua

module("logic.extensions.zoo.view.ZooShopView", package.seeall)

local ZooShopView = class("ZooShopView", ViewComponent)

function ZooShopView:buildUI()
	ZooShopView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._ingCoinIcon = self:getGo("coin/ImgC_Icon")
	self._txtCoinNum = self:getTxt("coin/TxtC_Num")

	local txtTitle = self:getTxt("txtTitle")

	txtTitle.text = lang("petzoo_shop_title")
end

function ZooShopView:bindEvents()
	ZooShopView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tableview:RegisterCallback(self._numItemsInView, self._itemCellSizeForIndex, self._itemCellAtIndex, self)
end

function ZooShopView:unbindEvents()
	ZooShopView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function ZooShopView:onEnter()
	ZooShopView.super.onEnter(self)

	self._exchangeItems = ZooConfig.instance:getAllExchangeItems()

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()

	local items = string.split(self._exchangeItems[1].gain, ":")
	local matType = checknumber(items[1])
	local matId = checknumber(items[2])
	local matNum = checknumber(items[3])

	MaterialMgr.setIcon(self._ingCoinIcon, matType, matId)

	self._txtCoinNum.text = tostring(matNum)

	GlobalDispatcher:addListener(GlobalNotify.OnZooExchangeItem, self._onZooExchangeItem, self)
end

function ZooShopView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnZooExchangeItem, self._onZooExchangeItem, self)

	self._exchangeItems = nil

	MaterialMgr.clearIcon(self._ingCoinIcon)
	self._tableview:Travel(self._clearItemCell, self)
	ZooShopView.super.onExit(self)
end

function ZooShopView:_numItemsInView(view)
	if not self._exchangeItems then
		return 0
	end

	return #self._exchangeItems
end

function ZooShopView:_itemCellSizeForIndex(view, idx)
	return 0, 0
end

function ZooShopView:_itemCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local data = self._exchangeItems[idx + 1]
	local item = goutil.findChild(cell.gameObject, "item")
	local txtLimit = goutil.findChildTextComponent(cell.gameObject, "txtLimit")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "TxtName")
	local lock = goutil.findChild(cell.gameObject, "lock")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "lock/txtLock")
	local txtPrice = goutil.findChildTextComponent(cell.gameObject, "price")
	local priceIcon = goutil.findChild(cell.gameObject, "price/icon")
	local myZoo = ZooModel.instance:getMyZoo()
	local shopBuildingLv = myZoo:getShopBuildingLevel()
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtLimit.gameObject:SetActive(false)
	lock:SetActive(shopBuildingLv < data.level)

	if shopBuildingLv < data.level then
		txtLock.text = string.format(lang("petzoo_shop_locktips"), shopBuildingLv)
	end

	local items = string.split(data.gain, ":")
	local matType = checknumber(items[1])
	local matId = checknumber(items[2])
	local matNum = checknumber(items[3])

	txtName.text = MaterialMgr.getMaterialsName(matType, matId)

	local proxy = MaterialMgr.setCell(matType, matId, item)

	proxy.binder:setNum(matNum)

	local priceItems = string.split(data.cost, ":")
	local costType = checknumber(priceItems[1])
	local costId = checknumber(priceItems[2])
	local costNum = checknumber(priceItems[3])

	MaterialMgr.setIcon(priceIcon, costType, costId)

	txtPrice.text = tostring(costNum)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		local hasNum = MaterialModel.instance:getMaterialsNumber(costType, costId)

		if hasNum < costNum then
			FloatWordMgr.instance:show(lang("petzoo_shop_coinnoenough"))

			return
		end

		if data.level > shopBuildingLv then
			FloatWordMgr.instance:show(string.format(lang("petzoo_shop_locktips"), shopBuildingLv))

			return
		end

		ZooAgent.instance:sendPM_ZooExchangeItemReq(data.id)
	end)

	return cell
end

function ZooShopView:_clearItemCell(cell)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local item = goutil.findChild(cell.gameObject, "item")
	local priceIcon = goutil.findChild(cell.gameObject, "price/icon")

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(priceIcon)
	btn:RemoveClickListener()
end

function ZooShopView:_onZooExchangeItem()
	return
end

return ZooShopView
