-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FightAgainstLandlordsMainView.lua

module("logic.extensions.landlords.view.FightAgainstLandlordsMainView", package.seeall)

local FightAgainstLandlordsMainView = class("FightAgainstLandlordsMainView", ViewComponent)

function FightAgainstLandlordsMainView:buildUI()
	FightAgainstLandlordsMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._cpCol = goutil.findChild(self.mainGO, "cpColRoot/cpCol")
	self._btnCheck = goutil.findChild(self.mainGO, "cpColRoot/cpCol/btnCheck")
	self._btnHide = goutil.findChild(self.mainGO, "cpColRoot/cpCol/btnHide")
	self._btnShow = goutil.findChild(self.mainGO, "cpColRoot/cpCol/btnShow")

	local tweens = self._cpCol:GetComponents(UnityTweensType.TweenPosition)

	for i = 0, tweens.Length - 1 do
		if tweens[i].tag == 0 then
			self._tweenHide = tweens[i]
		else
			self._tweenShow = tweens[i]
		end
	end

	self._cpScrollerview = goutil.findChild(self.mainGO, "cpColRoot/cpCol/cpScrollerview")
	self._cpScrollercell = goutil.findChild(self.mainGO, "cpColRoot/cpCol/cpScrollercell")
	self._cpScrollList = ScrollerList.create(self._cpScrollerview, self._cpScrollercell, GameUtil.handler(self._updateCpCell, self), GameUtil.handler(self._clearCpCell, self))
	self._supply = goutil.findChild(self.mainGO, "supplyCol/supply")
	self._bubbleInSupply = goutil.findChild(self.mainGO, "supplyCol/bubble")
	self._txtTipsInSupply = goutil.findChildTextComponent(self.mainGO, "supplyCol/tips/txt")
	self._txtOnline = goutil.findChildTextComponent(self.mainGO, "supplyCol/txtOnline")
	self._supplyTween = self._supply:GetComponent("TweenShakeRotate")
	self._btnEnter = goutil.findChild(self.mainGO, "btnEnter")
	self._txtDescInBtnEnter = goutil.findChildTextComponent(self.mainGO, "btnEnter/desc/txt")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnReport = goutil.findChild(self.mainGO, "btnReport")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnPet = goutil.findChild(self.mainGO, "btnPet")
	self._btnLeftTime = self:getBtn("btnLeftTime")
	self._leftTimeTips = self:getGo("tips")
	self._customInput = UICustomInput.Get(self._leftTimeTips)
	self._txtLeftTime = self:getTxt("tips/txtLeftTime")
end

function FightAgainstLandlordsMainView:bindEvents()
	FightAgainstLandlordsMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	GameUtil.addClickHandler(self._btnHide, function()
		self:_onClickBtnCpCol(false)
	end, self)
	GameUtil.addClickHandler(self._btnShow, function()
		self:_onClickBtnCpCol(true)
	end, self)
	GameUtil.addClickHandler(self._btnCheck, self._onClickBtnCheck, self)
	GameUtil.addClickHandler(self._supply, self._onClickSupply, self)
	self._btnLeftTime:AddClickListener(self._onClickbtnLeftTime, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function FightAgainstLandlordsMainView:unbindEvents()
	FightAgainstLandlordsMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPet)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnCheck)
	GameUtil.rmClickHandler(self._supply)
	self._btnLeftTime:RemoveClickListener()
	self._customInput:RemoveListener()
end

function FightAgainstLandlordsMainView:onEnter()
	FightAgainstLandlordsMainView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()
	self._baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)
	self._falSupplyMgr = FightAgainstLandlordsController.instance:enterSupplyMgr(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKGetDailySuppluGainRes, self._sendSupplyInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainRes, self._sendSupplyInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyLandlordsPKSupplyCanGain, self._updateSupply, self)
	self:_onSetUI()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKInfoReq(self._activityId)
	self:_sendSupplyInfoReq()
	goutil.setActive(self._leftTimeTips, false)
end

function FightAgainstLandlordsMainView:onExit()
	FightAgainstLandlordsMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKGetDailySuppluGainRes, self._sendSupplyInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainRes, self._sendSupplyInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes, self._onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyLandlordsPKSupplyCanGain, self._updateSupply, self)
	self:_stopSupplyTimer()

	self._falSupplyMgr = FightAgainstLandlordsController.instance:exitSupplyMgr()

	self:_onClearCpColUI()
	UIEffectManager.instance:stopEffect(self._bgEff)
end

function FightAgainstLandlordsMainView:_sendSupplyInfoReq()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKGetOnlineTimeSupplyGainInfoReq(self._activityId)
end

function FightAgainstLandlordsMainView:_onSetUI()
	local activityType = FightAgainstLandlordsController.instance:getActivityType()
	local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	self:_onUpdateCpColUI()

	local list = {}
	local tab_1 = {
		id = self._baseData.prize
	}

	table.insert(list, tab_1)

	local tab_2 = {
		id = self._baseData.scoreItem
	}

	table.insert(list, tab_2)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._baseData.scoreItem)
	local dailyMatNum = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("DAILY_LAND_GAIN_SCORE"))
	local intervalMatNum = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_INTERVAL_TIME_SCORE"))
	local intervalTimeMin = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_INTERVAL_TIME"))
	local maxTimeLimitMin = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_TIME_MAX_LIMIT"))
	local count = math.floor(maxTimeLimitMin / intervalTimeMin)
	local matNum = dailyMatNum + count * intervalMatNum

	self._txtTipsInSupply.text = string.format("预计获得<color=#57D377FF>%s</color>%s", matNum, matName)

	local effParent = self.mainGO
	local pathName = "20230210/doudizhu1/fx_ui_doudizhu_jm"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function FightAgainstLandlordsMainView:_onUpdateUI()
	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)
	local totalPlayNum = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("DAILY_TIMES"))
	local leftPlayNum = FightAgainstLandlordsController.instance:getLeftPlayNum()

	self._txtDescInBtnEnter.text = string.format("次数：%s/%s", leftPlayNum, totalPlayNum)

	self:_updateSupply()
	self:_updateLeftTime()
end

function FightAgainstLandlordsMainView:_startSupplyTimer()
	settimer(0.5, self._onSupplyTicking, self)
end

function FightAgainstLandlordsMainView:_stopSupplyTimer()
	removetimer(self._onSupplyTicking, self)
end

function FightAgainstLandlordsMainView:_onSupplyTicking()
	self._onLineTimeSec = self._falSupplyMgr:getOnlineTimeSec()
	self._txtOnline.text = string.format("累计时间中：%s", GameUtil.FormatTimeSymbol(self._onLineTimeSec))
end

function FightAgainstLandlordsMainView:_updateSupply()
	self:_stopSupplyTimer()
	self:_stopSupplyGainEff()

	local timerState = self._falSupplyMgr:getTimerState()
	local isNeedBubble = false

	self._clickCallBack = nil
	self._clickFloatTips = ""

	if timerState == FalSupplyMgr.TimerState.MaxTimeLimitReached then
		self._txtOnline.text = "供给总领取时间累计达到上限"
		self._clickFloatTips = "供给总领取时间累计达到上限,无法领取补给"
	elseif timerState == FalSupplyMgr.TimerState.IntervalTimeLimitReached then
		self._txtOnline.text = "供给领取间隔时间累计达到上限"
		self._clickFloatTips = "供给领取间隔时间累计达到上限,无法领取补给"
	elseif timerState == FalSupplyMgr.TimerState.TimerRunning then
		self:_startSupplyTimer()

		self._clickFloatTips = "累计时间不足,无法领取补给"
	end

	if self._falSupplyMgr:isCanGetDailyReward() then
		self._clickFloatTips = ""

		function self._clickCallBack()
			FightAgainstLandlordsController.instance:sendPM_LandlordsPKGetDailySuppluGainReq(self._activityId)
		end

		isNeedBubble = true

		self:_startSupplyGainEff()
	elseif self._falSupplyMgr:isCanGetOlineReward() then
		self._clickFloatTips = ""

		function self._clickCallBack()
			FightAgainstLandlordsController.instance:sendPM_LandlordsPKGetOnlineTimeSupplyGainReq(self._activityId)
		end

		self:_startSupplyGainEff()
	end

	GameUtil.SetActive(self._bubbleInSupply, isNeedBubble)
end

function FightAgainstLandlordsMainView:_onClickSupply()
	FloatWordMgr.instance:show(self._clickFloatTips)
	GameUtil.callBack(self._clickCallBack)
end

function FightAgainstLandlordsMainView:_startSupplyGainEff()
	local effParent = self._supply
	local pathName = "20230210/doudizhu1/fx_ui_doudizhu_lingqu"

	self:_stopSupplyGainEff()

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._supplyGainEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	self._supplyTween:Begin()
end

function FightAgainstLandlordsMainView:_stopSupplyGainEff()
	UIEffectManager.instance:stopEffect(self._supplyGainEff)
	self._supplyTween:Stop()
end

function FightAgainstLandlordsMainView:_onUpdateCpColUI()
	return
end

function FightAgainstLandlordsMainView:_onClearCpColUI()
	self._cpScrollList:dispose()
end

function FightAgainstLandlordsMainView:_updateCpCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local imgAixin = goutil.findChild(mainGo, "aixin/img")
	local pet_1 = goutil.findChild(mainGo, "pet/pet_1")
	local pet_2 = goutil.findChild(mainGo, "pet/pet_2")
	local txtTip = goutil.findChildTextComponent(mainGo, "txtTip")
	local buffTips = ""

	for idx, buffId in ipairs(data.buffIds) do
		buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)
		buffTips = idx < #data.buffIds and buffTips .. buffData.desc .. "\n" or buffTips .. buffData.desc
	end

	txtTip.text = buffTips

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		local creepsId = checknumber(data.creepsIds[idx])

		if creepsId > 0 then
			local petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(creepsId)
			local skinId = petMo.curFaceId
			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, go)

			if proxy then
				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			end
		else
			MaterialMgr.resetAll(go)
		end
	end

	local comp = imgAixin:GetComponent("Image")

	if comp then
		comp.color = FightAgainstLandlordsController.instance:getColorByCpId(self._activityId, data.cpId)
	end
end

function FightAgainstLandlordsMainView:_clearCpCell(cell)
	local mainGo = cell.gameObject
	local pet_1 = goutil.findChild(mainGo, "pet/pet_1")
	local pet_2 = goutil.findChild(mainGo, "pet/pet_2")

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		MaterialMgr.resetAll(go)
	end
end

function FightAgainstLandlordsMainView:_onClickBtnTip()
	local key = FightAgainstLandlordsConfig.instance:getFalCommonValue("MAIN_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function FightAgainstLandlordsMainView:_onClickBtnCpCol(isToShow)
	if isToShow then
		self._tweenShow:Begin()
	else
		self._tweenHide:Begin()
	end

	GameUtil.SetActive(self._btnShow, not isToShow)
	GameUtil.SetActive(self._btnHide, isToShow)
end

function FightAgainstLandlordsMainView:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.FalGameSelectView)
end

function FightAgainstLandlordsMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.FalRankView)
end

function FightAgainstLandlordsMainView:_onClickBtnReport()
	UIStateManager.instance:push(ViewName.FalBattleReportView)
end

function FightAgainstLandlordsMainView:_onClickBtnShop()
	local jumpToStr = FightAgainstLandlordsConfig.instance:getFalCommonValue("JUMP_SHOP")

	GotoMgr.gotoByString(jumpToStr)
end

function FightAgainstLandlordsMainView:_onClickBtnPet()
	UIStateManager.instance:push(ViewName.FalPetLibraryView)
end

function FightAgainstLandlordsMainView:_onClickBtnCheck()
	UIStateManager.instance:push(ViewName.FalCpBuffView)
end

function FightAgainstLandlordsMainView:_onClickbtnLeftTime()
	goutil.setActive(self._leftTimeTips, true)
	self:_updateLeftTime()
end

function FightAgainstLandlordsMainView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._leftTimeTips, false)
	end
end

function FightAgainstLandlordsMainView:_updateLeftTime()
	local times = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("DAILY_LOSE_PRIZE_TIMES"))
	local dailyLosePrizeTimes = FightAgainstLandlordsModel.instance:getDailyLosePrizeTimes()
	local leftTime = times - dailyLosePrizeTimes

	self._txtLeftTime.text = string.format("保底奖励次数：%s/%s", leftTime, times)
end

return FightAgainstLandlordsMainView
