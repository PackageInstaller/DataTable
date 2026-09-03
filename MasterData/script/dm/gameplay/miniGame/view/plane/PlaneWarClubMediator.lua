-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarClubMediator.lua

PlaneWarClubMediator = class("PlaneWarClubMediator", PlaneWarBaseMediator, _M)

PlaneWarClubMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local kBtnHandlers = {}

function PlaneWarClubMediator:initialize()
	super.initialize(self)
end

function PlaneWarClubMediator:dispose()
	super.dispose(self)
end

function PlaneWarClubMediator:userInject()
	return
end

function PlaneWarClubMediator:onRegister()
	super.onRegister(self)

	local view = self:getView()
	local background = cc.Sprite:create("asset/ui/miniplane/bg_miniplane_beijingtu.png")

	background:addTo(view, -1):setName("backgroundBG"):center(view:getContentSize())
end

function PlaneWarClubMediator:bindWidgets()
	return
end

function PlaneWarClubMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	self:adaptBackground(self:getView():getChildByName("backgroundBG"))
end

function PlaneWarClubMediator:enterWithData(data)
	self:setupTopInfoWidget()
	super.enterWithData(self)
	self:initData(data)
	self:initNodes()
	self:createView()
	self:rCreateGameView()
	self:createAnim()
	self:setPopPasueTip(true)

	self._playbackId = snkAudio.play("Mus_Dafeiji")

	snkAudio.setBlockIndex(self._playbackId, 0)
	self:refreshRedPoints()
	self:refreshBtnPos()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_STAGE_PAUSE, self, self.popPauseView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_GAMEOVER, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_MINIGAME_BUYTIMESANDBEGIN_SCUESS, self, self.rStartGame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_MINIGAME_RESULT_SCUESS, self, self.gameOverByServerRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHREDPOINT_SUCC, self, self.refreshRedPoints)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_MINIGAME_STOPSCENESOUND_CONFIRM, self, self.stopSceneSound)
end

function PlaneWarClubMediator:rCreateGameView()
	if not snkAudio.isPlaying(self._playbackId) then
		self._playbackId = snkAudio.play("Mus_Dafeiji")

		snkAudio.setBlockIndex(self._playbackId, 0)
	end

	snkAudio.resume(self._playbackId)
	super.rCreateGameView(self)
end

function PlaneWarClubMediator:stopSceneSound(event)
	if self._playbackId then
		snkAudio.pause(self._playbackId)
	end
end

function PlaneWarClubMediator:refreshRedPoints()
	if not self._beginBtn.redPoint then
		self._beginBtn.redPoint = RedPoint:createDefaultNode()

		self._beginBtn.redPoint:setScale(0.8)
		self._beginBtn.redPoint:addTo(self._beginBtn):posite(69, 26)
	end

	self._beginBtn.redPoint:setVisible(self._planeWarSystem:isTodayNotPlayed())
end

function PlaneWarClubMediator:dayRsetPush(event)
	if not self:getIsRunGame() then
		self:rsetTopInfoNode()
		self:rCreateGameView()
	end
end

function PlaneWarClubMediator:createAnim()
	if self._mainAnim then
		self._mainAnim:gotoAndPlay(0)

		return
	end

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local safeAreaInset = director:getOpenGLView():getSafeAreaInset()
	local offX = (winSize.width - safeAreaInset.left - safeAreaInset.right - self:getMainPanel():getContentSize().width) / 2
	local offY = (winSize.height - self:getMainPanel():getContentSize().height) / 2

	self._mainAnim = cc.MovieClip:create("main_feijitiaozhan")

	self._mainAnim:addEndCallback(function(fid)
		self._mainAnim:stop()
		self._mainAnim:removeCallback(fid)
	end)
	self._mainAnim:addTo(self._timePanel, 99):center(self._timePanel:getContentSize())

	local leftNodeAnim = self._mainAnim:getChildByName("leftnode")

	self._topNode:removeFromParent(false)
	self._topNode:addTo(leftNodeAnim):posite(-170, -45):offset(-offX, offY)

	local descAnim = self._mainAnim:getChildByName("desc")

	self._descLabel:removeFromParent(false)
	self._descLabel:addTo(descAnim):posite(-165, 45)

	local timeAnim = self._mainAnim:getChildByName("time")

	self._timesNode:removeFromParent(false)
	self._timesNode:addTo(timeAnim):posite(-172, -77)

	local btnAnim = self._mainAnim:getChildByName("btn")

	self._beginBtn:removeFromParent(false)
	self._beginBtn:addTo(btnAnim):posite(-5, -0)
	self._sweepBtn:removeFromParent(false)
	self._sweepBtn:addTo(btnAnim):posite(185, -0)

	self._beginBtn.initPos = cc.p(self._beginBtn:getPosition())
	self._sweepBtn.initPos = cc.p(self._sweepBtn:getPosition())

	local bgAnim = self._mainAnim:getChildByName("bg")

	self._backImg = cc.Sprite:create("asset/ui/miniplane/img_miniplane_board.png")

	self._backImg:addTo(bgAnim):posite(-5, -0)

	local posX, posY = 1 - offX, 1 - offY

	for i = 1, 3 do
		local btnAnim = self._mainAnim:getChildByName("btn" .. i)

		btnAnim:addEndCallback(function(fid)
			btnAnim:stop()
			btnAnim:removeCallback(fid)
		end)
	end

	local btn1Anim = self._mainAnim:getChildByName("btn1"):getChildByName("btn")

	self._rankBtn:removeFromParent(false)
	self._rankBtn:addTo(btn1Anim):posite(posX, posY)

	local btn2Anim = self._mainAnim:getChildByName("btn2"):getChildByName("btn")

	self._ruleBtn:removeFromParent(false)
	self._ruleBtn:addTo(btn2Anim):posite(posX, posY)

	local btn3Anim = self._mainAnim:getChildByName("btn3"):getChildByName("btn")

	self._rewardBtn:removeFromParent(false)
	self._rewardBtn:addTo(btn3Anim):posite(posX, posY)

	local redPointImg = RedPoint:createDefaultNode()

	redPointImg:setScale(0.8)

	local redPoint = RedPoint:new(redPointImg, self._rewardBtn, function()
		return self._planeWarSystem:hasRedPointByReward()
	end)

	redPoint:offset(-12, -8)
end

function PlaneWarClubMediator:initData(data)
	super.initData(self, data)

	self._planeWarSystem = self._miniGameSystem:getPlaneWarSystem()
	self._planeWarData = self._planeWarSystem:getClubGamePlaneData()
	self._pointData = self._planeWarData:getPoint()
	self._preHightScore = self._planeWarData:getHistoryHighScore()

	self:refreshSweepData()
end

function PlaneWarClubMediator:refreshSweepData()
	local levelNeed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MiniGame_Plane_Sweep_Level", "content")

	self._hasSweepBtn = not GameConfigs.closeClubPlaneSweep and levelNeed <= self._developSystem:getPlayerLevel() and self._planeWarData:getEverKillBoss()
end

function PlaneWarClubMediator:initNodes()
	super.initNodes(self)
	self:mapButtonHandlers(kBtnHandlers)

	self._timePanel = self:getView():getChildByFullName("timepanel")

	self._timePanel:setLocalZOrder(10)

	self._bottomNode = self:getView():getChildByFullName("bottomnode")

	self._bottomNode:setLocalZOrder(10)

	self._topNode = self:getView():getChildByFullName("topmnode")

	self._topNode:setLocalZOrder(10)

	self._topInfoNode.initPos = cc.p(self._topInfoNode:getPosition())

	GameStyle:setTabPressTextEffect(self._topNode:getChildByFullName("scorelabel2"))

	self._timesNode = self:getMainPanel():getChildByFullName("timesnode")

	self._timesNode:setLocalZOrder(10)

	self._descLabel = self:getMainPanel():getChildByFullName("desclabel")
	self._beginBtn = self:getMainPanel():getChildByFullName("beginbtn")
	self._addBtn = self._timesNode:getChildByFullName("addbtn")

	self._addBtn:addTouchEventListener(function(sender, eventType)
		self:onClickAddTimes(sender, eventType, viewType)
	end)
	self._addBtn:setTouchEnabled(true)

	self._beginBtnWidget = self:bindWidget(self._beginBtn, TwoLevelMainButton, {
		handler = bind1(self.onClickBegin, self)
	})
	self._sweepBtn = self:getMainPanel():getChildByFullName("sweepbtn")
	self._sweepBtnWidget = self:bindWidget(self._sweepBtn, TwoLevelViceButton, {
		handler = bind1(self.onClickSweep, self)
	})
	self._rankBtn = self._bottomNode:getChildByName("rankbtn")

	GameStyle:setBtnClickEffect(self._rankBtn, function(sender)
		return self:onClickRank()
	end)

	self._ruleBtn = self._bottomNode:getChildByName("rulebtn")

	GameStyle:setBtnClickEffect(self._ruleBtn, function(sender)
		return self:onClickRule()
	end)

	self._rewardBtn = self._bottomNode:getChildByName("rewardbtn")

	GameStyle:setBtnClickEffect(self._rewardBtn, function(sender)
		return self:onClickReward()
	end)
end

function PlaneWarClubMediator:refreshBtnPos()
	if not self._beginBtn.initPos then
		return
	end

	self._beginBtn:setPosition(self._beginBtn.initPos)
	self._sweepBtn:setPosition(self._sweepBtn.initPos)

	local offSetX = -70

	if self._hasSweepBtn then
		self._sweepBtn:setVisible(true)
		self._sweepBtn:offset(offSetX - 10, 0)
		self._beginBtn:offset(offSetX, 0)
	end
end

function PlaneWarClubMediator:setupTopInfoWidget()
	self._topInfoNode = self:getView():getChildByFullName("topinfo_node")

	self._topInfoNode:setLocalZOrder(1000)

	local config = {
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kGold
		},
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("MiniPlaneTitle")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(self._topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function PlaneWarClubMediator:createView()
	self._timesNode:setVisible(true)
	self:refreshTimesView()
	self:refreshRewardView()
end

function PlaneWarClubMediator:refreshTimesView()
	self._descLabel:setString(self._planeWarSystem:getGameDesc())

	local timesTitle = self._timesNode:getChildByFullName("timelabel1")

	timesTitle:setString(Strings:get("MiniPlane_UI5"))

	local timesLabel = self._timesNode:getChildByFullName("timelabel2")

	timesLabel:setString(self._planeWarData:getTimes() .. "/" .. self._planeWarData:getTimesMax())
	timesLabel:setColor(self._planeWarData:getTimes() > 0 and cc.c3b(71, 255, 101) or cc.c3b(255, 40, 40))
	self._beginBtn:setGray(self._planeWarData:getTimes() == 0)
	self._addBtn:setGray(self._planeWarData:getBuyTimes() == 0)
	self._addBtn:setVisible(self._planeWarData:getTimes() == 0)
	self:refreshSweepData()
	self:refreshBtnPos()
end

function PlaneWarClubMediator:refreshRewardView()
	local scoreLabel = self._topNode:getChildByFullName("scorelabel2")

	scoreLabel:setString(self._planeWarData:getDailyHighScore())

	local rewardParent = self._topNode:getChildByFullName("bgimg")

	rewardParent:removeAllChildren(true)

	local rewardLabel = self._topNode:getChildByFullName("rewardlabel")

	rewardLabel:setVisible(false)
end

function PlaneWarClubMediator:beginGame()
	self:offSetViewPos(true)
	self:runSleepAnim(function()
		self:runGame()
		self:setPopPasueTip(false)
	end)
end

function PlaneWarClubMediator:rsetTopInfoNode()
	self._topInfoNode:setPosition(self._topInfoNode.initPos)
	self._mainAnim:setVisible(true)
end

function PlaneWarClubMediator:offSetViewPos(isAdd)
	local factor = isAdd and 1 or -1

	self._mainAnim:setVisible(isAdd ~= true)

	local actionTime = 0.4
	local offSetY = 110

	self._topInfoNode:stopAllActions()
	self._topInfoNode:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))
end

function PlaneWarClubMediator:tryBeginGame()
	if self._planeWarData:getTimes() == 0 then
		local factor1 = self._planeWarData:getTimes() == 0
		local factor2 = self._planeWarData:getBuyTimes() == 0

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		local view = self:getInjector():getInstance("ClubGameBuyTimesView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			costData = {
				id = self._planeWarData:getBuyCostItemId(),
				amount = self._planeWarData:getCostBuyTimes(self._planeWarData:getExtraTimes() + 1)
			},
			gameType = MiniGameType.kPlaneWar
		}, nil))

		return
	end

	self._miniGameSystem:requestClubGameStart(self._planeWarData:getId(), function()
		self:refreshTimesView()
		self:beginGame()
	end)
end

function PlaneWarClubMediator:onClickRule()
	snkAudio.play("Se_Click_Open_2")

	local view = self:getInjector():getInstance("PlaneWarRuleTipView")
	local miniPlane_Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MiniPlane_Rule", "content")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, miniPlane_Rule, nil))
end

function PlaneWarClubMediator:onClickRank()
	snkAudio.play("Se_Click_Open_2")
	self._miniGameSystem:tryEnterClubGameRank(MiniGameType.kPlaneWar)
end

function PlaneWarClubMediator:onClickReward()
	snkAudio.play("Se_Click_Open_2")

	local view = self:getInjector():getInstance("PlaneWarClubGameRewardsTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function PlaneWarClubMediator:onClickBegin(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")
		self:tryBeginGame()
	end
end

function PlaneWarClubMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local clubSystem = self:getInjector():getInstance(ClubSystem)

		clubSystem:requestClubInfo(nil, function()
			local view = self:getInjector():getInstance("ClubView")

			self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil))
		end)
	end
end

function PlaneWarClubMediator:onClickAddTimes(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Open_2")

		local factor1 = self._planeWarData:getTimes() == 0
		local factor2 = self._planeWarData:getBuyTimes() == 0

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		local view = self:getInjector():getInstance("ClubGameBuyTimesView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			costData = {
				id = self._planeWarData:getBuyCostItemId(),
				amount = self._planeWarData:getCostBuyTimes(self._planeWarData:getExtraTimes() + 1)
			},
			gameType = MiniGameType.kPlaneWar
		}, nil))
	end
end

function PlaneWarClubMediator:onClickSweep(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local factor1 = self._planeWarData:getTimes() == 0
		local factor2 = self._planeWarData:getExtraTimes() >= self._planeWarData:getMaxBuyCostTimes()

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		if factor1 and not factor2 then
			local popupDelegate, outSelf = {}, self

			function popupDelegate:onContinue(dialog)
				return
			end

			function popupDelegate:onLeave(dialog)
				return
			end

			local view = outSelf:getInjector():getInstance("ClubGameBuyTimesView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 156,
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				costData = {
					id = self._planeWarData:getBuyCostItemId(),
					amount = self._planeWarData:getCostBuyTimes(self._planeWarData:getExtraTimes() + 1)
				},
				gameType = MiniGameType.kPlaneWar
			}, popupDelegate))

			return
		end

		self._miniGameSystem:getClubGameSweep(self._planeWarData:getId(), function(response)
			self:popResultView(response, true, true)
		end)
	end
end

function PlaneWarClubMediator:popPauseView(event)
	local activityId = self._data.activityId
	local config = ConfigReader:getRecordById("Activity", activityId)
	local popupDelegate, outSelf = {}, self

	function popupDelegate:onContinue(dialog)
		if outSelf:isGameOver() then
			outSelf:setPopPasueTip(true)
			outSelf:rCreateGameView()
			outSelf:rsetTopInfoNode()
			outSelf:refreshRewardView()
			snkAudio.setBlockIndex(self._playbackId, 0)

			return
		end

		outSelf:resume()
		outSelf:dispatch(Event:new(EVT_PLANEWAR_PAUSETIP_CLOSE))
	end

	function popupDelegate:onLeave(dialog)
		outSelf:setPopPasueTip(true)
		outSelf:rCreateGameView()
		outSelf:rsetTopInfoNode()
		snkAudio.setBlockIndex(self._playbackId, 0)
	end

	local data = event:getData()

	data.activityId = self._planeWarData:getId()

	local pauseView = outSelf:getInjector():getInstance("PlaneWarClubGamePauseView")

	outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, {
		maskOpacity = 156,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, popupDelegate))
end

function PlaneWarClubMediator:buyTimesScuess(event)
	self:refreshTimesView()
end

function PlaneWarClubMediator:refreshViewByResChange(event)
	self:refreshTimesView()
end

function PlaneWarClubMediator:popResultView(response, isWin, closeOffSet)
	local popupDelegate, outSelf = {}, self

	function popupDelegate:willClose(popupMediator, data)
		if data and data.rStartGame then
			-- block empty
		else
			outSelf:rCreateGameView()

			if not closeOffSet then
				outSelf:rsetTopInfoNode()
			end

			outSelf:refreshRewardView()
			snkAudio.setBlockIndex(self._playbackId, 0)
		end
	end

	local preHightScore = self._preHightScore

	if not response.data.score then
		local gameScore = 0

		if preHightScore < gameScore then
			self._preHightScore = gameScore
		end

		local var_50_1 = EVT_SHOW_POPUP
		local var_50_2 = self:getInjector():getInstance("PlaneWarClubGameResultView")
		local var_50_3 = {
			maskOpacity = 156,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}
		local var_50_4 = {
			isWin = isWin
		}

		var_50_4.rewards = response.data.reward or {}
		var_50_4.isHightScore = preHightScore < gameScore
		var_50_4.curScore = gameScore
		var_50_4.hightScore = self._planeWarData:getHistoryHighScore()

		self:dispatch(ViewEvent:new(var_50_1, var_50_2, var_50_3, var_50_4, popupDelegate))
	end
end

function PlaneWarClubMediator:gameOverByServerRefresh(event)
	local response = event:getData().response

	if response and self._gameOverParams then
		self:popResultView(response, self._gameOverParams.isWin)
	else
		self:dismiss()
	end
end

function PlaneWarClubMediator:gameOver(event)
	self:setPopPasueTip(true)

	local params = event:getData()

	self._gameOverParams = params

	self._miniGameSystem:requestClubGameFinish(self._planeWarData:getId(), params)
end

function PlaneWarClubMediator:rStartGame(event)
	self:rCreateGameView()
	self:beginGame()
end
