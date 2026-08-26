-- chunkname: @modules/logic/currency/view/CurrencyView.lua

module("modules.logic.currency.view.CurrencyView", package.seeall)

local CurrencyView = class("CurrencyView", BaseView)

function CurrencyView:onInitView()
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_container/#go_currency")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CurrencyView:addEvents()
	return
end

function CurrencyView:removeEvents()
	return
end

function CurrencyView._btncurrencyOnClick(param)
	local selfObj = param.self
	local index = param.index

	selfObj:_btncurrencyClick(selfObj.param[index])
end

function CurrencyView:_btncurrencyClick(param)
	if not param then
		return
	end

	if self.overrideClickFunc then
		return self.overrideClickFunc(self.overrideClickFuncObj, param)
	end

	if type(param) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, param, false, nil, self._cantJump)
	else
		MaterialTipController.instance:showMaterialInfo(param.type, param.id, false, nil, self._cantJump)
	end

	if self._callback then
		self._callback(self._callbackObj)
	end
end

function CurrencyView._btncurrencyExchangeOnClick(param)
	local selfObj = param.self
	local index = param.index

	selfObj:_btncurrencyExchangeClick(selfObj.param[index])
end

function CurrencyView:_btncurrencyExchangeClick(param)
	if not param then
		return
	end

	local currencyId = type(param) == "number" and param or param.id
	local infoMo = CurrencyExchangeModel.instance:getInfoMo(currencyId)

	if not infoMo then
		return
	end

	CurrencyExchangeController.instance:openCurrencyExchangeView(currencyId)
end

function CurrencyView:setOpenCallback(callback, callbackObj)
	self._openCallback = callback
	self._openCallbackObj = callbackObj
end

function CurrencyView:ctor(param, callback, callbackObj, localItemsEvent, cantJump)
	CurrencyView.super.ctor(self)

	self.param = param
	self._callback = callback
	self._callbackObj = callbackObj
	self._localItemsEvent = localItemsEvent
	self._cantJump = cantJump
end

function CurrencyView:overrideCurrencyClickFunc(func, obj)
	self.overrideClickFunc = func
	self.overrideClickFuncObj = obj
end

function CurrencyView:_onLocalItemChanged(items, notRefresh)
	self._minusItemDict = {}

	if items then
		for i = 1, #items do
			local item = items[i]

			if item.type == MaterialEnum.MaterialType.Currency then
				self._minusItemDict[item.id] = (self._minusItemDict[item.id] or 0) + item.quantity
			end
		end
	end

	if notRefresh then
		return
	end

	self:_onCurrencyChange()
end

function CurrencyView._onClick(param)
	local selfObj = param.self
	local index = param.index
	local param = selfObj.param[index]

	if not param then
		return
	end

	if type(param) == "number" then
		local currencyId = param

		CurrencyJumpHandler.JumpByCurrency(currencyId)
	elseif param.jumpFunc then
		param.jumpFunc(param.type, param.id)
	end
end

function CurrencyView:_editableInitView()
	gohelper.setActive(self._gocurrency, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._currencyObjs = {}
	self._currentItemIndex = nil

	if not self.param then
		logError("没有传入货币类型给CurrencyView")

		return
	end

	self._initialized = true

	self:_onCurrencyChange()
end

function CurrencyView:setCurrencyType(currencyTypeParam)
	self.param = currencyTypeParam

	self:_onCurrencyChange()
end

function CurrencyView:onDestroyView()
	for _, itemObj in ipairs(self._currencyObjs) do
		itemObj.simage:UnLoadImage()
		itemObj.btn:RemoveClickListener()
		itemObj.btncurrency:RemoveClickListener()
		itemObj.btnexchangetip:RemoveClickListener()
	end
end

function CurrencyView:onOpen()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSwitchTab, self._onSwitchStoreTab, self)

	if self._localItemsEvent then
		self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUplocalItem, self._onLocalItemChanged, self)
	end

	if self.viewContainer.viewParam and self.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		self._animator:Play("currencyview_in2")
	else
		self._animator:Play("currencyview_in")
	end

	if self._openCallback then
		self._openCallback(self._openCallbackObj)

		self._openCallback = nil
		self._openCallbackObj = nil
	end
end

function CurrencyView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshPowerDeadlineUI, self)
	TaskDispatcher.cancelTask(self._onRefreshExpireItemDeadlineUI, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self)

	if self.viewContainer.viewParam and self.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		self._animator:Play("currencyview_out2")
	else
		self._animator:Play("currencyview_out")
	end
end

function CurrencyView:_onCurrencyChange()
	if not self.param then
		gohelper.setActive(self._gocontainer, false)

		return
	end

	if not self._initialized then
		return
	end

	local paramLen = #self.param
	local sibling = 1

	for index = paramLen, 1, -1 do
		local itemObj = self:getCurrencyItem(index)
		local param = self.param[index]

		gohelper.setSibling(itemObj.go, sibling)

		sibling = sibling + 1

		gohelper.setActive(itemObj.goCurrentTime, false)
		gohelper.setActive(itemObj.deadlineEffect, false)

		if param then
			local isSingleImage = false
			local showBtn = true
			local showExchangeTipBtn = false

			if type(param) == "number" then
				local currencyID = param
				local currencyMO = CurrencyModel.instance:getCurrency(currencyID)
				local currencyCO = CurrencyConfig.instance:getCurrencyCo(currencyID)

				if currencyMO then
					if not currencyMO.quantity then
						local quantity = 0

						if self._minusItemDict and self._minusItemDict[currencyID] then
							quantity = quantity - self._minusItemDict[currencyID]
						end

						itemObj.txt.text = self.showMaxLimit and string.format("%s/%s", GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(currencyCO.maxLimit)) or GameUtil.numberDisplay(quantity)

						itemObj.go:SetActive(true)

						local currencyname = currencyCO.icon

						UISpriteSetMgr.instance:setCurrencyItemSprite(itemObj.image, currencyname .. "_1")

						if self:isNeedShieldAddBtn() then
							showBtn = false

							itemObj.btn.gameObject:SetActive(false)
						end

						if self:isNeedExchangeTipBtn(currencyID) then
							showExchangeTipBtn = true
						end

						if currencyID == CurrencyEnum.CurrencyType.Power then
							self.powerItemObj = itemObj

							self:_onRefreshPowerDeadlineUI()
						end

						isSingleImage = false
					end
				end
			else
				local type = param.type
				local id = param.id
				local isIcon = param.isIcon

				if not param.quantity then
					local quantity = ItemModel.instance:getItemQuantity(type, id)

					itemObj.txt.text = GameUtil.numberDisplay(quantity)

					itemObj.go:SetActive(true)

					if param.isCurrencySprite then
						if not param.icon then
							local iconId = id

							UISpriteSetMgr.instance:setCurrencyItemSprite(itemObj.image, tostring(iconId) .. "_1")
						end
					else
						local icon = param.icon

						if not icon then
							if isIcon then
								icon = ItemModel.instance:getItemSmallIcon(id)
							else
								local _, tempIcon = ItemModel.instance:getItemConfigAndIcon(type, id, isIcon)

								icon = tempIcon
							end
						end

						itemObj.simage:LoadImage(icon)
					end

					if self:isNeedShieldAddBtn() or param.isHideAddBtn == true then
						showBtn = false
					end

					if self:isNeedExchangeTipBtn(id) then
						showExchangeTipBtn = true
					end

					if type == MaterialEnum.MaterialType.PowerPotion then
						self.powerItemObj = itemObj

						self:_onRefreshPowerDeadline()
					end

					if type == MaterialEnum.MaterialType.SpecialExpiredItem then
						self.expiredItemObj = itemObj

						self:_onRefreshExpireItemDeadline()
					end

					isSingleImage = not param.isCurrencySprite
				end
			end

			gohelper.setActive(itemObj.image.gameObject, not isSingleImage)
			gohelper.setActive(itemObj.simage.gameObject, isSingleImage)
			gohelper.setActive(itemObj.btn, showBtn)
			gohelper.setActive(itemObj.btnexchangetip, showExchangeTipBtn)
		else
			itemObj.go:SetActive(false)
		end
	end

	if paramLen < #self._currencyObjs then
		for i = paramLen + 1, #self._currencyObjs do
			local itemObj = self:getCurrencyItem(i)

			itemObj.go:SetActive(false)
		end
	end

	gohelper.setActive(self._gocontainer, paramLen > 0)
end

function CurrencyView:getCurrencyItem(index)
	local currencyObj = self._currencyObjs[index]

	if not currencyObj then
		currencyObj = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gocurrency, "currency")

		currencyObj.go = go
		currencyObj.btn = gohelper.findChildButtonWithAudio(go, "#btn_currency/#btn")
		currencyObj.simage = gohelper.findChildSingleImage(go, "#btn_currency/#simage")
		currencyObj.image = gohelper.findChildImage(go, "#btn_currency/#image")
		currencyObj.btncurrency = gohelper.findChildButtonWithAudio(go, "#btn_currency")
		currencyObj.txt = gohelper.findChildText(go, "#btn_currency/content/#txt")
		currencyObj.click = gohelper.findChild(go, "#btn_currency/click")
		currencyObj.goCurrentTime = gohelper.findChild(go, "#btn_currency/#go_currenttime")
		currencyObj.txtTime = gohelper.findChildText(go, "#btn_currency/#go_currenttime/timetxt")
		currencyObj.deadlineEffect = gohelper.findChild(go, "#btn_currency/#effect")
		currencyObj.btnexchangetip = gohelper.findChildButtonWithAudio(go, "#btn_currency/#btn_exchangetip")

		currencyObj.btn:AddClickListener(self._onClick, {
			self = self,
			index = index
		})
		currencyObj.btncurrency:AddClickListener(self._btncurrencyOnClick, {
			self = self,
			index = index
		})
		currencyObj.btnexchangetip:AddClickListener(self._btncurrencyExchangeOnClick, {
			self = self,
			index = index
		})

		self._currencyObjs[index] = currencyObj

		gohelper.setActive(currencyObj.go, true)
	end

	return currencyObj
end

function CurrencyView:isNeedExchangeTipBtn(currencyId)
	if not self.viewName then
		return false
	end

	if self.viewName ~= ViewName.StoreView then
		return false
	end

	local exchangeConfig = CurrencyExchangeConfig.instance:getExchangeConfig(currencyId)

	if not exchangeConfig then
		return false
	end

	local infoMo = CurrencyExchangeModel.instance:getInfoMo(currencyId)

	if not infoMo then
		return false
	end

	local versionConstConfig = lua_const.configDict[ConstEnum.VersionId]
	local version = tonumber(versionConstConfig.value)

	if exchangeConfig.versionId ~= version then
		return false
	end

	return true
end

function CurrencyView:isNeedShieldAddBtn()
	if self.foreShowBtn then
		return false
	end

	if self.foreHideBtn then
		return true
	end

	CurrencyView.needShieldAddBtnViews = CurrencyView.needShieldAddBtnViews or {
		[ViewName.StoreSkinConfirmView] = 1,
		[ViewName.CharacterLevelUpView] = 1,
		[ViewName.StoreView] = 1,
		[ViewName.EquipView] = 1,
		[ViewName.NormalStoreGoodsView] = 1,
		[ViewName.SummonConfirmView] = 1,
		[ViewName.CharacterRankUpView] = 1,
		[ViewName.CurrencyExchangeView] = 1,
		[ViewName.PowerView] = 1,
		[ViewName.PowerBuyTipView] = 1,
		[ViewName.CurrencyDiamondExchangeView] = 1,
		[ViewName.CharacterTalentLevelUpView] = 1,
		[ViewName.RoomStoreGoodsTipView] = 1,
		[ViewName.PackageStoreGoodsView] = 1,
		[ViewName.StoreLinkGiftGoodsView] = 1,
		[ViewName.StoreSkinGoodsView] = 1,
		[ViewName.DecorateStoreGoodsView] = 1,
		[ViewName.VersionActivityStoreView] = 1,
		[ViewName.VersionActivityNormalStoreGoodsView] = 1,
		[ViewName.SeasonStoreView] = 1,
		[ViewName.VersionActivity1_2StoreView] = 1,
		[ViewName.V1a5BuildingView] = 1,
		[ViewName.V1a5BuildingDetailView] = 1,
		[ViewName.PowerActChangeView] = 1,
		[ViewName.SummonStoreGoodsView] = 1,
		[ViewName.VersionActivity1_6NormalStoreGoodsView] = 1,
		[ViewName.RoomFormulaMsgBoxView] = 1,
		[ViewName.SummonResultView] = 1,
		[ViewName.VersionActivity1_5NormalStoreGoodsView] = 1,
		[ViewName.PartyClothLotteryView] = 1,
		[ViewName.PartyClothRewardView] = 1
	}

	if not self.viewName then
		return false
	end

	return CurrencyView.needShieldAddBtnViews[self.viewName] == 1
end

function CurrencyView:_hideAddBtn(needHideType)
	local paramLen = #self.param

	for index = paramLen, 1, -1 do
		local param = self.param[index]
		local itemObj = self:getCurrencyItem(index)

		gohelper.setActive(itemObj.btn.gameObject, param ~= needHideType)
	end
end

function CurrencyView:_onRefreshPowerDeadline()
	self:_onRefreshPowerDeadlineUI()
	TaskDispatcher.runRepeat(self._onRefreshPowerDeadlineUI, self, 1)
end

function CurrencyView:_onRefreshPowerDeadlineUI()
	local itemDeadline = CurrencyController.instance:getPowerItemDeadLineTime()

	if itemDeadline and itemDeadline > 0 then
		local limitSec = itemDeadline - ServerTime.now()

		if limitSec <= 0 then
			ItemRpc.instance:autoUseExpirePowerItem()
			gohelper.setActive(self.powerItemObj.goCurrentTime, false)
			gohelper.setActive(self.powerItemObj.deadlineEffect, false)
			TaskDispatcher.cancelTask(self._onRefreshPowerDeadlineUI, self)

			return
		end

		local date, dateFormat, hasDay = TimeUtil.secondToRoughTime(limitSec, true)

		self.powerItemObj.txtTime.text = string.format("%s%s", date, dateFormat)

		gohelper.setActive(self.powerItemObj.goCurrentTime, not hasDay)
		gohelper.setActive(self.powerItemObj.deadlineEffect, not hasDay)
	else
		gohelper.setActive(self.powerItemObj.goCurrentTime, false)
		gohelper.setActive(self.powerItemObj.deadlineEffect, false)
	end
end

function CurrencyView:_onRefreshExpireItemDeadline()
	self:_onRefreshExpireItemDeadlineUI()
	TaskDispatcher.runRepeat(self._onRefreshExpireItemDeadlineUI, self, 1)
end

function CurrencyView:_onRefreshExpireItemDeadlineUI()
	local itemDeadline = ItemExpireModel.instance:getSpecialExpireItemEarliestExpireTime(StoreEnum.SupplementMonthCardItemId)

	if itemDeadline and itemDeadline > 0 then
		local limitSec = itemDeadline - ServerTime.now()

		if limitSec <= 0 then
			gohelper.setActive(self.expiredItemObj.goCurrentTime, false)
			gohelper.setActive(self.expiredItemObj.deadlineEffect, false)
			TaskDispatcher.cancelTask(self._onRefreshExpireItemDeadlineUI, self)

			return
		end

		local date, dateFormat, hasDay = TimeUtil.secondToRoughTime(limitSec, true)

		self.expiredItemObj.txtTime.text = string.format("%s%s", date, dateFormat)

		gohelper.setActive(self.expiredItemObj.goCurrentTime, true)
		gohelper.setActive(self.expiredItemObj.deadlineEffect, true)
	else
		gohelper.setActive(self.expiredItemObj.goCurrentTime, false)
		gohelper.setActive(self.expiredItemObj.deadlineEffect, false)
	end
end

function CurrencyView:_onSwitchStoreTab()
	TaskDispatcher.cancelTask(self._onRefreshPowerDeadlineUI, self)
	TaskDispatcher.cancelTask(self._onRefreshExpireItemDeadlineUI, self)
end

CurrencyView.prefabPath = "ui/viewres/common/currencyview.prefab"

return CurrencyView
