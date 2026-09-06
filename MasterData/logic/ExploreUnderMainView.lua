-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderMainView.lua

module("logic.extensions.exploreunder.view.ExploreUnderMainView", package.seeall)

local ExploreUnderMainView = class("ExploreUnderMainView", ViewComponent)

function ExploreUnderMainView:buildUI()
	ExploreUnderMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._goActTime = self:getGo("actTime")
	self._goCurLevel = self:getGo("curLevel")
	self._posBar = self:getGo("posBar")
	self._btnContinue = self:getGo("btnContinue")
	self._btnShowPrize = self:getGo("btnShowPrize")
	self._btnDice = self:getGo("btnDice")
	self._iconCost = goutil.findChild(self._btnDice, "cost/icon")
	self._txtCost = goutil.findChildTextComponent(self._btnDice, "cost/txt")
	self._btnSpecialDice = self:getGo("btnSpecialDice")
	self._txtLeftTime = goutil.findChildTextComponent(self._btnSpecialDice, "txtTime")
	self._txtActTime = goutil.findChildTextComponent(self._goActTime, "txt")
	self._txtCurLevel = goutil.findChildTextComponent(self._goCurLevel, "txt")
	self._chessboard = self:getGo("chessboard")
	self._chesscell = self:getGo("chesscell")
	self._chessCells = {}
	self._partSaiZi = self:getGo("partSaiZi")
	self._goSaiZi_1 = goutil.findChild(self._partSaiZi, "camera/go_1")
	self._goSaiZi_2 = goutil.findChild(self._partSaiZi, "camera/go_2")
	self._faceTo = {
		Vector3.New(0, 90, 0),
		Vector3.New(-90, 0, 0),
		Vector3.New(0, 180, 0),
		Vector3.New(0, -90, 0),
		Vector3.New(90, 0, 0),
		(Vector3.New(0, 0, 0))
	}
	self._comPlayer = self:getGo("comPlayer")
end

function ExploreUnderMainView:bindEvents()
	ExploreUnderMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShowPrize, self._onClickShowPrize, self)
	GameUtil.addClickHandler(self._btnDice, self._onClickDice, self)
	GameUtil.addClickHandler(self._btnSpecialDice, self._onClickSpecialDice, self)
	GameUtil.addClickHandler(self._btnContinue, self._onClickContinue, self)
end

function ExploreUnderMainView:unbindEvents()
	ExploreUnderMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShowPrize)
	GameUtil.rmClickHandler(self._btnDice)
	GameUtil.rmClickHandler(self._btnSpecialDice)
	GameUtil.rmClickHandler(self._btnContinue)
end

function ExploreUnderMainView:onEnter()
	ExploreUnderMainView.super.onEnter(self)
	ExploreUnderModel.instance:ShowCI()
	goutil.setActive(self._goActTime, false)
	goutil.setActive(self._goCurLevel, false)
	goutil.setActive(self._chesscell, false)

	self._actTimeCfg = ExploreUnderModel.instance:getCurActTimeCfg()

	if self._actTimeCfg then
		self:refreshViewByCfg()
		ExploreUnderController.instance:getInfo()
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderInfoUpdate, self.refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderPlayDice, self._playDiceAni1, self)
	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderEventInfoChange, self._doMoveAni, self)

	self._tweenList = {}

	local path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._spine = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self._comPlayer.transform)
		eff:setScale(0.2)
		eff:setLocalPos(0, -20, 0)
		RoleObjectPool.instance:playAnimation(eff.effGo, "idle", true)
	end)
	self._mainEff = UIEffectManager.instance:playEffect(self, "20220602/liliangmijing/fx_ui_tansuoliliangjiemian.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function ExploreUnderMainView:onExit()
	ExploreUnderMainView.super.onExit(self)
	self:removeAllTimer()
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderInfoUpdate, self.refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderPlayDice, self._playDiceAni1, self)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderEventInfoChange, self._doMoveAni, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._lastPosEff then
		UIEffectManager.instance:stopEffect(self._lastPosEff)

		self._lastPosEff = nil
	end

	if self._spine then
		UIEffectManager.instance:stopEffect(self._spine)

		self._spine = nil
	end
end

function ExploreUnderMainView:refreshViewByCfg()
	self._actId = ExploreUnderModel.instance:getActId()

	if self._actId ~= self._actTimeCfg.activityId then
		ExploreUnderModel.instance:setActId(self._actTimeCfg.activityId)

		self._actId = ExploreUnderModel.instance:getActId()
	end

	self._actCfg = ExploreUnderConfig.instance:getActfg(self._actId)

	self:_refreshActTimeTxt()
	self:_playStory()
	self:_showGoldBar()
end

function ExploreUnderMainView:_playStory()
	local userDataKey = "exploreundermainview" .. self._actId
	local userData = GameUtil.getUserData(userDataKey)

	if checkint(userData) <= 0 then
		GameUtil.saveUserData(userDataKey, 1)

		if self._actCfg.storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._actCfg.storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function ExploreUnderMainView:_refreshActTimeTxt()
	local startTime = GameUtil.string2time(self._actTimeCfg.startTime)
	local endTime = GameUtil.string2time(self._actTimeCfg.endTime)

	self._txtActTime.text = langPara("%s-%s", GameUtil.formatTimeStamp("%Y.%m.%d 5:00", startTime), GameUtil.formatTimeStamp("%Y.%m.%d 5:00", endTime))

	goutil.setActive(self._goActTime, true)
end

function ExploreUnderMainView:_showGoldBar()
	local mat = self._actCfg.diceConsume
	local list = {
		{
			showAdd = false,
			id = mat,
			showAddCallBack = function()
				EnergyController.instance:openBuyView(string.splitToNumber(mat, ":")[2])
			end
		}
	}

	MainUIController.instance:showGlodBar(self._posBar, self._viewPresentor, list)

	self._costMatType, self._costMatId, self._costMatNum = MaterialMgr.getMatParams(mat)

	MaterialMgr.setIcon(self._iconCost, self._costMatType, self._costMatId)

	self._txtCost.text = langPara("*%s", self._costMatNum)
end

function ExploreUnderMainView:refreshViewByInfo()
	if ExploreUnderModel.instance:getIsNewLevel() and self._lastPosEff then
		UIEffectManager.instance:stopEffect(self._lastPosEff)

		self._lastPosEff = nil
	end

	self:refreshLevelInfo()
	self:refreshEventByInfo()
	self:buildChessBoard()
end

function ExploreUnderMainView:refreshEventByInfo()
	self._curEventState = ExploreUnderModel.instance:getCurEventState()

	goutil.setActive(self._btnContinue, self._curEventState ~= ExploreUnderEnum.EventState_Finish)
end

function ExploreUnderMainView:refreshLevelInfo()
	self._curLevel = ExploreUnderModel.instance:getCurLevel()
	self._txtCurLevel.text = ExploreUnderModel.instance:getIsAllPass() and lang("已全通") or langPara("当前第%s层", self._curLevel)

	goutil.setActive(self._goCurLevel, true)

	self._leftTotalTimes = ExploreUnderModel.instance:getTotalLeftTimes()
	self._txtLeftTime.text = self._leftTotalTimes > 0 and langPara("共剩余%s次", self._leftTotalTimes) or lang("无投掷次数")
end

function ExploreUnderMainView:buildChessBoard()
	self._curGridInfos = ExploreUnderModel.instance:getCurGridInfos()

	for k, v in pairs(self._curGridInfos) do
		local cell = self._chessCells[k]

		if cell and cell.go then
			-- block empty
		else
			cell = {
				go = goutil.cloneAndSetParent(self._chesscell, self._chessboard.transform, "chesscell" .. k)
			}
		end

		cell.icon = goutil.findChild(cell.go, "icon")
		cell.change = cell.icon:GetComponent("UIImageSpriteChange")
		cell.btnEvent = goutil.findChild(cell.go, "btnEvent")
		cell.goFirst = goutil.findChild(cell.go, "goFirst")
		cell.goEnd = goutil.findChild(cell.go, "goEnd")
		cell.pos = goutil.findChild(cell.go, "pos")
		cell.info = v

		GameUtil.rmClickHandler(cell.btnEvent)
		GameUtil.addClickHandler(cell.btnEvent, GameUtil.handler(self._onClickEvent, self, cell.info))

		if cell.info.isFirst or cell.info.isEnd then
			goutil.setActive(cell.icon, false)
			goutil.setActive(cell.goFirst, cell.info.isFirst)
			goutil.setActive(cell.goEnd, cell.info.isEnd)
		else
			goutil.setActive(cell.icon, true)
			goutil.setActive(cell.goFirst, false)
			goutil.setActive(cell.goEnd, false)
			cell.change:SetState(v.iconId)
		end

		GameUtil.setAnchoredPos(cell.go, v.posX, v.posY)
		goutil.setActive(cell.go, true)

		self._chessCells[k] = cell
	end

	self._curGridId = ExploreUnderModel.instance:getCurGridId()

	self._comPlayer.transform:SetParent(self._chessCells[self._curGridId].pos.transform)
	GameUtil.setAnchoredPos(self._comPlayer, 0, 0)
	self._comPlayer.transform:SetParent(self._chessboard.transform)
end

function ExploreUnderMainView:_onClickClose()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	self:close()
end

function ExploreUnderMainView:_onClickTip()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	UIStateManager.instance:open(ViewName.RulesView, "exploreunderrule")
end

function ExploreUnderMainView:_onClickEvent(info)
	if info.isFirst or info.isEnd then
		return
	else
		if self._isMoving then
			FloatWordMgr.instance:show(lang("动画播放中"))

			return
		end

		ExploreUnderController.instance:showDealEventView(info, true)
	end
end

function ExploreUnderMainView:_onClickShowPrize()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	UIStateManager.instance:push(ViewName.ExploreUnderPrizeView)
end

function ExploreUnderMainView:_onClickDice()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	if self._curEventState ~= ExploreUnderEnum.EventState_Finish then
		FloatWordMgr.instance:show(lang("当前存在未完成事件"))

		return
	end

	if ExploreUnderModel.instance:getIsAllPass() then
		FloatWordMgr.instance:show(lang("本期活动已全部通关"))

		return
	end

	local isTip = ExploreUnderModel.instance:getIsAutoTipToday()

	if isTip then
		local iconStr = TipsFacade.instance:getContentMatStr(string.format("%s:%s", self._costMatType, self._costMatId), 50, -10, true)
		local content = langPara("确认消耗%s*%s,投掷一次普通色子？", iconStr, self._costMatNum)

		TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, self._costMatNum, content, function()
			ExploreUnderController.instance:dice(-1)
		end, function(isOn)
			ExploreUnderModel.instance:setAutoTipToday(not isOn)
		end, lang("今日不再提示"), nil, nil)
	else
		local isEnough = MaterialModel.instance:IsEnough(self._costMatType, self._costMatId, self._costMatNum)

		if isEnough then
			ExploreUnderController.instance:dice(-1)
		else
			local costName = MaterialMgr.getMaterialsName(self._costMatType, self._costMatId)

			FloatWordMgr.instance:show(langPara("你当前拥有的[%s]不足以投掷普通色子噢", costName))
		end
	end
end

function ExploreUnderMainView:_onClickSpecialDice()
	if self._leftTotalTimes > 0 then
		if self._isMoving then
			FloatWordMgr.instance:show(lang("动画播放中"))

			return
		end

		if self._curEventState ~= ExploreUnderEnum.EventState_Finish then
			FloatWordMgr.instance:show(lang("当前存在未完成事件"))

			return
		end

		if ExploreUnderModel.instance:getIsAllPass() then
			FloatWordMgr.instance:show(lang("本期活动已全部通关"))

			return
		end

		UIStateManager.instance:push(ViewName.ExploreUnderDiceView)
	else
		FloatWordMgr.instance:show(lang("固定色子的次数已用完"))
	end
end

function ExploreUnderMainView:_onClickHideSaiZi()
	if self._isPlayDice then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	self:_resetSaiZi(self._goSaiZi_1)
	self:_resetSaiZi(self._goSaiZi_2)
	goutil.setActive(self._partSaiZi, false)
	self:_doMoveAni()
end

function ExploreUnderMainView:_onClickContinue()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	if self._curEventState ~= ExploreUnderEnum.EventState_Finish then
		local info = self._curGridInfos[ExploreUnderModel.instance:getCurGridId()]

		ExploreUnderController.instance:showDealEventView(info)
	else
		goutil.setActive(self._btnContinue, false)
	end
end

function ExploreUnderMainView:removeAllTimer()
	removetimer(self._playDiceAni2, self)
	removetimer(self._endPlayDice, self)
	removetimer(self._movePlayer, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	self:_resetSaiZi(self._goSaiZi_1)
	self:_resetSaiZi(self._goSaiZi_2)
	goutil.setActive(self._partSaiZi, false)

	self._isMoving = false
end

function ExploreUnderMainView:_resetSaiZi(go)
	local tweenBezier = go:GetComponent("TweenBezier")

	tweenBezier.enabled = false

	GameUtil.setLocalRotation(go, 0, 0, 0)
	UnityTweens.TweenRotate.StopTween(go)
	goutil.setActive(go, false)
end

function ExploreUnderMainView:_playDiceAni1()
	self._curFaceTo = self._faceTo[ExploreUnderModel.instance:getCurDiceNum()]

	if not self._curFaceTo then
		return
	end

	self._leftTotalTimes = ExploreUnderModel.instance:getTotalLeftTimes()
	self._txtLeftTime.text = self._leftTotalTimes > 0 and langPara("共剩余%s次", self._leftTotalTimes) or lang("无投掷次数")
	self._isPlayDice = true

	self:_resetSaiZi(self._goSaiZi_1)
	self:_resetSaiZi(self._goSaiZi_2)
	goutil.setActive(self._partSaiZi, true)

	if ExploreUnderModel.instance:getIsSpecialDice() then
		if not self._goSaiZi_2 then
			local goSaizi = self._goSaiZi_1

			goutil.setActive(goSaizi, true)

			goSaizi:GetComponent("TweenBezier").enabled = true
			UnityTweens.TweenRotate.StartTween(goSaizi, Vector3.zero, Vector3.New(360, 360, 0), 0.3).loopType = UnityTweens.LoopType.loop

			settimer(1, self._playDiceAni2, self, false)
		end
	end
end

function ExploreUnderMainView:_playDiceAni2()
	if ExploreUnderModel.instance:getIsSpecialDice() then
		if not self._goSaiZi_2 then
			local goSaizi = self._goSaiZi_1

			goSaizi:GetComponent("TweenBezier").enabled = false

			local tx, ty, tz = GameUtil.getLocalRotation(goSaizi)

			UnityTweens.TweenRotate.StartTween(goSaizi, Vector3.New(tx, ty, tz), self._curFaceTo, 0.5).loopType = UnityTweens.LoopType.none

			settimer(1.5, self._endPlayDice, self, false)
		end
	end
end

function ExploreUnderMainView:_endPlayDice()
	removetimer(self._playDiceAni2, self)
	ExploreUnderModel.instance:resetDiceNum()

	self._isPlayDice = false

	self:_onClickHideSaiZi()
end

function ExploreUnderMainView:_doMoveAni()
	local newGridId = ExploreUnderModel.instance:getCurGridId()

	self._stepNum = ((ExploreUnderModel.instance:getIsNewLevel() or nil) and ExploreUnderModel.instance:getCurMapEndIdId()) - self._curGridId
	self._IsMoveForward = self._stepNum > 0

	if self._IsMoveForward then
		self._stepNum = self._stepNum or -1 * self._stepNum
	end

	if self._stepNum > 0 then
		self._isMoving = true

		settimer(0.5, self._movePlayer, self)

		if self._spine then
			RoleObjectPool.instance:playAnimation(self._spine.effGo, "run", true)
		end
	else
		self:refreshEventByInfo()
	end
end

function ExploreUnderMainView:_movePlayer()
	if self._stepNum > 0 then
		self._stepNum = self._stepNum - 1

		if self._IsMoveForward then
			self._curGridId = self._curGridId + 1 or self._curGridId - 1
		end

		local pos1 = GameUtil.getPos(self._comPlayer) or Vector3.zero
		local pos2 = GameUtil.getPos(self._chessCells[self._curGridId].pos) or Vector3.zero

		GameUtil.setLocalScale(self._comPlayer, pos1.x - pos2.x > 0 and -1 or 1, 1, 1)

		local tween = self._comPlayer.transform:DOMove(self._chessCells[self._curGridId].pos.transform.position, 0.5)

		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tween)
	elseif self._stepNum == 0 then
		self._stepNum = self._stepNum - 1

		if self._tweenList then
			for i, v in ipairs(self._tweenList) do
				v:Kill()
			end

			self._tweenList = nil
		end

		if self._spine then
			RoleObjectPool.instance:playAnimation(self._spine.effGo, "idle", true)
		end

		if self._lastPosEff then
			UIEffectManager.instance:stopEffect(self._lastPosEff)

			self._lastPosEff = nil
		end

		self._lastPosEff = UIEffectManager.instance:playEffect(self, "20220602/liliangmijing/fx_ui_geziguang.prefab", nil, 0, 0, false, false, nil, function(target, eff)
			eff:setParent(self._chessCells[self._curGridId].pos.transform)
			eff:setLocalPos(0, -28, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	else
		removetimer(self._movePlayer, self)

		if ExploreUnderModel.instance:getIsNewLevel() then
			ExploreUnderModel.instance:ShowCI()
			ExploreUnderModel.instance:resetIsNewLevel()
			self:refreshViewByInfo()

			if ExploreUnderModel.instance:getIsAllPass() then
				local text = "您已完成所有地宫探索"

				TipsFacade.instance:openTipWindowNoX("温馨提示", text)
			end
		else
			self:refreshEventByInfo()

			if self._curEventState ~= ExploreUnderEnum.EventState_Finish then
				local info = self._curGridInfos[ExploreUnderModel.instance:getCurGridId()]

				ExploreUnderController.instance:showDealEventView(info)
			end
		end

		self._isMoving = false
	end
end

return ExploreUnderMainView
