-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampMainView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampMainView", package.seeall)

local FunCampMainView = class("FunCampMainView", ViewComponent)

function FunCampMainView:ctor()
	FunCampMainView.super.ctor(self)
end

function FunCampMainView:buildUI()
	FunCampMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStory = self:getBtn("btn/btnStory")
	self._btnRank = self:getBtn("btn/btnRank")
	self._btnExchange = self:getBtn("btn/btnExchange")
	self._btnPassport = self:getBtn("btn/btnPassport")
	self._btnReward = self:getBtn("btn/btnReward")
	self._btnRule = self:getBtn("txtCountdown/btnRule")
	self._btnMain = self:getBtn("btnMain")
	self._btnMain1 = self:getBtn("btnMain1")
	self._btnMain2 = self:getBtn("btnMain2")
	self._btnMain3 = self:getBtn("btnMain3")
	self._btnTip = self:getBtn("btnTip")
	self._txtBtnMain = self:getTxt("btnMain/txt")
	self._txtCountdown = self:getTxt("txtCountdown")
	self._txtTitle = self:getTxt("txtTitle")
	self._todayCountTxt = self:getTxt("todayCountTxt")
	self._rankRedPoint = self:getGo("btn/btnRank/redPoint")
	self._imgTitle = self:getGo("imgTitle"):GetComponent(ComponentType.UIImageSpriteChange)
	self.cell = self:getGo("progress/tablecell")
	self.tableview = self:getGo("progress/tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self._timeSlider = self:getSlider("progress/tableview/viewport/content/progressSlider")
	self._campClsList = {}

	for i = 1, 3 do
		local cls = FunCampMainItem.New(self:getGo("camp/camp_" .. i))

		table.insert(self._campClsList, cls)
	end

	self._customTipGo = self:getGo("featuresTip")
	self._uiCustomInputTip = UICustomInput.Get(self._customTipGo)
	self._txtTipTitle = self:getTxt("featuresTip/title/txt")
	self._txtTipDesc = self:getTxt("featuresTip/ScrollView/Viewport/Content/txtDesc")
	self._scrollRect = self:getGo("featuresTip/ScrollView"):GetComponent(ComponentType.ScrollRect)

	goutil.setActive(self._customTipGo, false)

	self._btnGift = self:getBtn("btnGift")
	self._giftTrans = self._btnGift.gameObject:GetComponent(goutil.Type_RectTransform)
	self._rdPassport = goutil.findChild(self._btnPassport.gameObject, "red")
	self._discountPassport = goutil.findChild(self._btnPassport.gameObject, "discount")
	self._bg = self:getGo("bg")
	self._redPointBtnMain = self:getGo("btnMain/red")
	self._redPointBtnStory = self:getGo("btn/btnStory/red")

	goutil.setActive(self._redPointBtnMain, false)
	goutil.setActive(self._redPointBtnStory, false)
end

function FunCampMainView:bindEvents()
	FunCampMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStory:AddClickListener(self._onClickStory, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnPassport:AddClickListener(self._onClickPassport, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnMain:AddClickListener(self._onClickMain, self)
	self._btnMain1:AddClickListener(self._onClickMain, self)
	self._btnMain2:AddClickListener(self._onClickMain, self)
	self._btnMain3:AddClickListener(self._onClickMain, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._uiCustomInputTip:AddListener(self._onClickCustomTip, self)
	self._btnGift:AddClickListener(self._onClickGift, self)
end

function FunCampMainView:unbindEvents()
	FunCampMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStory:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnPassport:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnMain:RemoveClickListener()
	self._btnMain1:RemoveClickListener()
	self._btnMain2:RemoveClickListener()
	self._btnMain3:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._uiCustomInputTip:RemoveListener()
	self._btnGift:RemoveClickListener()
end

function FunCampMainView:_initVariables()
	self._activityId = FunCampModel.instance:getActivityId()
	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._activityId)
	self._shopActivityId = self._cfgActivity.shopID
	self._groupId = self._cfgActivity.groupId
	self._maxGameTimes = self._cfgActivity.inspireGameTimes
	self._maxCfgCoinCount = self._cfgActivity.coinDonateTimes

	local cfgActivityNpc = FunCampNpcConfig.instance:getCfgById(self._activityId)

	self._maxIntrusionTimes = cfgActivityNpc.dailyTimes
end

function FunCampMainView:onEnter()
	FunCampMainView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onDateUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampChangeActivityId, self._onChangeActivityId, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampSelectCampRes, self._onSelectCampRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GainCampPrizeRes, self._onGainCampPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampShowTip, self._onClickShowTip, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	self:_initVariables()
	FunCampController.instance:playAnimEveryDay(self._cfgActivity.animPath, self._cfgActivity.storyId, self._onClickRule)
	self:_updateStage()
	self:_updateTime()
	self:_initCamp()
	self:_onSecond()
	settimer(1, self._onSecond, self)
	FunCampAgent.instance:sendPM_CB_GetInfoReq(self._activityId)

	if self._curStage == FunCampController.Inspire or self._curStage == FunCampController.Compete then
		FunCampAgent.instance:sendPM_CB_GetPlayInfoReq(self._activityId)
	end

	if self._curStage == FunCampController.Compete then
		CampScuffleAgent.instance:sendCS_ScuffleInfoReq()
	end

	RedPointController.instance:regRedPoint(self._rankRedPoint, RedPointModel.ID_FUN_CAMP_RANK)
	RedPointController.instance:regRedPoint(self._rdPassport, RedPointModel.ID_PASSPORT_CAMP_PRIZE, RedPointModel.ID_PASSPORT_CAMP_TASK)
	RedPointController.instance:regRedPoint(self._redPointBtnStory, RedPointModel.ID_FUN_CAMP_ROLE_RELATION, 242)
	self:_updatePassport()
	FunCampController.instance:markDailyRedPoint()
end

function FunCampMainView:onExit()
	FunCampMainView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onDateUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampChangeActivityId, self._onChangeActivityId, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampSelectCampRes, self._onSelectCampRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GainCampPrizeRes, self._onGainCampPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampShowTip, self._onClickShowTip, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	self.scrollList:dispose()
	removetimer(self._onSecond, self)
	RedPointController.instance:unregRedPoint(self._rankRedPoint)
	RedPointController.instance:unregRedPoint(self._rdPassport)
	RedPointController.instance:unregRedPoint(self._redPointBtnStory)
	goutil.setActive(self._customTipGo, false)
end

function FunCampMainView:_onClickClose()
	self:close()
end

function FunCampMainView:_onClickStory()
	FuncOpenController.instance:openFunc(FuncConst.ActivityStory)
	SurveyController.instance:reportBehavior(201169)
end

function FunCampMainView:_onClickRank()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_FUN_CAMP_RANK)
	UIStateManager.instance:push(ViewName.FuncampRankView)
	SurveyController.instance:reportBehavior(201170)
end

function FunCampMainView:_onClickExchange()
	FuncOpenController.instance:openFunc(FuncConst.ActivityShopExchange, GameEnum.ActivityType.FUN_CAMP_EXCHANGE, self._shopActivityId)
	SurveyController.instance:reportBehavior(201171)
end

function FunCampMainView:_onClickPassport()
	UIStateManager.instance:push(ViewName.PassportCampView)
	SurveyController.instance:reportBehavior(201172)
end

function FunCampMainView:_onClickReward()
	UIStateManager.instance:push(ViewName.FuncampRewardView)
	SurveyController.instance:reportBehavior(201173)
end

function FunCampMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.FunCampRuleView)
end

function FunCampMainView:_onClickMain()
	if not FunCampModel.instance:isRecGetInfoRes() then
		printInfo("test 未收到协议")
	end

	self:_updateStage()
	self:_clickMain()
end

function FunCampMainView:_clickMain()
	if self._curStage == FunCampController.Select then
		UIStateManager.instance:push(ViewName.FunCampSelectView)
	elseif self._curStage == FunCampController.SelectFinish then
		local curTimestamp = ServerTime.now()
		local endTimestamp = FunCampController.instance:getStageEndTimestamp(FunCampController.SelectFinish)
		local leftTime = Mathf.Max(endTimestamp - curTimestamp, 0)
		local showStr = string.format("已完成阵营选择，距离下阶段开启\n倒计时：%s", GameUtil.FormatTimeSymbol(leftTime))

		FloatWordMgr.instance:show(showStr)
	elseif self._curStage == FunCampController.Inspire then
		UIStateManager.instance:push(ViewName.FunCampInspireView)
	elseif self._curStage == FunCampController.Compete then
		UIStateManager.instance:push(ViewName.FunCampCompeteView)
	elseif self._curStage == FunCampController.Reward then
		-- block empty
	else
		FloatWordMgr.instance:show("活动结束")
	end
end

function FunCampMainView:_handleRewardStage()
	if not FunCampModel.instance:isSelectCamp() then
		FloatWordMgr.instance:show("阵营争霸-未选择阵营，无法领取奖励")

		return
	else
		local rewardMinScore = checknumber(CampGameConfig.instance:getParams("GET_PRICE_SCORE"))
		local realScore = FunCampModel.instance:getPersonScore()

		if rewardMinScore <= realScore then
			if not FunCampModel.instance:isHasGainCampPrize() then
				FunCampAgent.instance:sendPM_CB_GainCampPrizeReq(self._activityId)
			else
				FloatWordMgr.instance:show("已经获得瓜分奖励")
			end
		else
			FloatWordMgr.instance:show("阵营争霸-未达到所能领取的阵营个人积分")
		end
	end
end

function FunCampMainView:_onClickGift()
	self:_handleRewardStage()
end

function FunCampMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "funcampmainview_rule")
end

function FunCampMainView:_onClickCustomTip(hover)
	if not hover then
		goutil.setActive(self._customTipGo, false)
	end
end

function FunCampMainView:_updateStage()
	local oldStage = self._curStage
	local newStage = FunCampController.instance:getCurStage()

	self._curStage = newStage

	if (newStage == FunCampController.Inspire or newStage == FunCampController.Compete) and newStage ~= oldStage then
		FunCampAgent.instance:sendPM_CB_GetInfoReq(self._activityId)

		return
	end

	local str, index = FunCampController.instance:getBtnMainTxt(self._curStage)
	local isShowBtnMain = FunCampController.instance:isShowBtnMain(self._curStage)
	local isShowBox = FunCampModel.instance:isSelectCamp() and FunCampController.instance:isShowBox(self._curStage)
	local isCompete = self._curStage == FunCampController.Compete

	self._txtBtnMain.text = str
	self._txtTitle.text = str

	self._imgTitle:SetState(index - 1)
	goutil.setActive(self._btnRank.gameObject, isCompete)
	goutil.setActive(self._btnReward.gameObject, isCompete)
	self:_updateCountdown()
	self:_loadBgEffect()
	self:_updateBtnMainState(isShowBtnMain)
	self:_updateGiftState(isShowBox)
	self:_updateRedPointBtnMain()

	if self._curStage ~= FunCampController.Compete then
		RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_FUN_CAMP_RANK)
	end
end

function FunCampMainView:_onDateUpdate()
	self:_updateStage()
	self:_updateTime()
end

function FunCampMainView:_onGetInfoRes()
	self:_updateStage()
	self:_updateCamp()

	if FunCampModel.instance:isAutoSelectCamp() then
		local title = "分配阵营"
		local cfg = FunCampConfig.instance:getCampGroupCfg(self._groupId, FunCampModel.instance:getCampId())

		if cfg then
			if not cfg.name then
				local name = ""
				local text = string.format("目前已经过了手动选择阵营的时间，已为您自动分配到了【%s】", name)
				local func
				local btnText = "知道了"

				TipsFacade.instance:openTipWindow(title, text, func, btnText)
			end
		end
	end

	self:_setTodayItemCount()
end

function FunCampMainView:_onChangeActivityId()
	printInfo("test 活动变更 FunCampMainView:_onChangeActivityId", self._activityId)
	self:_initVariables()
	self:_updateTime()
	self:_initCamp()
	self:_updatePassport()
	FunCampAgent.instance:sendPM_CB_GetInfoReq(self._activityId)
end

function FunCampMainView:_onSelectCampRes()
	self:_updateStage()
	self:_updateCamp()
end

function FunCampMainView:_onGainCampPrizeRes()
	self:_updateStage()
end

function FunCampMainView:_onClickShowTip(title, desc, parentGo)
	if not goutil.isNil(parentGo) then
		self._txtTipTitle.text = title
		self._txtTipDesc.text = desc
		self._scrollRect.verticalNormalizedPosition = 1
		self._customTipGo.transform.position = parentGo.transform.position

		goutil.setActive(self._customTipGo, true)
	end
end

function FunCampMainView:_onGetPlayInfoRes()
	self:_updateRedPointBtnMain()
end

function FunCampMainView:_onScuffleInfoRes(isSuccess)
	if isSuccess then
		self:_updateRedPointBtnMain()
	end
end

function FunCampMainView:_updateTime()
	local cfgs = FunCampConfig.instance:getTimeProgressList()

	self.scrollList:reloadData(cfgs)
	self:_updateTimeSlider(cfgs)
end

function FunCampMainView:_updateTimeSlider(cfgs)
	local count = #cfgs
	local num = 0
	local curTimestamp = ServerTime.now()
	local intervalValue = 0
	local record1 = 1
	local record2 = 1

	self._targetIndex = 1

	for i, v in ipairs(cfgs) do
		local timestamp = GameUtil.string2time(v.time)

		if timestamp <= curTimestamp then
			num = num + 1
			record1 = timestamp
			self._targetIndex = i
		else
			record2 = timestamp - record1
			intervalValue = curTimestamp - record1
			self._targetIndex = i

			break
		end
	end

	local value = Mathf.Clamp01(num / count + 1 / count * (intervalValue / record2))

	self._timeSlider:SetValue(value)
end

function FunCampMainView:_reloadFinish()
	if self._targetIndex then
		self.scrollList:MoveCellInView(self._targetIndex - 1, true)
	end
end

function FunCampMainView:_updateCell(view, cell, data, tag)
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local spriteChange = goutil.findChild(cell, "spriteChange"):GetComponent(ComponentType.UIImageSpriteChange)
	local date = GameUtil.string2date(data.time)
	local timestamp = GameUtil.string2time(data.time)
	local curTimestamp = ServerTime.now()

	txtTime.text = string.format("%02d.%02d", date.month, date.day)
	txtDesc.text = data.desc

	spriteChange:SetState(timestamp <= curTimestamp and 1 or 0)
end

function FunCampMainView:_clearCell(cell)
	return
end

function FunCampMainView:_initCamp()
	for i, v in ipairs(self._campClsList) do
		v:initData(self._activityId, self._groupId, i)
	end

	if FunCampModel.instance:isRecGetInfoRes() then
		self:_updateCamp()
	end
end

function FunCampMainView:_updateCamp()
	for i, v in ipairs(self._campClsList) do
		local data = {}

		data.isSelectCamp = FunCampModel.instance:isSelectCamp()
		data.selectCampId = FunCampModel.instance:getCampId()
		data.campInspireValue = FunCampModel.instance:getCampInspireValue(i)
		data.personalInspireValue = FunCampModel.instance:getPersonInspireValue()
		data.personScore = FunCampModel.instance:getPersonScore()
		data.campScore = FunCampModel.instance:getCampScore(FunCampModel.PlunderDonate, i)
		data.rank = FunCampModel.instance:getCampRank(i)

		v:updateData(data)
	end
end

function FunCampMainView:_resetCamp()
	return
end

function FunCampMainView:_onSecond()
	self:_updateCountdown()
end

function FunCampMainView:_updateCountdown()
	local curTimestamp = ServerTime.now()
	local endTimestamp = FunCampController.instance:getStageEndTimestamp(self._curStage)
	local leftTime = Mathf.Max(endTimestamp - curTimestamp, 0)

	self._txtCountdown.text = string.format("阶段倒计时：%s", GameUtil.FormatTimeSymbol(leftTime))
end

function FunCampMainView:_updateBtnMainState(isShow)
	if isShow then
		if not self._btnMain.gameObject.activeSelf then
			goutil.setActive(self._btnMain.gameObject, true)
		end
	elseif self._btnMain.gameObject.activeSelf then
		goutil.setActive(self._btnMain.gameObject, false)
	end
end

function FunCampMainView:_updateGiftState(isShow)
	if isShow then
		if not self._btnGift.gameObject.activeSelf then
			goutil.setActive(self._btnGift.gameObject, true)
		end

		local x, y = self:_getBtnGiftPos()

		Framework.TransformUtil.SetAnchoredPos(self._giftTrans, x, y)
	elseif self._btnGift.gameObject.activeSelf then
		goutil.setActive(self._btnGift.gameObject, false)
	end
end

function FunCampMainView:_getBtnGiftPos()
	local campId = FunCampModel.instance:getCampId()

	if campId == 1 then
		return -204.6, -112.9
	elseif campId == 2 then
		return 137.1, 20.7
	else
		return 467.2, -104.3
	end
end

function FunCampMainView:_updatePassport()
	local passportCfg = PassportConfig.instance:getPeriodActivityCfgById(self._shopActivityId)
	local isDiscount = passportCfg and not string.nilorempty(passportCfg.discountTime) and GameUtil.checkTimeStr(passportCfg.discountTime)

	goutil.setActive(self._discountPassport, isDiscount)
end

function FunCampMainView:_loadBgEffect()
	self:_removeBgEffect()

	self._bgEffect = self._curStage == FunCampController.Compete and UIEffectManager.instance:playEffect(self, FunCampMainViewPresentor.Effect2, self._bg.transform, 0, 0, true, false) or UIEffectManager.instance:playEffect(self, FunCampMainViewPresentor.Effect1, self._bg.transform, 0, 0, true, false)

	self._bgEffect:setParent(self._bg.transform)
	self._bgEffect:setScale(1)
	self._bgEffect:setLocalPos(0, 0, 0)
end

function FunCampMainView:_removeBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function FunCampMainView:_updateRedPointBtnMain()
	goutil.setActive(self._redPointBtnMain, self:_isShowRedPointBtnMain())
end

function FunCampMainView:_isShowRedPointBtnMain()
	if self._curStage == FunCampController.Select then
		return true
	elseif self._curStage == FunCampController.SelectFinish then
		return false
	elseif self._curStage == FunCampController.Inspire then
		return self:_isShowInspireRedPoint()
	elseif self._curStage == FunCampController.Compete then
		return self:_isShowCompeteRedPoint()
	elseif self._curStage == FunCampController.Reward then
		return not FunCampModel.instance:isHasGainCampPrize()
	else
		return false
	end
end

function FunCampMainView:_isShowInspireRedPoint()
	local curGameTime = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameTime = FunCampModel.instance:getTotalMaxGameTimes(self._maxGameTimes)
	local isGameLeftTime = curGameTime < maxGameTime
	local curTime = FunCampModel.instance:getDonateTimes()
	local maxTime = FunCampModel.instance:getTotalMaxDonateTimes(self._maxCfgCoinCount)
	local isDonateLeftTime = curTime < maxTime

	return isGameLeftTime or isDonateLeftTime
end

function FunCampMainView:_isShowCompeteRedPoint()
	local curTime = FunCampModel.instance:getDonateTimes()
	local maxTime = FunCampModel.instance:getTotalMaxDonateTimes(self._maxCfgCoinCount)
	local isDonateLeftTime = curTime < maxTime
	local maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))
	local curScuffleTime = CampScuffleModel.instance:getCurGameTimes()
	local maxScuffleTime = CampScuffleModel.instance:getTotalMaxGameTimes(maxCfgGameCount)
	local isScuffleLeftTime = curScuffleTime < maxScuffleTime
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxIntrusionTimes)
	local maxBuyTime = FunCampNpcConfig.instance:getGameBuyMax()
	local isLeftTime = curGameTime < maxGameTime

	return isDonateLeftTime or isScuffleLeftTime or isLeftTime
end

function FunCampMainView:_setTodayItemCount()
	local cfg = ItemConfig.instance:getActItemCfgById(187002)
	local todayCount = FunCampModel.instance:getTodayItemCount()

	self._todayCountTxt.text = ""

	local isShow = self._curStage == FunCampController.Compete

	if isShow and cfg then
		self._todayCountTxt.text = string.format(CampGameConfig.instance:getParams("DAILY_LIMIT_TEXT"), todayCount, cfg.dailyLimit)
	end
end

return FunCampMainView
