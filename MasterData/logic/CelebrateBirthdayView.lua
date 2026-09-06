-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/CelebrateBirthdayView.lua

module("logic.extensions.celebratebirthday.view.CelebrateBirthdayView", package.seeall)

local CelebrateBirthdayView = class("CelebrateBirthdayView", ViewComponent)

function CelebrateBirthdayView:unbindEvents()
	CelebrateBirthdayView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i, v in ipairs(self._gift) do
		v.btn:RemoveClickListener()
	end

	self._tipBtn:RemoveClickListener()
	self._closeTipBtn:RemoveClickListener()
	self._mask:RemoveClickListener()
end

function CelebrateBirthdayView:bindEvents()
	CelebrateBirthdayView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, v in ipairs(self._gift) do
		v.btn:AddClickListener(function()
			self:_onClickGift(i)
		end)
	end

	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._closeTipBtn:AddClickListener(self._onClickCloseTip, self)
	self._mask:AddClickListener(self._onClickMask, self)
end

function CelebrateBirthdayView:buildUI()
	CelebrateBirthdayView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._roleBubble = self:getGo("bubble")
	self._roleBubbleText = self:getTxt("bubble/Text")
	self._gift = {}

	for i = 1, 3 do
		self._gift[i] = {
			go = self:getGo("gift_" .. i)
		}
		self._gift[i].btn = Framework.ButtonAdapter.GetFrom(self._gift[i].go, "btn")
		self._gift[i].lock = goutil.findChild(self._gift[i].go, "lock")
	end

	self._finger = self:getGo("finger")
	self._prizeView = goutil.findChildComponent(self.mainGO, "prizeView", ComponentType.ScrollRect)
	self._viewPort = self:getGo("prizeView/ViewPort"):GetComponent(goutil.Type_RectTransform)
	self._prizeContentRect = goutil.findChildComponent(self.mainGO, "prizeView/ViewPort/Content", goutil.Type_RectTransform)
	self._prizes = {
		parent = self:getGo("prizeView/ViewPort/Content/prizes").transform
	}
	self._gridLayout = self._prizes.parent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._progressBar = goutil.findChildComponent(self.mainGO, "prizeView/ViewPort/Content/progressBar", goutil.Type_RectTransform)
	self._progressSlider = self:getGo("prizeView/ViewPort/Content/progressBar"):GetComponent(ComponentType.Slider)
	self._bar = DiscreteProgressBar.New(self._progressSlider, self._gridLayout)
	self._time = self:getTxt("time/txtTime")
	self._weekMakeMax = self:getTxt("weekMakeMax")
	self._todayMake = self:getTxt("todayMake")
	self._giftFinish = self:getGo("giftFinish")
	self._giftFinishChanged = goutil.findChildComponent(self._giftFinish, "img", ComponentType.UIImageSpriteChange)
	self._num = self:getTxt("num/value")
	self._mask = self:getBtn("mask")
	self._tipBtn = self:getBtn("btnTips")
	self._closeTipBtn = self:getBtn("closeTipBtn")
	self._tip = self:getGo("tip")
	self._tipText = self:getTxt("tip/Text")
end

function CelebrateBirthdayView:onExit()
	CelebrateBirthdayView.super.onExit(self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftGetInfo, self._PM_MakeGiftGetInfo, self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftMake, self._PM_MakeGiftMake, self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftGainPrize, self._PM_MakeGiftGainPrize, self)

	if self._canGainEffs then
		for _, v in pairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil

	removetimer(self._timer, self)
	UIEffectManager.instance:stopEffect(self._fingerEff)
end

function CelebrateBirthdayView:onEnter()
	CelebrateBirthdayView.super.onEnter(self)

	self._cfg = MakeGiftConfig.instance:getCfgById(CelebrateBirthdayModel.ACTID)
	self._makeCfg = MakeGiftConfig.instance:getMakeByPlan(self._cfg.makePlanId)
	self._dailyLimit = #self._makeCfg
	self._prizeCfg = MakeGiftConfig.instance:getPrizeByPlan(self._cfg.prizePlanId)
	self._maxMakeTimes = self._prizeCfg[#self._prizeCfg].time
	self._minGainedId = self._prizeCfg[#self._prizeCfg].id - 1

	goutil.setActive(self._finger, false)

	self._canGainEffs = {}

	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftGetInfo, self._PM_MakeGiftGetInfo, self)
	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftMake, self._PM_MakeGiftMake, self)
	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftGainPrize, self._PM_MakeGiftGainPrize, self)
	MakeGiftAgent.instance:sendPM_MakeGiftGetInfoReq(CelebrateBirthdayModel.ACTID)

	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(92, CelebrateBirthdayModel.ACTID)

	self:_timer()

	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(14001)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	settimer(1, self._timer, self, true)
	goutil.setActive(self._mask.gameObject, false)

	local ruleCo = RulesConfig.instance:getRuleCo("celebrate_birthday")

	self._tipText.text = ruleCo.rules
	self._fingerEff = self:_playEffect("common/fx_ui_zhiyin_quan_03.prefab", self._finger)
end

function CelebrateBirthdayView:_PM_MakeGiftGetInfo()
	self._gainedPrizeIds = CelebrateBirthdayModel.instance:getGainPrizeStatus()
	self._weekMakeMax.text = string.format(lang("celebrate_birthday_1"), CelebrateBirthdayModel.instance:getWeeklyTime(), self._cfg.weeklyLimit)
	self._todayMake.text = string.format(lang("celebrate_birthday_2"), CelebrateBirthdayModel.instance:getDailyTime(), self._dailyLimit)
	self._cells = {}

	GameUtil.updateCellsWithCreate(self._gridLayout, self._prizeCfg, self._updateOnePrize, self)

	local scores = {}

	for _, v in ipairs(self._prizeCfg) do
		table.insert(scores, v.time)
	end

	local x = self._bar:setValue(scores, CelebrateBirthdayModel.instance:getTotalTime())

	self._prizeContentRect.sizeDelta = Vector2.New(x + 70, 100)

	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x

	Framework.TransformUtil.SetAnchoredPos(self._prizeContentRect, 35 + (cellWidth + spacingX) * self._minGainedId, 0)
	self:_updateGift()
end

function CelebrateBirthdayView:_PM_MakeGiftGainPrize(prizeId)
	if self._canGainEffs[prizeId] then
		self._canGainEffs[prizeId].received:SetActive(true)
		UIEffectManager.instance:stopEffect(self._canGainEffs[prizeId])

		self._canGainEffs[prizeId] = nil
	end
end

function CelebrateBirthdayView:_PM_MakeGiftMake(index)
	self:_updateGift()

	self._weekMakeMax.text = string.format(lang("celebrate_birthday_1"), CelebrateBirthdayModel.instance:getWeeklyTime(), self._cfg.weeklyLimit)
	self._todayMake.text = string.format(lang("celebrate_birthday_2"), CelebrateBirthdayModel.instance:getDailyTime(), self._dailyLimit)

	local scores = {}
	local total = CelebrateBirthdayModel.instance:getTotalTime()

	for _, v in ipairs(self._prizeCfg) do
		if total >= v.time and not self._canGainEffs[v.id] and not self._gainedPrizeIds[v.id] then
			local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
			local eff = self:_playEffect(url, self._cells[v.id], 0.62)

			eff.received = goutil.findChild(self._cells[v.id], "item/received")
			self._canGainEffs[v.id] = eff

			local btn = Framework.ButtonAdapter.GetFrom(self._cells[v.id], "btn")

			btn.gameObject:SetActive(true)
			btn:AddClickListener(function()
				CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftGainPrize, CelebrateBirthdayModel.ACTID, v.id)
			end)
		end

		table.insert(scores, v.time)
	end

	self._bar:setValue(scores, total)
	goutil.setActive(self._mask.gameObject, true)

	self._animationPlayer = AnimationPlayer.play("storyconfig/animations/miya_givegift0" .. index .. ".txt", function()
		self._giftEffect = UIEffectManager.instance:playEffect(self, "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_03.prefab", nil, nil, nil, false)

		self._giftEffect:setParent(self.mainGO.transform)
		self._giftEffect:setScale(1)
		self._giftEffect:setLocalPos(0, 0, 0)
		self._giftEffect:setLocalEulerAngle(0, 0, 45)
		goutil.setActive(self._mask.gameObject, false)

		self._animationPlayer = nil
	end, nil, self, 1, true, true)
end

function CelebrateBirthdayView:_updateOnePrize(go, cfg)
	self._cells[cfg.id] = go

	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.time

	received:SetActive(self._gainedPrizeIds[cfg.id])

	local canGain = CelebrateBirthdayModel.instance:getTotalTime() >= cfg.time

	if canGain and not self._gainedPrizeIds[cfg.id] then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
		local eff = self:_playEffect(url, go, 0.62)

		eff.received = received
		self._canGainEffs[cfg.id] = eff

		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftGainPrize, CelebrateBirthdayModel.ACTID, cfg.id)
		end)

		self._minGainedId = math.min(self._minGainedId, cfg.id - 1)
	else
		btn.gameObject:SetActive(false)
	end
end

function CelebrateBirthdayView:_updateGift()
	self._num.text = CelebrateBirthdayModel.instance:getTotalTime()

	local nextGift = CelebrateBirthdayModel.instance:getTotalTime() % 3 + 1
	local weeklyTime, dailyTime = CelebrateBirthdayModel.instance:getWeeklyTime(), CelebrateBirthdayModel.instance:getDailyTime()

	for i, v in ipairs(self._gift) do
		goutil.setActive(v.go, not (weeklyTime >= self._cfg.weeklyLimit) and not (dailyTime >= self._dailyLimit))

		if nextGift < i then
			goutil.setActive(v.lock, true)
			uGuiUtil.setImageGrayState(v.go, true)
		elseif i < nextGift then
			goutil.setActive(v.lock, false)
			uGuiUtil.setImageGrayState(v.go, false)
		elseif CelebrateBirthdayModel.instance:getEarliesTime() < ServerTime.now() then
			local x, y = Framework.TransformUtil.GetAnchoredPos(v.go:GetComponent(goutil.Type_RectTransform), 0, 0)

			Framework.TransformUtil.SetAnchoredPos(self._finger:GetComponent(goutil.Type_RectTransform), x, y)
			goutil.setActive(v.lock, false)
			uGuiUtil.setImageGrayState(v.go, false)
		else
			goutil.setActive(v.lock, true)
			uGuiUtil.setImageGrayState(v.go, true)
		end
	end

	goutil.setActive(self._finger, dailyTime < self._dailyLimit and weeklyTime < self._cfg.weeklyLimit and CelebrateBirthdayModel.instance:getEarliesTime() < ServerTime.now())
	goutil.setActive(self._giftFinish, weeklyTime >= self._cfg.weeklyLimit or dailyTime >= self._dailyLimit)

	if weeklyTime >= self._cfg.weeklyLimit then
		self._giftFinishChanged:SetState(1)
	elseif dailyTime >= self._dailyLimit then
		self._giftFinishChanged:SetState(0)
	end
end

function CelebrateBirthdayView:_onClickGift(index)
	local nextGift = CelebrateBirthdayModel.instance:getTotalTime() % 3 + 1

	if nextGift < index then
		FloatWordMgr.instance:show(lang("celebrate_birthday_9"))
	elseif index < nextGift then
		FloatWordMgr.instance:show(lang("celebrate_birthday_8"))
	elseif CelebrateBirthdayModel.instance:getEarliesTime() < ServerTime.now() then
		CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftMake, CelebrateBirthdayModel.ACTID, index)
	else
		FloatWordMgr.instance:show(lang("celebrate_birthday_7"))
	end
end

function CelebrateBirthdayView:_onClickTip()
	goutil.setActive(self._tip, true)
	goutil.setActive(self._closeTipBtn.gameObject, true)
end

function CelebrateBirthdayView:_onClickCloseTip()
	goutil.setActive(self._tip, false)
	goutil.setActive(self._closeTipBtn.gameObject, false)
end

function CelebrateBirthdayView:_onClickMask()
	if CelebrateBirthdayModel.instance:getDailyTime() > self._cfg.dayTimesSkip then
		self._animationPlayer:Stop()
		goutil.setActive(self._mask.gameObject, false)
	end
end

function CelebrateBirthdayView:_timer()
	self._time.text = self._endTime - ServerTime.now() > 0 and GameUtil.FormatTimeSymbol(self._endTime - ServerTime.now()) or lang("text_activity_end")

	local totalTime = CelebrateBirthdayModel.instance:getTotalTime()

	if totalTime and totalTime < self._maxMakeTimes then
		local _time = CelebrateBirthdayModel.instance:getEarliesTime() - ServerTime.now()

		if _time >= 0 then
			self._roleBubbleText.text = string.format(lang("celebrate_birthday_6"), GameUtil.FormatTimeSymbol(_time))

			goutil.setActive(self._roleBubble, true)
		else
			local weeklyTime = CelebrateBirthdayModel.instance:getWeeklyTime()
			local dailyTime = CelebrateBirthdayModel.instance:getDailyTime()

			if weeklyTime >= self._cfg.weeklyLimit then
				goutil.setActive(self._roleBubble, false)
			elseif dailyTime >= self._dailyLimit then
				self._roleBubbleText.text = lang("celebrate_birthday_5")

				goutil.setActive(self._roleBubble, true)
			else
				self._roleBubbleText.text = lang("celebrate_birthday_10")

				goutil.setActive(self._roleBubble, true)
			end

			self:_updateGift()
		end
	else
		goutil.setActive(self._roleBubble, false)
	end
end

function CelebrateBirthdayView:_playEffect(url, parent, scale)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

return CelebrateBirthdayView
