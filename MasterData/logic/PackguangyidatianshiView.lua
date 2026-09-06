-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/PackguangyidatianshiView.lua

module("logic.extensions.hdsummerlotteryrecommend.view.PackguangyidatianshiView", package.seeall)

local PackguangyidatianshiView = class("PackguangyidatianshiView", ViewComponent)

function PackguangyidatianshiView:buildUI()
	PackguangyidatianshiView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtLeftTime = self:getTxt("time/txtTime")
	self._btnClose = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self.ITEM_NUM = 3
	self._txtTip = self:getTxt("tip/txtTip")
	self._itemList = {}

	for i = 1, self.ITEM_NUM do
		self._itemList[i] = {}
		self._itemList[i].mainGo = self:getGo("gift_" .. i)
		self._itemList[i].btnBuy = self:getBtn("gift_" .. i .. "/btnBuy")
		self._itemList[i].soldoutGo = self:getGo("gift_" .. i .. "/soldout")
		self._itemList[i].discount = self:getGo("gift_" .. i .. "/discount")
		self._itemList[i].oldPrice = self:getGo("gift_" .. i .. "/oldPrice")
		self._itemList[i].txtOldPrice = self:getTxt("gift_" .. i .. "/oldPrice/txtOldPrice")
		self._itemList[i].txtName = self:getTxt("gift_" .. i .. "/txtName")
		self._itemList[i].txtBuy = self:getTxt("gift_" .. i .. "/btnBuy/txtBuy")
		self._itemList[i].txtDiscount = self:getTxt("gift_" .. i .. "/discount/txtDiscount")
		self._itemList[i].ScrollView = self:getGo("gift_" .. i .. "/ScrollView")
		self._itemList[i].Cell = self:getGo("gift_" .. i .. "/Cell")
		self._itemList[i].tableview = ScrollerList.create(self._itemList[i].ScrollView, self._itemList[i].Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	end
end

function PackguangyidatianshiView:bindEvents()
	PackguangyidatianshiView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self.close, self))

	for i = 1, self.ITEM_NUM do
		GameUtil.addClickHandler(self._itemList[i].btnBuy, GameUtil.handler(self._onClickBtnBuy, self, i), self)
	end
end

function PackguangyidatianshiView:unbindEvents()
	PackguangyidatianshiView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, self.ITEM_NUM do
		GameUtil.rmClickHandler(self._itemList[i].btnBuy)
	end
end

function PackguangyidatianshiView:onEnter()
	PackguangyidatianshiView.super.onEnter(self)

	self._funcId = checknumber(self:getFirstParam())

	self:initConf()

	local resName = DirectPurchaseConfig.instance:getGiftShopConstValue(string.format("Func_%s_BG", self._funcId))

	self._bgResPath = GameUrl.getBigbgFolderUrl("hdsummerlottery", resName)

	uGuiUtil.setSpriteToImage(self._bg, nil, self._bgResPath)
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateView, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateView, self)
	PackguangyidatianshiModel.instance:clearClickDot()
	self:_initMaterial()
	self:_updateView()
	self:_setActLeftTime()
end

function PackguangyidatianshiView:_initMaterial()
	for i = 1, self.ITEM_NUM do
		local cfg = self._itemList[i].cfg

		self._itemList[i].tableview:reloadData(string.split(cfg.content, "#"))
	end
end

function PackguangyidatianshiView:initConf()
	if self._funcId <= 0 then
		printError("看看功能开启表 jumpTo 是不是配了 ui#packguangyidatianshiView#功能id")

		return
	end

	local keys = {
		"GiftId1",
		"GiftId2",
		"GiftId3"
	}

	for i = 1, self.ITEM_NUM do
		local key = keys[i]
		local goodsId = self:_getShopIdByKey(key)

		self._itemList[i].goodsId = goodsId
		self._itemList[i].cfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)
	end
end

function PackguangyidatianshiView:onExit()
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateView, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateView, self)
	removetimer(self._updateTimer, self)
	uGuiUtil.clearImage(self._bg)
	PackguangyidatianshiView.super.onExit(self)
end

function PackguangyidatianshiView:onExitFinished()
	PackguangyidatianshiView.super.onExitFinished(self)
end

function PackguangyidatianshiView:_onClickBtnBuy(i)
	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(self._itemList[i].goodsId)

	if isCanBuy then
		local data = PayShopModel.instance:getBuyData(self._itemList[i].goodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, self._showLeftTime)
		else
			printError("配置错误")
		end
	else
		FloatWordMgr.instance:show(lang("text_recall_desc_6"))

		return
	end
end

function PackguangyidatianshiView:_updateView()
	local hasAnyDiscount = false

	for i = 1, self.ITEM_NUM do
		local goodsId = self._itemList[i].goodsId

		if goodsId > 0 then
			goutil.setActive(self._itemList[i].mainGo, true)

			local cfg = self._itemList[i].cfg
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

			goutil.setActive(self._itemList[i].btnBuy.gameObject, isCanBuy)
			goutil.setActive(self._itemList[i].soldoutGo, not isCanBuy)

			self._itemList[i].txtName.text = cfg.name

			local disCount = checknumber(cfg.disCount) / 100
			local isDiscountTime = PayShopController.instance:checkTimeStr(cfg.discountTime)

			self._itemList[i].txtDiscount.text = string.format("首周%s折", disCount)

			goutil.setActive(self._itemList[i].discount, disCount > 0 and isDiscountTime)

			if isDiscountTime then
				if not cfg.discountGoodsId then
					local priceId = cfg.originalGoodsId

					self._itemList[i].txtOldPrice.text = string.format("原价：%s元", PayConfig.instance:getPayMoneyYuan(cfg.originalGoodsId))
					self._itemList[i].txtBuy.text = string.format("%s元", PayConfig.instance:getPayMoneyYuan(priceId))

					goutil.setActive(self._itemList[i].oldPrice, isDiscountTime)

					hasAnyDiscount = hasAnyDiscount or isDiscountTime
				end
			end
		else
			goutil.setActive(self._itemList[i].mainGo, false)
		end
	end

	self._txtTip.text = hasAnyDiscount and "首周特惠，12月3日5点后恢复原价\n12.17 5点后加入圣翼·光天使专属召唤" or "12.17 5点后加入圣翼·光天使专属召唤"
end

function PackguangyidatianshiView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
	MaterialMgr.setCellByCfg(data, icon)
end

function PackguangyidatianshiView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function PackguangyidatianshiView:_setActLeftTime()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(self._funcId)
	local arr = string.split(cfg.openTime, "#")
	local time = GameUtil.string2time(arr[2])

	self._leftTime = time - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function PackguangyidatianshiView:_updateTimer()
	self._leftTime = self._leftTime - 1

	if self._leftTime > 0 then
		self._txtLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function PackguangyidatianshiView:_formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)

	return d > 0 and string.format("时间剩余：%d天%2d时%2d分", d, h, m) or h > 0 and string.format("时间剩余：%d时%2d分%2d秒", h, m, s) or string.format("时间剩余：%2d分%2d秒", m, s)
end

function PackguangyidatianshiView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function PackguangyidatianshiView:_getShopIdByKey(key)
	local content = DirectPurchaseConfig.instance:getGiftShopConstValue(key)
	local s, e = string.find(content, self._funcId .. ":%d+")
	local goodsId = 0

	if s then
		local str = string.sub(content, s, e)
		local value = string.gsub(str, self._funcId .. ":", "")
		local id = checknumber(value)
		local cfgItem = DirectPurchaseConfig.instance:getSellShopMultiCfg(id)

		goodsId = cfgItem.shopItemId
	end

	return checknumber(goodsId)
end

return PackguangyidatianshiView
