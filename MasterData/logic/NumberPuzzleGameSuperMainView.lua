-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSuperMainView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSuperMainView", package.seeall)

local NumberPuzzleGameSuperMainView = class("NumberPuzzleGameSuperMainView", ViewComponent)

function NumberPuzzleGameSuperMainView:buildUI()
	NumberPuzzleGameSuperMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart")
	self._btnStart_btn = goutil.findChild(self.mainGO, "btnStart/btn")
	self._btnStart_redPoint = goutil.findChild(self.mainGO, "btnStart/btn/redPoint")
	self._btnStart_txtDesc = goutil.findChildTextComponent(self.mainGO, "btnStart/desc/txt")
	self._iconMask = goutil.findChild(self.mainGO, "info/mask/icon")
	self._btnSpeed = goutil.findChild(self.mainGO, "info/btnSpeed")
	self._redBtnSpeed = goutil.findChild(self.mainGO, "info/btnSpeed/red")
	self._txtSpeed = goutil.findChildTextComponent(self.mainGO, "info/txtSpeed")
	self._speedStrFormat = self._txtSpeed.text
	self._txtEnergy = goutil.findChildTextComponent(self.mainGO, "info/txtEnergy")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._btnGain = goutil.findChild(self.mainGO, "prizeCol/btnGain")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function NumberPuzzleGameSuperMainView:bindEvents()
	NumberPuzzleGameSuperMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart_btn, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGain, self)
	GameUtil.addClickHandler(self._btnSpeed, self._onClickBtnSpeed, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
end

function NumberPuzzleGameSuperMainView:unbindEvents()
	NumberPuzzleGameSuperMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart_btn)
	GameUtil.rmClickHandler(self._btnGain)
	GameUtil.rmClickHandler(self._btnSpeed)
	GameUtil.rmClickHandler(self._btnRank)
end

function NumberPuzzleGameSuperMainView:onEnter()
	NumberPuzzleGameSuperMainView.super.onEnter(self)

	self._activityId = NumberPuzzleGameController.instance:getActivityId()
	self._activityType = NumberPuzzleGameController.instance:getActivityType()

	local isInTime = NumberPuzzleGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = NumberPuzzleGameConfig.instance:getNpgActData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_2048InfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_2048ExtremeGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_2048OpenHangingEfficiencyRes, self._sendInfoReq, self)
	RedPointController.instance:regRedPoint(self._btnStart_redPoint, RedPointModel.ID_NUMBERPUZZLEGAMEFIRSTREDINSUPER)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_sendInfoReq()
end

function NumberPuzzleGameSuperMainView:onExit()
	NumberPuzzleGameSuperMainView.super.onExit(self)
	removetimer(self._onTicking, self)

	self._isTicking = false

	MaterialMgr.resetAll(self._iconMask)
	RedPointController.instance:unregRedPoint(self._btnStart_redPoint)
	self:_onClearPrizeCol()
end

function NumberPuzzleGameSuperMainView:_sendInfoReq()
	NumberPuzzleGameController.instance:sendPM_2048InfoReq(self._activityId)
end

function NumberPuzzleGameSuperMainView:_onTicking()
	local cur = ServerTime.nowMs()
	local leftMin = Mathf.Floor((cur - self._balanceTime) / 1000 / 60)

	self._curProgress = self._baseProgress + leftMin * self._addScoreEachMin
end

function NumberPuzzleGameSuperMainView:_onUpdate()
	self._balanceTime = NumberPuzzleGameModel.instance:getExtremeHangingBalanceTime()
	self._addScoreEachMin = NumberPuzzleGameModel.instance:getExtremeHangingEfficiency()
	self._baseProgress = NumberPuzzleGameModel.instance:getExtremeHangingScore()
	self._curProgress = self._baseProgress

	if not self._isTicking then
		self._isTicking = true

		settimer(0.5, self._onTicking, self, true)
	end

	self:_onTicking()

	local efficiency = NumberPuzzleGameModel.instance:getExtremeHangingEfficiency()

	self._txtSpeed.text = string.format(self._speedStrFormat, efficiency)

	local maxEnergy = NumberPuzzleGameConfig.instance:getNpgExtremeEnergy(self._activityId)
	local leftEnergy = NumberPuzzleGameController.instance:getLeftEnergy(self._activityId)

	self._txtEnergy.text = string.format("%s/%s", leftEnergy, maxEnergy)

	local maxGbId = NumberPuzzleGameModel.instance:getExtremeMaxGridId()
	local gbData = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(maxGbId)

	if gbData then
		self._btnStart_txtDesc.text = gbData.name or "无"
	end

	local isCanRed = false
	local stageCfg = NumberPuzzleGameConfig.instance:getNpgSupStageCfg(self._activityId)

	if stageCfg then
		local first = stageCfg[1]

		if first then
			if not first.skinId then
				local skinId = 0

				for _, stageData in ipairs(stageCfg) do
					if NumberPuzzleGameController.instance:isHasUnlock(stageData.gbId) then
						skinId = stageData.skinId
					end

					if NumberPuzzleGameController.instance:isCanUnlock(stageData.gbId) then
						isCanRed = true

						break
					end
				end

				MaterialMgr.setIcon(self._iconMask, MatType.PET_SKIN, skinId)
			end
		end
	else
		MaterialMgr.resetAll(self._iconMask)
	end

	GameUtil.SetActive(self._redBtnSpeed, isCanRed)
	self:_onUpdatePrizeCol()
end

function NumberPuzzleGameSuperMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) or self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)
	GameUtil.SetGray(self._btnGain, not self:_isHaveCanGet())

	self._prizeCol_total_txtNum.text = curProgress
end

function NumberPuzzleGameSuperMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function NumberPuzzleGameSuperMainView:_getProgressDataList()
	return NumberPuzzleGameConfig.instance:getHangingPrizeCfg(self._activityId)
end

function NumberPuzzleGameSuperMainView:_getSliderComp()
	return self._sliderComp
end

function NumberPuzzleGameSuperMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function NumberPuzzleGameSuperMainView:_getCurProgress()
	return self._curProgress
end

function NumberPuzzleGameSuperMainView:_getProgressByData(data)
	return data.needScore
end

function NumberPuzzleGameSuperMainView:_getPrizeIdByData(data)
	return data.prizeId
end

function NumberPuzzleGameSuperMainView:_getPrizeStrByData(data)
	return data.prize
end

function NumberPuzzleGameSuperMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return NumberPuzzleGameModel.instance:isHasGainPrizeExtreme(prizeId)
end

function NumberPuzzleGameSuperMainView:_isEnoughGetPrize(data)
	local cur = self:_getCurProgress()
	local need = self:_getProgressByData(data)

	return need <= cur
end

function NumberPuzzleGameSuperMainView:_isCanGetPrize(data)
	return not self:_isHasGainPrize(data) and self:_isEnoughGetPrize(data)
end

function NumberPuzzleGameSuperMainView:_isHaveCanGet()
	local isHaveCanGet = false
	local dataList = self:_getProgressDataList()

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			isHaveCanGet = true

			break
		elseif self:_isHasGainPrize(data) then
			break
		end
	end

	return isHaveCanGet
end

function NumberPuzzleGameSuperMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function NumberPuzzleGameSuperMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function NumberPuzzleGameSuperMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	NumberPuzzleGameController.instance:sendPM_2048ExtremeGainPrizeReq(self._activityId)
end

function NumberPuzzleGameSuperMainView:_onClickBtnGain()
	if not self:_isHaveCanGet() then
		FloatWordMgr.instance:show("没有可领取的奖励")

		return
	end

	NumberPuzzleGameController.instance:sendPM_2048ExtremeGainPrizeReq(self._activityId)
end

function NumberPuzzleGameSuperMainView:_onClickBtnStart()
	local key = "npgfirstsuper_" .. self._activityId

	GameUtil.saveUserData(key, 1)
	NumberPuzzleGameController.instance:updateSupperFirstRed(self._activityId)
	NumberPuzzleGameController.instance:startNumberPuzzleGameOfSup(self._activityId)
end

function NumberPuzzleGameSuperMainView:_onClickBtnTip()
	local key = NumberPuzzleGameConfig.instance:getNpgActValue(self._activityId, "ruleKey")

	TipsFacade.instance:openRulesView(key)
end

function NumberPuzzleGameSuperMainView:_onClickBtnSpeed()
	UIStateManager.instance:push(ViewName.NumberPuzzleGameSuperBuffView, self._activityId)
end

function NumberPuzzleGameSuperMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.NumberPuzzleGameSuperRankView, self._activityId)
end

return NumberPuzzleGameSuperMainView
