-- chunkname: @modules/logic/battlepass/view/BpBuyView.lua

module("modules.logic.battlepass.view.BpBuyView", package.seeall)

local BpBuyView = class("BpBuyView", BaseView)

function BpBuyView:onInitView()
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnBuy")
	self._btnMin = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnMin", AudioEnum.UI.play_ui_set_volume_button)
	self._btnMax = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnMax", AudioEnum.UI.play_ui_set_volume_button)
	self._btnMinus = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnMinus", AudioEnum.UI.play_ui_set_volume_button)
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnAdd", AudioEnum.UI.play_ui_set_volume_button)
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btnClose")
	self._btnClose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._sliderBuy = gohelper.findChildSlider(self.viewGO, "bg/#slider_buy")
	self._txtTips = gohelper.findChildText(self.viewGO, "bg/#txtTips")
	self._txtCost = gohelper.findChildText(self.viewGO, "bg/cost/#txtCost")
	self._imgCost = gohelper.findChildImage(self.viewGO, "bg/cost/#imgCost")
	self._txtbuy = gohelper.findChildTextMesh(self.viewGO, "bg/txtbuy/#txt_buyNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpBuyView:addEvents()
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnMin:AddClickListener(self._onClickbtnMin, self)
	self._btnMax:AddClickListener(self._onClickbtnMax, self)
	self._btnMinus:AddClickListener(self._onClickbtnMinus, self)
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnClose1:AddClickListener(self.closeThis, self)
	self._sliderBuy:AddOnValueChanged(self._onInpEndEdit, self)
end

function BpBuyView:removeEvents()
	self._btnBuy:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnClose1:RemoveClickListener()
	self._sliderBuy:RemoveOnValueChanged()
	self.removeEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._onBuyLevel, self)
end

function BpBuyView:_editableInitView()
	self._maxNum = #BpConfig.instance:getBonusCOList(BpModel.instance.id)
end

function BpBuyView:onOpen()
	local buyCost = CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost)

	self._buyCost = string.splitToNumber(buyCost, "#")

	local currencyname = CurrencyConfig.instance:getCurrencyCo(self._buyCost[2]).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgCost, currencyname .. "_1")

	self._num = 1

	self:_updateView()
end

function BpBuyView:onClose()
	return
end

function BpBuyView:_onClickbtnBuy()
	if CurrencyController.instance:checkFreeDiamondEnough(self._buyCost[3] * self._num, CurrencyEnum.PayDiamondExchangeSource.HUD, nil, self.buyLevel, self) then
		self:buyLevel()
	end
end

function BpBuyView:buyLevel()
	self.addEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._onBuyLevel, self)
	BpRpc.instance:sendBpBuyLevelRequset(self._num)
end

function BpBuyView:_onYes()
	self:closeThis()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function BpBuyView:_onClickbtnMin()
	self._num = 1

	self:_updateView()
end

function BpBuyView:_onClickbtnMax()
	self._num = self:_getMax()

	self:_updateView()
end

function BpBuyView:_onClickbtnMinus()
	if self._num > 1 then
		self._num = self._num - 1

		self:_updateView()
	end
end

function BpBuyView:_onClickbtnAdd()
	if self._num < self:_getMax() then
		self._num = self._num + 1

		self:_updateView()
	end
end

function BpBuyView:_onInpEndEdit()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local curLevel = math.floor(BpModel.instance.score / levelScore)
	local sliderValue = self._sliderBuy:GetValue()
	local num = Mathf.Round(sliderValue * (self._maxNum - curLevel - 1)) + 1

	if num then
		local max = self:_getMax()

		self._num = max < num and max or num < 1 and 1 or num
	end

	self:_updateView()
end

function BpBuyView:_updateView()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local curLevel = math.floor(BpModel.instance.score / levelScore)
	local targetLevel = self._num + curLevel
	local sliderValue = (self._num - 1) / (self._maxNum - curLevel - 1)

	self._sliderBuy.slider:SetValueWithoutNotify(sliderValue)

	self._txtbuy.text = self._num
	self._txtTips.text = formatLuaLang("bp_buy_reward_tip", targetLevel)

	local cost = self._buyCost[3] * self._num

	self._txtCost.text = tostring(cost)

	local currency = CurrencyModel.instance:getCurrency(self._buyCost[2])

	if currency then
		if not currency.quantity then
			local hasNum = 0

			SLFramework.UGUI.GuiHelper.SetColor(self._txtCost, cost <= hasNum and "#292523" or "#ff0000")

			local dict = {}
			local list = {}

			for level = curLevel + 1, targetLevel do
				local bonusCO = BpConfig.instance:getBonusCO(BpModel.instance.id, level)

				self:_calcBonus(dict, list, bonusCO.freeBonus)

				if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
					self:_calcBonus(dict, list, bonusCO.payBonus)
				end
			end

			BpBuyViewModel.instance:setList(list)
		end
	end
end

function BpBuyView:_calcBonus(dict, list, bonusStr)
	for _, str in pairs(string.split(bonusStr, "|")) do
		local sp = string.splitToNumber(str, "#")
		local id = sp[2]
		local num = sp[3]

		if not dict[id] then
			dict[id] = sp

			table.insert(list, sp)
		else
			dict[id][3] = dict[id][3] + num
		end
	end
end

function BpBuyView:_getMax()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local curLevel = math.floor(BpModel.instance.score / levelScore)
	local maxLevel = self._maxNum

	return maxLevel - curLevel
end

function BpBuyView:_onBuyLevel()
	self:closeThis()
end

function BpBuyView:onClickModalMask()
	self:closeThis()
end

return BpBuyView
