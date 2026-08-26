-- chunkname: @modules/logic/currency/view/PowerView.lua

module("modules.logic.currency.view.PowerView", package.seeall)

local PowerView = class("PowerView", BaseView)

function PowerView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._txtpower = gohelper.findChildText(self.viewGO, "powerGo/#txt_power")
	self._txtpowerlimit = gohelper.findChildText(self.viewGO, "powerGo/#txt_powerlimit")
	self._txtnexttime = gohelper.findChildText(self.viewGO, "#txt_nexttime")
	self._txttotaltime = gohelper.findChildText(self.viewGO, "#txt_totaltime")
	self._txtcount1 = gohelper.findChildText(self.viewGO, "item1/#txt_count1")
	self._txteffectname1 = gohelper.findChildText(self.viewGO, "item1/#txt_effectname1")
	self._btnuseitem1 = gohelper.findChildButtonWithAudio(self.viewGO, "item1/#btn_useitem1")
	self._godeadline1 = gohelper.findChild(self.viewGO, "item1/#go_deadline1")
	self._txtdeadline1 = gohelper.findChildText(self.viewGO, "item1/#go_deadline1/#txt_deadline1")
	self._imagetimeicon1 = gohelper.findChildImage(self.viewGO, "item1/#go_deadline1/#image_timeicon1")
	self._btnadd1 = gohelper.findChildButtonWithAudio(self.viewGO, "item1/#btn_add")
	self._txtcount2 = gohelper.findChildText(self.viewGO, "item2/#txt_count2")
	self._txteffectname2 = gohelper.findChildText(self.viewGO, "item2/#txt_effectname2")
	self._btnuseitem2 = gohelper.findChildButtonWithAudio(self.viewGO, "item2/#btn_useitem2")
	self._godeadline2 = gohelper.findChild(self.viewGO, "item2/#go_deadline2")
	self._txtdeadline2 = gohelper.findChildText(self.viewGO, "item2/#go_deadline2/#txt_deadline2")
	self._imagetimeicon2 = gohelper.findChildImage(self.viewGO, "item2/#go_deadline2/#image_timeicon2")
	self._btnadd2 = gohelper.findChildButtonWithAudio(self.viewGO, "item2/#btn_add")
	self._actItem = gohelper.findChild(self.viewGO, "act_item")
	self._txtactcount = gohelper.findChildText(self.viewGO, "act_item/#txt_actcount")
	self._txtacteffect = gohelper.findChildText(self.viewGO, "act_item/#txt_acteffect")
	self._btnactitem = gohelper.findChildButtonWithAudio(self.viewGO, "act_item/#btn_actitem")
	self._goactdeatline = gohelper.findChild(self.viewGO, "act_item/#go_actdeadline")
	self._txtacttime = gohelper.findChildText(self.viewGO, "act_item/#go_actdeadline/#txt_acttime")
	self._txtacticon = gohelper.findChildImage(self.viewGO, "act_item/#go_actdeadline/#txt_acttime/acttimeicon")
	self._txtbuycount = gohelper.findChildText(self.viewGO, "buyitem/#txt_buycount")
	self._txtbuypower = gohelper.findChildText(self.viewGO, "buyitem/#txt_buypower")
	self._btnbuyitem = gohelper.findChildButtonWithAudio(self.viewGO, "buyitem/#btn_buyitem")
	self._txtcost = gohelper.findChildText(self.viewGO, "buyitem/#txt_cost")
	self._goaddPowerTip = gohelper.findChild(self.viewGO, "#go_addPowerTip")
	self._goinventoryLackTip = gohelper.findChild(self.viewGO, "#go_inventoryLackTip")
	self._simageCostIcon = gohelper.findChildSingleImage(self.viewGO, "buyitem/#simage_costicon")
	self._buySuccessAnim = gohelper.findChild(self.viewGO, "bg/vxeffect/anim"):GetComponent(typeof(UnityEngine.Animator))
	self._txtpowervx = gohelper.findChildText(self.viewGO, "bg/vxeffect/anim/#txt_powervx")
	self._txtpowerlimitvx = gohelper.findChildText(self.viewGO, "bg/vxeffect/anim/#txt_powerlimitvx")
	self._overflowItem = gohelper.findChild(self.viewGO, "overflowitem")
	self._txtoverflowcount = gohelper.findChildText(self.viewGO, "overflowitem/#txt_overflowcount")
	self._txtoverfloweffect = gohelper.findChildText(self.viewGO, "overflowitem/#txt_overfloweffect")
	self._btnoverflowitem = gohelper.findChildButtonWithAudio(self.viewGO, "overflowitem/#btn_overflowitem")
	self._gooverflowdeatline = gohelper.findChild(self.viewGO, "overflowitem/#go_overflowdeadline")
	self._txtoverflowtime = gohelper.findChildText(self.viewGO, "overflowitem/#go_overflowdeadline/#txt_overflowtime")
	self._txtoverflowicon = gohelper.findChildImage(self.viewGO, "overflowitem/#go_overflowdeadline/#txt_overflowtime/overflowtimeicon")
	self._btnoverflowadd = gohelper.findChildButtonWithAudio(self.viewGO, "overflowitem/#btn_add")
	self._gooverflowmaker = gohelper.findChild(self.viewGO, "#go_overflowmaker")
	self._btnoverflowmakerInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_overflowmaker/#btn_Info")
	self._gomaking = gohelper.findChild(self.viewGO, "#go_overflowmaker/#go_making")
	self._txtmaketime = gohelper.findChildText(self.viewGO, "#go_overflowmaker/#go_making/#txt_maketime")
	self._gopause = gohelper.findChild(self.viewGO, "#go_overflowmaker/#go_pause")
	self._txtpausemaketime = gohelper.findChildText(self.viewGO, "#go_overflowmaker/#go_pause/#txt_maketime")
	self._goempty = gohelper.findChild(self.viewGO, "#go_overflowmaker/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PowerView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnuseitem1:AddClickListener(self._btnuseitem1OnClick, self)
	self._btnuseitem2:AddClickListener(self._btnuseitem2OnClick, self)
	self._btnbuyitem:AddClickListener(self._btnbuyitemOnClick, self)
	self._btnactitem:AddClickListener(self._btnactitemOnClick, self)
	self._btnoverflowitem:AddClickListener(self._btnoverflowitemOnClick, self)
	self._btnadd1:AddClickListener(self._btnadd1OnClick, self)
	self._btnadd2:AddClickListener(self._btnadd2OnClick, self)
	self._btnoverflowadd:AddClickListener(self._btnoverflowAddOnClick, self)
	self._btnoverflowmakerInfo:AddClickListener(self._btnoverflowmakerOnClick, self)
end

function PowerView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnuseitem1:RemoveClickListener()
	self._btnuseitem2:RemoveClickListener()
	self._btnbuyitem:RemoveClickListener()
	self._btnactitem:RemoveClickListener()
	self._btnoverflowitem:RemoveClickListener()
	self._btnadd1:RemoveClickListener()
	self._btnadd2:RemoveClickListener()
	self._btnoverflowadd:RemoveClickListener()
	self._btnoverflowmakerInfo:RemoveClickListener()
end

function PowerView:_btnactitemOnClick()
	if self._sendingUsePower or self._playingBuySuccessEffect or self._viewInEffect then
		return
	end

	if ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId) <= 0 then
		local icon = ResUrl.getPropItemIcon(self.actPowerConfig.icon)

		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, self.actPowerConfig.name)

		return
	end

	local maxPower = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit
	local currentPower = self._currencyMO.quantity
	local offsetPower = maxPower - currentPower
	local maxUseCount = math.floor(offsetPower / self.actPowerEffect)

	if maxUseCount < 1 then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 4)

		return
	end

	ViewMgr.instance:openView(ViewName.PowerActChangeView, {
		PowerId = MaterialEnum.PowerId.ActPowerId
	})
end

function PowerView:_btnoverflowitemOnClick()
	self:_showPowerBuyTipView(MaterialEnum.PowerType.Overflow, MaterialEnum.PowerId.OverflowPowerId)
end

function PowerView:_btnbuyitemOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	if self._playingBuySuccessEffect or self._viewInEffect then
		return
	end

	if CurrencyModel.instance.powerCanBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.MaxBuyTimeId, 3)

		return
	end

	if self._currencyMO.quantity + self._addBuyRecoverPower > self._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	local sendParam = {}

	sendParam.index = nil
	sendParam.isPowerPotion = false
	sendParam.item = nil

	ViewMgr.instance:openView(ViewName.PowerBuyTipView, sendParam)
end

function PowerView:_btnuseitem1OnClick()
	self:_usePowerPotion(MaterialEnum.PowerType.Small)
end

function PowerView:_btnuseitem2OnClick()
	self:_usePowerPotion(MaterialEnum.PowerType.Big)
end

function PowerView:_btnadd1OnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.SmallPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Small)
end

function PowerView:_btnadd2OnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.BigPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Big)
end

function PowerView:_btnoverflowAddOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.OverflowPowerId)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Overflow)
end

function PowerView:_usePowerPotion(type)
	if type == MaterialEnum.PowerType.Small then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)
	end

	if self._sendingUsePower or self._playingBuySuccessEffect or self._viewInEffect then
		return
	end

	local powerMo = ItemPowerModel.instance:getPowerByType(type)
	local icon

	if not powerMo or powerMo.quantity <= 0 then
		if type == MaterialEnum.PowerType.Small then
			icon = ResUrl.getPropItemIcon("100101")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, luaLang("power_item1_name"))
		elseif type == MaterialEnum.PowerType.Big then
			icon = ResUrl.getPropItemIcon("100201")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, luaLang("power_item2_name"))
		end

		return
	end

	if type == MaterialEnum.PowerType.Small then
		if not self.smallPowerConfig then
			local config = self.bigPowerConfig

			if self._currencyMO.quantity + config.effect > self._maxPowerValue then
				GameFacade.showToast(ToastEnum.MaxPowerLimitId, type)

				return
			end

			if self.isNeedOpenTip then
				local sendParam = {}

				sendParam.type = type
				sendParam.isPowerPotion = true
				sendParam.uid = powerMo.uid

				ViewMgr.instance:openView(ViewName.PowerBuyTipView, sendParam)

				return
			end

			self._sendingUsePower = true

			ItemRpc.instance:sendUsePowerItemRequest(powerMo.uid)
			self:_playBuyPowerSuccessEffect()
		end
	end
end

function PowerView:_showPowerBuyTipView(type, powerId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	local powerMo = ItemPowerModel.instance:getPowerByType(type)
	local powerConfig = ItemConfig.instance:getPowerItemCo(powerId)

	if not powerMo or powerMo.quantity <= 0 then
		local icon = ResUrl.getPropItemIcon(powerConfig.icon)

		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, powerConfig.name)

		return
	end

	if self._currencyMO.quantity + powerConfig.effect > self._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	if self.isNeedOpenTip then
		local sendParam = {}

		sendParam.type = type
		sendParam.isPowerPotion = true
		sendParam.uid = powerMo.uid

		ViewMgr.instance:openView(ViewName.PowerBuyTipView, sendParam)

		return
	end

	self._sendingUsePower = true

	ItemRpc.instance:sendUsePowerItemRequest(powerMo.uid)
	self:_playBuyPowerSuccessEffect()
end

function PowerView:_btncloseOnClick()
	if not self._playingBuySuccessEffect and not self._viewInEffect then
		self:closeThis()
	end
end

function PowerView:_btnoverflowmakerOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, MaterialEnum.PowerMakerItemId)
end

function PowerView:_editableInitView()
	self.smallPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.SmallPower)
	self.smallPowerEffect = self.smallPowerConfig.effect
	self.bigPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.BigPower)
	self.bigPowerEffect = self.bigPowerConfig.effect
	self.actPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.ActPowerId)
	self.actPowerEffect = self.actPowerConfig.effect
	self.showToastId = 0

	self._simagebg:LoadImage(ResUrl.getPowerBuyBg("full/tlyuan_tl_001"))

	self._currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	self._maxPowerValue = self._currencyCo.maxLimit
	self._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)

	local buyCostStr = CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId)
	local buyPresentStr = CommonConfig.instance:getConstStr(ConstEnum.PowerPresentId)

	self._costParamList = GameUtil.splitString2(buyCostStr, true)
	self._costParam = self._costParamList[1]
	self._presentParam = string.splitToNumber(buyPresentStr, "#")
	self._sendingUsePower = false

	self:_initEffectList()
	self:refreshPowerItem()
	self:_refreshPower()
	self:_refreshBuyPower()
	self:_refreshOfMaker()

	self._playingBuySuccessEffect = false
	self._changePowerTextEffect = false

	gohelper.removeUIClickAudio(self._btnuseitem1.gameObject)
	gohelper.removeUIClickAudio(self._btnuseitem2.gameObject)
	gohelper.removeUIClickAudio(self._btnbuyitem.gameObject)
	TaskDispatcher.runRepeat(self._refreshDeadlineTime, self, 1)
end

function PowerView:_refreshDeadlineTime()
	self:refreshPowerItem()
end

function PowerView:_initEffectList()
	local effectList = {}

	for i, v in ipairs(lua_power_item.configList) do
		effectList[v.effect] = effectList[v.effect] or true
	end

	self._powerEffectList = {}

	for k, v in pairs(effectList) do
		table.insert(self._powerEffectList, k)
	end

	table.sort(self._powerEffectList, function(a, b)
		return a < b
	end)
end

function PowerView:refreshPowerItem()
	self:refreshOnePowerItem(MaterialEnum.PowerType.Small)
	self:refreshOnePowerItem(MaterialEnum.PowerType.Big)
	self:refreshOnePowerItem(MaterialEnum.PowerType.Act)
	self:refreshOnePowerItem(MaterialEnum.PowerType.Overflow)
end

function PowerView:refreshOnePowerItem(powerType)
	local count = 0
	local effect = 0
	local limitSec = 0

	if powerType == MaterialEnum.PowerType.Small then
		count = count + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower_Expire)
		count = count + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower)
		effect = self.smallPowerEffect
		limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.SmallPower_Expire)

		self:refreshTxtCount(self._txtcount1, count)
		self:refreshTxtEffect(self._txteffectname1, effect)
		self:refreshDeadLine(self._godeadline1, self._txtdeadline1, self._imagetimeicon1, limitSec, count)
	elseif powerType == MaterialEnum.PowerType.Big then
		count = count + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower_Expire)
		count = count + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower)
		effect = self.bigPowerEffect
		limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.BigPower_Expire)

		self:refreshTxtCount(self._txtcount2, count)
		self:refreshTxtEffect(self._txteffectname2, effect)
		self:refreshDeadLine(self._godeadline2, self._txtdeadline2, self._imagetimeicon2, limitSec, count)
	elseif powerType == MaterialEnum.PowerType.Act then
		self:_refreshActPower()
	elseif powerType == MaterialEnum.PowerType.Overflow then
		self:_refreshOverflow()
	end
end

function PowerView:refreshTxtCount(textComp, count)
	textComp.text = GameUtil.numberDisplay(count)
end

function PowerView:refreshTxtEffect(textComp, effect)
	textComp.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		effect
	})
end

function PowerView:refreshDeadLine(goDeadline, textComp, icon, limitSec, count)
	if not limitSec or limitSec <= 0 then
		gohelper.setActive(goDeadline, false)

		return
	end

	if count and count <= 0 then
		gohelper.setActive(goDeadline, false)

		return
	end

	gohelper.setActive(goDeadline, true)

	if limitSec <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(icon, "#EA6868")

		textComp.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(limitSec))
	else
		SLFramework.UGUI.GuiHelper.SetColor(icon, "#FFFFFF")

		textComp.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(limitSec))
	end
end

function PowerView:_refreshActPower()
	local actId = MaterialEnum.ActPowerBindActId
	local count = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId)

	if ActivityHelper.getActivityStatus(actId) ~= ActivityEnum.ActivityStatus.Normal and count < 1 then
		gohelper.setActive(self._actItem, false)

		return
	end

	gohelper.setActive(self._actItem, true)

	local limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.ActPowerId)

	self:refreshTxtCount(self._txtactcount, count)
	self:refreshTxtEffect(self._txtacteffect, self.actPowerEffect)
	self:refreshDeadLine(self._goactdeatline, self._txtacttime, self._txtacticon, limitSec, count)
end

function PowerView:_getPowerPotionByIndex(index)
	local effect = self._powerEffectList[index]
	local list = self._powerPotionList[effect]

	return list and list[1]
end

function PowerView:_refreshPower()
	local level = PlayerModel.instance:getPlayinfo().level

	self._recoverLimit = PlayerConfig.instance:getPlayerLevelCO(level).maxAutoRecoverPower
	self._currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	self.presentConfig = ItemModel.instance:getItemConfig(self._presentParam[1], self._presentParam[2])

	TaskDispatcher.runRepeat(self._checkPowerRecover, self, 1)
	self:_checkPowerRecover()
end

function PowerView:_checkPowerRecover2()
	self:_checkPowerRecover()
	TaskDispatcher.runRepeat(self._checkPowerRecover, self, 1)
end

function PowerView:_checkPowerRecover()
	if self._changePowerTextEffect then
		TaskDispatcher.cancelTask(self._checkPowerRecover, self)

		self._changePowerTextEffect = false

		TaskDispatcher.runDelay(self._checkPowerRecover2, self, 0.85)

		return
	end

	local power = self._currencyMO.quantity

	self._txtpowerlimit.text = string.format("<size=40>/</size>%s", self._recoverLimit)
	self._txtpowerlimitvx.text = self._txtpowerlimit.text

	if power >= self._recoverLimit then
		TaskDispatcher.cancelTask(self._checkPowerRecover, self)

		self._txtpower.text = string.format("<color=#EA6868>%s</color>", power)
		self._txtpowervx.text = self._txtpower.text
		self._txtnexttime.text = "--:--:--"
		self._txttotaltime.text = "--:--:--"

		return
	else
		self._txtpower.text = string.format("<color=#FFFFFF>%s</color>", power)
		self._txtpowervx.text = self._txtpower.text
	end

	local lastRecoverTime = self._currencyMO.lastRecoverTime / 1000
	local curRecoverEndTime = lastRecoverTime + self._currencyCo.recoverTime
	local curRecoverSec = math.max(curRecoverEndTime - ServerTime.now(), 0)
	local remainPower = math.max(0, self._recoverLimit - power - self._currencyCo.recoverNum)
	local allRecoverSec = curRecoverSec + self._currencyCo.recoverTime * math.ceil(remainPower / self._currencyCo.recoverNum)

	self._txtnexttime.text = TimeUtil.second2TimeString(curRecoverSec, true)
	self._txttotaltime.text = TimeUtil.second2TimeString(allRecoverSec, true)
end

function PowerView:_refreshBuyPower()
	self._txtbuycount.text = string.format("%s/%s", CurrencyModel.instance.powerCanBuyCount, self._powerMaxBuyCount)
	self._costParam = self._costParamList[self._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

	if self._costParam == nil then
		self._costParam = self._costParamList[#self._costParamList]
	end

	self._txtcost.text = luaLang("multiple") .. self._costParam[3]

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._costParam[1], self._costParam[2])

	self._simageCostIcon:LoadImage(icon)

	local level = PlayerModel.instance:getPlayinfo().level
	local addBuyRecoverPower = PlayerConfig.instance:getPlayerLevelCO(level).addBuyRecoverPower

	self._addBuyRecoverPower = addBuyRecoverPower
	self._txtbuypower.text = string.format("+%s%s", addBuyRecoverPower, luaLang("p_mainview_power"))
end

function PowerView:onUpdateParam()
	self.isNeedOpenTip = false

	self:updateNeedOpenTipValue()
end

function PowerView:onOpen()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, self._onPowerBuyCountChange, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UsePowerPotionFinish, self._onUsePowerPotionFinish, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, self._onUsePowerPotionListFinish, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.BeforeUsePowerPotionList, self._onUsePowerPotionListBefore, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.PowerBuyTipToggleOn, self._onSwitchBuyTip, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.PowerBuySuccess, self._playBuyPowerSuccessEffect, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.RefreshPowerMakerInfo, self._refreshPowerMakerInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.updateNeedOpenTipValue, self)
	self:updateNeedOpenTipValue()

	self._viewInEffect = true

	TaskDispatcher.runDelay(self._viewInEffectEnd, self, 0.6)
	NavigateMgr.instance:addEscape(ViewName.PowerView, self._btncloseOnClick, self)
	self:_initPowerMakerInfo()
end

function PowerView:_viewInEffectEnd()
	self._viewInEffect = false
end

function PowerView:updateNeedOpenTipValue()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)
	local today = ServerTime.getServerTimeToday(true)
	local saveToday = PlayerPrefsHelper.getNumber(key, 0)

	self.isNeedOpenTip = today ~= saveToday
end

function PowerView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshPower()
	self:_checkOfMaking()
end

function PowerView:_onSwitchBuyTip(isToggleOn)
	if isToggleOn then
		self.isNeedOpenTip = false

		self:_updateCurrentDayPlayerPrefs()
	end
end

function PowerView:_updateCurrentDayPlayerPrefs()
	local today = ServerTime.getServerTimeToday(true)
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)

	PlayerPrefsHelper.setNumber(key, today)
end

function PowerView:_playBuyPowerSuccessEffect()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Addhuoxing)
	self._buySuccessAnim:SetTrigger("buySuccess")

	self._changePowerTextEffect = true
end

function PowerView:_onPowerBuyCountChange(isShowPowerAddIdToast)
	self.showToastId = self.showToastId + 1

	self:_refreshBuyPower()

	if isShowPowerAddIdToast then
		GameFacade.showToast(ToastEnum.PowerAddId, self._addBuyRecoverPower, self.showToastId)
	end

	if self.presentConfig then
		GameFacade.showToast(ToastEnum.GetGiftId, self.presentConfig.name, self._presentParam[3], self.showToastId)
	end
end

function PowerView:_onUsePowerPotionFinish(uid)
	local powerMo = ItemPowerModel.instance:getPowerItem(uid)
	local config = ItemConfig.instance:getPowerItemCo(powerMo.id)

	self.showToastId = self.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, config.effect, self.showToastId)
	self:refreshPowerItem()

	self._sendingUsePower = false

	if powerMo.id == MaterialEnum.PowerId.OverflowPowerId then
		ItemRpc.instance:sendGetPowerMakerInfoRequest()
	end
end

function PowerView:_onUsePowerPotionListBefore()
	self._sendingUsePower = true

	self:_playBuyPowerSuccessEffect()
end

function PowerView:_onUsePowerPotionListFinish(userItemList)
	local effect = 0

	for _, useItem in ipairs(userItemList) do
		local powerMo = ItemPowerModel.instance:getPowerItem(useItem.uid)
		local config = ItemConfig.instance:getPowerItemCo(powerMo.id)

		effect = effect + config.effect * useItem.num
	end

	self.showToastId = self.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, effect, self.showToastId)
	self:refreshPowerItem()

	self._sendingUsePower = false
end

function PowerView:_onPowerAddTip(addPowerCount)
	transformhelper.setLocalPosXY(self._goaddPowerTip.transform, 782.5, -134)
	gohelper.setActive(self._goaddPowerTip, true)

	if self.addMoveId then
		ZProj.TweenHelper.KillById(self.addMoveId)
	end

	if self.addFadeId then
		ZProj.TweenHelper.KillById(self.addFadeId)
	end

	GameFacade.showToast(ToastEnum.PowerAddId, addPowerCount)

	self.addMoveId = ZProj.TweenHelper.DOAnchorPosY(self._goaddPowerTip.transform, -12, 1)
	self.addFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._goaddPowerTip, 1, 0, 1.5)
end

function PowerView:_onPowerLackTip()
	transformhelper.setLocalPosXY(self._goinventoryLackTip.transform, 782.5, -134)
	gohelper.setActive(self._goinventoryLackTip, true)

	if self.lackMoveId then
		ZProj.TweenHelper.KillById(self.lackMoveId)
	end

	if self.lackFadeId then
		ZProj.TweenHelper.KillById(self.lackFadeId)
	end

	local tiptxt = gohelper.findChildText(self._goinventoryLackTip, "tiptxt")

	tiptxt.text = string.format("%s", luaLang("power_lack"))
	self.lackMoveId = ZProj.TweenHelper.DOAnchorPosY(self._goinventoryLackTip.transform, -12, 1)
	self.lackFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._goinventoryLackTip, 1, 0, 1.5)
end

function PowerView:onRefreshActivity(actId)
	if actId ~= MaterialEnum.ActPowerBindActId then
		return
	end

	self:_refreshActPower()
end

function PowerView:_initPowerMakerInfo()
	self._lessTimeMaker = 0

	self:_powerMakerInfoRequest(true)
end

function PowerView:_powerMakerInfoRequest(isAutoUse)
	self._isShowMakerTime = false

	gohelper.setActive(self._gomaking, false)

	if self._lessTimeMaker > 1 then
		return
	end

	ItemRpc.instance:sendGetPowerMakerInfoRequest(isAutoUse)
end

function PowerView:_refreshPowerMakerInfo()
	self._isShowMakerTime = true
	self._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if not self._ofMakerInfo then
		self:_powerMakerInfoRequest()

		return
	end

	local isPause = self._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Pause

	self._lessTimeMaker = (self._ofMakerInfo.nextRemainSecond <= 0 or isPause) and self._lessTimeMaker + 1 or 0

	self:_ofMakerFlyPower()
	gohelper.setActive(self._gopause, isPause)
	gohelper.setActive(self._goempty, false)
	gohelper.setActive(self._gomaking, not isPause)

	local OfMakerAnimName = isPause and "pause" or "click"

	self:_playOfMakerAnim(OfMakerAnimName)
	self:_runRepeatOfMaker()
end

function PowerView:_refreshOverflow()
	local powerId = MaterialEnum.PowerId.OverflowPowerId

	self._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if self._ofMakerInfo then
		if not self._ofMakerInfo.itemTotalCount then
			local count = ItemPowerModel.instance:getPowerCount(powerId)
			local powerConfig = ItemConfig.instance:getPowerItemCo(powerId)
			local limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(powerId)

			self:refreshTxtCount(self._txtoverflowcount, count)
			self:refreshTxtEffect(self._txtoverfloweffect, powerConfig.effect)
			self:refreshDeadLine(self._gooverflowdeatline, self._txtoverflowtime, self._txtoverflowicon, limitSec, count)
		end
	end
end

function PowerView:_refreshOfMaker()
	TaskDispatcher.runRepeat(self._runRepeatOfMaker, self, 1)
end

function PowerView:_runRepeatOfMaker()
	if not self._isShowMakerTime then
		return
	end

	if not self._ofMakerInfo then
		self:_powerMakerInfoRequest()

		return
	end

	local isPause = self._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Pause

	if isPause then
		self:_showOFPowerPauseStatus()

		return
	end

	local _remainTime = self._ofMakerInfo.nextRemainSecond - (ServerTime.now() - self._ofMakerInfo.nowTime)

	self._txtmaketime.text = self:_showMakerTime(_remainTime)

	if _remainTime <= 0 then
		self:_powerMakerInfoRequest()
	end
end

function PowerView:_checkOfMaking()
	if self._ofMakerInfo and self._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Making then
		return
	end

	if self._currencyMO.quantity >= self._recoverLimit then
		self:_powerMakerInfoRequest()
	end
end

function PowerView:_showOFPowerPauseStatus()
	local _time = self._ofMakerInfo.nextRemainSecond

	_time = _time <= 0 and MaterialEnum.PowerMakerFixedPauseTime or _time
	self._txtpausemaketime.text = self:_showMakerTime(_time)
end

function PowerView:_ofMakerFlyPower()
	local makeCount = self._ofMakerInfo.makeCount

	if makeCount <= 0 then
		return
	end

	if not self._ofMakerFlyGroup then
		local go = gohelper.findChild(self.viewGO, "#go_overflowmaker/flygroup")

		self._ofMakerFlyGroup = MonoHelper.addNoUpdateLuaComOnceToGo(go, PowerItemFlyGroup)
	end

	self._ofMakerFlyGroup:flyItems(makeCount)

	self._ofMakerInfo.makeCount = 0
end

function PowerView:_showMakerTime(time)
	return time > 0 and TimeUtil.second2TimeString(time, true) or ""
end

function PowerView:_playOfMakerAnim(animName)
	self._anioverflowmaker = self._anioverflowmaker or self._gooverflowmaker:GetComponent(typeof(UnityEngine.Animator))

	self._anioverflowmaker:Play(animName, 0, 0)
end

function PowerView:onClose()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, self._onPowerBuyCountChange, self)
	TaskDispatcher.cancelTask(self._checkPowerRecover, self)
	TaskDispatcher.cancelTask(self._checkPowerRecover2, self)
	TaskDispatcher.cancelTask(self._refreshDeadlineTime, self)
	TaskDispatcher.cancelTask(self._runRepeatOfMaker, self)
	TaskDispatcher.cancelTask(self._viewInEffectEnd, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.updateNeedOpenTipValue, self)

	if self._ofMakerFlyGroup then
		self._ofMakerFlyGroup:cancelTask()
	end
end

function PowerView:onDestroyView()
	self._simagebg:UnLoadImage()

	if self.clonepowerview then
		gohelper.destroy(self.clonepowerview)

		self.clonepowerview = nil
	end
end

return PowerView
