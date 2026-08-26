-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3StoreView.lua

module("modules.logic.turnback.view.turnback3.Turnback3StoreView", package.seeall)

local Turnback3StoreView = class("Turnback3StoreView", BaseView)

local function sortFunc(a, b)
	if a.config.order ~= b.config.order then
		return a.config.order < b.config.order
	end

	return a.id > b.id
end

function Turnback3StoreView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_title")
	self._goitem = gohelper.findChild(self.viewGO, "root/dayfree/#go_item")
	self._gocanget = gohelper.findChild(self.viewGO, "root/dayfree/#go_canget")
	self._gobannercontent = gohelper.findChild(self.viewGO, "root/banner/#go_bannercontent")
	self._goslider = gohelper.findChild(self.viewGO, "root/banner/#go_slider")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "root/banner/#go_bannerscroll")
	self._golefticon1 = gohelper.findChild(self.viewGO, "root/yueka/reward/left/#go_lefticon1")
	self._golefticon2 = gohelper.findChild(self.viewGO, "root/yueka/reward/left/#go_lefticon2")
	self._gorighticon1 = gohelper.findChild(self.viewGO, "root/yueka/reward/right/#go_righticon1")
	self._gorighticon2 = gohelper.findChild(self.viewGO, "root/yueka/reward/right/#go_righticon2")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/yueka/#btn_buy")
	self.txtpriceNum = gohelper.findChildText(self.viewGO, "root/yueka/#btn_buy/bg/#txt_materialNum")
	self._txtlimit = gohelper.findChildText(self.viewGO, "root/yueka/#btn_buy/#txt_limit")
	self._gohasget = gohelper.findChild(self.viewGO, "root/yueka/#btn_buy/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3StoreView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self._payFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateChargeGoods, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self._refreshLeftBottom, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshDayFree, self)
end

function Turnback3StoreView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btndayfreecanget:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshDayFree, self)
end

function Turnback3StoreView:_btnbuyOnClick()
	if not TurnbackModel.instance:getMonthCardShowState() then
		return
	end

	logNormal("onClickMonthCard")

	local turnBackMo = TurnbackModel.instance:getCurTurnbackMo()
	local config = turnBackMo.config
	local storePackageMo = StoreModel.instance:getGoodsMO(config.monthCardAddedId)

	StoreController.instance:openPackageStoreGoodsView(storePackageMo)
end

function Turnback3StoreView:_editableInitView()
	return
end

function Turnback3StoreView:onUpdateParam()
	return
end

function Turnback3StoreView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._turnbackconfig = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)
	self._subconfig = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	self:_initMiniMonthCard()
	self:_refreshLeftBottom()
	self:_initDayFree()
end

function Turnback3StoreView:_initDayFree()
	local day = TurnbackModel.instance:getCurrentTurnbackDay()

	if day > 0 then
		local config = TurnbackConfig.instance:getTurnbackDailyBonusConfig(self._turnbackId, day)

		if config then
			local reward = string.split(config.bonus, "#")
			local type, id, num = reward[1], reward[2], reward[3]

			self._imgdayfreeRare = gohelper.findChildImage(self.viewGO, "root/dayfree/#image_quality")
			self._txtdayfreeCount = gohelper.findChildText(self.viewGO, "root/dayfree/#txt_count")
			self._gotxt = gohelper.findChildText(self.viewGO, "root/dayfree/txt")
			self._gotomorrow = gohelper.findChild(self.viewGO, "root/dayfree/tomorrow")
			self._godayfree = gohelper.findChild(self.viewGO, "root/dayfree/#go_item")
			self._godayfreecanget = gohelper.findChild(self.viewGO, "root/dayfree/#go_canget")
			self._btndayfreecanget = gohelper.findChildButton(self.viewGO, "root/dayfree/#go_canget/#btn_canget")
			self._godayfreehasget = gohelper.findChild(self.viewGO, "root/dayfree/#go_hasget")

			local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

			if icon then
				self._godayfreeIcon = IconMgr.instance:getCommonPropItemIcon(self._godayfree)

				self._godayfreeIcon:setMOValue(type, id, num, nil, true)
				self._godayfreeIcon:isShowCount(false)
				self._godayfreeIcon:isShowQuality(false)
			end

			self._txtdayfreeCount.text = "×" .. num

			local urlname = "v3a2_activitycollect_quality" .. config.rare + 1

			UISpriteSetMgr.instance:setV3a2Turnnback3Sprite(self._imgdayfreeRare, urlname, true)
			self._btndayfreecanget:AddClickListener(self._btnDayFree, self)

			local hasGet = TurnbackModel.instance:isClaimedDailyBonus(day)

			gohelper.setActive(self._godayfreecanget, not hasGet)
			gohelper.setActive(self._godayfreehasget, hasGet)
			self:_updateTxt()
		end
	end
end

function Turnback3StoreView:_updateTxt()
	local isLastDay = TurnbackModel.instance:checkIsLastTurnbackDay()
	local day = TurnbackModel.instance:getCurrentTurnbackDay()
	local hasGet = TurnbackModel.instance:isClaimedDailyBonus(day)

	gohelper.setActive(self._gotomorrow, hasGet and not isLastDay)
end

function Turnback3StoreView:_btnDayFree()
	TurnbackRpc.instance:sendGetTurnbackDailyBonusRequest(self._turnbackId)
end

function Turnback3StoreView:refreshDayFree()
	local day = TurnbackModel.instance:getCurrentTurnbackDay()
	local hasGet = TurnbackModel.instance:isClaimedDailyBonus(day)

	gohelper.setActive(self._godayfreecanget, not hasGet)
	gohelper.setActive(self._godayfreehasget, hasGet)
	self:_updateTxt()
end

function Turnback3StoreView:_initMiniMonthCard()
	local leftIconList = {}
	local RightIconList = {}

	for i = 1, 2 do
		local leftIcon = gohelper.findChild(self.viewGO, "root/yueka/reward/left/#go_lefticon" .. i)
		local rightIcon = gohelper.findChild(self.viewGO, "root/yueka/reward/right/#go_righticon" .. i)

		table.insert(leftIconList, leftIcon)
		table.insert(RightIconList, rightIcon)
	end

	local miniMonthCardCo = StoreConfig.instance:getMonthCardAddConfig(self._turnbackconfig.monthCardAddedId)
	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local miniReward = GameUtil.splitString2(miniMonthCardCo and miniMonthCardCo.onceBonus)
	local rewardList = GameUtil.splitString2(monthCardCo and monthCardCo.dailyBonus)

	for _, co in ipairs(rewardList) do
		co[3] = co[3] * miniMonthCardCo.days
	end

	self:_initRewardIcon(leftIconList, miniReward)
	self:_initRewardIcon(RightIconList, rewardList)
	self:_refreshMonthCard()
end

function Turnback3StoreView:_initRewardIcon(list, rewardList)
	for index, co in ipairs(rewardList) do
		local icon = list[index]
		local iconComp = IconMgr.instance:getCommonPropItemIcon(icon)

		iconComp:setMOValue(tonumber(co[1]), tonumber(co[2]), tonumber(co[3]))
		iconComp:setCountFontSize(36)
	end
end

function Turnback3StoreView:_refreshLeftBottom()
	self._bottomItemList = self._bottomItemList or {}

	for i = 1, 2 do
		local item = self._bottomItemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.findChild(self.viewGO, "root/packagestore/pos" .. i)
			item.goempty = gohelper.findChild(item.go, "#go_empty")
			item.goitem = gohelper.findChild(item.go, "#go_item")
			item.btnclick = gohelper.findChildButton(item.go, "#go_item/#btn_click")
			item.itemBg = gohelper.findChildSingleImage(item.goitem, "bg")
			item.simagebg = gohelper.findChildSingleImage(item.goitem, "#simage_bg")
			item.imagebg = gohelper.findChildImage(item.goitem, "#simage_bg")
			item.simageicon = gohelper.findChildSingleImage(item.goitem, "#simage_icon")
			item.imageicon = gohelper.findChildImage(item.goitem, "#simage_icon")
			item.txtlimit = gohelper.findChildText(item.goitem, "#txt_limit")
			item.txtpriceNum = gohelper.findChildText(item.goitem, "#txt_priceNum")
			item.txtname = gohelper.findChildText(item.goitem, "txt_name")

			item.btnclick:AddClickListener(self._onClickItem, self, item)
			table.insert(self._bottomItemList, item)
		end
	end

	local goodMoList = self:_getGoodMoList()

	for index, item in ipairs(self._bottomItemList) do
		local mo = goodMoList[index]

		gohelper.setActive(item.goempty, not mo)
		gohelper.setActive(item.goitem, mo)

		if mo then
			item.mo = mo

			self:_updateStoreItem(item)
		end
	end
end

function Turnback3StoreView:_getGoodMoList()
	local tabConfig = StoreModel.instance:getRecommendSecondTabs(StoreEnum.StoreId.Package, true)
	local list = {}

	if tabConfig and #tabConfig > 0 then
		for _, config in ipairs(tabConfig) do
			local tempList = StoreModel.instance:getPackageGoodValidList(config.id)

			for _, mo in ipairs(tempList) do
				local co = mo and mo.config

				if co and co.isShowTurnback and not tabletool.indexOf(list, mo) then
					table.insert(list, mo)
				end
			end
		end
	end

	table.sort(list, sortFunc)

	return list
end

function Turnback3StoreView:_updateStoreItem(item)
	local mo = item.mo

	item.imageicon.preserveAspect = true

	item.simageicon:LoadImage(ResUrl.getStorePackageIcon(mo.config.bigImg))

	local underlayParam

	if string.nilorempty(mo.config.underlay) then
		logError("商店改版 缺少底板配置 商品id:" .. tostring(mo.goodsId))

		underlayParam = string.splitToNumber(ChargePackageEnum.DefaultUnderlayParam, "#")
	end

	local var_17_0

	do
		underlayParam = string.splitToNumber(mo.config.underlay, "#")
		var_17_0 = mo.isChargeGoods and PayModel.instance:getProductOriginPriceNum(mo.id) or 0
	end

	logNormal(string.format("---商店改版 底板配置 id: %s 底板id: %s 价格: %s ", mo.goodsId, underlayParam[1], var_17_0))

	local itemBgIconName = "panel/package_quality_" .. self:_getNumStr(underlayParam[1])

	logNormal("商店改版 底板: " .. itemBgIconName)
	item.itemBg:LoadImage(ResUrl.getStorePackageIcon(itemBgIconName))

	local itemBgIndex
	local itemIconBgName = itemBgIconName .. "_" .. self:_getNumStr(mo.config.showBg ~= nil and mo.config.showBg ~= 0 and mo.config.showBg or StoreHelper.getPackageIconBgIndex(mo.goodsId, mo.id, underlayParam[1]))

	logNormal("商店改版 图标底板: " .. itemIconBgName)
	item.simagebg:LoadImage(ResUrl.getStorePackageIcon(itemIconBgName))

	local maxBuyCount = mo.maxBuyCount
	local remain = maxBuyCount - mo.buyCount
	local content = mo.isChargeGoods and StoreConfig.instance:getChargeRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime) or StoreConfig.instance:getRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)

	if string.nilorempty(content) then
		gohelper.setActive(item.txtlimit.gameObject, false)
	else
		gohelper.setActive(item.txtlimit.gameObject, true)

		item.txtlimit.text = content
	end

	item.txtname.text = mo.config.name

	local cost = mo.cost

	if string.nilorempty(cost) or cost == 0 then
		item.txtpriceNum.text = luaLang("store_free")
	elseif mo.isChargeGoods then
		item.txtpriceNum.text = PayModel.instance:getProductPrice(mo.id)
	else
		local costs = string.split(cost, "|")

		if not costs[mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")

			item.txtpriceNum.text = costInfo[3]
		end
	end
end

function Turnback3StoreView:_getNumStr(num)
	if tonumber(num) < 10 then
		return "0" .. num
	end

	return tostring(num)
end

function Turnback3StoreView:_onClickItem(item)
	local goodsIds = {
		item.mo.goodsId
	}

	ChargeRpc.instance:sendReadChargeNewRequest(goodsIds, self._onRefreshNew, self)

	if not self:_isStoreItemUnlock(item.mo) then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if self._cfgType == StoreEnum.StoreChargeType.LinkGiftGoods then
		if item.mo.buyCount > 0 and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(item.mo.goodsId) then
			TaskRpc.instance:sendFinishTaskRequest(item.mo.config.taskid)
			StoreGoodsTaskController.instance:requestGoodsTaskList()
		else
			StoreController.instance:openPackageStoreGoodsView(item.mo)
		end
	elseif self._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	else
		StoreController.instance:openPackageStoreGoodsView(item.mo)
	end
end

function Turnback3StoreView:_isStoreItemUnlock(mo)
	local episodeId = mo.config.needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function Turnback3StoreView:_payFinished()
	self:_refreshLeftBottom()

	local turnbackMonthCardId = TurnbackModel.instance:getCurrentTurnbackMonthCardId()
	local monthCardAddConfig = StoreConfig.instance:getMonthCardAddConfig(turnbackMonthCardId)

	if TurnbackModel.instance:getCurrentMonthBuyCount() < monthCardAddConfig.limit then
		TurnbackRpc.instance:sendGetTurnbackInfoRequest(self._refreshMonthCard, self)
	end
end

function Turnback3StoreView:_refreshMonthCard()
	local buyCount = TurnbackModel.instance:getCurrentMonthBuyCount()

	if buyCount > 0 then
		gohelper.setActive(self._txtlimit.gameObject, false)
	else
		gohelper.setActive(self._txtlimit.gameObject, true)
	end

	self._txtlimit.text = string.format("%s: %d", luaLang("store_buylimit"), 1)

	local state = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(self._gohasget, not state)
end

function Turnback3StoreView:_updateChargeGoods()
	ChargeRpc.instance:sendGetChargeInfoRequest()
end

function Turnback3StoreView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:refreshDayFree()
	end
end

function Turnback3StoreView:onClose()
	for index, item in ipairs(self._bottomItemList) do
		item.btnclick:RemoveClickListener()
	end
end

function Turnback3StoreView:onDestroyView()
	return
end

return Turnback3StoreView
