-- chunkname: @modules/logic/sodache/view/inside/SodacheWorshipView.lua

module("modules.logic.sodache.view.inside.SodacheWorshipView", package.seeall)

local SodacheWorshipView = class("SodacheWorshipView", BaseView)

function SodacheWorshipView:onInitView()
	self._gocard = gohelper.findChild(self.viewGO, "Card/go_carditem")
	self._btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/selected/#btn_reveal")
	self._coinimage = gohelper.findChildImage(self.viewGO, "Bottom/selected/#btn_reveal/#image_currency")
	self._txtCost = gohelper.findChildTextMesh(self.viewGO, "Bottom/selected/#btn_reveal/#txt_cost")
	self._goselect = gohelper.findChild(self.viewGO, "Bottom/selected")
	self._gounselect = gohelper.findChild(self.viewGO, "Bottom/unselect")
	self._gochecked = gohelper.findChild(self.viewGO, "Bottom/effected")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._godesc = gohelper.findChild(self.viewGO, "Bottom/selected/scroll_Desc/Viewport/Content/#txt_Desc")
	self._godesc2 = gohelper.findChild(self.viewGO, "Bottom/effected/scroll_Desc/Viewport/Content/#txt_Desc")
	self._gocoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self._btnattr = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ViewAll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheWorshipView:addEvents()
	self._btnCheck:AddClickListener(self.checkHandle, self)
	self._btnattr:AddClickListener(self._onClickAttr, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnScenePropUpdate, self._onPropUpdate, self)
end

function SodacheWorshipView:removeEvents()
	self._btnCheck:RemoveClickListener()
	self._btnattr:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnScenePropUpdate, self._onPropUpdate, self)
end

function SodacheWorshipView:_editableInitView()
	gohelper.setActive(self._goevent, false)
end

function SodacheWorshipView:_onClickAttr()
	ViewMgr.instance:openView(ViewName.SodacheRelicOverView)
end

function SodacheWorshipView:onOpen()
	self._unitMo = self.viewParam.unitMo

	self:initCost()

	self._cardItems = {}
	self._selectCards = {}
	self._cardAnim = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._createCard, {
		1,
		2,
		3
	}, nil, self._gocard)

	local selectCards = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SodacheWorshipSelectCard, "")

	if not string.nilorempty(selectCards) then
		if isDebugBuild then
			local allShowItems = SodacheMapUtil.getWorshipItems()

			for i, v in ipairs(string.splitToNumber(selectCards, "#")) do
				local isHave = false

				if isDebugBuild then
					for _, cardMo in ipairs(isDebugBuild) do
						if cardMo.serverMo.configId == v then
							isHave = true

							break
						end
					end
				else
					isHave = true
				end

				if isHave then
					table.insert(self._selectCards, v)
				end
			end
		end
	end

	self:_refreshCardShow()
end

function SodacheWorshipView:initCost()
	UISpriteSetMgr.instance:setSodache2Sprite(self._coinimage, SodacheUtil.getCurrencyIcon())
	MonoHelper.addNoUpdateLuaComOnceToGo(self._gocoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Inside
	})

	self._costNum = 0
	self._isEnoughCoin = true

	local costStr = SodacheConfig.instance:getConstVal(SodacheEnum.ConstId.WorshipCost)

	if not string.nilorempty(costStr) then
		local arr = string.splitToNumber(costStr, ":")
		local itemId = arr[1]
		local costNum = arr[2]

		if costNum > SodacheUtil.getItemCount(itemId, SodacheEnum.BagType.Inside) then
			self._isEnoughCoin = false
		end

		self._costNum = costNum
		self._txtCost.text = self._isEnoughCoin and -costNum or "<color=#C00017>" .. -costNum
	else
		self._txtCost.text = "0"

		logError("没有配置供奉消耗!!!")

		return
	end
end

function SodacheWorshipView:_createCard(obj, data, index)
	local tb = self:getUserDataTb_()

	tb.cardGo = gohelper.findChild(obj, "go_has")
	tb.cardItemGo = gohelper.findChild(obj, "go_has/sodache_carditem")
	tb.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(tb.cardItemGo, SodacheCardItem)
	tb.addGo = gohelper.findChild(obj, "go_add")
	tb.emptyGo = gohelper.findChild(obj, "go_empty")
	tb.lockGo = gohelper.findChild(obj, "go_lock")
	tb.click = gohelper.findChildButtonWithAudio(obj, "#btn_click")
	self._cardAnim[index] = gohelper.findComponentAnim(tb.cardGo)

	tb.cardItem:showInfo()
	tb.cardItem:setShowStar(true)
	self.addClickCb(self, tb.click, self._onCardSelect, self, index)

	self._cardItems[data] = tb
end

function SodacheWorshipView:_onCardSelect(index)
	if self:isUnitChecked() then
		return
	end

	if index > SodacheUtil.getAttr(SodacheEnum.AttrId.AltarLimit) then
		GameFacade.showToast(ToastEnum.SodacheToastId373009)

		return
	end

	if not self.selectMo then
		local selectMo = SodacheCardSelectMo.New()

		selectMo.selectCallobj = self
		selectMo.selectCallback = self.onSelectCardEnd
		selectMo.isMultSelect = true
		selectMo.canSelectCards = SodacheMapUtil.getWorshipItems()
		selectMo.totalSelectCount = SodacheUtil.getAttr(SodacheEnum.AttrId.AltarLimit)
		self.selectMo = selectMo
	end

	if #self.selectMo.canSelectCards <= 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373016)

		return
	end

	self.selectMo:clearSelect()

	for i, v in ipairs(self._selectCards) do
		self.selectMo:addItemCount(v, 1)
	end

	ViewMgr.instance:openView(ViewName.SodacheCardQuickSelectView, self.selectMo)
end

function SodacheWorshipView:checkHandle()
	if not self._isEnoughCoin then
		GameFacade.showToast(ToastEnum.SodacheToastId373001, SodacheUtil.getCurrencyName())

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.SodacheMessageId373002, MsgBoxEnum.BoxType.Yes_No, self._realTriggerEvent, nil, nil, self, nil, nil, SodacheUtil.getCurrencyName(), self._costNum)
end

function SodacheWorshipView:_realTriggerEvent()
	local selectArr = self._selectCards

	if selectArr[1] then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Interaction, tostring(self._unitMo.uid) .. "#" .. table.concat(selectArr, ","))
	end
end

function SodacheWorshipView:_onPropUpdate()
	self:_refreshCardShow(true)
end

function SodacheWorshipView:_refreshCardShow(isServer)
	local isChecked = self:isUnitChecked()

	gohelper.setActive(self._gotopright, not isChecked)

	if isChecked or not self._selectCards[1] then
		self._selectCards = {}

		local insideMo = SodacheModel.instance:getInsideMo()
		local cards = insideMo.prop.offerRelicIds

		for i = 1, #cards do
			local itemId = cards[i]

			table.insert(self._selectCards, itemId)
		end
	end

	if isServer and isChecked then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.check_success)

		for i = 1, 3 do
			if not self._selectCards[i] then
				local cardId = 0

				if cardId > 0 then
					self._cardAnim[i]:Play("confirm")
				end
			end
		end
	end

	for i = 1, 3 do
		local cardTb = self._cardItems[i]

		if not self._selectCards[i] then
			local cardId = 0
			local isLock = i > SodacheUtil.getAttr(SodacheEnum.AttrId.AltarLimit)

			gohelper.setActive(cardTb.lockGo, isLock)
			gohelper.setActive(cardTb.cardGo, cardId > 0)
			gohelper.setActive(cardTb.addGo, not isLock and cardId <= 0 and not isChecked)
			gohelper.setActive(cardTb.emptyGo, not isLock and cardId <= 0 and isChecked)

			if cardId > 0 then
				cardTb.cardItem:updateMo(SodacheCardMo.Create(cardId))
			end
		end
	end

	gohelper.setActive(self._goselect, self._selectCards[1] and not isChecked)
	gohelper.setActive(self._gochecked, self._selectCards[1] and isChecked)
	gohelper.setActive(self._gounselect, not self._selectCards[1])
	gohelper.CreateObjList(self, self._createDesc, self._selectCards, nil, (isChecked or nil) and (self._godesc2 or self._godesc))
end

function SodacheWorshipView:_createDesc(obj, data, index)
	local outsideMo = SodacheModel.instance:getOutsideMo()
	local mo = outsideMo.relicBox:getRelicMo(data)

	if not mo then
		return
	end

	local txt = gohelper.findChildTextMesh(obj, "")

	txt.text = string.format("<#F0E8BB>%s：</color>%s", mo.itemCo.name, SodacheUtil.changeDescColor(mo.relicCo.effect2Desc))
end

function SodacheWorshipView:isUnitChecked()
	local insideMo = SodacheModel.instance:getInsideMo()
	local cards = insideMo.prop.offerRelicIds

	return #cards > 0
end

function SodacheWorshipView:onSelectCardEnd(selectCards)
	self._selectCards = {}

	for k, v in pairs(selectCards) do
		for i = 1, v do
			table.insert(self._selectCards, k)
		end
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SodacheWorshipSelectCard, table.concat(self._selectCards, "#"))
	self:_refreshCardShow()
end

return SodacheWorshipView
