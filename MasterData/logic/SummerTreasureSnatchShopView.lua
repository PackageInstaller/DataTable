-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchShopView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchShopView", package.seeall)

local SummerTreasureSnatchShopView = class("SummerTreasureSnatchShopView", ViewComponent)

function SummerTreasureSnatchShopView:ctor()
	SummerTreasureSnatchShopView.super.ctor(self)
end

function SummerTreasureSnatchShopView:buildUI()
	SummerTreasureSnatchShopView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/txtTitle/btnTip")
	self._icon = self:getGo("coin/icon")
	self._txtScoreNum = self:getTxt("coin/txtNum")
	self._con = self:getGo("con")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tablecell2 = self:getGo("tablecell2")
	self._tabcellTab = self:getGo("tabcellTab")
	self._tableviewTab = self:getGo("tableviewTab")
	self._scrollList = ScrollerList.create(self._tableview, {
		self._tablecell,
		self._tablecell2
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetTagByIdx(function()
		return self._curTab or 1
	end)

	self._scrollListTab = ScrollerList.create(self._tableviewTab, self._tabcellTab, GameUtil.handler(self._updateCellTab, self), GameUtil.handler(self._clearCellTab, self))
end

function SummerTreasureSnatchShopView:bindEvents()
	SummerTreasureSnatchShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function SummerTreasureSnatchShopView:unbindEvents()
	SummerTreasureSnatchShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function SummerTreasureSnatchShopView:onEnter()
	SummerTreasureSnatchShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchBuyItemRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.UpdateActiveShopInfo, self._onActivityShopUpdate, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMaterialCountChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	self._actCfg = SummerTreasureSnatchConfig.instance:getActivityCfg(self._activityId) or {}
	self._endTime = GameUtil.string2time(self._actCfg.endTime)
	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	self._info = SummerTreasureSnatchModel.instance:getInfo(self._activityId)
	self._curTab = 1
	self._tabDataList = {}

	for tab, name in ipairs(self._actCfg.shopTabName) do
		table.insert(self._tabDataList, {
			tab = tab,
			name = name
		})
	end

	local skinId = self._actCfg.shopSkinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	self:_updateCoin()
	self._scrollListTab:reloadData(self._tabDataList)
	self:_onUpdate(self._activityId)

	if ServerTime.now() < self._endTime then
		SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchInfoReq(self._activityId)
	end

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	settimer(1, self._onCountDown, self)
end

function SummerTreasureSnatchShopView:onExit()
	SummerTreasureSnatchShopView.super.onExit(self)
	removetimer(self._onCountDown, self)

	self._discountTimerList = nil

	MaterialMgr.clearIcon(self._icon)
	RoleObjectPool.instance:removeRole(self._role)

	if self._scrollList then
		self._scrollList:dispose()
	end

	if self._scrollListTab then
		self._scrollListTab:dispose()
	end
end

function SummerTreasureSnatchShopView:_onUpdate(activityId)
	if activityId ~= self._activityId then
		return
	end

	self._info = SummerTreasureSnatchModel.instance:getInfo(self._activityId)

	self:_updateCoin()

	if self._curTab == 1 then
		local shopCfgs = SummerTreasureSnatchConfig.instance:getShopCfgs(self._activityId)
		local gainItemId = self._info and checktable(self._info.gainItemId) or {}

		if #gainItemId > 0 then
			self._sortList = self._sortList or TableUtil.deepcopy(shopCfgs)

			self:_sortShopCfg()
			self._scrollList:reloadData(self._sortList)
		else
			self._scrollList:reloadData(shopCfgs)
		end
	end
end

function SummerTreasureSnatchShopView:_updateCell(view, cell, data, tag)
	if tag == 2 then
		self:_updateCell2(view, cell, data)

		return
	end

	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local item = goutil.findChild(cell, "item")
	local imgCost = goutil.findChild(cell, "imgCost")
	local txtPrice = goutil.findChildTextComponent(cell, "txtPrice")
	local imgover = goutil.findChild(cell, "imgover")
	local matData = string.split(data.matStr, ":")
	local matNum = checknumber(matData[3])
	local gainItemId = self._info and checktable(self._info.gainItemId) or {}
	local canBuy = false

	if data.itemType ~= SummerTreasureSnatchController.BuyItemType.BossTimes then
		canBuy = not table.indexof(gainItemId, data.itemId)
	end

	if self._info then
		if not self._info.weeklyBuyBossClgTimes then
			do
				local weeklyBuyBossClgTimes = 0

				canBuy = weeklyBuyBossClgTimes < data.weeklyBuyTimesLimit
			end

			local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

			self:_setItemShow(item, txtName, txtPrice, data)

			if data.weeklyBuyTimesLimit > 0 then
				local buyTime = 0

				if data.itemType == SummerTreasureSnatchController.BuyItemType.BossTimes then
					buyTime = self._info and checknumber(self._info.weeklyBuyBossClgTimes) or 0
				elseif self._info then
					if not self._info.gainItemId then
						local gainItemId = {}

						buyTime = table.indexof(gainItemId, data.itemId) and 1 or 0
					end
				end

				txtLimit.text = langPara("每周限购:%s", data.weeklyBuyTimesLimit - buyTime)
			else
				txtLimit.text = ""
			end

			MaterialMgr.setIcon(imgCost, matType, matId, nil, nil)
			MaterialMgr.setCellByCfg(data.matStr, item)
			GameUtil.SetActive(imgover, not canBuy)
			GameUtil.SetGray(cell, not canBuy)
			GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickBuy, self, data))
		end
	end
end

function SummerTreasureSnatchShopView:_clearCell(cell)
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")

	if goodsTranGo then
		self:_clearCell2(cell)

		return
	end

	local item = goutil.findChild(cell, "item")
	local imgCost = goutil.findChild(cell, "imgCost")
	local imgover = goutil.findChild(cell, "imgover")

	MaterialMgr.resetAll(item)
	GameUtil.SetActive(imgover, false)
	GameUtil.SetGray(cell, false)
	GameUtil.rmClickHandler(cell)
end

function SummerTreasureSnatchShopView:_updateCell2(view, cell, data)
	local goodsNameTxt = goutil.findChildTextComponent(cell, "goodsNameTxt")
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local limitTxt = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt")
	local txtDiscountTime = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt/txtDiscountTime")
	local rate = goutil.findChild(cell, "rate")
	local txtRate = goutil.findChildTextComponent(cell, "rate/txtRate")
	local txtPrice = goutil.findChildTextComponent(cell, "consumeGo/txtPrice")
	local coin = goutil.findChild(cell, "consumeGo/txtPrice/coin")
	local txtDiscount = goutil.findChildTextComponent(cell, "consumeGo/txtDiscount")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local buyLimit = goutil.findChild(cell, "buyLimit")

	MaterialMgr.resetAll(goodsTranGo)
	self:_removeDiscountTimer(cell)

	local matSplitList = string.split(data.sellContent, ":")
	local goodsType = checknumber(matSplitList[1])
	local goodsId = checknumber(matSplitList[2])
	local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

	goodsNameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)
	txtDiscountTime.text = ""

	local sellOut = self:_isActivityShopSellOut(data)

	self:_setActivityShopLimitTxt(data, limitTxt)

	local content = data.sellContent

	if string.find(data.sellContent, "^" .. MatType.Cloth .. ":") then
		local contentList = string.split(data.sellContent, "#")

		content = contentList[Mathf.Min(RoleModel.instance:getGender() + 1, #contentList)]
	end

	MaterialMgr.setCellByCfg(content, goodsTranGo)

	local inSellTime = PayShopController.instance:checkTimeStr(data.sellTime)

	GameUtil.SetActive(buyOutGo, sellOut)
	GameUtil.SetActive(buyLimit, not sellOut and not inSellTime)

	local sellPriceSplit = string.split(data.sellPrice, ":")
	local priceType = sellPriceSplit[1] and checknumber(sellPriceSplit[1]) or 104
	local priceId = sellPriceSplit[2] and checknumber(sellPriceSplit[2]) or 1

	if not sellPriceSplit[3] then
		local priceCount = 100
		local isDiscountTime = not string.nilorempty(data.discountTime) and GameUtil.checkTimeStr(data.discountTime)
		local discountEndTime = ActivityshopModel.instance:getDiscountEndTime(data.discountTime)

		if discountEndTime and isDiscountTime then
			self:_addDiscountTimer(discountEndTime, cell, txtDiscountTime)
		end

		txtPrice.text = MaterialFacade.instance:getGoodCost(priceType, priceId, priceCount)

		local showDiscount = isDiscountTime and not string.nilorempty(data.discountPrice)

		GameUtil.SetActive(txtDiscount.gameObject, showDiscount)

		if showDiscount then
			priceCount = MaterialFacade.instance:getGoodCostByStr(data.discountPrice)
			txtDiscount.text = priceCount
		end

		local showRate = showDiscount and data.discountNum > 0

		GameUtil.SetActive(rate, showRate)

		if showRate then
			txtRate.text = langPara("%s折", data.discountNum / 10)
		end

		MaterialMgr.setIcon(coin, priceType, priceId)
		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickActivityShopItem, self, data, sellOut, priceType, priceId, priceCount))
	end
end

function SummerTreasureSnatchShopView:_clearCell2(cell)
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local coin = goutil.findChild(cell, "consumeGo/txtPrice/coin")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local buyLimit = goutil.findChild(cell, "buyLimit")

	GameUtil.rmClickHandler(cell)
	MaterialMgr.resetAll(goodsTranGo)
	MaterialMgr.clearIcon(coin)
	GameUtil.SetActive(buyOutGo, false)
	GameUtil.SetActive(buyLimit, false)
	self:_removeDiscountTimer(cell)
end

function SummerTreasureSnatchShopView:_onClickActivityShopItem(data, sellOut, priceType, priceId, priceCount)
	if sellOut then
		FloatWordMgr.instance:show(lang("已售罄"))

		return
	end

	local inSellTime = PayShopController.instance:checkTimeStr(data.sellTime)

	if string.nilorempty(data.sellTime) or not inSellTime then
		if not string.nilorempty(data.notSellTimeTips) then
			TipsFacade.instance:openCommonTips(data.notSellTimeTips)
		end

		return
	end

	local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

	if priceType == MatType.Diamond_Consume then
		priceType = MatType.Diamond
		priceId = MatType.Diamond_Binding
	end

	if ((priceType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(priceCount) then
		local cfg = MaterialMgr.getMatCfg(priceType, priceId)

		if cfg then
			FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
		else
			FloatWordMgr.instance:show(lang("所需货币不足！"))
		end

		return
	end

	UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, self._activityType, data.activityId, data.shopItemId)
end

function SummerTreasureSnatchShopView:_isActivityShopSellOut(data)
	local itemId = data.shopItemId
	local sellOut = false

	if data.sellPeriodLimit ~= "none" then
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)

		sellOut = buyTime >= data.sellLimitCount
	end

	if not sellOut and data.activityLimitCount > 0 then
		local buyTimeInActivity = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

		sellOut = buyTimeInActivity >= data.activityLimitCount
	end

	return sellOut
end

function SummerTreasureSnatchShopView:_setActivityShopLimitTxt(data, limitTxt)
	if PayShopController.instance:checkTimeStr(data.sellTime) then
		local itemId = data.shopItemId
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)
		local limitKey = self:_getActivityShopLimitKey(data.sellPeriodLimit)
		local finalStr = ""

		if limitKey then
			local remainCount = math.max(data.sellLimitCount - buyTime, 0)

			finalStr = finalStr .. "\n" .. langPara(limitKey, remainCount, data.sellLimitCount)
		end

		if data.activityLimitCount > 0 then
			local buyTimeInActivity = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)
			local remainCount = math.max(data.activityLimitCount - buyTimeInActivity, 0)

			finalStr = finalStr .. "\n" .. langPara("活动限兑：%s/%s", remainCount, data.activityLimitCount)
		end

		limitTxt.text = string.trim(finalStr)

		return
	end

	if string.nilorempty(data.sellTime) then
		limitTxt.text = lang("未开始售卖")

		return
	end

	if data.sellTime == "全天" then
		limitTxt.text = ""

		return
	end

	local sellTimeList = string.split(data.sellTime, "|")

	if sellTimeList[1] == "时段" then
		local timeList = string.split(sellTimeList[2], ",")
		local startTime = GameUtil.string2time(timeList[1])
		local leftTime = startTime - ServerTime.nowServerLook()

		if leftTime > 0 then
			limitTxt.text = langPara("%s天后开始售卖", math.ceil(leftTime / 86400))

			return
		end
	end

	limitTxt.text = lang("未开始售卖")
end

function SummerTreasureSnatchShopView:_getActivityShopLimitKey(limitType)
	if string.nilorempty(limitType) or limitType == "none" then
		return
	end

	if limitType == "daily" then
		return "每日限购 %s/%s"
	elseif limitType == "allTime" then
		return "活动限购 %s/%s"
	elseif limitType == "weekly" then
		return "每周限购 %s/%s"
	end
end

function SummerTreasureSnatchShopView:_addDiscountTimer(endTime, cell, txt)
	self._discountTimerList = self._discountTimerList or {}

	if endTime > 0 and txt then
		self._discountTimerList[cell] = {
			endTime = endTime,
			txt = txt
		}
	end
end

function SummerTreasureSnatchShopView:_removeDiscountTimer(cell)
	if self._discountTimerList then
		self._discountTimerList[cell] = nil
	end
end

function SummerTreasureSnatchShopView:_onCountDown()
	if not self._discountTimerList then
		return
	end

	local timeNow = ServerTime.now()

	for _, timerInfo in pairs(self._discountTimerList) do
		local leftTime = timerInfo.endTime - timeNow

		if leftTime <= 0 then
			self:_reloadActivityShopData()

			return
		end

		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)
		local timerStr = string.format("%02d:%02d:%02d", hour % 24, min, sec)

		if hour >= 24 then
			timerStr = langPara("%s天%s", math.floor(hour / 24), timerStr)
		end

		timerInfo.txt.text = langPara("折扣:%s", timerStr)
	end
end

function SummerTreasureSnatchShopView:_updateCellTab(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell, "nameText")
	local changeGroup = cell:GetComponent(ComponentType.UIChangeGroup)

	nameText.text = lang(data.name)

	changeGroup:SetState(self._curTab == data.tab and 1 or 0)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTab, self, data.tab))
end

function SummerTreasureSnatchShopView:_clearCellTab(cell)
	GameUtil.rmClickHandler(cell)
end

function SummerTreasureSnatchShopView:_onClickTab(tab)
	if self._curTab == tab then
		return
	end

	self._curTab = tab

	self._scrollListTab:reloadData(self._tabDataList)

	if tab == 1 then
		local shopCfgs = SummerTreasureSnatchConfig.instance:getShopCfgs(self._activityId)
		local gainItemId = self._info and checktable(self._info.gainItemId) or {}

		if #gainItemId > 0 then
			self._sortList = self._sortList or TableUtil.deepcopy(shopCfgs)

			self:_sortShopCfg()
			self._scrollList:reloadData(self._sortList)
		else
			self._scrollList:reloadData(shopCfgs)
		end

		self:_updateCoin()
	elseif tab == 2 then
		self:_reloadActivityShopData(true)
	end
end

function SummerTreasureSnatchShopView:_reloadActivityShopData(resetPos)
	local activityShopCfgs = ActivityshopConfig.instance:getActivityShopCfgWithPage(self._activityType, self._activityId)

	if not activityShopCfgs[1] then
		local canBuyList = {}
		local sellOutList = {}
		local lockedList = {}

		for _, data in ipairs(activityShopCfgs[1]) do
			if data.showflag ~= 1 then
				local sellOut = self:_isActivityShopSellOut(data)

				if sellOut then
					table.insert(sellOutList, data)
				elseif PayShopController.instance:checkTimeStr(data.sellTime) then
					table.insert(canBuyList, data)
				else
					table.insert(lockedList, data)
				end
			end
		end

		table.insertto(canBuyList, sellOutList)
		table.insertto(canBuyList, lockedList)

		self._activityShopDataList = activityShopCfgs[1]

		self._scrollList:reloadData(canBuyList)
		self:_updateCoin()

		if resetPos and #canBuyList > 0 then
			self._scrollList:MoveCellToBegin(0, false)
		end
	end
end

function SummerTreasureSnatchShopView:_onActivityShopUpdate(activityType, activityId)
	if activityType ~= self._activityType or activityId ~= self._activityId then
		return
	end

	if self._curTab == 2 then
		self:_reloadActivityShopData()
	end
end

function SummerTreasureSnatchShopView:_onMaterialCountChange()
	if self._curTab == 2 then
		self:_reloadActivityShopData()
	end
end

function SummerTreasureSnatchShopView:_updateCoin()
	if self._curTab == 2 then
		if self._activityShopDataList then
			do
				local firstData = self._activityShopDataList[1]

				if not firstData then
					MaterialMgr.clearIcon(self._icon)

					self._txtScoreNum.text = 0

					return
				end

				local sellPriceList = string.split(firstData.sellPrice, ":")
				local matType = checknumber(sellPriceList[1])
				local matId = checknumber(sellPriceList[2])

				MaterialMgr.setIcon(self._icon, matType, matId)

				self._txtScoreNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId) or 0

				return
			end

			local matType, matId = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

			MaterialMgr.setIcon(self._icon, matType, matId, nil, nil)

			self._txtScoreNum.text = self._info and checknumber(self._info.score) or 0
		end
	end
end

function SummerTreasureSnatchShopView:_setItemShow(item, txtName, txtPrice, data)
	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.matStr)
	txtPrice.text = data.cost

	if data.itemType == SummerTreasureSnatchController.BuyItemType.PetExperience then
		local supportPetCfg = SummerTreasureSnatchConfig.instance:getSupportPetCfg(self._activityId, data.itemParam)

		if supportPetCfg then
			local skinId = checknumber(supportPetCfg.faceId)
			local petName = PetSkinConfig.instance:getPetSkinName(skinId)

			if skinId <= 0 then
				skinId = supportPetCfg.raceId
				petName = supportPetCfg.creepsName
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, item)

			if proxy then
				local fMo = FightingPowerPetMo.New()

				fMo:fromChallengeCreepCo(supportPetCfg)
				fMo:toBaseBagPetMo()

				local function func()
					CommonTipsMgr.instance:showPetTips(fMo)
				end

				proxy.binder:setClickCallBack(func)
			end

			txtName.text = petName
		end
	else
		MaterialMgr.setCellByCfg(data.matStr, item)
	end
end

function SummerTreasureSnatchShopView:_onClickBuy(data)
	if self._curTab == 1 and ServerTime.now() >= self._endTime then
		FloatWordMgr.instance:show(lang("当前活动已结束，无需购买"))

		return
	end

	if self._info then
		if not self._info.gainItemId then
			local gainItemId = {}
			local buyTime = table.indexof(gainItemId, data.itemId) and 1 or 0

			if data.itemType == SummerTreasureSnatchController.BuyItemType.BossTimes then
				buyTime = self._info and checknumber(self._info.weeklyBuyBossClgTimes) or 0
			end

			local weeklyBuyTimesLimit = data.weeklyBuyTimesLimit

			if data.itemType == SummerTreasureSnatchController.BuyItemType.BossTimes and weeklyBuyTimesLimit > 0 and weeklyBuyTimesLimit <= buyTime then
				FloatWordMgr.instance:show(lang("超过购买次数限制"))

				return
			end

			if data.itemType ~= SummerTreasureSnatchController.BuyItemType.BossTimes and buyTime > 0 then
				FloatWordMgr.instance:show(lang("已购买过，无需重复购买"))

				return
			end

			local costName = MaterialMgr.getMaterialsNameByCfg(data.matStr)

			if self._info.score < data.cost then
				FloatWordMgr.instance:show(lang("积分不足，暂时无法购买"))

				return
			end

			local tipsContent = langPara("是否花费%s购买%s?", data.cost, costName)

			TipsFacade.instance:openPopupWindow("提示", tipsContent, function()
				SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchBuyItemReq(self._activityId, data.itemId)
			end, nil, "确定", "取消")
		end
	end
end

function SummerTreasureSnatchShopView:_onClickClose()
	self:close()
end

function SummerTreasureSnatchShopView:_onClickTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function SummerTreasureSnatchShopView:_sortShopCfg()
	local function func(cfg)
		local gainItemId = self._info and checktable(self._info.gainItemId) or {}
		local hasBuy = table.indexof(gainItemId, cfg.itemId)
		local notIsBossTime = cfg.itemType ~= SummerTreasureSnatchController.BuyItemType.BossTimes

		if hasBuy and notIsBossTime then
			return 0
		else
			return 1
		end
	end

	local function func2(cfg)
		return cfg.itemType
	end

	local function func3(cfg)
		return cfg.itemId
	end

	ArraySort.sortOn(self._sortList, {
		func,
		func2,
		func3
	}, {
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.DESCENDING
	})
end

return SummerTreasureSnatchShopView
