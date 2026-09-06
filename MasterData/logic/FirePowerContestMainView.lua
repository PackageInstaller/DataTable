-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestMainView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestMainView", package.seeall)

local FirePowerContestMainView = class("FirePowerContestMainView", ViewComponent)
local SliderAnimKey = "20220602.FirePowerContestMainView.SliderAnim"

function FirePowerContestMainView:ctor()
	FirePowerContestMainView.super.ctor(self)
end

function FirePowerContestMainView:unbindEvents()
	FirePowerContestMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function FirePowerContestMainView:bindEvents()
	FirePowerContestMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function FirePowerContestMainView:buildUI()
	FirePowerContestMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnStart = self:getBtn("bottomright/btnStart")
	self._btnTip = self:getBtn("leftTop/txtTitle/btnTip")
	self._txtCount = self:getTxt("bottomright/count/txt")
	self._rewardScrollerRect = self:getScrollRect("bottom/reward/tableview")
	self._rewardScrollerRectTrans = self._rewardScrollerRect.gameObject:GetComponent(goutil.Type_RectTransform)
	self._rewardCell = self:getGo("bottom/reward/rewardcell")
	self._rewardContent = self:getGo("bottom/reward/tableview/viewport/content")
	self._rewardContentRectTrans = self._rewardContent:GetComponent(goutil.Type_RectTransform)
	self._sliderMask = self:getGo("bottom/reward/playerslidermask")
	self._rewardSilder = self:getSlider("bottom/reward/tableview/viewport/content/progressSlider")
	self._rewardSilderRectTrans = self._rewardSilder.gameObject:GetComponent(goutil.Type_RectTransform)
	self._txtScore = self:getTxt("bottom/txt/txtNumber")
	self._cellBtns = {}
	self._cells = {}
	self._cellEffects = {}

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._rewardSilderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 150
	self._rewardScrollerRectWidth = self._rewardScrollerRectTrans.rect.width

	self._rewardCell:SetActive(false)

	self._mainEffectGo = self:getGo("effect")
	self._tipsRoot = self:getGo("tipsRoot")
end

function FirePowerContestMainView:onExit()
	FirePowerContestMainView.super.onExit(self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterGetInfoResponse, self._updatePrizes, self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterGainPrizeResponse, self._updatePrizes, self)

	if self._cells then
		for _, cell in ipairs(self._cells) do
			goutil.destroy(cell)
		end

		self._cells = {}
	end

	if self._cellEffects then
		for container, effect in pairs(self._cellEffects) do
			self:_clearEffect(container)
		end

		self._cellEffects = {}
	end

	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end

	self:_removeMainEffect()
end

function FirePowerContestMainView:onEnter()
	FirePowerContestMainView.super.onEnter(self)
	FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterGetInfoResponse, self._updatePrizes, self)
	FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterGainPrizeResponse, self._updatePrizes, self)
	self.addGEvent(self, GlobalNotify.PM_FPCSweepRes, self._updatePrizes, self)

	self._nFirstEnter = 0

	FirePowerContestController.instance:setIsTourArenaMode(false)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_FIRE_POWER)

	self._activityType = GameEnum.ActivityType.FIRE_POWER_CONTEST
	self._activityId = FirePowerContestConfig.instance:getActId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self._activityConf = FirePowerContestConfig.instance:getGameActivityConf(self._activityId)
	self._txtTitle.text = self._activityConf.gameName

	self:_initPrizes()
	FirePowerContestAgent.instance:sendPM_GetFirePowerContestInfoReq(self._activityId)

	local isPlayed = GameUtil.getUserData(SliderAnimKey)

	self._isNeedPlaySliderAnim = not isPlayed

	self._sliderMask:SetActive(self._isNeedPlaySliderAnim)
	self:_setActivityTime()
	self:_playSliderAnimation(GameUtil.handler(self._tryJump2Prize, self))
	self:_addMainEffect()

	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function FirePowerContestMainView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function FirePowerContestMainView:_addMainEffect()
	self:_removeMainEffect()

	local eff = UIEffectManager.instance:playEffect(self, FirePowerContestConfig.instance:getEffectUrl("fx_ui_hyll_fenwen"), self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function FirePowerContestMainView:_playSliderAnimation(doneCallback)
	if self._isNeedPlaySliderAnim then
		local function onComplete()
			self._isNeedPlaySliderAnim = false

			self._sliderMask:SetActive(false)
			goutil.setActive(self._sliderMask, false)
			GameUtil.callBack(doneCallback)
		end

		GameUtil.saveUserData(SliderAnimKey, true)

		self._sequence = GameUtil.playSliderAnimation(self._rewardScrollerRect.scrollRect, onComplete)
	else
		GameUtil.callBack(doneCallback)
	end
end

function FirePowerContestMainView:_setRewardContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace

	self._contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._rewardContentRectTrans, self._contentTotalLength)
	goutil.setWidth(self._rewardSilderRectTrans, sliderLength)
end

function FirePowerContestMainView:_initPrizes()
	table.clear(self._cells)

	local posX = self._playerSliderStartOffset
	local configs = FirePowerContestConfig.instance:getGamePrizeConfs(self._activityConf)
	local count = table.nums(configs)

	self:_setRewardContentLength(count)

	self._pgValueSteps = {
		0
	}
	self._pbPercentSteps = {
		0
	}

	local percentStep = 1 / count

	for i = 1, count do
		local conf = configs[i]

		posX = posX + self._playerWidthSpace

		local go = self:_getPrizeGo(conf)

		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, 0)
		table.insert(self._cells, go)
		table.insert(self._pgValueSteps, conf.progress)

		if i == count then
			table.insert(self._pbPercentSteps, 1)
		else
			table.insert(self._pbPercentSteps, percentStep * i)
		end
	end
end

function FirePowerContestMainView:_getPrizeGo(data)
	local go = goutil.cloneAndSetParent(self._rewardCell, self._rewardContent.transform)
	local item = goutil.findChild(go, "item")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)

	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("FirePowerContestMainView__5", data.progress)

	goutil.setActive(go, true)

	return go
end

function FirePowerContestMainView:_updatePrizes()
	local remianGameCount = FirePowerContestModel.instance:getRemainGameCount(self._activityConf.times)

	self._txtCount.text = langPara("FirePowerContestMainView__3", remianGameCount, self._activityConf.times)

	local configs = FirePowerContestConfig.instance:getGamePrizeConfs(self._activityConf)
	local count = table.nums(configs)
	local model = FirePowerContestModel.instance

	self._canGainPrizeIndex = -1

	for i = 1, count do
		local cell = self._cells[i]
		local geted = goutil.findChild(cell, "geted")
		local canGet = goutil.findChild(cell, "canGet")
		local config = configs[i]

		self._cellBtns[i] = canGet

		self:_clearEffect(canGet)

		if model:isHasGainPrizeByIndex(i) then
			goutil.setActive(geted, true)
			goutil.setActive(canGet, false)
		elseif model:isCanGainPrizeByIndex(i) then
			goutil.setActive(canGet, true)
			GameUtil.asBtn(canGet):RemoveClickListener()
			GameUtil.asBtn(canGet):AddClickListener(function()
				FirePowerContestController.instance:sendGainPrize(self._activityId, config.id)
				goutil.setActive(canGet, false)
			end, self)
			self:_playEffect(canGet)

			if self._canGainPrizeIndex == -1 then
				self._canGainPrizeIndex = i
			end
		else
			goutil.setActive(canGet, false)
		end
	end

	local curScore = model:getTotalScore() or 0

	self._txtScore.text = curScore

	GameUtil.setProgress(self._rewardSilder, curScore, self._pgValueSteps, self._pbPercentSteps)
	self:_tryJump2Prize()
end

function FirePowerContestMainView:_playEffect(canGet)
	self:_clearEffect(canGet)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, canGet.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rewardScrollerRectTrans) then
			eff:setClipping(self._rewardScrollerRectTrans)
		end
	end)

	uiEffect:setParent(canGet.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects[canGet] = uiEffect
end

function FirePowerContestMainView:_clearEffect(canGet)
	if self._cellEffects[canGet] then
		UIEffectManager.instance:stopEffect(self._cellEffects[canGet])

		self._cellEffects[canGet] = nil
	end
end

function FirePowerContestMainView:_tryJump2Prize()
	if self._nFirstEnter == 0 then
		self._nFirstEnter = 1
	elseif self._nFirstEnter == 1 then
		self._nFirstEnter = 2

		self:_jump2Prize()
	end
end

function FirePowerContestMainView:_jump2Prize()
	if self._canGainPrizeIndex > 0 then
		local totalWidth = self._contentTotalLength - self._rewardScrollerRectWidth
		local endIndex = math.ceil(totalWidth / self._playerWidthSpace)
		local index = Mathf.Clamp(self._canGainPrizeIndex - 1, 0, endIndex)

		self._rewardScrollerRect.scrollRect.horizontalNormalizedPosition = (index + 0.5) / endIndex
	end
end

function FirePowerContestMainView:_setActivityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FIRE_POWER_CONTEST, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = langPara("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function FirePowerContestMainView:_onClickStart()
	if self._activityConf then
		local model = FirePowerContestModel.instance
		local remianGameCount = model:getRemainGameCount(self._activityConf.times)

		if remianGameCount > 0 then
			if model:isInMatchCD() then
				FloatWordMgr.instance:show(langPara("FirePowerContestMainView__4", model:getMatchCDSec()))
			else
				FirePowerContestController.instance:reqStartGame()
			end
		else
			FloatWordMgr.instance:show(lang("FirePowerContestMainView__1"))
		end
	end
end

function FirePowerContestMainView:_onClickTip()
	if self._activityConf then
		UIStateManager.instance:push(ViewName.RulesView, self._activityConf.rulesKey)
	end
end

function FirePowerContestMainView:_onClickDiffBtnEnter()
	local isHasPassFirst = FirePowerContestModel.instance:getGameTime() > 0

	if self._isBelongSweep and isHasPassFirst then
		local isInitInfo = YearCardModel.instance:isInitInfo()

		if not isInitInfo then
			FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

			return
		end

		local sweepResult = self:_getTrySweepGameResultAndTips(true, self._activityId, 1)

		if sweepResult == GameEnum.ResultCode.Success then
			local descTxt = "您已首通完毕，是否扫荡直接通关？"

			local function sureCallBack(view)
				self:_sweepGame(self._activityId, view:getCurTimes())
			end

			local function cancelCallBack(view)
				self:_onClickStart()
			end

			local otherCallBack
			local maxCoinNum = self._activityConf.times

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
			end

			local historyMaxScore = FirePowerContestModel.instance:getHistoryMaxScore()

			local function updateDescTxtCallBack(view)
				view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", historyMaxScore * view:getCurTimes())
			end

			local left = self:_getLeftTimes()

			TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_onClickStart()
		end
	else
		self:_onClickStart()
	end
end

function FirePowerContestMainView:_getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not DuoLaLightController.instance:isInActivityTimeAsDuoLa(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes()

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function FirePowerContestMainView:_getLeftTimes()
	local maxTime = self._activityConf.times
	local curTime = DuoLaLightModel.instance:getGameTime()
	local isFinished = maxTime <= curTime

	return isFinished and 0 or 1
end

function FirePowerContestMainView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DuoLaLightController.instance:sendPM_FPCSweepReq(activityId)
end

return FirePowerContestMainView
