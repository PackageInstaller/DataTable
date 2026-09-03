-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/darts/DartsMediator.lua

DartsMediator = class("DartsMediator", DmAreaViewMediator)

DartsMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
DartsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DartsMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
DartsMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	batback_btn = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBatBack"
	},
	["main.bottomnode.rulebtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.bottomnode.rankbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRank"
	},
	["main.bottomnode.rewardbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["start_panel.times_panel.begin_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBegin"
	},
	["start_panel.times_panel.addbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAddTimes"
	}
}

function DartsMediator:initialize()
	super.initialize(self)
end

function DartsMediator:dispose()
	self:cleanActivityLastScheduler()
	self:cleanTimeScheduler()
	self:resetData()
	super.dispose(self)
end

function DartsMediator:userInject()
	return
end

function DartsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DartsMediator:bindMapEventListener()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BEGIN_SCUESS, self, self.beginSuccessEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesSuccessEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_RESULT_SCUESS, self, self.resultSuccessEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DARTS_PLAYAGAIN, self, self.restartGameEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DARTS_QUIT_SUCC, self, self.quitGameEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DARTS_BACK_SUCC, self, self.backGameEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DARTS_PASSGAME_SUCC, self, self.passGameEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_GETREWARD_SCUESS, self, self.refreshRedPoints)
end

function DartsMediator:beginSuccessEvent(event)
	self:refreshData()
	self:refreshTimesView()
	self:GameStart()
end

function DartsMediator:buyTimesSuccessEvent(event)
	self:refreshData()
	self:refreshTimesView()
end

function DartsMediator:resultSuccessEvent(event)
	self:refreshData()
	self:refreshTimesView()
end

function DartsMediator:dayRsetPush(event)
	self:refreshData()
	self:refreshTimesView()
end

function DartsMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	local director = cc.Director:getInstance()

	self.winSize = director:getWinSize()
	self.safeAreaInset = director:getOpenGLView():getSafeAreaInset()

	self:setupTopInfoWidget()
	self:initData(self._activity)
	self:refreshData()
	self:resetData()
	self:initNodes()
	self:bindMapEventListener()
	self:refreshRedPoints()
	self:refreshTimesView()
	self:showFirstRule()
	self:setupView()
	AudioEngine:getInstance():playBackgroundMusic("Se_Effect_Dwtx_Air")
end

function DartsMediator:setupView()
	local key = self._developSystem:getPlayer():getRid() .. self._activity:getId() .. "enterTime"
	local curTime = self._gameServerAgent:remoteTimestamp()

	cc.UserDefault:getInstance():setIntegerForKey(key, curTime)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
end

function DartsMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._mainPlayPanel = self:getView():getChildByFullName("main_play")
	self._playTouchPanel = self:getView():getChildByFullName("main_play.Panel_playtouch")

	self._mainPlayPanel:setVisible(false)

	self._startpanel = self:getView():getChildByFullName("start_panel")

	self._startpanel:setVisible(true)
	self:createStartAnim()

	self._batBackBtn = self:getView():getChildByFullName("batback_btn")

	self._batBackBtn:setVisible(false)

	self._dartshot = self._mainPlayPanel:getChildByFullName("Image_kouhong")
	self._target = self._mainPlayPanel:getChildByFullName("Image_target")
	self._targetBottom = self._mainPlayPanel:getChildByFullName("Image_target_bottom")
	self._bottomnodeDartsNumnode = self._mainPlayPanel:getChildByFullName("bottomnode_dartsnum")
	self._bottomnode = self:getView():getChildByFullName("main.bottomnode")

	self._bottomnode:setVisible(true)

	self._activityLastlabel = self:getView():getChildByFullName("start_panel.Text_activity_last")
	self._lastTimelabel = self:getView():getChildByFullName("main_play.topmidnode_time.Text_last_time")
	self._curlevellabel = self:getView():getChildByFullName("main_play.topmidnode_time.Text_curlevel")
	self._showTextlevel = self:getView():getChildByFullName("main_play.Text_Pass_Level")
	self._ruleBtn = self:getView():getChildByFullName("main.bottomnode.rulebtn")
	self._rankBtn = self:getView():getChildByFullName("main.bottomnode.rankbtn")
	self._rewardBtn = self:getView():getChildByFullName("main.bottomnode.rewardbtn")
	self._curScoreLabel = self:getView():getChildByFullName("main_play.topnode_reward.Text_curscore")

	self:setButtonNameStyle(self._curScoreLabel)

	self._panelRewardPos = self:getView():getChildByFullName("main_play.topnode_reward.Panel_reward_pos")
	self._diamondNumLabel = self:getView():getChildByFullName("main_play.topnode_reward.Text_get_diamon")
	self._goldNumLabel = self:getView():getChildByFullName("main_play.topnode_reward.Text_get_gold")
	self._rewardNumLabel = self:getView():getChildByFullName("main_play.topnode_reward.Text_get_reward")
	self._clickShowImage = self:getView():getChildByFullName("main_play.bottommidnode.Text_324")

	self._diamondNumLabel:setString(self._diamondNum)
	self._goldNumLabel:setString(self._goldNum)
	self._rewardNumLabel:setString(self._heroPieceNum)

	local iconsimple = IconFactory:createIcon({
		id = self._rewardHeroPieceId
	}, {
		isWidget = true
	})

	iconsimple:setAnchorPoint(cc.p(0.5, 0.5))
	iconsimple:setScale(0.2)
	iconsimple:addTo(self._panelRewardPos):center(self._panelRewardPos:getContentSize()):offset(-10, -5)

	self._panelGuangPos = self:getView():getChildByFullName("main_play.Panel_guang_pos")

	self._playTouchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:touchShot(sender, eventType)
		end
	end)

	self._dartswidth = self._dartshot:getContentSize().width
	self._dartsheight = self._dartshot:getContentSize().height
	self._targetwidth = self._targetBottom:getContentSize().width
	self._targetheight = self._targetBottom:getContentSize().height
	self._timeNode = self._startpanel:getChildByName("timeNode")

	local text = self._timeNode:getChildByName("time")
	local startDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getStartTime() / 1000)
	local endDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getEndTime() / 1000)

	text:setString(startDate .. "-" .. endDate)
end

function DartsMediator:initTimesPanel(panel)
	self._limitRewardLable = panel:getChildByFullName("limitRewardLable")

	self._limitRewardLable:setString(Strings:get("Activity_Darts_Reward_Limit"))

	self._gameTimesLabel = panel:getChildByFullName("Text_times")
	self._beginBtn = panel:getChildByName("begin_btn")
	self._addTimesBtn = panel:getChildByName("addbtn")
end

function DartsMediator:createStartAnim()
	local anim = cc.MovieClip:create("begin_dongwentexun")

	anim:addTo(self._startpanel):posite(self._startpanel:getContentSize().width / 2, self._startpanel:getContentSize().height / 2)
	anim:setVisible(true)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)

	local node = anim:getChildByName("node_begin")

	if node then
		local ss = self._startpanel:getChildByFullName("times_panel")

		ss:changeParent(node):posite(-150, 0)
		self:initTimesPanel(ss)
	end

	local node = anim:getChildByName("node_dec")

	if node then
		local text = self._startpanel:getChildByFullName("Text_StartText")

		text:setPositionX(-105)
		text:setPositionY(20)
		text:changeParent(node)
		text:setString(Strings:get("Activity_Darts_Describe"))
	end

	anim:gotoAndPlay(1)
	AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Logo", false)
	anim:addCallbackAtFrame(15, function()
		local scriptNames = "ministory_2a"
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:setSkipCheckSave(false)

		local guideSaved = storyAgent:isSaved(scriptNames)

		if not guideSaved then
			storyAgent:trigger(scriptNames)
		end
	end)
end

function DartsMediator:closeBgSound()
	if self._bgSoundEffectId then
		AudioEngine:getInstance():stopEffect(self._bgSoundEffectId)

		self._bgSoundEffectId = nil
	end
end

function DartsMediator:updateRotationTimeScheduler()
	local index = 1

	local function update(dt)
		local pertime = self._gameDuration

		self._gameDuration = self._gameDuration - dt

		if self._gameDuration < 0 then
			self:TimeOver()

			return
		end

		if math.floor(pertime) ~= math.floor(self._gameDuration) then
			local timeStr = TimeUtil:formatTime("${MM}:${SS}", math.floor(self._gameDuration))

			self._lastTimelabel:setString(timeStr)
		end

		self._gameStartTime = self._gameStartTime + dt

		if self._gameStartTime > self._reverPoint2 then
			self._gameStartTime = self._gameStartTime - self._reverPoint2
			index = 1
		end

		local directionPer = self._direction * 100

		if self._intervalTable[index] and self._intervalTable[index] < self._gameStartTime then
			if directionPer > math.random(0, 100) then
				self._gameState = "turnaround"
				self.reduce = -(self.trueSpeed / (self._accelerateTime / 2 / dt))
				self._falgHuizuanTime = self._accelerateTime
				self._maxSpeed = self.trueSpeed
			end

			index = index + 1
		end

		if self._gameState == "turnaround" then
			self._falgHuizuanTime = self._falgHuizuanTime - dt

			if self._falgHuizuanTime > 0 then
				self.trueSpeed = self.trueSpeed + self.reduce

				if math.abs(self.trueSpeed) > math.abs(self._maxSpeed) then
					self.trueSpeed = self.trueSpeed > 0 and math.abs(self._maxSpeed) or -math.abs(self._maxSpeed)
					self._gameState = "normal"
				end
			else
				self.trueSpeed = self.trueSpeed > 0 and math.abs(self._maxSpeed) or -math.abs(self._maxSpeed)
				self._gameState = "normal"
			end
		end

		local r = self.trueSpeed * 360 * dt

		self._targetBottom:setRotation(self._targetBottom:getRotation() + r)
		self._target:setRotation(self._target:getRotation() + r)
	end

	if self._timeSchedulerRotation == nil then
		self._timeSchedulerRotation = LuaScheduler:getInstance():schedule(function(task, dt)
			update(dt)
		end, 0, true)
	end
end

function DartsMediator:startRotation()
	self:initCurLevelData()

	local function callback()
		local blink = cc.Blink:create(3, 3)
		local action = cc.RepeatForever:create(blink)

		self._clickShowImage:runAction(action)
		self._clickShowImage:setVisible(true)
		self._batBackBtn:setTouchEnabled(true)
		self._playTouchPanel:setTouchEnabled(true)
		self:updateRotationTimeScheduler()
	end

	self._clickShowImage:setVisible(false)
	self:showLevelText(self._curLevel, callback)
end

function DartsMediator:getFirstOpenDarts()
	local key = self._developSystem:getPlayer():getRid() .. self._activityId

	if not cc.UserDefault:getInstance():getBoolForKey(key) then
		cc.UserDefault:getInstance():setBoolForKey(key, true)

		return true
	end

	return false
end

function DartsMediator:refreshRedPoints()
	if not self._rewardBtn.redPoint then
		self._rewardBtn.redPoint = RedPoint:createDefaultNode()

		self._rewardBtn.redPoint:setScale(0.8)
		self._rewardBtn.redPoint:addTo(self._rewardBtn):posite(60, 70)
	end

	self._rewardBtn.redPoint:setVisible(self._activity:hasTaskReward())
end

function DartsMediator:refreshTimesView()
	if self._dartsSystem:isGetRewardLimit() then
		self._limitRewardLable:setVisible(true)
	else
		self._limitRewardLable:setVisible(false)
	end

	self._gameTimesLabel:setString(Strings:get("Activity_Darts_Residualtimes") .. tostring(self._activity:getGameTimes()))
	self._addTimesBtn:setGray(self._activity:getBuyTimes() == self._dartsSystem:getCostBuyMaxTimes())
	self._addTimesBtn:setVisible(self._activity:getGameTimes() == 0)
	self:refreshRedPoints()
end

function DartsMediator:setupTopInfoWidget()
	self._topInfoNode = self:getView():getChildByFullName("topinfo_node")

	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(self._topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function DartsMediator:GameStart(beginStage)
	self._showResult = false

	self:resetData()
	self:refreshPlayView()
	self:startRotation()
	self:updateInteractTimeScheduler()
end

function DartsMediator:sendResult()
	local rewardsData = {
		{
			id = CurrencyIdKind.kGold,
			num = self._goldNum
		},
		{
			id = CurrencyIdKind.kDiamond,
			num = self._diamondNum
		},
		{
			id = self._rewardHeroPieceId,
			num = self._heroPieceNum
		}
	}
	local preHightScore = self._activity:getHighestScore()
	local data = {
		isWin = true,
		modelId = "Model_YFZZhu",
		stage = 0,
		rewards = rewardsData,
		score = self._curScore,
		highscore = preHightScore,
		todaytimes = self._activity:getGameTimes(),
		totaltimes = self._dartsSystem:getMaxTimes(),
		isHightScore = preHightScore < self._curScore,
		gameType = MiniGameType.kDarts,
		buytimes = self._activity:getBuyTimes(),
		buymaxtimes = self._dartsSystem:getCostBuyMaxTimes(),
		eachbuynum = self._dartsSystem:getEachBuyNum(),
		costid = self._dartsSystem:getBuyCostItemId(),
		amountlist = self._dartsSystem:getCostAmountList(),
		isGetRewardLimit = self._dartsSystem:isGetRewardLimit(),
		event = EVT_DARTS_PLAYAGAIN,
		activityId = self._activityId
	}
	local goldAmount, dimondAmount, fragAmount = 0, 0, 0

	for i, v in pairs(self._curRewardList) do
		local rewardConfig = ConfigReader:getRecordById("Reward", v)

		if rewardConfig then
			local reward = rewardConfig.Content[1]
			local rewardType = reward.code
			local rewardAmount = reward.amount

			if rewardType == CurrencyIdKind.kGold then
				goldAmount = goldAmount + rewardAmount
			elseif rewardType == CurrencyIdKind.kDiamond then
				dimondAmount = dimondAmount + rewardAmount
			elseif rewardType == self._rewardHeroPieceId then
				fragAmount = fragAmount + rewardAmount
			end
		end
	end

	local serviceData = {
		count = self._curScore / self._perScore,
		rewards = {
			{
				type = 2,
				code = CurrencyIdKind.kGold,
				amount = goldAmount
			},
			{
				type = 2,
				code = CurrencyIdKind.kDiamond,
				amount = dimondAmount
			},
			{
				type = 2,
				code = self._rewardHeroPieceId,
				amount = fragAmount
			}
		},
		round = self._curLevel
	}
	local doActivityType = 103

	self._miniGameSystem:requestActivityGameResult(self._activity:getId(), serviceData, function(response)
		if response.resCode == GS_SUCCESS then
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data and data.ignoreRefresh and data.ignoreRefresh == true then
					-- block empty
				else
					outSelf:refreshStartView()
				end
			end

			data.rewards = response.data.rewards
			data.highscore = self._activity:getHighestScore()

			local view = self:getInjector():getInstance("MiniGameResultView")

			self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {}, data, delegate))
		else
			if response.resCode == 13315 then
				local data = {
					title = Strings:get("Activity_Darts_Abn_1"),
					title1 = Strings:get("Activity_Darts_Abn_2"),
					content = Strings:get("Activity_Darts_Abn_3"),
					sureBtn = {}
				}
				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			end

			self:refreshStartView()
		end
	end, doActivityType)
end

function DartsMediator:refreshStartView()
	if self._timeSchedulerRotation then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerRotation)

		self._timeSchedulerRotation = nil
	end

	if self._timeSchedulerInteract then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

		self._timeSchedulerInteract = nil
	end

	self._batBackBtn:setVisible(false)
	self._batBackBtn:setTouchEnabled(false)
	self._playTouchPanel:setTouchEnabled(false)
	self._startpanel:setVisible(true)
	self._topInfoNode:setVisible(true)
	self._bottomnode:setVisible(true)
	self._mainPlayPanel:setVisible(false)
end

function DartsMediator:refreshPlayView()
	self._bottomnode:setVisible(false)
	self._startpanel:setVisible(false)
	self._topInfoNode:setVisible(false)
	self._batBackBtn:setVisible(true)
	self._mainPlayPanel:setVisible(true)
	self._diamondNumLabel:setString(self._diamondNum)
	self._goldNumLabel:setString(self._goldNum)
	self._rewardNumLabel:setString(self._heroPieceNum)
end

function DartsMediator:cleanTimeScheduler()
	if self._timeSchedulerRotation then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerRotation)

		self._timeSchedulerRotation = nil
	end

	if self._timeSchedulerInteract then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

		self._timeSchedulerInteract = nil
	end
end

function DartsMediator:cleanActivityLastScheduler()
	if self._timer then
		LuaScheduler:getInstance():unschedule(self._timer)

		self._timer = nil
	end
end

function DartsMediator:GameOver()
	self._isGameOver = true

	self._dartshot:setVisible(true)
	self._curFlyDart:stopAllActions()
	self._curFlyDart:setAnchorPoint(cc.p(0.5, 0.5))

	local act = cc.Spawn:create(cc.EaseBackOut:create(cc.RotateBy:create(2, 400)), cc.MoveBy:create(2, cc.p(0, -700)))

	self._curFlyDart:runAction(cc.Sequence:create(act, cc.CallFunc:create(function()
		self._curFlyDart:removeFromParent()

		self._curFlyDart = nil

		self:sendResult()
	end)))
	self:cleanTimeScheduler()
	self._batBackBtn:setTouchEnabled(false)
	self._playTouchPanel:setTouchEnabled(false)
end

function DartsMediator:TimeOver()
	self._isGameOver = true

	self._dartshot:setVisible(true)

	if self._curFlyDart then
		self._curFlyDart:stopAllActions()
		self._curFlyDart:removeFromParent()

		self._curFlyDart = nil
	end

	self:sendResult()
	self:cleanTimeScheduler()
	self._batBackBtn:setTouchEnabled(false)
	self._playTouchPanel:setTouchEnabled(false)
end

function DartsMediator:createJumpCircle()
	if not self._jump_circle then
		self._jump_circle = ccui.ImageView:create("jump_circle.png", ccui.TextureResType.plistType)

		self._jump_circle:setVisible(false)
		self._jump_circle:setAnchorPoint(0.5, 0.5)
		self._jump_circle:addTo(self._mainPanel, 1):posite(0, 0)
	end
end

function DartsMediator:RectObbByPoint(PosTable, TagPoint)
	local A = PosTable[1]
	local B = PosTable[2]
	local C = PosTable[3]
	local D = PosTable[4]
	local a = (B.x - A.x) * (TagPoint.y - A.y) - (B.y - A.y) * (TagPoint.x - A.x)
	local b = (C.x - B.x) * (TagPoint.y - B.y) - (C.y - B.y) * (TagPoint.x - B.x)
	local c = (D.x - C.x) * (TagPoint.y - C.y) - (D.y - C.y) * (TagPoint.x - C.x)
	local d = (A.x - D.x) * (TagPoint.y - D.y) - (A.y - D.y) * (TagPoint.x - D.x)

	if a > 0 and b > 0 and c > 0 and d > 0 or a < 0 and b < 0 and c < 0 and d < 0 then
		return true
	end

	return false
end

function DartsMediator:makeRectObbByPointAndRota(pos, rota, width, higth)
	local sin_rad = math.sin(math.rad(rota))
	local cos_rad = math.cos(math.rad(rota))
	local x1 = pos.x + sin_rad * higth / 2
	local y1 = pos.y - cos_rad * higth / 2
	local x2 = x1 + cos_rad * width
	local y2 = y1 - sin_rad * width
	local x3 = x2 + sin_rad * higth
	local y3 = y2 + cos_rad * higth
	local x4 = x1 + sin_rad * higth
	local y4 = y1 + cos_rad * higth

	return {
		cc.p(x1, y1),
		cc.p(x2, y2),
		cc.p(x3, y3),
		cc.p(x4, y4)
	}
end

function DartsMediator:touchShot(sender, eventType)
	self._clickShowImage:stopAllActions()
	self._clickShowImage:setVisible(false)
	self:shotDarts()
end

function DartsMediator:shotDarts()
	if self._curFlyDart then
		return
	end

	local clonedartshot = self._dartshot:clone()

	clonedartshot:setVisible(true)
	clonedartshot:setAnchorPoint(cc.p(0, 0.5))

	local postarget = cc.p(self._targetBottom:getPosition())
	local _ac1 = cc.MoveTo:create(0.1, cc.p(postarget.x + self._targetwidth / 2 + 0.25 * self._dartswidth, postarget.y))

	self._dartshot:setVisible(false)

	local function ActionCallBack()
		local rota = self._targetBottom:getRotation() % 360

		if not self:isPrickTarget() then
			return
		end

		self:dartsPrickReward()

		local x = math.sin(math.rad(rota + 90)) * self._targetwidth / 2 + self._targetwidth / 2
		local y = self._targetwidth / 2 - math.cos(math.rad(rota + 90)) * self._targetwidth / 2

		clonedartshot:changeParent(self._targetBottom, 1):posite(x, y)
		clonedartshot:setAnchorPoint(cc.p(0.55, 0.5))
		clonedartshot:setRotation(-rota)
		table.insert(self._dartslist, clonedartshot)
		self:dartsShotTargetClip()
		self._dartshot:setVisible(true)
		self._targetBottom:runAction(RockAction:create(8, 0.25))
		self._target:runAction(RockAction:create(8, 0.25))

		self.trueSpeed = self.trueSpeed > 0 and self.trueSpeed + self.add or self.trueSpeed - self.add

		if self._gameState == "turnaround" then
			self._maxSpeed = self._maxSpeed > 0 and self._maxSpeed + self.add or self._maxSpeed - self.add
		end

		self._bottomnodeDartsNumnode:getChildByFullName("Panel_show_kuwu_" .. 12 - self._dirtTotalNum + self._dirtLastNum):getChildByFullName("Image_kuwu_liang"):setVisible(false)

		self._dirtLastNum = self._dirtLastNum - 1

		local dartsnumbg = self._bottomnodeDartsNumnode:getChildByName("Image_shownum_bg")

		dartsnumbg:getChildByFullName("Text_kuwu_num"):setString("x" .. self._dirtLastNum)

		self._curFlyDart = nil
		self._shotCount = self._shotCount + 1
		self._curScore = self._curScore + self._perScore

		self._curScoreLabel:setString("" .. self._curScore)
		self:dartsShotOver()
	end

	local _ac2 = cc.CallFunc:create(ActionCallBack)

	clonedartshot:addTo(self._mainPlayPanel):posite(self._dartshot:getPositionX(), self._dartshot:getPositionY())
	clonedartshot:runAction(cc.Sequence:create({
		_ac1,
		_ac2
	}))
	table.insert(self._curFlyDartsList, clonedartshot)

	self._curFlyDart = clonedartshot
end

function DartsMediator:isPrickTarget()
	local rota = self._targetBottom:getRotation() % 360

	for k, v in pairs(self._dartslist) do
		if math.abs(math.abs(v:getRotation()) - rota) < self._dartsCollision or math.abs(math.abs(v:getRotation()) - rota) > 360 - self._dartsCollision then
			AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Losing", false)
			self:GameOver()

			return false
		end
	end

	return true
end

function DartsMediator:dartsPrickReward()
	local postarget = cc.p(self._targetBottom:getPosition())
	local rota = self._targetBottom:getRotation() % 360

	for k, v in pairs(self._rewardlist) do
		if math.abs(math.abs(v.rota) - rota) < self._rewardCollision or math.abs(math.abs(v.rota) - rota) > 360 - self._rewardCollision then
			local item = v.widget

			item:setAnchorPoint(cc.p(0.5, 0.5))
			item:setRotation(0)
			item:changeParent(self._mainPlayPanel):posite(postarget.x + self._targetwidth / 2, self._dartshot:getPositionY())
			item:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(-150, 400)), cc.CallFunc:create(function()
				item:removeFromParent()

				item = nil
			end)))
			self:writeReward(v.reward)
			table.insert(self._curRewardList, v.reward)

			self._rewardlist[k] = nil

			if v.soundtype == 1 then
				-- block empty
			elseif v.soundtype == 2 then
				-- block empty
			end

			break
		end
	end
end

function DartsMediator:dartsShotOver()
	if self._dirtLastNum == 0 then
		if self._timeSchedulerRotation then
			LuaScheduler:getInstance():unschedule(self._timeSchedulerRotation)

			self._timeSchedulerRotation = nil
		end

		if self._timeSchedulerInteract then
			LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

			self._timeSchedulerInteract = nil
		end

		self._curLevel = self._curLevel + 1

		if self._dartsSystem:getMaxLevel() < self._curLevel then
			self._curLevel = self._dartsSystem:getMaxLevel()

			self:passGame()
		else
			self:NextLevel()
		end
	end
end

function DartsMediator:dartsShotTargetClip()
	AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Scoring", false)

	local anim = cc.MovieClip:create("guang_darts_dongwentexun")

	anim:addTo(self._panelGuangPos):posite(-100, 0)
	anim:gotoAndPlay(33)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent(true)
	end)
end

function DartsMediator:cleanTargetChild()
	for i, v in pairs(self._rewardlist) do
		v.widget:removeFromParent()
	end

	self._rewardlist = {}

	for i, v in pairs(self._dartslist) do
		v:removeFromParent()
	end

	self._dartslist = {}
end

function DartsMediator:passGame()
	self:cleanTargetChild()
	self._dartshot:setVisible(false)
	self._playTouchPanel:setTouchEnabled(false)
	self._targetBottom:setVisible(false)
	self._target:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Smashing")

	local anim = cc.MovieClip:create("target_darts_dongwentexun")

	anim:addTo(self._mainPlayPanel):posite(self._targetBottom:getPositionX(), self._targetBottom:getPositionY())
	anim:gotoAndPlay(32)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent(true)
		self:TimeOver()
	end)
end

function DartsMediator:dartsFlyRandom()
	return
end

function DartsMediator:NextLevel()
	self:cleanTargetChild()
	self._dartshot:setVisible(false)
	self._playTouchPanel:setTouchEnabled(false)
	self._targetBottom:setVisible(false)
	self._target:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Smashing")

	local anim = cc.MovieClip:create("target_darts_dongwentexun")

	anim:addTo(self._mainPlayPanel):posite(self._targetBottom:getPositionX(), self._targetBottom:getPositionY())
	anim:gotoAndPlay(32)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent(true)
		self:startRotation()
		self:updateInteractTimeScheduler()
	end)
end

function DartsMediator:refreshData()
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self._dartsSystem:syncData(self._activity)
end

function DartsMediator:initData(data)
	self._bagSystem = self._developSystem:getBagSystem()
	self._dartsSystem = self._miniGameSystem:getDartsSystem()

	self._dartsSystem:initDartsData(data)

	self._curLevel = self._dartsSystem:getCurLevel() or 1
	self._curScore = 0
	self._curGoldCount = 0
	self._curDiamonCount = 0
	self._curRewardList = {}
	self._curFlyDart = nil
	self._rewardlist = {}
	self._dartslist = {}
	self._perScore = 0
	self._goldGetCount = self._dartsSystem:getGoldGetCount()
	self._diamondGetCount = self._dartsSystem:getDiamondGetCount()
	self._fragGetCount = self._dartsSystem:getFragGetCount()
	self._goldNum = 0
	self._diamondNum = 0
	self._heroPieceNum = 0
	self._dartsCollision = 17
	self._rewardCollision = 25
	self._rewardHeroPieceId = self._dartsSystem:getRewardHeroPieceId()
end

function DartsMediator:showLevelText(level, callback)
	self._showTextlevel:stopAllActions()
	self._showTextlevel:setScale(2)
	self._showTextlevel:setOpacity(255)
	self._showTextlevel:setVisible(true)
	self._showTextlevel:setString(Strings:get("Activity_Darts_Round", {
		day = level
	}))
	self._showTextlevel:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 0.5)), cc.CallFunc:create(function()
		self._showTextlevel:setVisible(false)
		callback()
	end)))
end

function DartsMediator:showFirstRule()
	if self:getFirstOpenDarts() then
		self:onClickRule()
	end
end

function DartsMediator:initCurLevelData()
	self._curScoreLabel:setString("" .. self._curScore)
	self:cleanTargetChild()
	self._dartshot:setVisible(true)
	self._target:setVisible(true)
	self._targetBottom:setVisible(true)
	self._target:setScale(1)

	self._curFlyDartsList = {}

	local levelInfo = self._dartsSystem:getLevelInfoBylevel(self._curLevel)

	self._gameDuration = levelInfo.GameDuration
	self._curSpeed = levelInfo.MoveSpeed
	self.add = levelInfo.Accelerate

	local shift = (levelInfo.SpeedShift[2] - levelInfo.SpeedShift[1]) * 1000
	local shift1 = levelInfo.SpeedShift[1] * 1000
	local shift2 = levelInfo.SpeedShift[2] * 1000

	self.fudongAdd = (math.random(shift1 + shift, shift2 + shift) - shift) / 1000
	self.trueSpeed = self._curSpeed + self.fudongAdd
	self._reverPoint1 = levelInfo.RevertPoint[1]
	self._reverPoint2 = levelInfo.RevertPoint[2]

	local revertPoint3 = levelInfo.RevertPoint[3]

	self._intervalTable = {}
	self._dirtTotalNum = levelInfo.DartNum
	self._dirtLastNum = self._dirtTotalNum

	local mininterval = self._dartsSystem:getRevertGapTime()

	self._accelerateTime = self._dartsSystem:getAccelerateTime()
	self._perScore = self._dartsSystem:getDartsScore()

	if revertPoint3 ~= 0 then
		local cha = (self._reverPoint2 - self._reverPoint1) / (revertPoint3 + 1)
		local a = self._reverPoint1 * 1000
		local b = (self._reverPoint1 + cha) * 1000 - mininterval / 2 * 1000

		for i = 1, revertPoint3 do
			self._intervalTable[i] = math.random(a, b) / 1000
			a = b + mininterval / 2 * 1000
			b = b + mininterval / 2 * 1000 + cha * 1000 - mininterval / 2 * 1000
		end
	end

	self._direction = levelInfo.Direction
	self._gameState = "normal"
	self._gameStartTime = 0
	self._initialReward = levelInfo.InitialReward

	self._targetBottom:setRotation(0)
	self._target:setRotation(0)

	for i, v in ipairs(levelInfo.InitialDart) do
		local ss = self._dartshot:clone()
		local rota = v * 360 % 360
		local x = math.sin(math.rad(rota + 90)) * self._targetwidth / 2 + self._targetwidth / 2
		local y = self._targetwidth / 2 - math.cos(math.rad(rota + 90)) * self._targetwidth / 2

		ss:addTo(self._targetBottom, 1):posite(x, y)
		ss:setAnchorPoint(cc.p(0.55, 0.5))
		ss:setRotation(-rota)
		table.insert(self._dartslist, ss)
	end

	for i, v in pairs(levelInfo.InitialReward) do
		local rewardid = levelInfo.Reward[i]
		local reward = ConfigReader:getRecordById("Reward", rewardid).Content[1]
		local rewardData = {
			amount = 0,
			code = reward.code
		}

		rewardData.type = reward.type

		local iconsimple = IconFactory:createPic({
			id = rewardData.code
		}, {
			isWidget = true
		})

		iconsimple:setAnchorPoint(cc.p(0.5, 0))

		local rota = v * 360 % 360
		local x = math.sin(math.rad(rota + 90)) * self._targetwidth / 2 + self._targetwidth / 2
		local y = self._targetwidth / 2 - math.cos(math.rad(rota + 90)) * self._targetwidth / 2
		local soundtype = 1

		if rewardData.code == CurrencyIdKind.kDiamond then
			iconsimple:setAnchorPoint(cc.p(0.5, 0.33))

			soundtype = 1
		elseif rewardData.code == CurrencyIdKind.kGold then
			iconsimple:setAnchorPoint(cc.p(0.5, 0.33))

			soundtype = 2
		else
			local templeIcon = IconFactory:createPic({
				id = CurrencyIdKind.kGold
			}, {
				isWidget = true
			})
			local standardSize = templeIcon:getContentSize()
			local scale = standardSize.height / iconsimple:getContentSize().height

			iconsimple:setAnchorPoint(cc.p(0.5, 0.33))
			iconsimple:setScale(scale)

			soundtype = 3
		end

		iconsimple:addTo(self._targetBottom, 1):posite(x, y)
		iconsimple:setRotation(-rota + 90)

		local rewardInfo = {}

		rewardInfo.widget = iconsimple
		rewardInfo.rota = v * 360 % 360
		rewardInfo.reward = levelInfo.Reward[i]
		rewardInfo.soundtype = soundtype
		self._rewardlist[#self._rewardlist + 1] = rewardInfo
	end

	local width = (self._dirtTotalNum - 5) * 35
	local dartsnumbg = self._bottomnodeDartsNumnode:getChildByName("Image_shownum_bg")

	dartsnumbg:getChildByFullName("Text_kuwu_num"):setPositionX(230 + width)
	dartsnumbg:getChildByFullName("Text_kuwu_num"):setString("x" .. self._dirtTotalNum)
	dartsnumbg:setContentSize(cc.size(280 + width, dartsnumbg:getContentSize().height))

	for i = 1, 12 do
		if i > 12 - self._dirtTotalNum then
			self._bottomnodeDartsNumnode:getChildByFullName("Panel_show_kuwu_" .. i):setVisible(true)
		else
			self._bottomnodeDartsNumnode:getChildByFullName("Panel_show_kuwu_" .. i):setVisible(false)
		end

		self._bottomnodeDartsNumnode:getChildByFullName("Panel_show_kuwu_" .. i):getChildByFullName("Image_kuwu_liang"):setVisible(true)
	end

	self._curlevellabel = self:getView():getChildByFullName("main_play.topmidnode_time.Text_curlevel")

	local timeStr = TimeUtil:formatTime("${MM}:${SS}", self._gameDuration)

	self._lastTimelabel:setString(timeStr)
	self._curlevellabel:setString(Strings:get("Activity_Darts_Times", {
		day = self._curLevel
	}))
	self._lastTimelabel:setPositionX(self._curlevellabel:getPositionX() + self._curlevellabel:getContentSize().width + 10)
end

function DartsMediator:setButtonNameStyle(text)
	local fontName = DEFAULT_TTF_FONT
	local fontSize = 26
	local outlineColor = cc.c4b(114, 81, 70, 255)
	local outlineWidth = 2
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(255, 244, 120, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}
	local nameText = text

	nameText:setFontName(fontName)
	nameText:setFontSize(fontSize)
	nameText:enableOutline(outlineColor, outlineWidth)
	nameText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
end

function DartsMediator:resetData()
	self:cleanTargetChild()

	self._curFlyDart = nil
	self._curScore = 0
	self._curLevel = self._dartsSystem:getCurLevel() or 1
	self._curGoldCount = 0
	self._curDiamonCount = 0
	self._curRewardList = {}
	self._shotCount = 0
	self._diamondNum = 0
	self._goldNum = 0
	self._heroPieceNum = 0
	self._goldGetCount = self._dartsSystem:getGoldGetCount()
	self._diamondGetCount = self._dartsSystem:getDiamondGetCount()
	self._fragGetCount = self._dartsSystem:getFragGetCount()
end

function DartsMediator:updateInteractTimeScheduler()
	local function update()
		if self._curFlyDart == nil then
			return
		end

		local pos = self._mainPanel:convertToWorldSpace(cc.p(self._curFlyDart:getPosition()))

		for k, v in pairs(self._dartslist) do
			local tablepos = self:makeRectObbByPointAndRota(cc.p(v:getPositionX(), v:getPositionY()), v:getRotation(), v:getContentSize().width - v:getContentSize().width / 2, v:getContentSize().height)
			local pos1 = self._target:convertToWorldSpace(tablepos[1])
			local pos2 = self._target:convertToWorldSpace(tablepos[2])
			local pos3 = self._target:convertToWorldSpace(tablepos[3])
			local pos4 = self._target:convertToWorldSpace(tablepos[4])
			local isPointInRect = self:RectObbByPoint({
				pos1,
				pos2,
				pos3,
				pos4
			}, cc.p(pos.x, pos.y + self._curFlyDart:getContentSize().height / 4))
			local isPointInRect1 = self:RectObbByPoint({
				pos1,
				pos2,
				pos3,
				pos4
			}, cc.p(pos.x, pos.y - self._curFlyDart:getContentSize().height / 4))

			if isPointInRect or isPointInRect1 then
				AudioEngine:getInstance():playEffect("Se_Effect_Dwtx_Losing", false)
				self:GameOver()

				return
			end
		end
	end

	if self._timeSchedulerInteract == nil then
		self._timeSchedulerInteract = LuaScheduler:getInstance():schedule(function()
			update()
		end, 0, false)
	end
end

function DartsMediator:restartGameEvent(event)
	local doActivityType = 101

	self._miniGameSystem:requestActivityGameBegin(self._activity:getId(), function()
		return
	end, doActivityType)
end

function DartsMediator:quitGameEvent(event)
	if self._timeSchedulerRotation then
		self._timeSchedulerRotation:getScheduler():resume()
	end

	if self._timeSchedulerInteract then
		self._timeSchedulerInteract:getScheduler():resume()
	end

	self:TimeOver()
end

function DartsMediator:backGameEvent(event)
	if self._timeSchedulerRotation then
		self._timeSchedulerRotation:getScheduler():resume()
	end

	if self._timeSchedulerInteract then
		self._timeSchedulerInteract:getScheduler():resume()
	end
end

function DartsMediator:passGameEvent(event)
	self:TimeOver()
end

function DartsMediator:checkRewardLimit()
	local goldlimit, diamondlimit, herolimit = false, false, false

	if self._goldGetCount == self._dartsSystem:getGoldLimit() then
		goldlimit = true
	end

	if self._diamondGetCount == self._dartsSystem:getDiamondLimit() then
		diamondlimit = true
	end

	if goldlimit and diamondlimit and (self._fragGetCount == self._dartsSystem:getFragLimit() or nil) and true then
		return true
	else
		return false
	end
end

function DartsMediator:writeReward(rewardId)
	if rewardId then
		local rewardConfig = ConfigReader:getRecordById("Reward", rewardId)

		if rewardConfig then
			local reward = rewardConfig.Content[1]
			local rewardType = reward.code
			local rewardAmount = reward.amount

			if rewardType == CurrencyIdKind.kGold then
				self:writeGoldNum(rewardAmount)
			elseif rewardType == CurrencyIdKind.kDiamond then
				self:writeDiamondNum(rewardAmount)
			elseif rewardType == self._rewardHeroPieceId then
				self:writeHeropicNum(rewardAmount)
			end
		end
	end
end

function DartsMediator:writeGoldNum(num)
	if self._goldGetCount == self._dartsSystem:getGoldLimit() then
		return
	end

	if self._goldGetCount + num >= self._dartsSystem:getGoldLimit() then
		self._goldNum = self._dartsSystem:getGoldLimit() - self._goldGetCount + self._goldNum
		self._goldGetCount = self._dartsSystem:getGoldLimit()

		self._goldNumLabel:setString(self._goldNum)
	else
		self._goldNum = self._goldNum + num
		self._goldGetCount = self._goldGetCount + num

		self._goldNumLabel:setString(self._goldNum)
	end
end

function DartsMediator:writeDiamondNum(num)
	if self._diamondGetCount == self._dartsSystem:getDiamondLimit() then
		return
	end

	if self._diamondGetCount + num >= self._dartsSystem:getDiamondLimit() then
		self._diamondNum = self._diamondNum + self._dartsSystem:getDiamondLimit() - self._diamondGetCount
		self._diamondGetCount = self._dartsSystem:getDiamondLimit()

		self._diamondNumLabel:setString(self._diamondNum)
	else
		self._diamondNum = self._diamondNum + num
		self._diamondGetCount = self._diamondGetCount + num

		self._diamondNumLabel:setString(self._diamondNum)
	end
end

function DartsMediator:writeHeropicNum(num)
	if self._fragGetCount == self._dartsSystem:getFragLimit() then
		return
	end

	if self._fragGetCount + num >= self._dartsSystem:getFragLimit() then
		self._heroPieceNum = self._dartsSystem:getFragLimit() - self._fragGetCount + self._heroPieceNum
		self._fragGetCount = self._dartsSystem:getFragLimit()

		self._rewardNumLabel:setString(self._heroPieceNum)
	else
		self._heroPieceNum = self._heroPieceNum + num
		self._fragGetCount = self._fragGetCount + num

		self._rewardNumLabel:setString(self._heroPieceNum)
	end
end

function DartsMediator:onClickBack(sender, eventType)
	self:closeBgSound()
	self:dismiss()
end

function DartsMediator:onClickRank(sender, eventType)
	self._miniGameSystem:requestActivityRankData(RankType.kDarts, self._activityId, 1, self._dartsSystem:getMaximumShow(), function()
		local view = self:getInjector():getInstance("MiniGameRankView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			type = MiniGameType.kDarts,
			evn = MiniGameEvn.kActivity,
			activityId = self._activityId,
			rankNum = self._dartsSystem:getMaximumShow(),
			rankType = RankType.kDarts
		}, nil))
	end)
end

function DartsMediator:onClickReward(sender, eventType)
	local view = self:getInjector():getInstance("MiniGameRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}, nil))
end

function DartsMediator:onClickRule(sender, eventType)
	local rewardStr = ""
	local rewardList = self._dartsSystem:getRewardMaxList()
	local strList = {}

	for i, v in pairs(rewardList) do
		local name = RewardSystem:getName(v)

		strList[#strList + 1] = Strings:get("Activity_Darts_UI_30", {
			name = name,
			num = v.amount
		})
	end

	rewardStr = rewardStr .. table.concat(strList, "、")

	local ruleList = self._activity:getRuleDesc()
	local ruleData = {
		{
			Desc = ruleList
		}
	}
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = ruleData,
		ruleReplaceInfo = {
			value = rewardStr
		}
	}))
end

function DartsMediator:onClickBatBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._timeSchedulerInteract then
			self._timeSchedulerInteract:getScheduler():pause()
		end

		if self._timeSchedulerRotation then
			self._timeSchedulerRotation:getScheduler():pause()
		end

		local data = {}

		data.reward = {
			{
				id = CurrencyIdKind.kGold,
				num = self._goldNum
			},
			{
				id = CurrencyIdKind.kDiamond,
				num = self._diamondNum
			},
			{
				id = self._rewardHeroPieceId,
				num = self._heroPieceNum
			}
		}
		data.eventconfirm = EVT_DARTS_QUIT_SUCC
		data.eventback = EVT_DARTS_BACK_SUCC

		local view = self:getInjector():getInstance("MiniGameQuitConfirmView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end
end

function DartsMediator:buyTimes()
	local buytimes = self._activity:getBuyTimes()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if not outSelf._bagSystem:checkCostEnough(outSelf._dartsSystem:getBuyCostItemId(), outSelf._dartsSystem:getCostBuyTimes(buytimes + 1), {
				type = "tip"
			}) then
				return
			end

			outSelf._miniGameSystem:requestActivityGameBuyTimes(outSelf._activityId)
		end
	end

	local data = {
		isRich = true,
		title = Strings:get("MiniGame_BuyTimes_UI1"),
		title1 = Strings:get("MiniGame_BuyTimes_UI2"),
		content = Strings:get("Activity_Darts_UI_16", {
			fontName = TTF_FONT_FZYH_R,
			num = self._dartsSystem:getCostBuyTimes(buytimes + 1),
			count = self._dartsSystem:getEachBuyNum()
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function DartsMediator:checkBuyTimes(call)
	local times = self._activity:getGameTimes()
	local buytimes = self._activity:getBuyTimes()
	local maxtimes = self._dartsSystem:getCostBuyMaxTimes()

	if times == 0 then
		local factor1 = times == 0
		local factor2 = buytimes == maxtimes

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Times_Out")
			}))

			return false
		end

		if call and call() then
			return
		end

		self:buyTimes()

		return false
	end

	return true
end

function DartsMediator:checkRewardLimitTips(event)
	local isRewardLimit = self._dartsSystem:isGetRewardLimit()

	if isRewardLimit then
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf:buyTimes()
			end
		end

		local data = {
			title = Strings:get("Pass_UI50"),
			title1 = Strings:get("Pass_UI51"),
			content = Strings:get("MiniGame_Common_UI7"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))

		return false
	end

	return true
end

function DartsMediator:onClickBegin(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local function callBack()
			if not self:checkRewardLimitTips(EVT_DARTS_REWARDCONFIRM) then
				return true
			end

			return false
		end

		if not self:checkBuyTimes(callBack) then
			return
		end

		local doActivityType = 101

		self._miniGameSystem:requestActivityGameBegin(self._activity:getId(), function()
			return
		end, doActivityType)
	end
end

function DartsMediator:onClickAddTimes(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local function callBack()
			if not self:checkRewardLimitTips(EVT_DARTS_REWARDCONFIRM_ADD) then
				return true
			end

			return false
		end

		if not self:checkBuyTimes(callBack) then
			return
		end
	end
end
