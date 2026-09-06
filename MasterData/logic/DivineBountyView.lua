-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyView.lua

module("logic.extensions.divinebounty.view.DivineBountyView", package.seeall)

local DivineBountyView = class("DivineBountyView", ViewComponent)

function DivineBountyView:ctor()
	DivineBountyView.super.ctor(self)

	self.clickTimer = 0
end

function DivineBountyView:buildUI()
	DivineBountyView.super.buildUI(self)

	self._goBgRoot = self:getGo("bg")
	self._goSpineRoot = goutil.findChild(self._goBgRoot, "spineRoot")
	self._goTurntable = self:getGo("turntable")
	self._goZhizhen = goutil.findChild(self._goTurntable, "zhizhen")
	self._goPrizeRoot = goutil.findChild(self._goTurntable, "lotteryPrizeRoot")
	self._goViewDownTran = self:getGo("viewDownTran")
	self._goEffectRoot = goutil.findChild(self._goTurntable, "effectRoot")
	self._btnSkip = self:getBtn("btnSkip")
	self._imgSkip = goutil.findChild(self._btnSkip, "imgSelect")
	self._btnShop = goutil.findChildButtonComponent(self._goViewDownTran, "shopBtn")
	self._btnOneClick = goutil.findChildButtonComponent(self._goViewDownTran, "oneClickBtn")
	self._btnTenClick = goutil.findChildButtonComponent(self._goViewDownTran, "tenClickBtn")
	self._tenFreeGo = goutil.findChild(self._btnTenClick, "tenFreeGo")

	local cycleCountGo = goutil.findChild(self._goViewDownTran, "cycleCountGo")

	self._cycleNum1 = goutil.findChild(cycleCountGo, "cycleNum_1"):GetComponent("UIImageSpriteChange")
	self._cycleNum2 = goutil.findChild(cycleCountGo, "cycleNum_2"):GetComponent("UIImageSpriteChange")

	local oneNeedGo = goutil.findChild(self._goViewDownTran, "oneNeedGo")

	self._imgOneNeed = goutil.findChildImageComponent(oneNeedGo, "oneNeedIma")
	self._txtOneNeed = goutil.findChildTextComponent(oneNeedGo, "oneNeedTxt")

	local tenNeedGO = goutil.findChild(self._goViewDownTran, "tenNeedGo")

	self._imgTenNeed = goutil.findChildImageComponent(tenNeedGO, "tenNeedIma")
	self._txtTenNeed = goutil.findChildTextComponent(tenNeedGO, "tenNeedTxt")
	self._discountNeedGo = goutil.findChild(tenNeedGO, "discountNeedGo")
	self._goPrize = self:getGo("prize")
	self._goTableview = goutil.findChild(self._goPrize, "tableview")
	self._goCell = goutil.findChild(self._goTableview, "cell")
	self._goUpShowTran = self:getGo("upShowTran")
	self._btnClose = goutil.findChild(self._goUpShowTran, "viewCloseBtn")
	self._btnTip = goutil.findChild(self._goUpShowTran, "btnTip")
	self._scoreItem = goutil.findChild(self._goUpShowTran, "scoreItem")
	self._imgScoreIcon = goutil.findChildImageComponent(self._scoreItem, "scoreIconIma")
	self._txtScoreCount = goutil.findChildTextComponent(self._scoreItem, "scoreCountTxt")
	self._scoreBtn = Framework.ButtonAdapter.GetFrom(self._scoreItem, "scoreAddBtn")
	self._daibiItem = goutil.findChild(self._goUpShowTran, "daibiItem")
	self._imgDaibiIcon = goutil.findChildImageComponent(self._daibiItem, "daibiIconIma")
	self._txtDaibiCount = goutil.findChildTextComponent(self._daibiItem, "daibiCountTxt")
	self._daibiBtn = Framework.ButtonAdapter.GetFrom(self._daibiItem, "daibiAddBtn")
	self._diamondItem = goutil.findChild(self._goUpShowTran, "diamondItem")
	self._txtdiamondCount = goutil.findChildTextComponent(self._diamondItem, "diamondCountTxt")
	self._diamondBtn = Framework.ButtonAdapter.GetFrom(self._diamondItem, "diamondAddBtn")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regReloadFinish(GameUtil.handler(self.reloadFinish, self))

	self._btnJumpWandererPass = self:getGo("btnJumpWandererPass")
end

function DivineBountyView:unbindEvents()
	DivineBountyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSkip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._scoreBtn)
	GameUtil.rmClickHandler(self._daibiBtn)
	GameUtil.rmClickHandler(self._diamondBtn)
	GameUtil.rmClickHandler(self._btnOneClick)
	GameUtil.rmClickHandler(self._btnTenClick)
	GameUtil.rmClickHandler(self._btndiamondAdd)
	GameUtil.rmClickHandler(self._btnJumpWandererPass)
end

function DivineBountyView:bindEvents()
	DivineBountyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSkip, self._onClickSkipBtn, self)
	GameUtil.addClickHandler(self._btnShop, self._openShopTabView, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickCloseBtn, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._scoreBtn, self._onClickScoreBtn, self)
	GameUtil.addClickHandler(self._daibiBtn, self._onClickDaibiBtn, self)
	GameUtil.addClickHandler(self._diamondBtn, self._onClickDiamondBtn, self)
	GameUtil.addClickHandler(self._btnJumpWandererPass, self._onClickJumpWandererPass, self)
	GameUtil.addClickHandler(self._btnOneClick, function()
		self:_onClickBuyBtn(1)
	end, self)
	GameUtil.addClickHandler(self._btnTenClick, function()
		self:_onClickBuyBtn(10)
	end, self)
	GameUtil.addClickHandler(self._btndiamondAdd, function()
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(28)

		if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			FloatWordMgr.instance:show(cfg.lockedTips)

			return
		end

		LotteryModel.instance.openTabIndex = self.choIndex

		PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
	end, self)
end

function DivineBountyView:onEnter()
	DivineBountyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineBountyGetLotteryInfoRes, self._onGetLotteryInfoRes, self)
	self.addGEvent(self, GlobalNotify.DivineBountyLotteryRes, self._onGetLotteryRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._refreshViewShow, self)
	self.addGEvent(self, GlobalNotify.DivineBountyViewUnlockBlock, self._onDivineBountyViewUnlockBlock, self)
	DivineBountyController.instance:registerLocalNotify(DivineBountyController.ShopViewClose, self._handleShopViewCloseEvent, self)

	self.clickTimer = 0
	self._curLevel = 1
	self._localDataKey = "divinebounty_"
	self._effBigPrizes = {}
	self._effStartCjMap = {}

	self:_loadViewConfigs()
	self:_initViewShow()
	DivineBountyAgent.instance:sendPM_DivineBountyGetLotteryInfoReq()
	GameUtil.SetActive(self._btnJumpWandererPass, false)

	local activityId = WandererpassController.CURR_ACTIVITY_ID

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		GameUtil.SetActive(self._btnJumpWandererPass, true)
	end
end

function DivineBountyView:onExit()
	DivineBountyView.super.onExit(self)
	removetimer(self._timerFunc1, self)
	removetimer(self._showPrizeInTemp, self)
	removetimer(self._playStartCjEffByZhizhen, self)
	removetimer(self._rmEndCjEff, self)
	removetimer(self._unLockClickEvent, self)
	self:_destroySpineObjects()
	self:_rmBgEffect()
	self:_rmEndCjEff()

	if self._effBigPrizes then
		for i, v in ipairs(self._effBigPrizes) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self:_unLockClickEvent()
end

function DivineBountyView:_unLockClickEvent()
	ViewBlockMgr.instance:blockClick(false, self)
	removetimer(self._unLockClickEvent, self)
	print("跳过抽奖 解锁点击事件")
end

function DivineBountyView:_onClickCloseBtn()
	self:close()
end

function DivineBountyView:_onClickTipBtn()
	TipsFacade.instance:openRulesView("divinebountyview_rule")
end

function DivineBountyView:_onClickSkipBtn()
	self._isSkip = not self._isSkip

	GameUtil.saveUserData(self._localDataKey .. "isSkip", self._isSkip)
	goutil.setActive(self._imgSkip, self._isSkip)
end

function DivineBountyView:_onClickBuyBtn(times)
	if not self:PreventTooFastClick() then
		return
	end

	local function localFunc()
		ViewBlockMgr.instance:blockClick(true, self)
		print("锁定点击事件", times)
		DivineBountyAgent.instance:sendPM_DivineBountyLotteryReq(times)
	end

	local info = DivineBountyModel.instance:getLotteryInfo()
	local goldCoinCount = tonumber(string.split(self._basePrize, ":")[3])
	local matType, matId, oneClickFare = MaterialMgr.getMatParams(self._lotteryCost)
	local _, _, discountFare = MaterialMgr.getMatParams(self._lotterDiscountCost)
	local myCoins = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local isDiscount = info.usedDiscountTimes < tonumber(self._discountTimes)
	local curFare = oneClickFare * times

	if times == 10 and isDiscount then
		curFare = discountFare
	end

	if myCoins < curFare then
		FloatWordMgr.instance:show("神钻数量不足")

		return
	end

	local str = string.format("确定花费<color=#d44c28>%s神钻</color>购买%s金币，进行%s次转盘吗？", curFare, goldCoinCount * times, times)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, curFare, str, localFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function DivineBountyView:_loadViewConfigs()
	self._lotteryPrizeCfgs = DivineBountyConfig.instance:getLotteryPrizeCfgs() or {}
	self._progressPrizeCfgs = DivineBountyConfig.instance:getProgressPrizeCfgs() or {}
	self.maxTimes = 0

	for _, v in pairs(self._progressPrizeCfgs) do
		if v.times and self.maxTimes < v.times then
			self.maxTimes = v.times
		end
	end

	self._payCoins = string.split(DivineBountyConfig.instance:getCommonCfg("SHOPPAY_COST"), "#")[2]
	self._lotteryCost = DivineBountyConfig.instance:getCommonCfg("LOTTERY_COST")
	self._lotterDiscountCost = DivineBountyConfig.instance:getCommonCfg("LOTTERY_TEN_DISCOUNT_COST")
	self._discountTimes = DivineBountyConfig.instance:getCommonCfg("DISCOUNT_TIMES")
	self._basePrize = DivineBountyConfig.instance:getCommonCfg("LOTTERY_BASE_PRIZE")
end

function DivineBountyView:_initViewShow()
	self._isSkip = GameUtil.getUserData(self._localDataKey .. "isSkip") or false

	local z = tonumber(GameUtil.getUserData(self._localDataKey .. "zhizhenRotateZ")) or 0

	goutil.setActive(self._imgSkip, self._isSkip)
	self:_showPrizeUnderBg()
	self:_playBgEffect()
	self:_createSpineObjects()
	GameUtil.setLocalRotation(self._goZhizhen, 0, 0, z)
end

function DivineBountyView:_showPrizeUnderBg()
	self._bigPrizeIds = string.split(DivineBountyConfig.instance:getCommonCfg("BIG_PRIZE_ID"), "#")

	local index = 1

	for k, v in ipairs(self._lotteryPrizeCfgs) do
		local go = goutil.findChild(self._goPrizeRoot, "prize" .. k)
		local goEffect = goutil.findChild(go, "effect")
		local change = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
		local goIcon = goutil.findChild(go, "icon")
		local goSpecial = goutil.findChild(go, "special")
		local count = goutil.findChildTextComponent(go, "count")
		local isBigPrizeId = v.id == tonumber(self._bigPrizeIds[index])
		local matType, matId, matCount = MaterialMgr.getMatParams(v.prize)

		MaterialMgr.setCellByCfg(v.prize, goIcon)

		local cellBg = goutil.findChild(goIcon, "GoldCell/item_cell(Clone)/ImgBg")
		local cellImg = goutil.findChild(goIcon, "GoldCell/item_cell(Clone)/Image")
		local cellTxt = goutil.findChild(goIcon, "GoldCell/item_cell(Clone)/TxtNum")
		local cellTopGo = goutil.findChild(goIcon, "GoldCell/item_cell(Clone)/topGo")

		count.text = matCount

		goutil.setActive(cellBg, false)
		goutil.setActive(cellImg, false)
		goutil.setActive(cellTxt, false)
		goutil.setActive(cellTopGo, false)
		goutil.setActive(goSpecial, isBigPrizeId)
		change:SetState(isBigPrizeId and 1 or 0)

		if isBigPrizeId then
			local path = "20240823/zhaohuan/fx_ui_zhaohuan_tejiang.prefab"
			local effBigPrize = UIEffectManager.instance:playEffect(self, path, goEffect.transform, 0, 0, true, false, nil)

			effBigPrize:setParent(goEffect.transform)
			effBigPrize:setScale(1)
			effBigPrize:setLocalPos(0, 0, 0)
			table.insert(self._effBigPrizes, effBigPrize)

			if index + 1 <= #self._bigPrizeIds then
				index = index + 1
			end
		end
	end

	self:_refreshPrizeSelectEff()
end

function DivineBountyView:_openShopTabView()
	local tabViewCfg = DivineBountyConfig.instance:getShopCfg()

	goutil.setActive(self._scoreItem, false)
	goutil.setActive(self._daibiItem, false)
	goutil.setActive(self._diamondItem, false)

	if #tabViewCfg <= 0 then
		FloatWordMgr.instance:show("商店暂无商品出售")

		return
	end

	UIStateManager.instance:push(ViewName.DivineBountyShopView)
end

function DivineBountyView:_onGetLotteryInfoRes()
	self:_refreshLotteryInfo()
	self._tableview:reloadData(self._progressPrizeCfgs)
end

function DivineBountyView:_onGetLotteryRes()
	self:_onGetLotteryInfoRes()
	self:_refreshPrizeSelectEff()

	local itemIds, progressPrizeIds, changeSetIds = DivineBountyModel.instance:getDivineBountyLotteryRes()

	self._changeSetIds = changeSetIds

	local bestQuality = 1000000000
	local bestId = -1

	for _, id in ipairs(itemIds) do
		if bestQuality > self._lotteryPrizeCfgs[id].quality then
			bestQuality = self._lotteryPrizeCfgs[id].quality
			bestId = id
		end
	end

	if self._isSkip then
		local targetAngle = (bestId - 1) * 360 / #self._lotteryPrizeCfgs

		GameUtil.setLocalRotation(self._goZhizhen, 0, 0, -1 * targetAngle)
		GameUtil.saveUserData(self._localDataKey .. "zhizhenRotateZ", tostring(-1 * targetAngle))
		self:_refreshPrizeSelectEff(bestId)
		settimer(0.5, self._unLockClickEvent, self, false)
		settimer(0.7, self._showPrizeInTemp, self, false)

		return
	end

	self:_playAnim("jiasu", true)
	self:_startTurntable(bestId, progressPrizeIds)
end

function DivineBountyView:_startTurntable(itemId, progressPrizeIds)
	local keepTime = 3
	local total = #self._lotteryPrizeCfgs
	local perAngle = 360 / total
	local targetAngle = (itemId - 1) * perAngle + 1800
	local curAngele = self._goZhizhen.transform.localRotation.eulerAngles.z % 360

	self._isLottery = true

	UnityTweens.TweenRotate.StartTween(self._goZhizhen, Vector3.New(0, 0, curAngele), Vector3.New(0, 0, -1 * targetAngle), keepTime, UnityTweens.EaseType.easeInOutQuad)
	settimer(0, self._playStartCjEffByZhizhen, self, true)

	function self._timerFunc1()
		self:_refreshPrizeSelectEff(itemId)
		self:_unLockClickEvent()
		removetimer(self._timerFunc1, self)
	end

	settimer(keepTime, self._timerFunc1, self, false)
	settimer(keepTime + 0.8, self._showPrizeInTemp, self, false)
end

function DivineBountyView:_showPrizeInTemp()
	if self._changeSetIds and #self._changeSetIds > 0 then
		local list = {}
		local coinGold = 0

		for i, changeSetId in ipairs(self._changeSetIds) do
			local items = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)

			if items then
				for i, mo in ipairs(items) do
					if mo.type == MatType.Coin and mo.id == MatType.Coin_Gold then
						coinGold = coinGold + mo.num
					else
						table.insert(list, mo)
					end
				end
			end
		end

		local obj = {}

		obj.items = list

		UIStateManager.instance:open(ViewName.ItemGet, obj, coinGold)
		removetimer(self._showPrizeInTemp, self)
	end
end

function DivineBountyView:_refreshPrizeSelectEff(prizeId)
	for k, v in ipairs(self._lotteryPrizeCfgs) do
		local goRoot = goutil.findChild(self._goPrizeRoot, "prize" .. k)
		local goEffect = goutil.findChild(goRoot, "effect")
		local goSelect = goutil.findChild(goRoot, "select")
		local isSelected = prizeId and v.id == prizeId

		if isSelected then
			self:_playAnim("idle", true)
			self:_playEndCjEff(goEffect)
		end

		goutil.setActive(goSelect, isSelected)
	end

	self._isLottery = false
end

function DivineBountyView:_updateCell(view, goCell, data)
	self:_clearCell(goCell)

	local item = goutil.findChild(goCell, "item")
	local txtScore = goutil.findChildTextComponent(goCell, "txtScore")
	local goCanGet = goutil.findChild(goCell, "canGet")
	local goGeted = goutil.findChild(goCell, "geted")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)
	local info = DivineBountyModel.instance:getAllInfo()
	local isCanGet = info._lotteryInfo.progress >= data.times

	txtScore.text = data.times

	goutil.setActive(goGeted, isCanGet)
end

function DivineBountyView:_clearCell(goCell)
	MaterialMgr.resetAll(goCell)
end

function DivineBountyView:reloadFinish()
	if self._curLevel then
		self._tableview:MoveCellToCenter(self._curLevel - 1)
	end
end

function DivineBountyView:_refreshLotteryInfo()
	local info = DivineBountyModel.instance:getLotteryInfo()
	local progBar = goutil.findChildComponent(self._goTableview, "viewport/content/progBar", "Slider")
	local progText = goutil.findChildTextComponent(self._goPrize, "times/txtScore")

	progText.text = "已累计转动<color=#F8D200FF>" .. tostring(info.progress) .. "</color>次"

	local perValue = 1 / #self._progressPrizeCfgs
	local curValue = 0

	for i = 1, #self._progressPrizeCfgs do
		if i - 1 > 0 then
			if not self._progressPrizeCfgs[i - 1].times then
				local preTimes = 0
				local nextTimes = self._progressPrizeCfgs[i].times

				if preTimes < info.progress and nextTimes >= info.progress then
					local baseValue = perValue * (i - 1)

					curValue = baseValue + (info.progress - preTimes) / (nextTimes - preTimes) * perValue
					self._curLevel = i
				end
			end
		end
	end

	progBar.value = curValue

	self:_refreshViewShow()
end

function DivineBountyView:_refreshViewShow()
	if self._txtdiamondCount then
		local num = RoleModel.instance:getTotalDiamond()

		self._txtdiamondCount.text = tostring(num)
	end

	if self._txtDaibiCount == nil then
		return
	end

	local matType1, matId1, oneClickFare1 = MaterialMgr.getMatParams(self._lotteryCost)

	if checknumber(matType1) <= 0 or checknumber(matId1) <= 0 then
		return
	end

	MaterialMgr.setIcon(self._imgDaibiIcon, matType1, matId1)
	MaterialMgr.setIcon(self._imgOneNeed, matType1, matId1)
	MaterialMgr.setIcon(self._imgTenNeed, matType1, matId1)

	local count = MaterialModel.instance:getMaterialsNumber(matType1, matId1)

	self._txtDaibiCount.text = tostring(count)

	local info = DivineBountyModel.instance:getLotteryInfo()
	local usedDiscountTimes = info.usedDiscountTimes

	self._txtOneNeed.text = "消耗：        x" .. tostring(oneClickFare1)
	self._txtTenNeed.text = "消耗：        x" .. tostring(oneClickFare1 * 10)

	local isDiscount = usedDiscountTimes < tonumber(self._discountTimes)

	goutil.setActive(self._discountNeedGo, isDiscount)
	goutil.setActive(self._tenFreeGo, isDiscount)

	if isDiscount then
		local _, _, discountFare = MaterialMgr.getMatParams(self._lotterDiscountCost)
		local txtDiscountNeed = goutil.findChildTextComponent(self._discountNeedGo, "discountNeedTxt")

		txtDiscountNeed.text = "x" .. tostring(discountFare)
	end

	if self._txtScoreCount == nil then
		return
	end

	local matType3, matId3, _ = MaterialMgr.getMatParams(self._payCoins)

	if checknumber(matType3) <= 0 or checknumber(matId3) <= 0 then
		return
	end

	MaterialMgr.setIcon(self._imgScoreIcon, matType3, matId3)

	local count = MaterialModel.instance:getMaterialsNumber(matType3, matId3)

	self._txtScoreCount.text = tostring(count)

	goutil.setActive(self._cycleNum1.gameObject, false)
	goutil.setActive(self._cycleNum2.gameObject, false)

	if checknumber(info.nextBigPrizeTimes) > 0 then
		local supCount = info.nextBigPrizeTimes

		if supCount <= 0 then
			supCount = 40
		end

		if supCount > 99 then
			supCount = 99
		end

		goutil.setActive(self._cycleNum1.gameObject, true)

		if supCount > 9 then
			local shi = math.floor(supCount / 10)
			local ge = supCount - shi * 10

			self._cycleNum1:SetState(shi)
			goutil.setActive(self._cycleNum2.gameObject, true)
			self._cycleNum2:SetState(ge)
		else
			self._cycleNum1:SetState(supCount)
		end
	end
end

function DivineBountyView:_onClickScoreBtn()
	local matType, matId, _ = MaterialMgr.getMatParams(self._payCoins)

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.openGetSource(matType, matId)
end

function DivineBountyView:_onClickDaibiBtn()
	local matType, matId, _ = MaterialMgr.getMatParams(self._lotteryCost)

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.openGetSource(matType, matId)
end

function DivineBountyView:_onClickDiamondBtn()
	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.Recharge)
end

function DivineBountyView:_onClickJumpWandererPass()
	local activityId = WandererpassController.CURR_ACTIVITY_ID

	UIStateManager.instance:push(ViewName.WandererpassmainView, activityId, 4)
end

function DivineBountyView:PreventTooFastClick(isTips)
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < 2.5 then
			return
		end

		self.clickTimer = now
	end

	return true
end

function DivineBountyView:_playBgEffect()
	local path = "20240823/zhaohuan/fx_ui_zhaohuan_loop.prefab"

	self._effBg = nil
	self._effBg = UIEffectManager.instance:playEffect(self, path, self._goBgRoot.transform, 0, 0, true, false)

	self._effBg:setParent(self._goBgRoot.transform)
	self._effBg:setScale(1)
	self._effBg:setLocalPos(0, 0, 0)
end

function DivineBountyView:_rmBgEffect()
	if self._effBg then
		UIEffectManager.instance:stopEffect(self._effBg)

		self._effBg = nil
	end
end

function DivineBountyView:_playStartCjEff(index)
	if self._effStartCjMap[index] then
		return
	end

	local path = "20240823/zhaohuan/fx_ui_zhaohuan_zhuan.prefab"
	local goParent = goutil.findChild(self._goPrizeRoot, "prize" .. index .. "/effect")
	local eff

	local function func()
		if self._effStartCjMap[index] then
			UIEffectManager.instance:stopEffect(self._effStartCjMap[index])

			self._effStartCjMap[index] = nil
		end
	end

	eff = UIEffectManager.instance:playEffect(self, path, goParent.transform, 0, 0, false, false, func)

	eff:setEffTime(0.2)
	eff:setParent(goParent.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._effStartCjMap[index] = eff
end

function DivineBountyView:_rmStartCjEff(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function DivineBountyView:_playStartCjEffByZhizhen()
	if self._isLottery then
		local curAngle = 360 - self._goZhizhen.transform.localRotation.eulerAngles.z % 360
		local perAngle = 360 / #self._lotteryPrizeCfgs
		local delAngle = 15
		local index = Mathf.Floor((curAngle - 90 + perAngle + 0.5 * perAngle + delAngle) / perAngle) % 8 + 1

		self:_playStartCjEff(index)
	else
		removetimer(self._playStartCjEffByZhizhen, self)
	end
end

function DivineBountyView:_playEndCjEff(goParent)
	local path = "20240823/zhaohuan/fx_ui_zhaohuan_jieshu.prefab"

	self._effEndCj = nil
	self._effEndCj = UIEffectManager.instance:playEffect(self, path, goParent.transform, 0, 0, false, false, self:_rmEndCjEff())
	self._effEndCj.hideEffWhileNotOnTop = false

	self._effEndCj:setParent(goParent.transform)
	self._effEndCj:setScale(1)
	self._effEndCj:setLocalPos(0, 0, 0)
end

function DivineBountyView:_rmEndCjEff()
	if self._effEndCj then
		UIEffectManager.instance:stopEffect(self._effEndCj)

		self._effEndCj = nil
	end
end

function DivineBountyView:_createSpineObjects()
	self._goSpineBg = self:getResInstance(DivineBountyViewPresentor.MainViewBgSpinePath)

	self:_setPrefabParent(self._goSpineBg, self._goSpineRoot.transform)

	self._skeletonGraphic = self._goSpineBg:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	GameUtil.setAnchoredPos(self._goSpineBg, 12.1, 69.2)
end

function DivineBountyView:_setPrefabParent(prefab, parent)
	if not prefab then
		return
	end

	prefab.transform:SetParent(parent)
	Framework.TransformUtil.SetLocalPos(prefab.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(prefab.transform, 1, 1, 1)
end

function DivineBountyView:_destroySpineObjects()
	if self._goSpineBg then
		goutil.destroy(self._goSpineBg)

		self._goSpineBg = nil
	end
end

function DivineBountyView:_playAnim(state, loop, force)
	if not force and self._currAnimState == state then
		return
	end

	self._currAnimState = state

	if self._skeletonGraphic then
		self._skeletonGraphic.startingAnimation = state

		self._skeletonGraphic.AnimationState:SetAnimation(0, state, loop)
		self._skeletonGraphic:Update(0)
	end
end

function DivineBountyView:_handleShopViewCloseEvent()
	goutil.setActive(self._scoreItem, true)
	goutil.setActive(self._daibiItem, true)
	goutil.setActive(self._diamondItem, true)
end

function DivineBountyView:_onDivineBountyViewUnlockBlock()
	ViewBlockMgr.instance:blockClick(false, self)
end

return DivineBountyView
