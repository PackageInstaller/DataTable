-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/actview/HdluoshiqiView.lua

module("logic.extensions.activitypopup.view.actview.HdluoshiqiView", package.seeall)

local HdluoshiqiView = class("HdluoshiqiView", ViewComponent)

HdluoshiqiView.config = {
	{
		shopId = 511,
		payType = GameEnum.PaySubGoodsType.PAY_SHOP
	},
	{
		shopId = 1,
		icon = "icon_xinshouka",
		payType = GameEnum.PaySubGoodsType.NEW_HAND_CARD
	},
	{
		shopId = 1,
		icon = "icon_yk",
		payType = GameEnum.PaySubGoodsType.MONTH_CARD
	},
	{
		shopId = 512,
		payType = GameEnum.PaySubGoodsType.PAY_SHOP
	}
}

function HdluoshiqiView:ctor()
	HdluoshiqiView.super.ctor(self)

	self.cellArr = {}
end

function HdluoshiqiView:buildUI()
	HdluoshiqiView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.cell = self:getGo("cell")
	self.itemCon = self:getGo("itemCon")
	self.item = self:getGo("item")

	GameUtil.SetActive(self.cell, false)
	GameUtil.SetActive(self.item, false)
end

function HdluoshiqiView:bindEvents()
	HdluoshiqiView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function HdluoshiqiView:unbindEvents()
	HdluoshiqiView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function HdluoshiqiView:destroyUI()
	HdluoshiqiView.super.destroyUI(self)
end

function HdluoshiqiView:onEnter()
	HdluoshiqiView.super.onEnter(self)
	self:refreshUI()

	self.payHandler = PayAgent.instance:addHandler(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
end

function HdluoshiqiView:onEnterFinished()
	HdluoshiqiView.super.onEnterFinished(self)
end

function HdluoshiqiView:onExit()
	HdluoshiqiView.super.onExit(self)
	PayAgent.instance:removeHandler(PayAgent.NotifyPayResultRes, self.payHandler)
	self:clearUI()
end

function HdluoshiqiView:onExitFinished()
	HdluoshiqiView.super.onExitFinished(self)
end

function HdluoshiqiView:clearUI()
	for k, cell in pairs(self.cellArr) do
		local bigItem = goutil.findChild(cell, "bigItem")
		local items = goutil.findChild(cell, "items")

		uGuiUtil.clearImage(bigItem)

		local trs = items.transform

		if trs ~= nil and trs.childCount > 0 then
			local count = trs.childCount

			for i = count, 1, -1 do
				local child = trs:GetChild(i - 1)

				MaterialMgr.resetAll(items)
			end
		end
	end

	self.cellArr = {}

	goutil.clearChildren(self.itemCon)
end

function HdluoshiqiView:refreshUI()
	self:clearUI()

	for i, v in ipairs(HdluoshiqiView.config) do
		self:createCell(v)
	end
end

function HdluoshiqiView:payShopBuy(cfg)
	if cfg.payType == GameEnum.PaySubGoodsType.PAY_SHOP then
		local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

		PayController.instance:pay(mibaoCfg.originalGoodsId, cfg.payType, cfg.shopId)
	elseif cfg.payType == GameEnum.PaySubGoodsType.MONTH_CARD then
		local newCfg = MonthCardConfig.instance:getCfgById(cfg.shopId)

		PayController.instance:pay(newCfg.payGoodsId, cfg.payType, cfg.shopId)
	elseif cfg.payType == GameEnum.PaySubGoodsType.NEW_HAND_CARD then
		local newCfg = NewHandCardConfig.instance:getCfgById(cfg.shopId)

		PayController.instance:pay(newCfg.payGoodsId, cfg.payType, cfg.shopId)
	end
end

function HdluoshiqiView:createCell(cfg)
	local cell = goutil.clone(self.cell, "cell_" .. cfg.payType .. "_" .. cfg.shopId)

	GameUtil.SetActive(cell, true)
	goutil.addChildToParent(cell, self.itemCon)
	table.insert(self.cellArr, cell)

	local bigItem = goutil.findChild(cell, "bigItem")
	local txtName = goutil.findChildTextComponent(cell, "imgName/Text")
	local btnBuy = goutil.findChild(cell, "btnBuy")
	local hasBuy = goutil.findChild(cell, "hasBuy")
	local hasBuyText = goutil.findChildTextComponent(hasBuy, "txt")
	local txtBuy = goutil.findChildTextComponent(cell, "btnBuy/Text")
	local itemsGo = goutil.findChild(cell, "items")
	local recordBtn = GameUtil.asBtn(goutil.findChild(cell, "btnRecord"))

	goutil.clearChildren(itemsGo)
	goutil.setActive(recordBtn.gameObject, cfg.payType == GameEnum.PaySubGoodsType.NEW_HAND_CARD)
	GameUtil.rmClickHandler(btnBuy)

	local isCanBuy = false
	local payCfg
	local arr = {}
	local days = {}
	local icon = cfg.icon
	local notCanbuyTip = "已购买"

	if cfg.payType == GameEnum.PaySubGoodsType.PAY_SHOP then
		local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

		txtName.text = mibaoCfg.name
		icon = mibaoCfg.icon

		local content = mibaoCfg.content

		arr = string.split(content, "#")
		payCfg = PayConfig.instance:getPayGoodsCfg(mibaoCfg.originalGoodsId)
		isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(cfg.shopId)
	elseif cfg.payType == GameEnum.PaySubGoodsType.NEW_HAND_CARD then
		recordBtn:AddClickListener(self._onClickNewHandCardRecord, self)

		local newCfg = NewHandCardConfig.instance:getCfgById(cfg.shopId)

		txtName.text = newCfg.name
		arr = string.split(newCfg.onceGain, "#")

		for i, v in ipairs(arr) do
			table.insert(days, 0)
		end

		local tem = string.split(newCfg.dailyGain, "#")

		for i, v in ipairs(tem) do
			table.insert(arr, v)
			table.insert(days, newCfg.duration)
		end

		payCfg = PayConfig.instance:getPayGoodsCfg(newCfg.payGoodsId)

		local buyNewhandcard = NewHandCardModel.instance:isBuyCard()
		local inAct = NewHandCardModel.instance:isInAct()

		isCanBuy = not buyNewhandcard and inAct

		if not isCanBuy then
			if buyNewhandcard then
				if not NewHandCardModel.instance:isShowMainIcon() then
					notCanbuyTip = "已过期"
				end
			else
				notCanbuyTip = "已过期"
			end
		end
	elseif cfg.payType == GameEnum.PaySubGoodsType.MONTH_CARD then
		local newCfg = MonthCardConfig.instance:getCfgById(cfg.shopId)

		txtName.text = newCfg.cardName
		arr = string.split(newCfg.onceGain, "#")

		for i, v in ipairs(arr) do
			table.insert(days, 0)
		end

		local tem = string.split(newCfg.dailyGain, "#")

		for i, v in ipairs(tem) do
			table.insert(arr, v)
			table.insert(days, newCfg.times)
		end

		payCfg = PayConfig.instance:getPayGoodsCfg(newCfg.payGoodsId)
		isCanBuy = not MonthCardModel.instance:isCardActive(cfg.shopId)
	end

	uGuiUtil.setSpriteToImage(bigItem, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(icon))
	self:setItems(arr, itemsGo, days, cfg.payType == GameEnum.PaySubGoodsType.NEW_HAND_CARD)

	txtBuy.text = ""

	if payCfg then
		local cost = payCfg.payMoney / 100

		txtBuy.text = "￥" .. cost
	end

	goutil.setActive(hasBuy, not isCanBuy)
	goutil.setActive(btnBuy, isCanBuy)

	hasBuyText.text = notCanbuyTip

	if isCanBuy then
		GameUtil.addClickHandler(btnBuy, GameUtil.handler(self.payShopBuy, self, cfg))
	end
end

function HdluoshiqiView:_onClickNewHandCardRecord()
	UIStateManager.instance:push(ViewName.NewhandcardrecordView)
end

function HdluoshiqiView:handleNotifyPayResultRes(msg, status)
	if status == 0 then
		self:refreshUI()
	end
end

function HdluoshiqiView:setItems(arr, itemsGo, days, isNewHandCard)
	for i, v in ipairs(arr) do
		local cell = goutil.clone(self.item)

		GameUtil.SetActive(cell, true)

		local con = goutil.findChild(cell, "con")

		goutil.addChildToParent(cell, itemsGo)
		MaterialMgr.setCellByCfg(v, con)

		local txt = goutil.findChildTextComponent(cell, "txt")
		local txtAuto = goutil.findChildTextComponent(cell, "txtAuto")

		txt.text = ""
		txtAuto.text = ""

		if checknumber(days[i]) > 0 then
			txt.text = langPara("连续%s天", days[i])
		end

		if isNewHandCard and i == 2 then
			txtAuto.text = "自动发放"
		end
	end
end

return HdluoshiqiView
