-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelExchangeView.lua

module("logic.extensions.timewheel.view.TimeWheelExchangeView", package.seeall)

local TimeWheelExchangeView = class("TimeWheelExchangeView", TableViewComponent)

function TimeWheelExchangeView:buildUI()
	TimeWheelExchangeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtCount = self:getTxt("txtCount")
	self._coinGo = self:getGo("coin")
	self._btnCoin = self:getBtn("coin")
end

function TimeWheelExchangeView:bindEvents()
	TimeWheelExchangeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCoin:AddClickListener(self._onClickCoin, self)
end

function TimeWheelExchangeView:unbindEvents()
	TimeWheelExchangeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCoin:RemoveClickListener()
end

function TimeWheelExchangeView:onEnter()
	TimeWheelExchangeView.super.onEnter(self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._onBuySuccessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateCoinCount, self)

	local cfgs = TimeWheelController.instance:getExchangeCfgsList()

	self._cfgs = cfgs

	self:updateListData(cfgs)
	self:_setCoinIcon(cfgs)
	self:_updateCoinCount()
end

function TimeWheelExchangeView:onExit()
	TimeWheelExchangeView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onBuySuccessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateCoinCount, self)
	self:_removeCoinIcon()

	self._cfgs = nil
end

function TimeWheelExchangeView:_onClickClose()
	self:close()
end

function TimeWheelExchangeView:_onClickCoin()
	if self._cfgs and #self._cfgs > 0 then
		local temp = string.split(self._cfgs[1].originalGoodsId, ":")
		local matType = checknumber(temp[1])
		local matId = checknumber(temp[2])

		CommonTipsMgr.instance:openMaterialTips(self._coinGo, matType, matId)
	end
end

function TimeWheelExchangeView:_getPath()
	return {
		cellPath = "scrollList/item",
		viewPath = "scrollList"
	}
end

function TimeWheelExchangeView:_cellSize(view, index)
	return 180, 220
end

function TimeWheelExchangeView:_updateCell(view, cell, data)
	local node = goutil.findChild(cell, "btn/node")
	local txtNum = goutil.findChildTextComponent(cell, "btn/txtNum")
	local icon = goutil.findChild(cell, "btn/txtPrice/icon")
	local txtPrice = goutil.findChildTextComponent(cell, "btn/txtPrice")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local temp = string.split(data.originalGoodsId, ":")
	local matType = checknumber(temp[1])
	local itemId = checknumber(temp[2])
	local price = checknumber(temp[3])

	MaterialMgr.setIcon(icon, matType, itemId)

	local proxy = MaterialMgr.setCellByCfg(data.content, node)

	txtPrice.text = price

	local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(data.id)
	local remainTimes = Mathf.Max(0, data.limitTimes - buyTimes)
	local desc = ""

	if data.limitType == "daily" then
		desc = "每日"
	elseif data.limitType == "weekly" then
		desc = "每周"
	elseif data.limitType == "monthly" then
		desc = "每月"
	elseif data.limitType == "allTime" then
		desc = "永久"
	end

	txtNum.text = string.format("%s限购：%d/%d", desc, remainTimes, data.limitTimes)

	if data.limitType == "none" then
		txtNum.text = ""
	end

	btn:AddClickListener(function()
		if data.limitType == "none" or data.limitTimes > 0 and remainTimes > 0 then
			if MaterialFacade.instance:checkMatEnough(matType, itemId, price) then
				PayShopController.instance:buyShopItem(data.id, 1)
			end
		else
			FloatWordMgr.instance:show("当前商品已经没有购买次数了哦~")
		end
	end)
end

function TimeWheelExchangeView:_clearTableview(cell)
	local node = goutil.findChild(cell, "btn/node")
	local icon = goutil.findChild(cell, "btn/txtPrice/icon")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	MaterialMgr.resetAll(node)
	MaterialMgr.clearIcon(icon)
	btn:RemoveClickListener()
end

function TimeWheelExchangeView:_onBuySuccessRes()
	self:reloadData()
end

function TimeWheelExchangeView:_setCoinIcon(cfgs)
	if cfgs and #cfgs > 0 then
		local temp = string.split(cfgs[1].originalGoodsId, ":")
		local matType = checknumber(temp[1])
		local itemId = checknumber(temp[2])
		local price = checknumber(temp[3])

		MaterialMgr.setIcon(self._coinGo, matType, itemId)
	end
end

function TimeWheelExchangeView:_removeCoinIcon()
	MaterialMgr.clearIcon(self._coinGo)
end

function TimeWheelExchangeView:_updateCoinCount()
	self._txtCount.text = MaterialMgr.getMatCount("8:23")
end

return TimeWheelExchangeView
