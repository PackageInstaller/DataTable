-- chunkname: @modules/logic/store/view/recommend/StoreMonthCardView.lua

module("modules.logic.store.view.recommend.StoreMonthCardView", package.seeall)

local StoreMonthCardView = class("StoreMonthCardView", StoreRecommendBaseSubView)

function StoreMonthCardView:onInitView()
	self._simagegoods = gohelper.findChildSingleImage(self.viewGO, "view/#simage_goods")
	self._txtlefttimetips = gohelper.findChildText(self.viewGO, "view/#txt_lefttimetips")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "view/layout/#txt_title1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "view/layout/#txt_title2")
	self._txtdec = gohelper.findChildText(self.viewGO, "view/#txt_dec")
	self._txttitleen = gohelper.findChildText(self.viewGO, "view/#txt_titleen")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips1/#simage_icon1")
	self._txttipnum1 = gohelper.findChildText(self.viewGO, "view/tips/tips1/#txt_tipnum1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips2/#simage_icon2")
	self._txttipnum2 = gohelper.findChildText(self.viewGO, "view/tips/tips2/#txt_tipnum2")
	self._simageicon3 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips3/#simage_icon3")
	self._txttipnum3 = gohelper.findChildText(self.viewGO, "view/tips/tips3/#txt_tipnum3")
	self._simageicon4 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips4/#simage_icon1")
	self._txttipnum4 = gohelper.findChildText(self.viewGO, "view/tips/tips4/#txt_tipnum1")
	self._golimittime = gohelper.findChild(self.viewGO, "view/tips/tips3/#go_limittime")
	self._imglimittime = gohelper.findChildImage(self.viewGO, "view/tips/tips3/#go_limittime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/buy/#btn_buy")
	self._txtcost = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost")
	self._txtbuynums = gohelper.findChildText(self.viewGO, "view/buy/txt_buynums")
	self._txtgoodstips = gohelper.findChildText(self.viewGO, "view/buy/#txt_goodstips")
	self._gomooncardup = gohelper.findChild(self.viewGO, "view/#go_mooncardup")
	self._gocanpatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_canpatch")
	self._txtcanpatch = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_canpatch/txt")
	self._goyuekapatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch")
	self._gonopatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_nopatch")
	self._txtnopatch = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_nopatch/txt")
	self._gosupplementicon = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/itemicon")
	self._btnbuqian = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_yuekapatch/#btn_buqian")
	self._simagesupplement = gohelper.findChildSingleImage(self.viewGO, "view/tips/patchtips/#txt_propnum/#simage_icon1")
	self._gopatchtips = gohelper.findChild(self.viewGO, "view/#go_patchtips")
	self._gopatchlimittime = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_limittime")
	self._gopatchcurrtime = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_currenttime")
	self._txtpatchcurrtime = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_currenttime/timetxt")
	self._txtpatchday = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/infobg/#txt_patchday")
	self._gopatchinfo = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/infobg")
	self._goreddot = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreMonthCardView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnbuqian:AddClickListener(self._btnbuqianOnClick, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSupplement, self)
end

function StoreMonthCardView:removeEvents()
	self._btnbuqian:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
end

function StoreMonthCardView:_btnbuyOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "711",
		[StatEnum.EventProperties.RecommendPageName] = "月历",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})

	local jumpParams = string.splitToNumber(self.config.systemJumpCode, "#")

	if jumpParams[2] then
		local goodId = jumpParams[2]
		local packageMo = StoreModel.instance:getGoodsMO(goodId)

		StoreController.instance:openPackageStoreGoodsView(packageMo)
	else
		self.viewContainer.storeView:_refreshTabs(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
		StoreController.instance:onSwitchTab(StoreEnum.StoreId.Package)
	end
end

function StoreMonthCardView:onWenHaoClick()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function StoreMonthCardView._btnItemDetailOnClick(param)
	local selfObj = param.self
	local index = param.index

	selfObj:_btnItemDetailClick(index)
end

function StoreMonthCardView:_btnItemDetailClick(index)
	if not self._bonusList then
		return
	end

	local bonusParam = self._bonusList[index]

	if not bonusParam then
		return
	end

	MaterialTipController.instance:showMaterialInfo(bonusParam[1], bonusParam[2], false)
end

function StoreMonthCardView:_editableInitView()
	self.godecorate = gohelper.findChild(self.viewGO, "view/decorateicon")
	self.wenhaoClick = gohelper.getClick(self.godecorate)

	self.wenhaoClick:AddClickListener(self.onWenHaoClick, self)

	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._bgClick = gohelper.getClick(self._simageBg.gameObject)

	gohelper.addUIClickAudio(self._bgClick.gameObject, AudioEnum.UI.play_ui_common_pause)
	self._simagegoods:LoadImage(ResUrl.getStoreBottomBgIcon("img_calendar"))
	self._simageBg:LoadImage(ResUrl.getStoreBottomBgIcon("deco"))
	self._bgClick:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.MonthCardInfoChanged, self.onMonthCardInfoChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._txtgoodstips.text = luaLang("storemonthcard_tips")

	self._simagesupplement:LoadImage(ResUrl.getSpecialPropItemIcon(StoreEnum.SupplementMonthCardItemId))

	self._txtcost.text = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)

	local clickCount = 4
	local offset = 4

	self._itemClickList = self:getUserDataTb_()

	local tipGo = gohelper.findChild(self.viewGO, string.format("view/tips"))

	for i = 1, clickCount do
		local subTipGo = tipGo.transform:GetChild(i + offset - 1).gameObject
		local bgGo = subTipGo.transform:GetChild(0).gameObject
		local image = gohelper.findChildImage(bgGo, "")

		image.raycastTarget = true

		table.insert(self._itemClickList, gohelper.getClick(bgGo))
	end

	for index, clickItem in ipairs(self._itemClickList) do
		clickItem:AddClickListener(self._btnItemDetailOnClick, {
			self = self,
			index = index
		})
	end

	self._btnsupplement = gohelper.getClick(self._simagesupplement.gameObject)

	self._btnsupplement:AddClickListener(self.onClickSupplementItem, self)

	self.supplementRedDot = RedDotController.instance:addNotEventRedDot(self._goreddot, self._checkSupplementRedDot, self)
	self.supplementTipsGo = gohelper.findChild(self.viewGO, "view/tips/patchtips")

	gohelper.setActive(self.supplementTipsGo, false)
end

function StoreMonthCardView:onClickSupplementItem()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId, false)
end

function StoreMonthCardView:onUpdateParam()
	return
end

function StoreMonthCardView:_initCurrency()
	local currencyConfig = StoreConfig.instance:getTabConfig(StoreEnum.RecommendSubStoreId.MonthCardId)

	if currencyConfig and not string.nilorempty(currencyConfig.showCost) then
		local param = {}
		local temp = string.splitToNumber(currencyConfig.showCost, "#")

		for i = #temp, 1, -1 do
			table.insert(param, temp[i])
		end

		local item = {
			id = StoreEnum.SupplementMonthCardItemId,
			type = MaterialEnum.MaterialType.SpecialExpiredItem
		}

		table.insert(param, item)
		self.viewContainer:setCurrencyByParams(param)
	end
end

function StoreMonthCardView:onOpen()
	self.monthCardInfo = StoreModel.instance:getMonthCardInfo()
	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.MonthCardId)

	self:_tryPatFaceMonthCardView()
	self:refreshUI()
	self:_initCurrency()
	StoreMonthCardView.super.onOpen(self)

	local jumpGoodsId = self.viewContainer:getJumpGoodsId()

	if not jumpGoodsId then
		return
	end

	local goodId = tonumber(jumpGoodsId)

	if not goodId or goodId <= 0 then
		return
	end

	local goodMo = StoreModel.instance:getGoodsMO(goodId)

	if not goodMo then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(goodMo)
end

function StoreMonthCardView:refreshUI()
	self:refreshRemainDay()
	self:refreshRewardIcon()
	self:_refreshSupplement()

	local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(self._gomooncardup, showtag)

	if SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
		StoreController.instance:dispatchEvent(StoreEvent.StopRecommendViewAuto)
	end
end

function StoreMonthCardView:refreshRemainDay()
	if self.monthCardInfo ~= nil then
		local remainDay = self.monthCardInfo:getRemainDay()

		self._txtlefttimetips.text = remainDay == StoreEnum.MonthCardStatus.NotPurchase and luaLang("not_purchase") or remainDay == StoreEnum.MonthCardStatus.NotEnoughOneDay and luaLang("not_enough_one_day") .. (self.monthCardInfo.hasGetBonus and luaLang("today_reward") or "") or formatLuaLang("remain_day", remainDay) .. (self.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
	else
		self._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function StoreMonthCardView:refreshRewardIcon()
	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceBonusParam = string.split(monthCardCo.onceBonus, "|")
	local dailyBonusParam = string.split(monthCardCo.dailyBonus, "|")
	local onceIconUrl, onceQuantity = self:getIconUrlAndQuantity(onceBonusParam[1])
	local onceIcon2Url, onceQuan2tity = self:getIconUrlAndQuantity(onceBonusParam[2])
	local dayIconUrl, dayQuantity = self:getIconUrlAndQuantity(dailyBonusParam[1])
	local powertable = dailyBonusParam[2]
	local power = string.split(powertable, "#")
	local powerconfig, powericon = ItemModel.instance:getItemConfigAndIcon(power[1], power[2])

	self._txttipnum1.text = luaLang("multiple") .. onceQuantity

	self._simageicon1:LoadImage(onceIconUrl)

	self._txttipnum2.text = luaLang("multiple") .. dayQuantity * 30

	self._simageicon2:LoadImage(dayIconUrl)

	self._txttipnum3.text = luaLang("multiple") .. power[3] * 30

	self._simageicon3:LoadImage(powericon)

	self._txttipnum4.text = luaLang("multiple") .. onceQuan2tity

	self._simageicon4:LoadImage(onceIcon2Url)
	UISpriteSetMgr.instance:setStoreGoodsSprite(self._imglimittime, "img_xianshi2")
	gohelper.setActive(self._golimittime, false)

	if powerconfig.expireTime then
		gohelper.setActive(self._golimittime, true)
	end

	local bonusList = {}

	for _, param in ipairs(onceBonusParam) do
		table.insert(bonusList, string.splitToNumber(param, "#"))
	end

	for _, param in ipairs(dailyBonusParam) do
		table.insert(bonusList, string.splitToNumber(param, "#"))
	end

	self._bonusList = bonusList
end

function StoreMonthCardView:getIconUrlAndQuantity(iconStr)
	local type, id, quantity
	local temp = string.splitToNumber(iconStr, "#")
	local _, icon = ItemModel.instance:getItemConfigAndIcon(temp[1], temp[2])

	return icon, temp[3]
end

function StoreMonthCardView:onMonthCardInfoChange()
	self.monthCardInfo = StoreModel.instance:getMonthCardInfo()

	self:refreshRemainDay()
	self:_refreshSupplement()
end

function StoreMonthCardView:onDailyRefresh()
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

function StoreMonthCardView:_onReceiveSupplementMonthCardReply()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	self:_refreshSupplement()
end

function StoreMonthCardView:_refreshSupplement()
	if StoreModel.instance:hasPurchaseMonthCard() then
		gohelper.setActive(self._goyuekapatch, true)

		local showBtn = SignInModel.instance:getCanSupplementMonthCardDays() > 0

		gohelper.setActive(self._gopatchtips, false)
		gohelper.setActive(self._gocanpatch, showBtn)
		gohelper.setActive(self._gonopatch, not showBtn)
	else
		gohelper.setActive(self._goyuekapatch, false)
		gohelper.setActive(self._gopatchtips, true)
	end

	if not self._supplementItem then
		self._supplementItem = IconMgr.instance:getCommonItemIcon(self._gosupplementicon)

		self._supplementItem:setMOValue(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId, 1)
		self._supplementItem:isShowCount(false)
		self._supplementItem:setCanShowDeadLine(false)
	end

	local nosigninday = SignInModel.instance:getSupplementMonthCardDays()
	local itemcount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)
	local showtips = false
	local showlimiticon = false

	if nosigninday and nosigninday > 0 then
		showtips = true
		self._txtpatchday.text = itemcount > 0 and formatLuaLang("p_monthcard_reappear_txt_04", SignInModel.instance:getCanSupplementMonthCardDays()) or luaLang("p_monthcard_reappear_txt_01")
	end

	if itemcount < 1 then
		showlimiticon = true
	else
		local itemDeadline = ItemExpireModel.instance:getSpecialExpireItemEarliestExpireTime(StoreEnum.SupplementMonthCardItemId)

		if itemDeadline and itemDeadline > 0 then
			local limitSec = itemDeadline - ServerTime.now()
			local date, dateFormat, hasDay = TimeUtil.secondToRoughTime(limitSec, true)

			self._txtpatchcurrtime.text = string.format("%s%s", date, dateFormat)
		end
	end

	gohelper.setActive(self._gopatchlimittime, showlimiticon)
	gohelper.setActive(self._gopatchcurrtime, not showlimiticon)
	gohelper.setActive(self._gopatchinfo, showtips)

	local storeMonthCardInfo = StoreModel.instance:getMonthCardInfo()
	local isMaxDay = storeMonthCardInfo and storeMonthCardInfo:getRemainDay() >= StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).maxDaysLimit - 1
	local goodId = StoreEnum.MonthCardGoodsId
	local packageMo = StoreModel.instance:getGoodsMO(goodId)
	local isSoldOut = not packageMo or packageMo:isSoldOut()

	gohelper.setActive(self._txtbuynums, not isSoldOut and not isMaxDay)
	self:_refreshSupplementRedDot()
end

function StoreMonthCardView:_refreshSupplementRedDot()
	self.supplementRedDot:refreshRedDot()
end

function StoreMonthCardView:_checkSupplementRedDot()
	return SignInModel.instance:getCanSupplementMonthCardDays() > 0
end

function StoreMonthCardView:_btnbuqianOnClick()
	if StoreModel.instance:hasPurchaseMonthCard() then
		local nosigninday = SignInModel.instance:getSupplementMonthCardDays()
		local itemcount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)

		if itemcount < 1 then
			MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)
		elseif nosigninday < 1 then
			GameFacade.showToastString(luaLang("p_monthcard_reappear_tips_02"))
		else
			local currencyParam = {}
			local item = {
				isHideAddBtn = true,
				id = StoreEnum.SupplementMonthCardItemId,
				type = MaterialEnum.MaterialType.SpecialExpiredItem
			}

			table.insert(currencyParam, item)
			SignInController.instance:showPatchpropUseView(MessageBoxIdDefine.SupplementMonthCardUseTip, MsgBoxEnum.BoxType.Yes_No, currencyParam, self._useSupplementMonthCard, nil, nil, self, nil, nil, SignInModel.instance:getCanSupplementMonthCardDays())
		end
	end
end

function StoreMonthCardView:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function StoreMonthCardView:_tryPatFaceMonthCardView()
	local config = StoreConfig.instance:getTabConfig(self.config.id)

	if not config.toprecommend then
		return
	end

	local num = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0)

	if num == 0 then
		ViewMgr.instance:openView(ViewName.StoreSupplementMonthCardTipView)
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 1)
	end
end

function StoreMonthCardView:onDestroyView()
	self._simagegoods:UnLoadImage()
	self._simageicon1:UnLoadImage()
	self._simageicon2:UnLoadImage()
	self._simageicon3:UnLoadImage()
	self._simageBg:UnLoadImage()
	self._btnbuy:RemoveClickListener()
	self._bgClick:RemoveClickListener()
	self.wenhaoClick:RemoveClickListener()
	self.removeEventCb(self, StoreController.instance, StoreEvent.MonthCardInfoChanged, self.onMonthCardInfoChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)

	for _, clickItem in ipairs(self._itemClickList) do
		clickItem:RemoveClickListener()
	end

	tabletool.clear(self._itemClickList)

	self._itemClickList = nil

	self._btnsupplement:RemoveClickListener()
end

return StoreMonthCardView
