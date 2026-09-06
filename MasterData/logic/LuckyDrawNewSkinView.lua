-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinView.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinView", package.seeall)

local LuckyDrawNewSkinView = class("LuckyDrawNewSkinView", ViewComponent)

function LuckyDrawNewSkinView:ctor()
	LuckyDrawNewSkinView.super.ctor(self)

	self._curSelectId = 0
	self._rorateStepNums = 0
	self._petIconOnClicks = {}
end

function LuckyDrawNewSkinView:unbindEvents()
	LuckyDrawNewSkinView.super.unbindEvents(self)
	self._worldSliderMo:unbindEvents()
	self._btnStart:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._effectSwitch:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnJumpWandererPass)
	GameUtil.rmClickHandler(self._btnQuan)
end

function LuckyDrawNewSkinView:bindEvents()
	LuckyDrawNewSkinView.super.bindEvents(self)
	self._worldSliderMo:bindEvents()
	self._btnStart:AddClickListener(self._startOnClick, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "luckydrawnewskinview")
	end)
	self._rankBtn:AddClickListener(self._onClickBtnRank, self)
	self._effectSwitch:AddOnValueChanged(function()
		self:_saveToggleState(self._effectSwitch.isOn)
	end)
	GameUtil.addClickHandler(self._btnJumpWandererPass, self._onClickJumpWandererPass, self)
	GameUtil.addClickHandler(self._btnQuan, self._onClickQuanSelect, self)
end

function LuckyDrawNewSkinView:buildUI()
	LuckyDrawNewSkinView.super.buildUI(self)

	local worldRoot = self:getGo("worldRoot")

	self._worldSliderMo = RewardSliderMo.New(worldRoot)
	self._worldPrizeRectTrans = goutil.findChild(worldRoot, "worldPrize"):GetComponent(goutil.Type_RectTransform)
	self._petIconListGo = self:getGo("petIconList")
	self._petIconCell = self:getGo("petIconCell")
	self._ratePointListGo = self:getGo("ratePoint/ratePointList")
	self._progressPointListGo = self:getGo("progressPoint/progressPointList")
	self._pointCell = self:getGo("pointCell")
	self._bg = self:getGo("bg")
	self._con = self:getGo("con")
	self._rank = self:getGo("rank")
	self._mask = self:getGo("mask")
	self._petInfo = self:getGo("petInfo")
	self._rare = self:getGo("petInfo/imgRare")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tipEmpty = self:getGo("rank/tipEmpty")
	self._cost = self:getGo("cost")
	self._cost1 = self:getGo("cost/price1")
	self._cost2 = self:getGo("cost/price2")
	self._iconCost = self:getGo("cost/price1/icon")
	self._iconDiscount = self:getGo("cost/price2/icon")
	self._progressPoint = self:getGo("progressPoint")
	self._progressEffct = self:getGo("progressEffct")
	self._progressTarget = self:getGo("worldRoot/worldPrize/prize/score")
	self._rankBtn = self:getBtn("rank")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._btnPreview = self:getBtn("btnPreview")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._costTip = self:getTxt("costTip")
	self._timeTxt = self:getTxt("time/txt")
	self._txtInfo = self:getTxt("rank/txtInfo")
	self._txtRankTitle = self:getTxt("rank/title")
	self._petName = self:getTxt("petInfo/txtName")
	self._lotteryTip = self:getTxt("lotteryTip/txt")
	self._txtCost = self:getTxt("cost/price1/txtCost")
	self._txtDiscount = self:getTxt("cost/price2/txtCost")
	self._txtTip = self:getTxt("txtTip")
	self._effectSwitch = self:getToggle("effectSwitch")
	self._fadeOut = self._txtInfo.gameObject:GetComponent("UITweenFadeOut")
	self._petIconList = ScrollerList.create(self._petIconListGo, self._petIconCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._petIconList:regGetCellSize(function()
		return 100, 100
	end)

	self._btnJumpWandererPass = self:getGo("btnJumpWandererPass")
	self._btnQuan = self:getGo("btnQuan")
	self._imgSelect = self:getGo("btnQuan/imgSelect")
end

function LuckyDrawNewSkinView:onEnter()
	LuckyDrawNewSkinView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkinLotteryFreeChargeRankRes, self._onFreeChargeRankRes, self)

	self._activityId = tonumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = LuckyDrawNewSkinModel.instance:getActId()
	end

	self._actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId) or {}
	self._pricePlanId = self._actCfg.pricePlan
	self._ratePointList = {}
	self._progressPointList = {}
	self._petIconSelecetId = 0
	self._unSelectColorId = 0
	self._selectColorId = 1

	GlobalDispatcher:addListener(GlobalNotify.SkinLotteryMainInfo, self._updatePointListGo, self)
	GlobalDispatcher:addListener(GlobalNotify.SkinLotteryTxtInfo, self._setRankInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SkinLotteryBtnInfo, self._lotteryStart, self)
	GlobalDispatcher:addListener(GlobalNotify.SkinLotteryProgress, self._updateProgress, self)
	self:_refreshPetSkinShow()
	self:_setPetListOpenOrClose()
	goutil.setActive(self._mask, false)
	self:_refreshViewInfoByCfg()
	self:_showUIEff()
	SkinLotteryAgent.instance:sendPM_SkinLotteryPanelInfoReq(self._activityId)
	SkinLotteryAgent.instance:sendPM_SkinLotteryFreeChargeRankReq(self._activityId)
	SkinLotteryAgent.instance:sendPM_SkinLotteryRecordsReq(self._activityId)

	local btnList = {}
	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId) or {}

	table.insert(btnList, {
		showAdd = true,
		id = GameEnum.GoldType.GodDiamondCoin
	})
	table.insert(btnList, {
		showAdd = true,
		id = actCfg.coupon
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)

	if GameUtil.getUserData(ViewName.LuckyDrawNewSkinView .. "toggle") == nil then
		self._effectSwitch.isOn = false
	else
		self._effectSwitch.isOn = GameUtil.getUserData(ViewName.LuckyDrawNewSkinView .. "toggle")
	end

	GameUtil.SetActive(self._btnJumpWandererPass, false)

	local activityId = WandererpassController.CURR_ACTIVITY_ID

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		GameUtil.SetActive(self._btnJumpWandererPass, true)
	end

	self:_updateCoupon()
end

function LuckyDrawNewSkinView:_updateCoupon(isShowTips)
	GameUtil.SetActive(self._btnQuan, false)

	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId) or {}

	if not string.nilorempty(actCfg.coupon) then
		GameUtil.SetActive(self._btnQuan, true)

		if not MaterialMgr.getMatEnough(actCfg.coupon) then
			GameUtil.SetActive(self._imgSelect, false)
			WandererpassController.instance:setCouponSelect(self._activityId, false)

			if isShowTips then
				TipsFacade.instance:openCommonTips(langPara("%s不足", MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)))
			end
		else
			local boo = WandererpassController.instance:getCouponSelect(self._activityId)

			GameUtil.SetActive(self._imgSelect, boo)
		end
	else
		WandererpassController.instance:setCouponSelect(self._activityId, false)
	end
end

function LuckyDrawNewSkinView:onExit()
	LuckyDrawNewSkinView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SkinLotteryMainInfo, self._updatePointListGo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SkinLotteryTxtInfo, self._setRankInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SkinLotteryBtnInfo, self._lotteryStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.SkinLotteryProgress, self._updateProgress, self)
	self._worldSliderMo:onExit()
	self._petIconList:dispose()

	self._petIconOnClicks = {}

	RoleObjectPool.instance:removeRole(self._roleObj)
	uGuiUtil.clearImage(self._bg)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._iconCost)
	MaterialMgr.resetAll(self._iconDiscount)
	removetimer(self._showNewRank, self)
	removetimer(self._lotterySecond, self)
	removetimer(self._lotteryThird, self)
	removetimer(self._lotteryEnd, self)
	removetimer(self._rollProgressPoint, self)
	removetimer(self._rollRatePoint, self)
	self:_clearListCell()
	self:_stopUIEff()
end

function LuckyDrawNewSkinView:_startOnClick()
	if LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):isAnyRewardCanGet() then
		FloatWordMgr.instance:show("还有进度奖励没有领取哦~")

		return
	end

	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId)
	local priceCfg = LuckySkinLotteryConfig.instance:getPriceCfg(actCfg.pricePlan, checknumber(self._curLotteryCount) + 1)
	local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(priceCfg.price)
	local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)
	local isExpendMoneyActivity = FemaleGodController.instance:isExpendMoneyActivity(self._activityId)

	self:_updateCoupon()

	local boo = WandererpassController.instance:getCouponSelect(self._activityId)

	if boo then
		local activityId = WandererpassController.CURR_ACTIVITY_ID

		if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
			local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId) or {}
			local mt, id, num = MaterialMgr.getMatParams(actCfg.coupon)
			local name = MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)
			local content = langPara("确定消耗%sx%s，直接进行本次抽奖？\n可抵消%s%s", name, num, extPrizeNum, extName)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
				SkinLotteryAgent.instance:sendPM_SkinLotteryReq(self._activityId, isExpendMoneyActivity, boo)
			end)

			return
		end
	end

	if isExpendMoneyActivity then
		FemaleGodController.instance:showCostTipType(self._activityId, priceCfg.price, extPrizeNum, "进行一次许愿吗？", function()
			local hasEnoughMoney = FemaleGodController.instance:hasEnoughMoney(self._activityId, extPrizeNum, priceCfg.price)

			if hasEnoughMoney then
				SkinLotteryAgent.instance:sendPM_SkinLotteryReq(self._activityId, isExpendMoneyActivity, boo)
			else
				FloatWordMgr.instance:show(langPara("%s不足", extName))
			end
		end)
	else
		local content = langPara("确定花费%s%s购买1000金币，并进行1次许愿吗？", extPrizeNum, extName)

		TipsFacade.instance:openPopupCostMatViewNew(extPrizeType, extPrizeId, extPrizeNum, content, function()
			local haveNum = MaterialModel.instance:getMaterialsNumber(extPrizeType, extPrizeId) or 0

			if extPrizeType == MatType.Diamond_Consume then
				extPrizeType = MatType.Diamond
				extPrizeId = MatType.Diamond_Binding
			end

			if ((extPrizeType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(extPrizeNum) then
				local cfg = MaterialMgr.getMatCfg(extPrizeType, extPrizeId)

				if cfg then
					FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
				else
					FloatWordMgr.instance:show(lang("所需货币不足！"))
				end
			else
				SkinLotteryAgent.instance:sendPM_SkinLotteryReq(self._activityId, isExpendMoneyActivity, boo)
			end
		end)
	end
end

function LuckyDrawNewSkinView:_showPrize()
	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId)
	local priceCfg = LuckySkinLotteryConfig.instance:getPriceCfg(actCfg.pricePlan, self._curLotteryCount)
	local extPrizeType, matId, num = MaterialMgr.getMatParams(priceCfg.reward)
	local iconStr = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", extPrizeType, matId)
	local matName = MaterialMgr.getMaterialsName(extPrizeType, matId)

	matName = string.format("<color=#F9FB39FF>%s</color>", matName)

	FloatWordMgr.instance:show(string.format("%s  %s x %d", iconStr, matName, num))
end

function LuckyDrawNewSkinView:_updatePointListGo(activityId)
	if self._activityId ~= activityId then
		return
	end

	self._lotteryPlan = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getLotteryPlan()
	self._curLotteryCount = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getCurLotteryCount()

	local count = self._curLotteryCount == 0 and 1 or self._curLotteryCount
	local lotteryCfg = LuckySkinLotteryConfig.instance:getSkinLotteryPlanCfg(self._lotteryPlan, count)
	local progressPlanCfg = LuckySkinLotteryConfig.instance:getProgressPlanCfg(lotteryCfg.processPlan)
	local ratePlanCfg = LuckySkinLotteryConfig.instance:getRatePlanCfg(lotteryCfg.criRatePlan)

	if #self._progressPointList <= 0 and #self._ratePointList <= 0 then
		for k, v in ipairs(progressPlanCfg) do
			local list = {}
			local go = goutil.cloneAndSetParent(self._pointCell, self._progressPointListGo.transform)

			list.go = go
			list.point = goutil.findChildTextComponent(go, "txt")
			list.select = goutil.findChild(go, "select")
			list.effect = goutil.findChild(go, "effect")
			list.color = goutil.findChildComponent(go, "txt", "UITextColorChange")
			list.point.text = v.processPoint

			goutil.setActive(go, true)

			self._progressPointList[k] = list
		end

		for k, v in ipairs(ratePlanCfg) do
			local list = {}
			local go = goutil.cloneAndSetParent(self._pointCell, self._ratePointListGo.transform)

			list.go = go
			list.point = goutil.findChildTextComponent(go, "txt")
			list.select = goutil.findChild(go, "select")
			list.effect = goutil.findChild(go, "effect")
			list.color = goutil.findChildComponent(go, "txt", "UITextColorChange")
			list.point.text = v.criRate

			goutil.setActive(go, true)

			self._ratePointList[k] = list
		end
	end

	self:_initWorldParams()
	self:_refreshInfo()
end

function LuckyDrawNewSkinView:_updateTabCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local withTag = goutil.findChild(cell, "withTag")
	local index = cell.index + 1

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data)
	goutil.setActive(select, index == self._petIconSelecetId)

	local isWith = MaterialMgr.isWithInSkinPrize(MatType.PET_SKIN, data)

	goutil.setActive(withTag, isWith)
	GameUtil.asBtn(cell.gameObject):RemoveClickListener()
	GameUtil.asBtn(cell.gameObject):AddClickListener(function()
		if index == self._petIconSelecetId then
			return
		end

		self:_onClickIndex(data, index)
	end, self)
end

function LuckyDrawNewSkinView:_clearTabCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
	GameUtil.asBtn(cell.gameObject):RemoveClickListener()
end

function LuckyDrawNewSkinView:_setPetListOpenOrClose()
	local skinIds = LuckySkinLotteryConfig.instance:getShowPetSkinId(self._activityId)

	if #skinIds <= 0 then
		goutil.setActive(self._petIconListGo, false)
	end
end

function LuckyDrawNewSkinView:setPetInfo(petId)
	MaterialMgr.resetAll(self._rare)

	local petCo = PetSkinConfig.instance:getPetSkinCfg(petId)

	GameUtil.setUIImageSpriteIdx(self._rare, petCo.quality)

	self._petName.text = petCo.skinName

	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:AddClickListener(function()
		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, petId)
	end, self)
	self._btnSkill:AddClickListener(function()
		local skinId = petId

		if skinId then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				local raceId = cfg.raceId

				PetbookController.instance:previewBattle(raceId, skinId)
			end
		end
	end, self)
end

function LuckyDrawNewSkinView:_rollSkinShow()
	local list = self._petIconList:getData() or {}

	if #list == 0 then
		return
	end

	self._petIconSelecetId = self._petIconSelecetId + 1

	if self._petIconSelecetId > #list then
		self._petIconSelecetId = 1
	end

	self:_onClickIndex(list[self._petIconSelecetId], self._petIconSelecetId)
end

function LuckyDrawNewSkinView:_initWorldParams()
	local worldParam = {}

	worldParam.view = self

	local planId = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._lotteryPlan)

	worldParam.prizeCfgs = LuckySkinLotteryConfig.instance:getRewardCfgList(planId)

	function worldParam.getWorldProgress()
		return LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getCurProgress()
	end

	function worldParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needPoint
	end

	function worldParam.getPrizeByRewardCfg(rewardCfg)
		return {
			rewardCfg.bigReward,
			rewardCfg.normalReward
		}
	end

	function worldParam.isWorldRewardCanGet(rewardCfg)
		return LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):isRewardCanGet(rewardCfg.rewarId, rewardCfg.needPoint)
	end

	function worldParam.isWorldRewardGeted(rewardCfg)
		return LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):isRewardGeted(rewardCfg.rewarId)
	end

	function worldParam.isAnyWorldRewardCanGet()
		return LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):isAnyRewardCanGet()
	end

	function worldParam.sendGainWorldPrizeReq(rewardCfg)
		SkinLotteryAgent.instance:sendPM_SkinLotteryGetProcessRewardReq(self._activityId)
	end

	function worldParam.getPrizeText()
		return string.format("当前进度:\n<color=#F8D200FF>%d</color>点", LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getCurProgress())
	end

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
	GameUtil.setAnchoredPos(self._worldPrizeRectTrans, 552.5, 29)
end

function LuckyDrawNewSkinView:_updateProgress(activityId)
	if self._activityId ~= activityId then
		return
	end

	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()

	if LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getIsRest() then
		SkinLotteryAgent.instance:sendPM_SkinLotteryPanelInfoReq(self._activityId)
	end

	LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):showChangeSetIds()
end

function LuckyDrawNewSkinView:_setRankInfo(activityId)
	if self._activityId ~= activityId then
		return
	end

	removetimer(self._showNewRank, self)

	local planId = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._lotteryPlan)
	local isFreePlan = LuckySkinLotteryConfig.instance:isFreePlan(planId)
	local isEmptyRank = true

	self._curRankId = 0
	self._rankList = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getRecordList()
	self._freeRankInfo = LuckyDrawNewSkinModel.instance:getFreeRankInfo(self._activityId)

	if self._freeRankInfo then
		self._freeRankList = self._freeRankInfo.infoList or {}
	end

	isEmptyRank = isFreePlan and #self._freeRankList <= 0 or #self._rankList <= 0

	if isEmptyRank then
		goutil.setActive(self._txtInfo.gameObject, false)
		goutil.setActive(self._tipEmpty, true)

		self._fadeOut.enabled = false
	else
		goutil.setActive(self._txtInfo.gameObject, true)
		goutil.setActive(self._tipEmpty, false)
		settimer(3, self._showNewRank, self)
		self:_showNewRank()
	end
end

function LuckyDrawNewSkinView:_showNewRank()
	self._curRankId = self._curRankId + 1

	local data
	local planId = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._lotteryPlan)
	local isFreePlan = LuckySkinLotteryConfig.instance:isFreePlan(self._pricePlanId)
	local txtInfoStr = "%s服的%s在第%s次许愿成功获得%s"

	if isFreePlan then
		if #self._freeRankList < self._curRankId then
			self._curRankId = 1
		end

		data = self._freeRankList[self._curRankId]

		local headInfo = self._freeRankList[self._curRankId].opHeadInfo

		txtInfoStr = "%s-%s\n第%s抽成功免单返还%s神钻"
		self._txtInfo.text = langPara("%s-%s\n第%s抽成功免单返还%s神钻", data.areaId, headInfo.userName, data.lotteryTimes, data.godGemCount)
	else
		if #self._rankList < self._curRankId then
			self._curRankId = 1
		end

		data = self._rankList[self._curRankId]

		local processRewardPlan = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._rankList[self._curRankId].plan)
		local prizeCfg = LuckySkinLotteryConfig.instance:getRewardCfg(processRewardPlan, data.rewardId)
		local prizeMat = prizeCfg.bigReward

		if string.nilorempty(prizeMat) then
			removetimer(self._showNewRank, self)
			printError("奖品未定义")

			return
		end

		local prizeName = MaterialMgr.getMaterialsNameByCfg(prizeMat)

		self._txtInfo.text = langPara(txtInfoStr, data.areName, data.useName, data.lotteryTime, prizeName)
	end

	self._fadeOut.enabled = true
end

function LuckyDrawNewSkinView:_refreshInfo()
	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId)
	local priceCfg = LuckySkinLotteryConfig.instance:getPriceCfg(actCfg.pricePlan, self._curLotteryCount + 1)
	local lotteryPlanCfg = LuckySkinLotteryConfig.instance:getSkinLotteryPlanCfgs(self._lotteryPlan)

	if priceCfg then
		local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(priceCfg.priceShow or "")

		if priceCfg then
			local ePrizeType, ePrizeId, ePrizeNum = MaterialMgr.getMatParams(priceCfg.price or "")

			goutil.setActive(self._cost1, not string.nilorempty(priceCfg and priceCfg.priceShow))
			goutil.setActive(self._cost, priceCfg)

			local loteryCfg = self:_getLotteryCfg(lotteryPlanCfg)
			local txt = "再抽<color=#eb4642>%s</color>次<color=#eb4642>%s</color>"
			local tipTxt = loteryCfg and string.format(txt, loteryCfg.lotteryNum - self._curLotteryCount, loteryCfg.criRateShow) or ""
			local isFreePlan = LuckySkinLotteryConfig.instance:isFreePlan(actCfg.pricePlan)

			self._txtCost.text = extPrizeNum or ""
			self._txtDiscount.text = ePrizeNum or ""
			self._lotteryTip.text = tipTxt
			self._txtRankTitle.text = "全服许愿信息"

			if isFreePlan then
				self._txtRankTitle.text = "全服免单信息"
			end

			if priceCfg and priceCfg.priceShow then
				MaterialMgr.setIcon(self._iconCost, ePrizeType, ePrizeId)
				MaterialMgr.setIcon(self._iconDiscount, ePrizeType, ePrizeId)
			end

			goutil.setActive(self._lotteryTip.transform.parent.gameObject, loteryCfg and true or false)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._cost:GetComponent(goutil.Type_RectTransform))
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._cost1:GetComponent(goutil.Type_RectTransform))
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._cost2:GetComponent(goutil.Type_RectTransform))
		end
	end
end

function LuckyDrawNewSkinView:_getLotteryCfg(cfg)
	for i, v in ipairs(cfg) do
		if i > self._curLotteryCount and not string.nilorempty(v.criRateShow) then
			return v
		end
	end

	return nil
end

function LuckyDrawNewSkinView:_refreshPetSkinShow()
	local skinIds = LuckySkinLotteryConfig.instance:getShowPetSkinId(self._activityId)

	goutil.setActive(self._petIconListGo, true)
	self._petIconList:reloadData(skinIds)

	for i, v in ipairs(skinIds) do
		-- block empty
	end

	self:_rollSkinShow()
end

function LuckyDrawNewSkinView:_onClickIndex(data, index)
	RoleObjectPool.instance:removeRole(self._roleObj)

	self._petIconSelecetId = index

	local bgImg = LuckySkinLotteryConfig.instance:getPetBgImg(data)
	local modelCfg = LuckySkinLotteryConfig.instance:getPetPos(data)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, data, self._con, modelCfg[3], nil, true, modelCfg[1], modelCfg[2])

	if not string.nilorempty(bgImg) then
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgImg)
	end

	self:setPetInfo(data)
	self._petIconList:refresh()
end

function LuckyDrawNewSkinView:_clearListCell()
	for k, v in pairs(self._progressPointList) do
		goutil.destroy(v.go)
	end

	for k, v in pairs(self._ratePointList) do
		goutil.destroy(v.go)
	end

	self._progressPointList = {}
	self._ratePointList = {}
end

function LuckyDrawNewSkinView:_refreshViewInfoByCfg()
	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId)
	local start, over = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SkinLottery, self._activityId)
	local startTime, endTime = GameUtil.time2date(start), GameUtil.time2date(over)

	self._timeTxt.text = string.format("活动时间: %s.%s %s:00 - %s.%s %s:00", startTime.month, startTime.day, startTime.hour, endTime.month, endTime.day, endTime.hour)
	self._costTip.text = actCfg.costTip or ""
	self._txtTip.text = actCfg.Tip or ""
end

function LuckyDrawNewSkinView:_showUIEff()
	local effPath = "20221104/xiunuocj/fx_ui_xiunuocj_jm.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function LuckyDrawNewSkinView:_stopUIEff()
	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function LuckyDrawNewSkinView:_playEffect()
	local path = "fx_jiazuxitong_juanxian_trail_zise"
	local path2 = "fx_jiazuxitong_juanxian_shouji_zise"
	local x, y, z = Framework.TransformUtil.GetPos(self._progressPoint.transform, 0, 0, 0)

	Framework.TransformUtil.SetPos(self._progressEffct.transform, x, y, z)

	local eff = self:_createEffect(path, self._progressEffct, true)
	local duration = 0.5

	if self._effectSwitch.isOn then
		duration = duration * 0.5
	end

	self._tween = TweenUtil.ValueTo(0, 1, duration, function(val)
		local x, y, z = Framework.TransformUtil.GetPos(self._progressPoint.transform, 0, 0, 0)
		local x1, y1, z1 = Framework.TransformUtil.GetPos(self._progressTarget.transform, 0, 0, 0)

		Framework.TransformUtil.SetPos(self._progressEffct.transform, x + (x1 - x) * val, y + (y1 - y) * val, z + (z1 - z) * val)
	end, function()
		UIEffectManager.instance:stopEffect(eff)
		self:_createEffect(path2, self._progressEffct, false)
		settimer(0.5, self._lotteryEnd, self, false)

		self._tween = nil
	end, self)
end

function LuckyDrawNewSkinView:_createEffect(path, parent, loop)
	local eff = UIEffectManager.instance:playEffect(self, "fx_ui_jiazuxitong/prefab/" .. path .. ".prefab", nil, 0, 0, false, false, nil, function(target, eff)
		local effGo = eff.effGo.transform

		goutil.addChildToParent(effGo, parent)
		Framework.TransformUtil.SetLocalPos(effGo, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(effGo, 1, 1, 1)
	end)
	local x, y, z = Framework.TransformUtil.GetPos(parent.transform, 0, 0, 0)

	eff:setPos(x, y, z)

	return eff
end

function LuckyDrawNewSkinView:_saveToggleState(isOn)
	GameUtil.saveUserData(ViewName.LuckyDrawNewSkinView .. "toggle", isOn)
end

function LuckyDrawNewSkinView:_lotteryStart(activityId)
	if self._activityId ~= activityId then
		return
	end

	goutil.setActive(self._mask, true)

	local round = 2

	self._rorateStepNums = self._effectSwitch.isOn and -1 or round * #self._progressPointList
	self._progressSelectId = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getProgressId()
	self._rateSelectId = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getRateId()

	settimer(0.2, self._rollProgressPoint, self)

	self._curLotteryCount = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getCurLotteryCount()

	self:_refreshInfo()
	self:_showPrize()
end

function LuckyDrawNewSkinView:_lotterySecond()
	removetimer(self._lotterySecond, self)

	local round = 2

	self._rorateStepNums = self._effectSwitch.isOn and -1 or round * #self._ratePointList

	if self._effectSwitch.isOn then
		self:_rollRatePoint()
	else
		settimer(0.2, self._rollRatePoint, self)
	end
end

function LuckyDrawNewSkinView:_lotteryThird()
	removetimer(self._lotteryThird, self)

	local mo = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId)
	local freeNum = mo:getCurFreeNum()

	self:_playEffect()

	if checknumber(freeNum) > 0 then
		local tipsContent = string.format("本次抽奖成功免单<color=#E5291EFF>%d神钻</color>，\n别忘记前往邮箱领取返还噢！", freeNum)

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, nil, "确定")
	end
end

function LuckyDrawNewSkinView:_lotteryEnd()
	removetimer(self._lotteryEnd, self)
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
	self:_clearCellList(self._progressPointList)
	self:_clearCellList(self._ratePointList)
	goutil.setActive(self._mask, false)
end

function LuckyDrawNewSkinView:_rollPoint(list)
	local lastSelectId = self._curSelectId

	if list[lastSelectId] then
		goutil.setActive(list[lastSelectId].select, false)
		list[lastSelectId].color:SetState(self._unSelectColorId)
	end

	self._rorateStepNums = self._rorateStepNums - 1
	self._curSelectId = self._curSelectId + 1

	if self._curSelectId > #list then
		self._curSelectId = 1
	end

	goutil.setActive(list[self._curSelectId].select, true)
	list[self._curSelectId].color:SetState(self._selectColorId)
end

function LuckyDrawNewSkinView:_rollProgressPoint()
	if self._rorateStepNums < 0 and self._curSelectId ~= self._progressSelectId and not self._effectSwitch.isOn then
		self._rorateStepNums = self._rorateStepNums + 1
	elseif self._rorateStepNums < 0 then
		removetimer(self._rollProgressPoint, self)
		self:_rollOver(self._progressPointList, self._progressSelectId)

		if self._effectSwitch.isOn then
			self:_lotterySecond()
		else
			settimer(1, self._lotterySecond, self, false)
		end

		return
	end

	self:_rollPoint(self._progressPointList)
end

function LuckyDrawNewSkinView:_rollRatePoint()
	if self._rorateStepNums < 0 and self._curSelectId ~= self._rateSelectId and not self._effectSwitch.isOn then
		self._rorateStepNums = self._rorateStepNums + 1
	elseif self._rorateStepNums < 0 then
		removetimer(self._rollRatePoint, self)
		self:_rollOver(self._ratePointList, self._rateSelectId)

		if self._effectSwitch.isOn then
			self:_lotteryThird()
		else
			settimer(1, self._lotteryThird, self, false)
		end

		return
	end

	self:_rollPoint(self._ratePointList)
end

function LuckyDrawNewSkinView:_rollOver(list, selectId)
	for k, v in pairs(list) do
		goutil.setActive(v.select, false)
		v.color:SetState(self._unSelectColorId)
	end

	goutil.setActive(list[selectId].effect, true)
	list[selectId].color:SetState(self._selectColorId)
end

function LuckyDrawNewSkinView:_clearCellList(list)
	for k, v in pairs(list) do
		goutil.setActive(v.select, false)
		goutil.setActive(v.effect, false)
		v.color:SetState(self._unSelectColorId)
	end
end

function LuckyDrawNewSkinView:_onClickBtnRank()
	local actCfg = LuckySkinLotteryConfig.instance:getCfgById(self._activityId)
	local isFreePlan = LuckySkinLotteryConfig.instance:isFreePlan(actCfg.pricePlan)
	local freeRankInfo = LuckyDrawNewSkinModel.instance:getFreeRankInfo(self._activityId)

	if freeRankInfo then
		if not freeRankInfo.infoList then
			local infoList = {}

			if isFreePlan then
				if #infoList > 0 then
					UIStateManager.instance:push(ViewName.LuckyDrawNewSkinLuckyRankView, self._activityId)
				else
					FloatWordMgr.instance:show("尚未有上榜名单")
				end
			else
				UIStateManager.instance:push(ViewName.LuckyDrawNewSkinRankView, self._activityId)
			end
		end
	end
end

function LuckyDrawNewSkinView:_onFreeChargeRankRes()
	self._freeRankInfo = LuckyDrawNewSkinModel.instance:getFreeRankInfo(self._activityId)

	if self._freeRankInfo then
		self._freeRankList = self._freeRankInfo.infoList or {}
	end

	self:_refreshInfo()
	self:_setRankInfo(self._activityId)
end

function LuckyDrawNewSkinView:_onClickJumpWandererPass()
	local activityId = WandererpassController.CURR_ACTIVITY_ID

	UIStateManager.instance:push(ViewName.WandererpassmainView, activityId, 2)
end

function LuckyDrawNewSkinView:_onClickQuanSelect()
	local boo = WandererpassController.instance:getCouponSelect(self._activityId)

	WandererpassController.instance:setCouponSelect(self._activityId, not boo)
	self:_updateCoupon(true)
end

return LuckyDrawNewSkinView
