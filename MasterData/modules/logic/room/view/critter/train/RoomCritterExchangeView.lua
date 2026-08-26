-- chunkname: @modules/logic/room/view/critter/train/RoomCritterExchangeView.lua

module("modules.logic.room.view.critter.train.RoomCritterExchangeView", package.seeall)

local RoomCritterExchangeView = class("RoomCritterExchangeView", BaseView)

function RoomCritterExchangeView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_leftbg")
	self._txtleftproductname = gohelper.findChildText(self.viewGO, "left/#txt_leftproductname")
	self._simageleftproduct = gohelper.findChildSingleImage(self.viewGO, "left/#simage_leftproduct")
	self._txtrightproductname = gohelper.findChildText(self.viewGO, "right/#txt_rightproductname")
	self._simagerightproduct = gohelper.findChildSingleImage(self.viewGO, "right/#simage_rightproduct")
	self._gobuy = gohelper.findChild(self.viewGO, "#go_buy")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_buy/#txt_count")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_buy/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_buy")
	self._gobuylimit = gohelper.findChild(self.viewGO, "#go_buy/#go_buylimit")
	self._gocost = gohelper.findChild(self.viewGO, "#go_buy/cost")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "#go_buy/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "#go_buy/cost/#txt_originalCost")
	self._txtoriginalCost2 = gohelper.findChildText(self.viewGO, "#go_buy/cost/#txt_originalCost2")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterExchangeView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomCritterExchangeView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

local MaxBuyCount = 99

function RoomCritterExchangeView:_btnminOnClick()
	self._buyCount = 1

	self:_refreshUI()
end

function RoomCritterExchangeView:_btnsubOnClick()
	if self._buyCount < 1 then
		return
	end

	self._buyCount = self._buyCount - 1

	self:_refreshUI()
end

function RoomCritterExchangeView:_btnaddOnClick()
	if self._buyCount >= self._maxBuyCount then
		return
	end

	self._buyCount = self._buyCount + 1

	self:_refreshUI()
end

function RoomCritterExchangeView:_btnmaxOnClick()
	self._buyCount = self._maxBuyCount

	self:_refreshUI()
end

function RoomCritterExchangeView:_btnbuyOnClick()
	local goodMo = RoomTrainCritterModel.instance:getProductGood(self.viewParam[2])
	local costs = string.splitToNumber(goodMo.config.cost, "#")
	local itemCo = ItemModel.instance:getItemConfig(costs[1], costs[2])
	local hasCount = self:getOwnCount()

	if hasCount < self._buyCount then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNotEnoughCurrency, itemCo.name)

		return
	end

	StoreController.instance:buyGoods(goodMo, self._buyCount, self._buyCallback, self)
	self:closeThis()
end

function RoomCritterExchangeView:_btncloseOnClick()
	self:closeThis()
end

function RoomCritterExchangeView:onClickModalMask()
	self:closeThis()
end

function RoomCritterExchangeView:_onInputCountValueChanged()
	self:_checkRefreshInputAmount()
end

function RoomCritterExchangeView:_onInputCountEndEdit()
	self:_checkRefreshInputAmount()
end

function RoomCritterExchangeView:_checkRefreshInputAmount()
	local value = tonumber(self._inputvalue:GetText())

	value = value or 0
	value = value > self._maxBuyCount and self._maxBuyCount or value
	self._buyCount = value

	self:_refreshUI()
end

function RoomCritterExchangeView:_editableInitView()
	self._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)
	self._inputText = self._inputvalue.inputField.textComponent
	self._buyCount = 1
end

function RoomCritterExchangeView:_refreshUI()
	self._inputvalue:SetText(self._buyCount)

	local goodMo = RoomTrainCritterModel.instance:getProductGood(self.viewParam[2])

	if not goodMo then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	local remain = goodMo.config.maxBuyCount - goodMo.buyCount
	local costs = string.splitToNumber(goodMo.config.cost, "#")
	local hasCount = self:getOwnCount()
	local content = StoreConfig.instance:getRemain(goodMo.config, remain, goodMo.offlineTime)

	if string.nilorempty(content) then
		gohelper.setActive(self._txtcount.gameObject, false)

		if hasCount > MaxBuyCount then
			self._maxBuyCount = MaxBuyCount or hasCount
		end
	else
		gohelper.setActive(self._txtcount.gameObject, true)

		self._txtcount.text = content .. "/" .. goodMo.config.maxBuyCount
		self._maxBuyCount = remain
	end

	if hasCount == 0 then
		self._maxBuyCount = 1
	end

	gohelper.setActive(self._gobuylimit, self._buyCount <= 0)
	gohelper.setActive(self._btnbuy.gameObject, self._buyCount > 0)
	gohelper.setActive(self._gocost, self._buyCount > 0)

	if self._buyCount > 0 then
		if string.nilorempty(goodMo.config.cost) then
			gohelper.setActive(self._txtoriginalCost.gameObject, false)
		else
			gohelper.setActive(self._txtoriginalCost.gameObject, true)

			self._txtoriginalCost.text = self._buyCount * costs[3]
		end

		if goodMo.config.originalCost > 0 then
			gohelper.setActive(self._txtoriginalCost2.gameObject, true)

			self._txtoriginalCost2.text = self._buyCount * goodMo.config.originalCost
		else
			gohelper.setActive(self._txtoriginalCost2.gameObject, false)
		end
	end

	local enough = hasCount >= self._buyCount

	if enough then
		if not self._colorDefault then
			self._inputText.color = Color.red
		end
	end
end

function RoomCritterExchangeView:getOwnCount()
	local goodMo = RoomTrainCritterModel.instance:getProductGood(self.viewParam[2])
	local costs = string.splitToNumber(goodMo.config.cost, "#")
	local hasCount = ItemModel.instance:getItemQuantity(costs[1], costs[2])

	return math.floor(hasCount / costs[3])
end

function RoomCritterExchangeView:onUpdateParam()
	return
end

function RoomCritterExchangeView:onOpen()
	self:_initIcon()
	self:_refreshUI()
	self._inputvalue:AddOnValueChanged(self._onInputCountValueChanged, self)
	self._inputvalue:AddOnEndEdit(self._onInputCountEndEdit, self)
end

function RoomCritterExchangeView:_initIcon()
	local goodMo = RoomTrainCritterModel.instance:getProductGood(self.viewParam[2])

	if not goodMo then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	local cost1s = string.splitToNumber(goodMo.config.product, "#")
	local itemCo1, icon1 = ItemModel.instance:getItemConfigAndIcon(cost1s[1], cost1s[2], true)

	gohelper.setActive(self._simagerightproduct.gameObject, true)
	self._simagerightproduct:LoadImage(icon1)

	self._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_critter_exchange"), {
		itemCo1.name,
		cost1s[3]
	})

	local cost2s = string.splitToNumber(goodMo.config.cost, "#")
	local itemCo2, icon2 = ItemModel.instance:getItemConfigAndIcon(cost2s[1], cost2s[2], true)

	gohelper.setActive(self._simageleftproduct.gameObject, true)
	self._simageleftproduct:LoadImage(icon2)

	self._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_critter_exchange"), {
		itemCo2.name,
		cost2s[3]
	})

	self._simagecosticon:LoadImage(icon2)

	local result = {}

	table.insert(result, cost1s[2])
	table.insert(result, cost2s[2])
	self.viewContainer:setCurrencyType(result)
end

function RoomCritterExchangeView:onClose()
	return
end

function RoomCritterExchangeView:onDestroyView()
	self._inputvalue:RemoveOnValueChanged()
	self._inputvalue:RemoveOnEndEdit()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageleftproduct:UnLoadImage()
	self._simagerightproduct:UnLoadImage()
end

return RoomCritterExchangeView
