-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingMoonCakeMainView.lua

module("logic.extensions.makingmooncake.view.MakingMoonCakeMainView", package.seeall)

local MakingMoonCakeMainView = class("MakingMoonCakeMainView", ViewComponent)

function MakingMoonCakeMainView:unbindEvents()
	MakingMoonCakeMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._playBtn:RemoveClickListener()
	self._buyTimesBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
end

function MakingMoonCakeMainView:bindEvents()
	MakingMoonCakeMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._playBtn:AddClickListener(self._onClickStart, self)
	self._buyTimesBtn:AddClickListener(self._onClickBuyTimes, self)
	self._exchangeBtn:AddClickListener(self._onClickExchange, self)
end

function MakingMoonCakeMainView:buildUI()
	MakingMoonCakeMainView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnTip")
	self._timeText = self:getTxt("time/txtTime")
	self._roleGo = self:getGo("role/go")
	self._score = self:getTxt("score/value")
	self._prizeView = goutil.findChildComponent(self.mainGO, "prizeView", ComponentType.ScrollRect)
	self._prizeContentRect = goutil.findChildComponent(self.mainGO, "prizeView/ViewPort/Content", goutil.Type_RectTransform)
	self._prizes = {
		parent = self:getGo("prizeView/ViewPort/Content/prizes").transform
	}
	self._gridLayout = self._prizes.parent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._progressBar = goutil.findChildComponent(self.mainGO, "prizeView/ViewPort/Content/progressBar", goutil.Type_RectTransform)
	self._progressSlider = self:getSlider("prizeView/ViewPort/Content/progressBar")
	self._prizeCell = self:getGo("cell")
	self._playBtn = self:getBtn("playBtn/btnStart")
	self._playBtnTxt = self:getTxt("playBtn/btnStart/Text")
	self._waitGo = self:getGo("playBtn/btnStart/wait")
	self._waitTxt = self:getTxt("playBtn/btnStart/wait/txtTip")
	self._playImg = self:getGo("playBtn/img")
	self._playTimes = self:getTxt("playBtn/txtCurNum")
	self._buyTimesBtn = self:getBtn("playBtn/btnAdd")
	self._exchangeBtn = self:getBtn("exchangeBtn")
	self._moonCakes = {}

	for i = 1, 5 do
		self._moonCakes[i] = self:getGo("moonCake/" .. i)
	end

	self._bubble = self:getGo("bubble")
	self._bubbleText = self:getTxt("bubble/Text")
	self._weekScore = self:getTxt("weekScore/value")
	self._txtTime = self:getTxt("timeRange/txtTime")
	self._worldProgress = self:getGo("worldProgress")
end

function MakingMoonCakeMainView:onExit()
	MakingMoonCakeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeInfoRes, self._handlePM_MakingMoonCakeInfoRes, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes, self._handlePM_MakingMoonCakeReceiveCumulativePrizeRes, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes, self._handlePM_MakingMoonCakeBuyTimesRes, self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._updateTimes, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeGainRoleProgressPrizeRes, self._handlePM_MakingMoonCakeGainRoleProgressPrizeRes, self)
	removetimer(self._timer, self)
	self._thrower:onExit()

	for i = self._prizes.parent.childCount - 1, 0, -1 do
		if self._prizes[i + 1].eff then
			UIEffectManager.instance:stopEffect(self._prizes[i + 1].eff)
		end

		goutil.destroy(self._prizes.parent:GetChild(i).gameObject)
	end

	UIEffectManager.instance:stopEffect(self._viewEff)

	local roles = MakingMoonCakeModel.instance:getRoles()

	if roles then
		for i = 1, 4 do
			local item = self:getGo("worldProgress/cells/cell" .. i .. "/item")
			local root = self:getGo("worldProgress/cells/cell" .. i .. "/root")
			local btnGet = self:getGo("worldProgress/cells/cell" .. i .. "/btnGet")

			MaterialMgr.resetAll(item)
			self:_clearProgressEffect(root)
			GameUtil.rmClickHandler(btnGet)
		end
	end

	if self._prizeItemList then
		for idx, item in ipairs(self._prizeItemList) do
			MaterialMgr.resetAll(item)
		end
	end
end

function MakingMoonCakeMainView:onEnter()
	MakingMoonCakeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeInfoRes, self._handlePM_MakingMoonCakeInfoRes, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes, self._handlePM_MakingMoonCakeReceiveCumulativePrizeRes, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes, self._handlePM_MakingMoonCakeBuyTimesRes, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeGainRoleProgressPrizeRes, self._handlePM_MakingMoonCakeGainRoleProgressPrizeRes, self)
	GlobalDispatcher:addListener(ClockMgr.TickDailyRefresh, self._updateTimes, self)

	self._activityInfo = MakingMoonCakeController.instance:getActivityInfo()
	self._thrower = CatchPropsAnimCtrl.New(self._roleGo)

	self._thrower:loadSpine(MakingMoonCakeModel.instance:getRoleUrl())

	if self._activityInfo == nil then
		self:_showCloseTip()

		return
	end

	MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeInfoReq(self._activityInfo.activityId)

	local prizeCfg = MakingMoonCakeConfig.instance:getCumulativePrizeByPlanId(self._activityInfo.cumulativePrizePlanId)

	goutil.setActive(self._prizeCell, false)

	local valueStep = 1 / #prizeCfg

	self._valueStepArr = {
		0
	}
	self._progStepArr = {
		0
	}
	self._prizeItemList = {}

	for i, cfg in ipairs(prizeCfg) do
		local t = {
			go = goutil.cloneAndSetParent(self._prizeCell, self._prizes.parent)
		}

		goutil.setActive(t.go, true)

		t.item = goutil.findChild(t.go, "item/itemcell")

		MaterialMgr.setCellByCfg(cfg.prize, t.item)

		t.received = goutil.findChild(t.go, "item/received")
		t.btn = Framework.ButtonAdapter.GetFrom(t.go, "btn")
		t.num = goutil.findChildTextComponent(t.go, "txtNum")
		t.num.text = cfg.cumulativeScore
		t.needScore = cfg.cumulativeScore
		self._prizes[i] = t

		table.insert(self._valueStepArr, cfg.cumulativeScore)
		table.insert(self._progStepArr, i * valueStep)
		table.insert(self._prizeItemList, t.item)
	end

	local prizesRect = self._prizes.parent:GetComponent(goutil.Type_RectTransform)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(prizesRect)

	local lastRect = self._prizes[#self._prizes].go:GetComponent(goutil.Type_RectTransform)
	local lastX, _ = Framework.TransformUtil.GetAnchoredPos(lastRect, 0, 0)
	local prizesX, _ = Framework.TransformUtil.GetAnchoredPos(prizesRect, 0, 0)
	local width = goutil.getWidth(lastRect)

	goutil.setWidth(self._prizeContentRect, prizesX + lastX + width)

	local prizesX, _ = Framework.TransformUtil.GetAnchoredPos(prizesRect, 0, 0)
	local spacingX = self._gridLayout.cellSize.x + self._gridLayout.spacing.x

	Framework.TransformUtil.SetAnchoredPos(self._progressBar, prizesX - spacingX + self._gridLayout.cellSize.x / 2, 3)
	goutil.setWidth(self._progressBar, spacingX * #self._prizes)

	self._time = 0

	goutil.setActive(self._bubble, true)

	self._maxBubbleNum = MakingMoonCakeConfig.instance:getParamByKey("BUBBLE_RANGE")
	self._bubbleText.text = MakingMoonCakeController.instance:getText("BUBBLE_" .. math.random(1, self._maxBubbleNum))
	self._timeText.text = GameUtil.FormatTimeSymbol(self._activityInfo.endTime - ServerTime.now())

	self:_timer()
	settimer(1, self._timer, self, true)

	local path = "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_fenwei.prefab"

	self._viewEff = UIEffectManager.instance:playEffect(self, path, nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)

	self:_updateTimeRange()
	self:_playStoryOnce(self._activityInfo.storyId)
end

function MakingMoonCakeMainView:_handlePM_MakingMoonCakeInfoRes()
	local surplusTimes = MakingMoonCakeModel.instance:getSurplusTimes()

	self._playTimes.text = MakingMoonCakeController.instance:getText("TEXT_5", surplusTimes)
	self._score.text = MakingMoonCakeModel.instance:getCurCumulativeScore()
	self._receivedCumulativePrizeIds = MakingMoonCakeModel.instance:getReceivedCumulativePrizeIds()

	local firstPrizeX

	for i, t in ipairs(self._prizes) do
		goutil.setActive(t.received, self._receivedCumulativePrizeIds[i])

		if not self._receivedCumulativePrizeIds[i] and MakingMoonCakeModel.instance:getCurCumulativeScore() >= t.needScore then
			goutil.setActive(t.btn.gameObject, true)
			t.btn:AddClickListener(function()
				if self._sendGainPrize then
					return
				end

				self._sendGainPrize = t

				MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeReceiveCumulativePrizeReq(self._activityInfo.activityId, i)
			end)

			t.eff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
				eff:setParent(t.item.transform)
				eff:setScale(1)
				eff:setLocalPos()
				eff:setScrollRectClipping(self._prizeView)
			end)
		else
			goutil.setActive(t.btn.gameObject, false)
		end

		if not self._receivedCumulativePrizeIds[i] and firstPrizeX == nil then
			local prizesX, _ = Framework.TransformUtil.GetAnchoredPos(self._prizes.parent:GetComponent(goutil.Type_RectTransform), 0, 0)
			local cellX, _ = Framework.TransformUtil.GetAnchoredPos(t.go:GetComponent(goutil.Type_RectTransform), 0, 0)

			firstPrizeX = prizesX + cellX
		end
	end

	GameUtil.setProgress(self._progressSlider, MakingMoonCakeModel.instance:getCurCumulativeScore(), self._valueStepArr, self._progStepArr)

	if checknumber(GameUtil.getUserData(MakingMoonCakeConfig.FIRST_LOGIN)) == 0 then
		self._prizeView.enabled = false

		local startPos, viewWidth = Vector3.New(), goutil.getWidth(self._prizeView:GetComponent(goutil.Type_RectTransform))

		startPos.x = firstPrizeX and viewWidth < firstPrizeX and viewWidth / 2 - firstPrizeX - self._gridLayout.cellSize.x / 2 or -viewWidth / 2

		local endX = viewWidth - goutil.getWidth(self._prizeContentRect) - viewWidth / 2
		local endPos = Vector3.New(endX, 0, 0)
		local go = self._prizeContentRect.gameObject
		local duration = 5
		local fadeIn = UnityTweens.TweenPosition.Create(go, startPos, endPos, duration, UnityTweens.EaseType.linear, 0.2)
		local fadeOut = UnityTweens.TweenPosition.Create(go, endPos, startPos, duration, UnityTweens.EaseType.linear, 0)
		local tweenSeq = UnityTweens.TweenSequence.StartTween(go, fadeIn, fadeOut)

		tweenSeq:AddListener(function()
			self._prizeView.enabled = true
		end)
		GameUtil.saveUserData(MakingMoonCakeConfig.FIRST_LOGIN, 1)
	end

	goutil.setActive(self._buyTimesBtn.gameObject, surplusTimes == 0 and self._activityInfo.buyTimesPlanId > 0)

	local weekScore = MakingMoonCakeModel.instance:getWeekScore()

	self._weekScore.text = string.format("%d/%d", weekScore, self._activityInfo.weekMax)

	goutil.setActive(self._playBtnTxt.gameObject, weekScore < self._activityInfo.weekMax)
	goutil.setActive(self._waitGo, weekScore >= self._activityInfo.weekMax)
	goutil.setActive(self._playImg, weekScore < self._activityInfo.weekMax)
	goutil.setActive(self._playTimes.gameObject, weekScore < self._activityInfo.weekMax)

	local roles = MakingMoonCakeModel.instance:getRoles()

	GameUtil.SetActive(self._worldProgress, roles ~= nil)

	if roles then
		local progressNames = MakingMoonCakeConfig.instance:getProgressName()
		local progressRewards = MakingMoonCakeConfig.instance:getProgressReward(self._activityInfo.activityId)
		local prizeCfg = MakingMoonCakeConfig.instance:getRoleCfg(self._activityInfo.activityId)

		for i = 1, 4 do
			local txtName = self:getTxt("worldProgress/cells/cell" .. i .. "/txtName")
			local txtProgress = self:getTxt("worldProgress/cells/cell" .. i .. "/txtProgress")
			local txtTarget = self:getTxt("worldProgress/cells/cell" .. i .. "/txtTarget")
			local item = self:getGo("worldProgress/cells/cell" .. i .. "/item")
			local root = self:getGo("worldProgress/cells/cell" .. i .. "/root")
			local btnGet = self:getGo("worldProgress/cells/cell" .. i .. "/btnGet")
			local geted = self:getGo("worldProgress/cells/cell" .. i .. "/geted")
			local curRole = roles[i]
			local prizeStr = progressRewards[i]
			local roleId = curRole.roleId
			local targetPrizeProgress = prizeCfg[roleId].needScore
			local canGetPrize = targetPrizeProgress <= curRole.curProgress
			local hasGet = curRole.gainedPirze

			txtName.text = progressNames and progressNames[i]
			txtProgress.text = MakingMoonCakeController.instance:numberFormatChange(checknumber(curRole.curProgress))
			txtTarget.text = "/" .. MakingMoonCakeController.instance:numberFormatChange(checknumber(targetPrizeProgress))

			MaterialMgr.resetAll(item)
			MaterialMgr.setCellByCfg(prizeStr, item)
			GameUtil.SetActive(btnGet, canGetPrize and not hasGet)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, prizeCfg[i]), self)
			self:_clearProgressEffect(root)

			if canGetPrize and not hasGet then
				self:_playProgressEffect(root)
			end
		end
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function MakingMoonCakeMainView:_playProgressEffect(effGo)
	self:_clearProgressEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function MakingMoonCakeMainView:_clearProgressEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function MakingMoonCakeMainView:_handlePM_MakingMoonCakeStartGameRes()
	UIStateManager.instance:push(ViewName.MakingMoonCakeView, self._activityInfo.activityId)
end

function MakingMoonCakeMainView:_handlePM_MakingMoonCakeBuyTimesRes()
	MakingMoonCakeModel.instance:setBuyTimes(0)
	goutil.setActive(self._buyTimesBtn.gameObject, false)

	self._playTimes.text = MakingMoonCakeController.instance:getText("TEXT_5", MakingMoonCakeModel.instance:getSurplusTimes())
end

function MakingMoonCakeMainView:_handlePM_MakingMoonCakeGainRoleProgressPrizeRes()
	local roles = MakingMoonCakeModel.instance:getRoles()

	GameUtil.SetActive(self._worldProgress, roles ~= nil)

	if roles then
		local progressNames = MakingMoonCakeConfig.instance:getProgressName()
		local progressRewards = MakingMoonCakeConfig.instance:getProgressReward(self._activityInfo.activityId)
		local prizeCfg = MakingMoonCakeConfig.instance:getRoleCfg(self._activityInfo.activityId)

		for i = 1, 4 do
			local txtName = self:getTxt("worldProgress/cells/cell" .. i .. "/txtName")
			local txtProgress = self:getTxt("worldProgress/cells/cell" .. i .. "/txtProgress")
			local txtTarget = self:getTxt("worldProgress/cells/cell" .. i .. "/txtTarget")
			local item = self:getGo("worldProgress/cells/cell" .. i .. "/item")
			local root = self:getGo("worldProgress/cells/cell" .. i .. "/root")
			local btnGet = self:getGo("worldProgress/cells/cell" .. i .. "/btnGet")
			local geted = self:getGo("worldProgress/cells/cell" .. i .. "/geted")
			local curRole = roles[i]
			local prizeStr = progressRewards[i]
			local roleId = curRole.roleId
			local targetPrizeProgress = prizeCfg[roleId].needScore
			local canGetPrize = targetPrizeProgress <= curRole.curProgress
			local hasGet = curRole.gainedPirze

			txtName.text = progressNames and progressNames[i]
			txtProgress.text = MakingMoonCakeController.instance:numberFormatChange(checknumber(curRole.curProgress))
			txtTarget.text = "/" .. MakingMoonCakeController.instance:numberFormatChange(checknumber(targetPrizeProgress))

			MaterialMgr.resetAll(item)
			MaterialMgr.setCellByCfg(prizeStr, item)
			GameUtil.SetActive(btnGet, canGetPrize and not hasGet)
			GameUtil.SetActive(geted, hasGet)
			self:_clearProgressEffect(root)

			if canGetPrize and not hasGet then
				self:_playProgressEffect(root)
			end
		end
	end
end

function MakingMoonCakeMainView:_handlePM_MakingMoonCakeReceiveCumulativePrizeRes()
	goutil.setActive(self._sendGainPrize.received, true)
	self._sendGainPrize.btn:RemoveClickListener()

	if self._sendGainPrize.eff then
		UIEffectManager.instance:stopEffect(self._sendGainPrize.eff)

		self._sendGainPrize.eff = nil
	end

	self._sendGainPrize = nil
end

function MakingMoonCakeMainView:_updateTimes()
	MakingMoonCakeModel.instance:setBuyTimes(0)
	MakingMoonCakeModel.instance:setSurplusTimes(tonumber(MakingMoonCakeConfig.instance:getParamByKey("DAILY_TIMES")))
	goutil.setActive(self._buyTimesBtn.gameObject, false)

	self._playTimes.text = MakingMoonCakeController.instance:getText("TEXT_5", MakingMoonCakeModel.instance:getSurplusTimes())
end

function MakingMoonCakeMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "makingmooncakerule")
end

function MakingMoonCakeMainView:_onClickStart()
	local curTimes = MakingMoonCakeModel.instance:getSurplusTimes()
	local weekScore = MakingMoonCakeModel.instance:getWeekScore()
	local progressQPetCfg = MakingMoonCakeConfig.instance:getProgressQPetSources()

	if curTimes > 0 and weekScore <= self._activityInfo.weekMax then
		local _clientKey = math.random(0, 16384)

		if #progressQPetCfg == 0 or #progressQPetCfg == 1 then
			MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeStartGameReq(self._activityInfo.activityId, _clientKey)
		else
			UIStateManager.instance:push(ViewName.MakingMoonCakeSelectView, self._activityId)
		end
	elseif curTimes <= 0 then
		if self._activityInfo.buyTimesPlanId > 0 then
			self:_onClickBuyTimes()
		else
			FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_12"))
		end
	else
		FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_13"))
	end
end

function MakingMoonCakeMainView:_onClickBuyTimes()
	local curTimes = MakingMoonCakeModel.instance:getBuyTimes()
	local buyTimesPlan = MakingMoonCakeConfig.instance:getTimesByPlanId(self._activityInfo.buyTimesPlanId)

	if buyTimesPlan[curTimes + 1] then
		local consume = buyTimesPlan[curTimes + 1].cost
		local matType, matId, matNum = MaterialMgr.getMatParams(consume)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, MakingMoonCakeController.instance:getText("TEXT_6", matNum, MaterialMgr.getContentMatStr(consume, 26, 0, true), #buyTimesPlan, #buyTimesPlan - curTimes), function()
			MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeBuyTimesReq(self._activityInfo.activityId)
		end)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), MakingMoonCakeController.instance:getText("TEXT_7"))
	end
end

function MakingMoonCakeMainView:_onClickExchange()
	ActivityshopController.instance:openExchangeView(68, self._activityInfo.activityId)
end

function MakingMoonCakeMainView:_onClickGetPrize(data)
	MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeGainRoleProgressPrizeReq(self._activityInfo.activityId, data.roleId)
end

function MakingMoonCakeMainView:_timer()
	self._time = (self._time + 1) % 4

	goutil.setActive(self._bubble, self._time ~= 3)

	if self._time == 0 then
		self._bubbleText.text = MakingMoonCakeController.instance:getText("BUBBLE_" .. math.random(1, self._maxBubbleNum))
	end

	self._timeText.text = self._activityInfo.endTime - ServerTime.now() > 0 and GameUtil.FormatTimeSymbol(self._activityInfo.endTime - ServerTime.now()) or lang("text_activity_end")

	local weekScore = MakingMoonCakeModel.instance:getWeekScore()

	if weekScore then
		if weekScore >= self._activityInfo.weekMax then
			local _time = self._activityInfo.startTime

			while _time < ServerTime.now() do
				_time = _time + 604800
			end

			local getNextMonday = GameUtil.time2date(_time)

			self._waitTxt.text = MakingMoonCakeController.instance:getText("TEXT_11", getNextMonday.month, getNextMonday.day, 5, 0)
		else
			goutil.setActive(self._waitGo, false)
			goutil.setActive(self._playImg, true)
			goutil.setActive(self._playTimes.gameObject, true)
		end
	end
end

function MakingMoonCakeMainView:_updateTimeRange()
	if self._activityInfo and self._activityInfo.activityId then
		local activityId = self._activityInfo.activityId
		local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

		self._txtTime.text = GameUtil.getActTimeDesc(activityType, activityId)
	else
		self._txtTime.text = "活动时间："
	end
end

function MakingMoonCakeMainView:_showCloseTip()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func)
end

function MakingMoonCakeMainView:_playStoryOnce(storyId)
	local key = ViewName.MakingMoonCakeMainView .. storyId

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end

			GameUtil.saveUserData(key, 1)
		end
	end)
end

return MakingMoonCakeMainView
