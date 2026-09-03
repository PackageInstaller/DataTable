-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/jump/JumpMediator.lua

JumpMediator = class("JumpMediator", DmAreaViewMediator)

JumpMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
JumpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
JumpMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
JumpMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kSpeicalName = "kSpeicalName_JumpRole"
local kBtnHandlers = {
	batback_btn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBatBack"
	},
	["main.menu_panel.rulebtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.menu_panel.rankbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRank"
	},
	["main.menu_panel.rewardbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["main.menu_panel.begin_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBegin"
	},
	["main.menu_panel.addbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAddTimes"
	}
}
local runType = "ONLINE"

function JumpMediator:initialize()
	super.initialize(self)
end

function JumpMediator:dispose()
	if self._timeSchedulerScorllCloud then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerScorllCloud)
	end

	self:resetData()
	super.dispose(self)
end

function JumpMediator:userInject()
	return
end

function JumpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function JumpMediator:bindMapEventListener()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_JUMP_QUIT_SUCC, self, self.showResult)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_JUMP_PLAYAGAIN, self, self.restartGame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_GETREWARD_SCUESS, self, self.refreshRedPoints)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BEGIN_SCUESS, self, self.beginSuccessEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesSuccessEvent)
end

function JumpMediator:beginSuccessEvent()
	self:refreshMainView()
	self:beginGame()
end

function JumpMediator:dayRsetPush(event)
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self._activity:resetData()
	self._jumpData:resetData()
	self:refreshTimesView()
end

function JumpMediator:buyTimesScuess(event)
	self:refreshData()
	self:refreshTimesView()
end

function JumpMediator:buyTimesSuccessEvent(event)
	self:refreshData()
	self:refreshTimesView()
end

function JumpMediator:palyBgAudio()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Shequ")
end

function JumpMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	local director = cc.Director:getInstance()

	self.winSize = director:getWinSize()
	self.safeAreaInset = director:getOpenGLView():getSafeAreaInset()

	self:setupTopInfoWidget()
	self:bindMapEventListener()
	self:initData()
	self:refreshData()
	self:resetData()
	self:initNodes()
	self:enterTime()
	self:displayMenuReward()

	self._roleNode = self:createHero()

	self._roleNode:setAnchorPoint(0.5, 0)
	self._roleNode:addTo(self._mainPanel, 2):posite(0, 0)
	self._roleNode:setName(kSpeicalName)
	self._roleNode:setPosition(280, 200)
	self._roleNode:setVisible(false)
	self:createJumpMap()
	self:refreshRightMainView()
	self:updateScorllCloudTimeScheduler()
	self:refreshRedPoints()
	self:addAnim()
end

function JumpMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._stage0Node = self._mainPanel:getChildByFullName("stage")

	self._stage0Node:setVisible(false)

	self._menuPanel = self:getView():getChildByFullName("main.menu_panel")
	self._menuBgNode = self._menuPanel:getChildByFullName("menu_bg")
	self._gameInfoNode = self:getView():getChildByFullName("main.menu_panel.gameinfo_text")

	self._gameInfoNode:setLineSpacing(-2)

	self._gameTimesLabel = self._menuPanel:getChildByFullName("today_times")
	self._limitRewardLabel = self._menuPanel:getChildByFullName("limitRewardLabel")
	self._rewardPanel = self:getView():getChildByFullName("reward_panel")
	self._stageShowNode = self._mainPanel:getChildByFullName("stage_show")
	self._scoreLabel = self._rewardPanel:getChildByFullName("score")
	self._goldNumLabel = self._rewardPanel:getChildByFullName("gold_num")
	self._diamondNumLabel = self._rewardPanel:getChildByFullName("diamond_num")
	self._heroPieceNumLabel = self._rewardPanel:getChildByFullName("heropic_num")
	self._loadingBarNode = self._rewardPanel:getChildByFullName("loadingbar")
	self._progressNumLabel = self._rewardPanel:getChildByFullName("process_num")
	self._batBackBtn = self:getView():getChildByFullName("batback_btn")
	self._gratzNode = self._mainPanel:getChildByFullName("gratz_pnl")
	self._beginBtn = self._menuPanel:getChildByFullName("begin_btn")
	self._addTimesBtn = self._menuPanel:getChildByName("addbtn")
	self._rankBtn = self._mainPanel:getChildByFullName("menu_panel.rankbtn")
	self._ruleBtn = self._mainPanel:getChildByFullName("menu_panel.rulebtn")
	self._rewardBtn = self._mainPanel:getChildByFullName("menu_panel.rewardbtn")
	self._percentCursor = self._rewardPanel:getChildByFullName("guangbiao")
	self._timeNode = self._menuPanel:getChildByName("timeNode")

	local text = self._timeNode:getChildByName("time")
	local startDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getStartTime() / 1000)
	local endDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getEndTime() / 1000)

	text:setString(startDate .. "-" .. endDate)
end

function JumpMediator:addAnim()
	local anim = cc.MovieClip:create("ruchang_meishidazuozhantiaoyitiao")

	anim:addTo(self._menuPanel):center(self._menuPanel:getContentSize())

	local descNode = anim:getChildByName("desc")
	local btnNode = anim:getChildByName("btn")
	local timesNode = anim:getChildByName("times")

	self._gameInfoNode:changeParent(descNode):center(descNode:getContentSize())
	self._beginBtn:changeParent(btnNode):center(btnNode:getContentSize())
	self._gameTimesLabel:changeParent(timesNode):center(timesNode:getContentSize())
	self._addTimesBtn:changeParent(timesNode)
	self._addTimesBtn:setPosition(cc.p(self._gameTimesLabel:getPositionX() + self._gameTimesLabel:getContentSize().width / 2 + 20, 2))
	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addCallbackAtFrame(15, function()
		local scriptNames = "ministory_1a"
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:setSkipCheckSave(false)

		local guideSaved = storyAgent:isSaved(scriptNames)

		if not guideSaved then
			storyAgent:trigger(scriptNames)
		end
	end)
end

function JumpMediator:enterTime()
	local key = self._developSystem:getPlayer():getRid() .. MiniGameType.kJump .. "enterTime"
	local curTime = self._gameServerAgent:remoteTimestamp()

	cc.UserDefault:getInstance():setIntegerForKey(key, curTime)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	self:dispatch(Event:new(EVT_CLUB_PUSHREDPOINT_SUCC))
end

function JumpMediator:refreshRightMainView()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Game_Candy")
	self._roleNode:setVisible(false)
	self._menuPanel:setVisible(true)
	self._rewardPanel:setVisible(false)
	self._batBackBtn:setVisible(false)
	self._topInfoNode:setVisible(true)
	self._mainPanel:setTouchEnabled(false)
	self._scoreLabel:setString(Strings:get("Activity_Jump_UI_5", {
		Num = 0
	}))
	self:setProgressPercent(1)
	self._goldNumLabel:setString(0)
	self._diamondNumLabel:setString(0)
	self._heroPieceNumLabel:setString(0)
	self:refreshTimesView()
end

function JumpMediator:refreshRedPoints()
	if not self._rewardBtn.redPoint then
		self._rewardBtn.redPoint = RedPoint:createDefaultNode()

		self._rewardBtn.redPoint:setScale(0.8)
		self._rewardBtn.redPoint:addTo(self._rewardBtn):posite(60, 75)
	end

	self._rewardBtn.redPoint:setVisible(self._activity:hasTaskReward())
end

function JumpMediator:refreshTimesView()
	self._gameTimesLabel:setString(Strings:get("Activity_Jump_UI_4", {
		NUM = self._activity:getGameTimes()
	}))
	self._beginBtn:setGray(self._activity:getGameTimes() == 0)

	if self._jumpSystem:isGetRewardLimit() then
		self._limitRewardLabel:setVisible(true)
	else
		self._limitRewardLabel:setVisible(false)
	end

	self._addTimesBtn:setGray(self._activity:getBuyTimes() == self._jumpSystem:getCostBuyMaxTimes())
	self._addTimesBtn:setVisible(self._activity:getGameTimes() == 0)
end

function JumpMediator:addIconAnim(icon, anim, time)
	local iconInAnim = anim:getChildByName("icon")

	icon:addTo(iconInAnim, 1):posite(0, 0)
	icon:setVisible(false)
	icon:setScale(0.7)
end

function JumpMediator:createCloudList()
	self._cloudList = {}

	for i = 1, 3 do
		local cloud = self:getView():getChildByFullName("backgroundBG_" .. i)

		table.insert(self._cloudList, cloud)
	end
end

function JumpMediator:createCityList()
	self._moveBgList = {}

	for i = 1, 3 do
		self._moveBgList[i] = {}

		for j = 1, 3 do
			self._moveBgList[i][j] = self:getView():getChildByFullName("bg_city" .. i .. "_" .. j)
		end
	end
end

function JumpMediator:scorllCloud()
	for k, v in pairs(self._cloudList) do
		local cloudspeed = 1
		local width = v:getContentSize().width
		local posX = v:getPositionX() - cloudspeed

		if posX <= -width then
			posX = width * 2
		end

		v:setPositionX(posX)
	end
end

function JumpMediator:updateScorllCloudTimeScheduler()
	local function update()
		self:scorllCloud()
	end

	if self._timeSchedulerScorllCloud == nil then
		self._timeSchedulerScorllCloud = LuaScheduler:getInstance():schedule(function()
			update()
		end, 0.1, false)
	end

	update()
end

function JumpMediator:displayMenuReward()
	local heroiconid = self._rewardHeroPieceId
	local diamondiconid = CurrencyIdKind.kDiamond
	local goldiconid = CurrencyIdKind.kGold

	self._heroicon = self:createIcon(heroiconid)

	self._heroicon:setAnchorPoint(0.5, 0.5)

	self._diamondicon = self:createIcon(diamondiconid)
	self._goldicon = self:createIcon(goldiconid)

	self._diamondicon:setAnchorPoint(0.5, 0.5)
	self._goldicon:setAnchorPoint(0.5, 0.5)
end

function JumpMediator:createIcon(Id)
	self._rewardData = {
		amount = 0,
		code = Id
	}
	self._rewardData.type = 2

	local icon = IconFactory:createRewardIcon(self._rewardData, {
		isWidget = true
	})

	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), self._rewardData, {
		needDelay = true
	})

	return icon
end

function JumpMediator:setupTopInfoWidget()
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

function JumpMediator:rewardLimitConfirm()
	self._miniGameSystem:requestClubGameStart(self._jumpData:getId(), function(response)
		if response.resCode == GS_SUCCESS then
			self:beginGame()
		end
	end)
end

function JumpMediator:beginGame(beginStage)
	beginStage = beginStage or self._jumpSystem:getBeginStage()
	self._showResult = false

	self:refreshData()
	self:resetData()
	self._roleNode:setVisible(true)
	self._menuPanel:setVisible(false)
	self._rewardPanel:setVisible(true)
	self._loadingBarNode:setPercent(20)
	self._batBackBtn:setVisible(true)
	self._topInfoNode:setVisible(false)
	self:initStage(beginStage)
	self:heroSetScale()
	self:setProgressPercent(beginStage)
	self._batBackBtn:setTouchEnabled(true)
	self._mainPanel:setTouchEnabled(true)
	self._mainPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:accumlate(sender, eventType)
		end

		if eventType == ccui.TouchEventType.ended then
			self:jumpToNextstage(sender, eventType)
		end
	end)
end

function JumpMediator:createAccumCircle()
	if self._role2 ~= nil then
		self._accum_circle2 = ccui.Layout:create()

		self._accum_circle2:setAnchorPoint(0.5, 0)
		self._accum_circle2:setContentSize(cc.size(147, 260))
		self:createAccumAnim(self._stageDataList[1].stageModel, "role2")
		self._accum_circle2:addTo(self._stageDataList[1].stageModel, 1):posite(self._role2:getPositionX() + 2, self._role2:getPositionY() - 20)
		self._accum_circle2:setVisible(true)
	else
		self:createAccumAnim(self._mainPanel)
	end
end

function JumpMediator:createAccumAnim(parent, roleType)
	if roleType and roleType == "role2" then
		if not self.__accumAnim2 then
			self._accumAnim2 = cc.MovieClip:create("xuli_meishidazuozhantiaoyitiao")

			self._accumAnim2:setAnchorPoint(0.5, 0)
			self._accumAnim2:addTo(parent, 3):posite(self._role2:getPositionX() + 2, self._role2:getPositionY())
			self._accumAnim2:setScale(1 / self._stageDataList[1].widthScale, 1)
			self._accumAnim2:setTag(1314)
			self._accumAnim2:addCallbackAtFrame(115, function()
				if self._accumAnim2 then
					self._accumAnim2:gotoAndPlay(90)
				end
			end)
		end
	else
		if not self._accumAnim then
			self._accumAnim = cc.MovieClip:create("xuli_meishidazuozhantiaoyitiao")

			self._accumAnim:setAnchorPoint(0.5, 0)
			self._accumAnim:addTo(parent, 3):posite(self._roleNode:getPositionX() + 2, self._roleNode:getPositionY())
			self._accumAnim:addCallbackAtFrame(115, function()
				self._accumAnim:gotoAndPlay(90)
			end)
		end

		self._accumAnim:setPosition(self._roleNode:getPositionX() + 2, self._roleNode:getPositionY())
		self._accumAnim:gotoAndPlay(0)
		self._accumAnim:setVisible(true)
	end
end

function JumpMediator:accumlate(sender, eventType)
	self._accumType = 0
	self._prepareMusId = AudioEngine:getInstance():playEffect("Se_Effect_Prepare_Jump")

	if self._role2 ~= nil then
		self._role2:playAnimation(0.1, "jump1", false)
		self._role2:setTimeScale(0.2)
		self:createAccumCircle()

		self.beginTime = self._gameServerAgent:remoteTimeMillis()
	else
		self._roleNode:playAnimation(0.1, "jump1", false)
		self._roleNode:setTimeScale(0.2)
		self:createAccumCircle()

		self.beginTime = self._gameServerAgent:remoteTimeMillis()
	end

	local function update()
		local accumtime = self._gameServerAgent:remoteTimeMillis()
		local time = accumtime - self.beginTime

		if time >= self._jumpMaxPressTime * 1000 then
			self:reAccumulate()

			self._accumType = 1

			if self._timeSchedulerAccum then
				LuaScheduler:getInstance():unschedule(self._timeSchedulerAccum)

				self._timeSchedulerAccum = nil
			end
		end
	end

	if self._timeSchedulerAccum == nil then
		self._timeSchedulerAccum = LuaScheduler:getInstance():schedule(function()
			update()
		end, 0.01, false)
	end
end

function JumpMediator:reAccumulate()
	if self._role2 ~= nil then
		self._role2:playAnimation(0, "stand", true)
		self._role2:setTimeScale(1)
		self._accum_circle2:setVisible(false)
		self:stopAccumAnim()

		self.beginTime = self._gameServerAgent:remoteTimeMillis()
	else
		self._roleNode:playAnimation(0, "stand", true)
		self._roleNode:setTimeScale(1)
		self:stopAccumAnim()

		self.beginTime = self._gameServerAgent:remoteTimeMillis()
	end

	self._mainPanel:setTouchEnabled(true)
end

function JumpMediator:stopAccumAnim()
	if self._role2 ~= nil then
		local anim = self._stageDataList[1].stageModel:getChildByTag(1314)

		if anim then
			anim:stop()
			anim:removeFromParent()
			self._accumAnim2:removeFromParent()

			self._accumAnim2 = nil
		end
	else
		self._accumAnim:stop()
		self._accumAnim:setVisible(false)
	end

	AudioEngine:getInstance():stopEffect(self._prepareMusId)
end

function JumpMediator:jumpToNextstage(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Effect_Jump_Stage")

	if self._accumType == 1 then
		return
	elseif self._timeSchedulerAccum then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerAccum)

		self._timeSchedulerAccum = nil
	end

	self.endTime = self._gameServerAgent:remoteTimeMillis()

	if self._role2 ~= nil then
		self._role2:setTimeScale(1)
	else
		self._roleNode:setTimeScale(1)
	end

	local time = self.endTime - self.beginTime

	if time < self._jumpMinPressTime * 1000 then
		self:reAccumulate()

		return
	end

	self:stopAccumAnim()
	self:stopMoveWithStage()
	self._mainPanel:setTouchEnabled(false)
	self._batBackBtn:setTouchEnabled(false)

	self.beginTime = 0
	self.endTime = 0

	self._roleNode:setPositionY(self._roleNode:getPositionY() + 50)

	local jumpdistance = time * self._stageDataList[1].accumPower / 1000
	local bezier = {
		cc.p(self._roleNode:getPositionX(), self._roleNode:getPositionY()),
		cc.p(self._roleNode:getPositionX() + jumpdistance, jumpdistance * 0.7 + self._roleNode:getPositionY()),
		cc.p(self._roleNode:getPositionX() + jumpdistance, -200)
	}

	self._roleNode:playAnimation(0.7, "jump2", false)

	self.jumpAction = cc.Sequence:create(cc.BezierTo:create(0.7, bezier), cc.CallFunc:create(function()
		LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

		self._timeSchedulerInteract = nil

		AudioEngine:getInstance():playEffect("Se_Effect_Knock_Fall")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		self:showResult()
	end))

	self._roleNode:stopAllActions()
	self._roleNode:runAction(self.jumpAction)
	self:updateInteractTimeScheduler()
end

function JumpMediator:stopMoveWithStage()
	if self._role2 ~= nil and self._accum_circle2 ~= nil then
		local posX = self._stageDataList[1].stageModel:getPositionX() + self._role2:getPositionX() * self._stageDataList[1].widthScale
		local posY = self._stageDataList[1].stageModel:getPositionY() + self._role2:getPositionY()

		self._roleNode:setPosition(posX, posY)
		self._roleNode:setVisible(true)
		self._role2:removeFromParent()

		self._role2 = nil

		self._accum_circle2:removeFromParent()

		self._accum_circle2 = nil
	end
end

function JumpMediator:refreshData()
	self._jumpData = self._jumpSystem:getJumpData()
	self._maxScore = self._jumpData:getMaxScore()
	self._jumpMaxPressTime = self._jumpData:getJumpMaxPressTime()
	self._jumpMinPressTime = self._jumpData:getJumpMinPressTime()
	self._rewardHeroId = self._jumpData:getRewardHeroId()
	self._rewardHeroPieceId = self._jumpData:getRewardHeroPieceId()

	local playerData = self._developSystem:getPlayer()

	self._playerLevel = playerData:getLevel()
	self._playerVip = playerData:getVipLevel()
	self._goldGetCount = self._jumpData:getGoldGetCount()
	self._diamondGetCount = self._jumpData:getDiamondGetCount()
	self._fragGetCount = self._jumpData:getFragGetCount()
end

function JumpMediator:initData()
	self._bagSystem = self._developSystem:getBagSystem()
	self._jumpSystem = self._miniGameSystem:getJumpSystem()

	self._jumpSystem:initJumpData(self._activity)

	self._jumpData = self._jumpSystem:getJumpData()
	self._stageDataList = {}
	self._rewardData = {}
	self._standHighth = 0.6666666666666666
	self._scoreAnimList = {}

	self:createCloudList()
	self:createCityList()

	self._stageHighth = 100

	for i = 1, 5 do
		self:initScoreAnimList()
	end
end

function JumpMediator:resetData()
	self._stageTotalPosX = 115
	self._stageModelList = {}

	self:createJumpMap()

	self._goldNum = 0
	self._rewardList = {}
	self._diamondNum = 0
	self._heroPieceNum = 0
	self._score = 0
	self._scoreItemList = {}
	self._sitemRemoveList = {}
	self._rewardData = {}
end

function JumpMediator:createJumpMap()
	self._jumpStageCache = {}

	local floorList = self._jumpData:getJumpFloorList()

	for i = 1, #floorList do
		local stageId = floorList[i]
		local stageData = ConfigReader:getRecordById("MiniJumpEnemy", tostring(stageId))

		self._jumpStageCache[i] = self:initStgeCell(stageId, stageData, i)
	end
end

function JumpMediator:getStageScore(index)
	return self._jumpStageCache[index].score
end

function JumpMediator:initStgeCell(stageId, stageData, index)
	local tmpStage = {}

	tmpStage.id = stageId
	tmpStage.index = index
	tmpStage.widthScale = self:getStageScale(stageData)
	tmpStage.posX = self:getStageLocationX(stageData)
	tmpStage.posY = self._stageHighth
	tmpStage.stageModel = nil
	tmpStage.score = stageData.score
	tmpStage.movement = stageData.MoveDirection
	tmpStage.moveSpeed = self:getStageMoveSpeed(stageData)
	tmpStage.moveDistance = self:getStageMoveDistance(stageData)
	tmpStage.accumPower = stageData.VariableX
	tmpStage.scoreNum = stageData.ScoreNum
	tmpStage.rewardId = stageData.RewardId
	tmpStage.rewardLength = stageData.MinAwardLength

	return tmpStage
end

function JumpMediator:getStageScale(stageData)
	if stageData.PlatformScale == nil then
		return
	end

	local a = stageData.PlatformScale[2] - stageData.PlatformScale[1]
	local reed = math.random(1, 100)

	return stageData.PlatformScale[1] + reed / 100 * a
end

function JumpMediator:getStageLocationX(stageData)
	if stageData.PlatformDistance == nil then
		return
	end

	local a = stageData.PlatformDistance[2] - stageData.PlatformDistance[1]
	local reed = math.random(1, 100)

	return stageData.PlatformDistance[1] + reed / 100 * a
end

function JumpMediator:getStageLocationY(stageData)
	if stageData.PlatformHeight == nil then
		return
	end

	local a = stageData.PlatformHeight[2] - stageData.PlatformHeight[1]
	local reed = math.random(1, 100)

	return stageData.PlatformHeight[1] + reed / 100 * a
end

function JumpMediator:getStageMoveSpeed(stageData)
	if stageData.Speed == nil then
		return
	end

	local a = stageData.Speed[2] - stageData.Speed[1]
	local reed = math.random(1, 100)

	return stageData.Speed[1] + reed / 100 * a
end

function JumpMediator:getStageMoveDistance(stageData)
	if stageData.MoveDistance == nil then
		return
	end

	local a = stageData.MoveDistance[2] - stageData.MoveDistance[1]
	local reed = math.random(1, 100)

	return stageData.MoveDistance[1] + reed / 100 * a
end

function JumpMediator:stageMove(stage)
	local delayAction = cc.DelayTime:create(2)
	local distance = 0
	local curStageIndex = 0

	if stage.index == self._stageDataList[2].index then
		distance = 0 - self:getStageWidth(self._stageDataList[1].widthScale) - self._stageDataList[2].posX
		curStageIndex = self._stageDataList[2].index
	elseif stage.index == self._stageDataList[3].index then
		distance = 0 - self:getStageWidth(self._stageDataList[1].widthScale) - self._stageDataList[2].posX - self:getStageWidth(self._stageDataList[2].widthScale) - self._stageDataList[3].posX
		curStageIndex = self._stageDataList[3].index
	elseif stage.index == self._stageDataList[4].index then
		distance = 0 - self:getStageWidth(self._stageDataList[1].widthScale) - self._stageDataList[2].posX - self:getStageWidth(self._stageDataList[2].widthScale) - self._stageDataList[3].posX - self:getStageWidth(self._stageDataList[3].widthScale) - self._stageDataList[4].posX
		curStageIndex = self._stageDataList[4].index
	end

	self._stageTotalPosX = self._stageTotalPosX + distance

	local call = cc.CallFunc:create(function()
		self:initStage(curStageIndex)
		self:checkStagePos()
		self._mainPanel:setTouchEnabled(true)
	end)

	self._roleNode:stopAllActions()

	if self._role2 then
		self._roleNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0))))
		self._stageDataList[1].stageModel:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0)), cc.DelayTime:create(0.1), call))
	else
		self._roleNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0)), cc.DelayTime:create(0.1), call))
		self._stageDataList[1].stageModel:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0))))
	end

	for k, v in pairs(self._stageDataList) do
		if k ~= 1 then
			v.stageModel:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0))))
		end
	end

	if #self._scoreItemList >= 1 then
		for k, v in pairs(self._scoreItemList) do
			if v.item then
				v.item:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0))))
			end
		end
	end

	local citycall = cc.CallFunc:create(function(city)
		return
	end)

	for i, bgList in pairs(self._moveBgList) do
		for k, v in pairs(bgList) do
			v:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(distance, 0)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				local nextcity
				local nextposx = bgList[k == 3 and 1 or k + 1]:getPositionX()
				local citywidth = v:getContentSize().width

				if v:getPositionX() <= -citywidth then
					v:setPositionX(citywidth * 2 + nextposx)
				end
			end)))
		end
	end
end

function JumpMediator:checkStagePos()
	for k, v in pairs(self._stageDataList) do
		v.remove = v.index < self._curStage.index
	end

	local stageMapLength = #self._stageDataList

	for i = 1, stageMapLength do
		local a = stageMapLength - i + 1

		if self._stageDataList[a].remove then
			self:resetStage(self._stageDataList[a].stageModel)

			self._stageDataList[a] = nil

			table.remove(self._stageDataList, a)
		end
	end
end

function JumpMediator:resetStage(stageModel)
	if not stageModel then
		return
	end

	if stageModel:getChildByTag(2222) then
		stageModel:removeChildByTag(2222, true)
	end

	if stageModel:getChildByTag(1920) then
		stageModel:removeChildByTag(1920, true)
	end

	stageModel:stopAllActions()
	stageModel:setScale(1)
	stageModel:setTag(0)
	stageModel:setVisible(false)
end

function JumpMediator:createHero()
	local roleId = "Model_CLMan_minigame"

	return (RoleFactory:createHeroAnimation(roleId, "stand"))
end

function JumpMediator:heroSetScale()
	self._roleNode:setScale(0.56, 0.56)

	local px = 115 + self._curStage.stageModel:getContentSize().width * 1 / 2
	local py = self._curStage.posY + self._curStage.stageModel:getContentSize().height * self._standHighth

	self._roleNode:setPosition(px, py)
	self._roleNode:playAnimation(0, "stand", true)
end

function JumpMediator:initStage(stageId)
	if stageId == nil or stageId == 0 then
		stageId = 1
	end

	local posX = self._stageTotalPosX

	for i = stageId, #self._jumpStageCache do
		local stage = self._jumpStageCache[i]

		if i == stageId then
			self._curStage = stage
		end

		if not stage.isCreated then
			if stageId < i then
				posX = self:getStageWidth(self._jumpStageCache[i - 1].widthScale) + posX + stage.posX

				if posX > 1500 then
					return
				else
					self._stageTotalPosX = posX
				end
			end

			stage.isCreated = true

			local posY = stage.posY
			local stageModel = self:getStageModel()

			stageModel:setScale(stage.widthScale, 1)
			stageModel:setPosition(posX, posY)

			stage.stageModel = stageModel

			table.insert(self._stageDataList, stage)

			if stage.movement == 1 then
				local stagemovement = cc.RepeatForever:create(UpDownActionWithNoFade:create(stage.moveSpeed, stage.moveDistance))

				stage.stageModel:runAction(stagemovement)
			elseif stage.movement == 2 then
				local stagemovement = cc.RepeatForever:create(LeftRightAction:create(stage.moveSpeed, stage.moveDistance))

				stage.stageModel:runAction(stagemovement)
			end

			if i == stageId then
				self:moveWithStage(stage, true)
			end

			local stageMapNum = #self._stageDataList

			if stageMapNum > 1 then
				self:createScoreItem(stageMapNum)
			end

			if stageId < i then
				self:initStageReward(stage)

				local reward = stage.flyreward

				if reward then
					local posX = self:getStageWidth(stage.widthScale)

					reward:addTo(stage.stageModel, 1):posite(79, 60)
				end
			end
		end
	end
end

function JumpMediator:getStageModel()
	for k, v in pairs(self._stageModelList) do
		if v:getTag() == 0 then
			v:setTag(1)
			v:setVisible(true)

			return v
		end
	end

	return (self:createStage())
end

function JumpMediator:createStage()
	local stage = ccui.ImageView:create("Jump_img_tiaoban.png", ccui.TextureResType.plistType)

	stage:setAnchorPoint(0, 0)
	stage:addTo(self._mainPanel, 1):posite(1, 1)
	table.insert(self._stageModelList, stage)

	return stage
end

function JumpMediator:setFriendToStage(data, stage)
	local friendpnl = ccui.Layout:create()

	friendpnl:setContentSize(286, 84)
	friendpnl:setVisible(true)
	friendpnl:setScale(1 / stage.widthScale, 1)
	friendpnl:setTag(2222)

	local headicon = IconFactory:createPlayerIcon({
		id = data.avatar
	})

	headicon:setAnchorPoint(0, 0)
	headicon:setScale(0.7)
	headicon:addTo(friendpnl, 1):posite(0, 0)

	local infospace = ccui.ImageView:create("bg_gaofenjilu.png", ccui.TextureResType.plistType)

	infospace:setAnchorPoint(0, 0)
	infospace:setScale9Enabled(true)
	infospace:setCapInsets(cc.rect(5, 5, 5, 5))
	infospace:setContentSize(cc.size(230, 73))

	local hwidth = headicon:getContentSize().width * 0.7

	infospace:addTo(friendpnl, 1):posite(hwidth, 0)

	local name = ccui.Text:create("--", DEFAULT_TTF_FONT, 28)

	name:setColor(cc.c3b(255, 204, 67))
	name:setAnchorPoint(cc.p(0, 0))
	name:setString(data.name)
	name:addTo(friendpnl, 2):posite(hwidth + 14, 40)

	local hstxt = ccui.Text:create("--", DEFAULT_TTF_FONT, 28)

	hstxt:setColor(cc.c3b(255, 255, 255))
	hstxt:setAnchorPoint(cc.p(0, 0))
	hstxt:setPositionX(hwidth + 14)
	hstxt:setPositionY(8.5)
	hstxt:setString(Strings:get("Jump_UI5"))
	hstxt:addTo(friendpnl, 2):posite(hwidth + 14, 7)

	local hsnum = ccui.Text:create("--", DEFAULT_TTF_FONT, 28)

	hsnum:setColor(cc.c3b(255, 191, 39))
	hsnum:setAnchorPoint(cc.p(0, 0))
	hsnum:setString(data._maxScore)
	hsnum:addTo(friendpnl, 2):posite(hwidth + 104, 7)
	friendpnl:setAnchorPoint(0.5, 0.5)
	friendpnl:addTo(stage.stageModel, 1):posite(120, -50)
end

function JumpMediator:getStageWidth(widthScale)
	return self._stage0Node:getContentSize().width * widthScale
end

function JumpMediator:initScoreItem()
	if not self._stageDataList[2] then
		return
	end

	self:createScoreItem(2)

	if not self._stageDataList[3] then
		return
	end

	self:createScoreItem(3)
end

function JumpMediator:createScoreItem(stageId)
	local fromPosx = self._stageDataList[stageId - 1].stageModel:getPositionX() + self:getStageWidth(self._stageDataList[stageId - 1].widthScale) / 2
	local destPosx = self._stageDataList[stageId].stageModel:getPositionX() + self:getStageWidth(self._stageDataList[stageId].widthScale) / 2
	local scoreNum = self._stageDataList[stageId].scoreNum

	if self._stageDataList[stageId].hasCreated then
		return
	else
		self._stageDataList[stageId].hasCreated = true
	end

	if scoreNum and #scoreNum >= 1 then
		for k, v in pairs(scoreNum) do
			local radian = v.position * 180
			local r = (destPosx - fromPosx) / 2
			local posX = fromPosx + r - r * math.cos(math.rad(radian))
			local posY = 150 + r * math.sin(math.rad(radian))

			if v.offsetY then
				posY = posY + v.offsetY
			end

			local itemNode = ccui.Layout:create()

			itemNode:setAnchorPoint(cc.p(0.5, 0.5))
			itemNode:ignoreContentAdaptWithSize(false)
			itemNode:setContentSize(cc.size(63, 63))

			local scoreItem = ccui.ImageView:create(v.pic, ccui.TextureResType.plistType)
			local qipaoImg = ccui.ImageView:create("Jump_img_qipao.png", ccui.TextureResType.plistType)

			qipaoImg:addTo(itemNode):center(itemNode:getContentSize())
			scoreItem:addTo(itemNode):center(itemNode:getContentSize()):setName("iconImg")
			itemNode:addTo(self._mainPanel, 1):posite(posX, posY)
			itemNode:setScale(v.scale)

			local itemcell = {
				isInterActed = false,
				item = itemNode,
				itemscore = v.score
			}

			table.insert(self._scoreItemList, itemcell)

			local timereed = math.random(v.moveTime[1], v.moveTime[2])
			local distancereed = math.random(v.moveDistance[1], v.moveDistance[2])
			local itemaction

			if v.moveType == 1 then
				itemaction = cc.RepeatForever:create(UpDownActionWithNoFade:create(timereed, distancereed))

				itemNode:runAction(itemaction)
			elseif v.moveType == 2 then
				itemaction = cc.RepeatForever:create(LeftRightAction:create(timereed, distancereed))

				itemNode:runAction(itemaction)
			end
		end
	end
end

function JumpMediator:updateInteractTimeScheduler()
	local function update()
		for k, v in pairs(self._stageDataList) do
			if v then
				self:Interact(v, "stage")
			end
		end

		if #self._scoreItemList >= 1 then
			for i = 1, #self._scoreItemList do
				if self._scoreItemList[i].item then
					self:Interact(self._scoreItemList[i], "item", i)
				end
			end

			for k, v in pairs(self._scoreItemList) do
				if v.isInterActed then
					table.remove(self._scoreItemList, k)
				end
			end
		end
	end

	if self._timeSchedulerInteract == nil then
		self._timeSchedulerInteract = LuaScheduler:getInstance():schedule(function()
			update()
		end, 0.01, false)
	end

	update()
end

function JumpMediator:Interact(obj, objtype, location)
	local rolewidth = 60
	local roleheight = 170
	local roleminposx = self._roleNode:getPositionX() - rolewidth / 2
	local rolemaxposx = self._roleNode:getPositionX() + rolewidth / 2
	local roleminposy = self._roleNode:getPositionY()
	local rolemaxposy = self._roleNode:getPositionY() + roleheight
	local stageminposx, stagemaxposx, stageminposy, stagemaxposy = 0, 0, 0, 0
	local objposx, objposy, objwidth, objheight, rewardwidth, rewardheight

	if objtype == "stage" then
		stageminposx = obj.stageModel:getPositionX()
		stagemaxposx = obj.stageModel:getPositionX() + self:getStageWidth(obj.widthScale)
		stageminposy = obj.stageModel:getPositionY()
		stagemaxposy = obj.stageModel:getPositionY() + obj.stageModel:getContentSize().height * 1
		objwidth = self:getStageWidth(obj.widthScale) / 2
		objheight = obj.stageModel:getContentSize().height * 1 / 2
		objposx = stageminposx + objwidth
		objposy = stageminposy + objheight
		rewardwidth = self:getStageWidth(obj.widthScale) * obj.rewardLength / 2
	elseif objtype == "item" then
		if obj.isInterActed == true then
			return
		end

		stageminposx = obj.item:getPositionX() - obj.item:getContentSize().width / 2
		stagemaxposx = obj.item:getPositionX() + obj.item:getContentSize().width / 2
		stageminposy = obj.item:getPositionY() - obj.item:getContentSize().height / 2
		stagemaxposy = obj.item:getPositionY() + obj.item:getContentSize().height / 2
		objwidth = obj.item:getContentSize().width
		objheight = obj.item:getContentSize().height
		objposx = obj.item:getPositionX()
		objposy = obj.item:getPositionY()
	end

	local roleposx = self._roleNode:getPositionX()
	local roleposy = self._roleNode:getPositionY() + roleheight / 2

	if math.abs(roleposx - objposx) <= rolewidth / 2 + objwidth and math.abs(roleposy - objposy) <= roleheight / 2 + objheight then
		if objtype == "item" then
			self:getScoreItem(obj, location)

			return
		end

		if roleminposy < stageminposy - 10 and roleposx < stageminposx then
			local direction = "l"

			self:failOnStage(direction, obj)

			return
		end

		if roleposx < stageminposx or stagemaxposx < roleposx then
			local direction = "u"

			self:failOnStage(direction, obj)

			return
		else
			if math.abs(roleposx - objposx) <= rolewidth / 2 + rewardwidth then
				self:succOnStage(obj, true)
			else
				self:succOnStage(obj, false)
			end

			return
		end
	end
end

function JumpMediator:getScoreItem(obj, location)
	if obj.itemscore == nil or obj.itemscore == 0 then
		return
	end

	local scoretmp = obj.itemscore

	AudioEngine:getInstance():playEffect("Se_Effect_Eat_Bubble")
	self:updateScore(scoretmp)
	self:createScoreAnim(obj, location, scoretmp)

	obj.isInterActed = true

	obj.item:setVisible(false)
	obj.item:removeFromParent()

	obj.item = nil
end

function JumpMediator:initScoreAnimList()
	local mainpnl = self:getView():getChildByFullName("main")
	local tmpanim = cc.MovieClip:create("item_meishidazuozhantiaoyitiao")

	tmpanim:stop()
	tmpanim:setVisible(false)
	tmpanim:setTag(1)
	tmpanim:addTo(mainpnl, 1):posite(0, 0)
	tmpanim:addEndCallback(function()
		tmpanim:stop()
		tmpanim:setTag(1)
	end)

	local tmpflynum = cc.MovieClip:create("jszdh_defenchidaoju")

	tmpflynum:stop()
	tmpflynum:setTag(1)
	tmpflynum:setVisible(false)
	tmpflynum:addTo(mainpnl, 1):posite(0, 0)
	tmpflynum:addEndCallback(function()
		tmpflynum:stop()
		tmpflynum:setTag(1)
	end)

	local animnode = {
		anim = tmpanim,
		flynum = tmpflynum
	}
	local animnum = tmpflynum:getChildByFullName("num")
	local fntFile = "asset/font/minigame_font.fnt"
	local num = ccui.TextBMFont:create(0, fntFile)

	num:setAnchorPoint(0, 0.5)
	num:addTo(animnum, 1):posite(-10, 0)
	num:setTag(3456)
	table.insert(self._scoreAnimList, animnode)
end

function JumpMediator:createScoreAnim(obj, location, scoretmp)
	local tmpanim, tmpflynum

	for k, v in pairs(self._scoreAnimList) do
		if v.anim and v.anim:getTag() == 1 then
			tmpanim = v.anim

			v.anim:setTag(2)
			tmpanim:setVisible(true)

			tmpflynum = v.flynum

			v.flynum:setTag(2)
			tmpflynum:setVisible(true)
			tmpanim:setPosition(obj.item:getPositionX(), obj.item:getPositionY())
			tmpanim:gotoAndPlay(1)
			tmpanim:setScale(obj.item:getScale())

			local iconNode = tmpanim:getChildByName("icon")
			local icon = obj.item:getChildByName("iconImg"):clone()

			icon:addTo(iconNode):center(iconNode:getContentSize())
			tmpflynum:setPosition(obj.item:getPositionX(), obj.item:getPositionY() + 30)
			tmpflynum:gotoAndPlay(1)

			local animnum = tmpflynum:getChildByFullName("num")

			if animnum:getChildByTag(3456) then
				animnum:removeChildByTag(3456)
			end

			local fntFile = "asset/font/minigame_font.fnt"
			local num = ccui.TextBMFont:create(scoretmp, fntFile)

			num:setAnchorPoint(0, 0.5)
			num:addTo(animnum, 1):posite(-10, 0)
			num:setTag(3456)

			return
		end
	end

	if not tmpanim then
		tmpanim = cc.MovieClip:create("item_meishidazuozhantiaoyitiao")

		tmpanim:setTag(2)
		tmpanim:addTo(self._mainPanel, 2):posite(obj.item:getPositionX(), obj.item:getPositionY())
		tmpanim:addEndCallback(function()
			tmpanim:stop()
			tmpanim:setTag(1)
		end)
	end

	if not tmpflynum then
		tmpflynum = cc.MovieClip:create("jszdh_defenchidaoju")

		tmpflynum:setTag(2)
		tmpflynum:addTo(self._mainPanel, 3):posite(obj.item:getPositionX(), obj.item:getPositionY() + 30)
		tmpflynum:addEndCallback(function()
			tmpflynum:stop()
			tmpflynum:setTag(1)
		end)
	end

	local animnode = {
		anim = tmpanim,
		flynum = tmpflynum
	}
	local animnum = tmpflynum:getChildByFullName("num")
	local fntFile = "asset/font/minigame_font.fnt"
	local num = ccui.TextBMFont:create(scoretmp, fntFile)

	num:setAnchorPoint(0, 0.5)
	num:addTo(animnum, 1):posite(-10, 0)
	num:setTag(3456)
	table.insert(self._scoreAnimList, animnode)
end

function JumpMediator:setArtNum(panel, num, location, color)
	if location == nil then
		location = 0
	end

	local symbol_add

	if color then
		symbol_add = ccui.ImageView:create("img_add.png", ccui.TextureResType.plistType)
	else
		local fntFile = "asset/font/minigame_font.fnt"

		symbol_add = ccui.TextBMFont:create("X", fntFile)
	end

	symbol_add:setAnchorPoint(0.5, 0.5)
	symbol_add:setScale(0.62)
	symbol_add:addTo(panel, 1):posite(11 + location, 27)

	for i = 1, #tostring(num) do
		local a = 1

		for j = 1, #tostring(num) - 1 do
			a = a * 10
		end

		local b = math.floor(num / a)

		num = num - b * a

		local result_num

		if color then
			result_num = ccui.ImageView:create("img_" .. b .. ".png", ccui.TextureResType.plistType)
		else
			local fntFile = "asset/font/minigame_font.fnt"

			result_num = ccui.TextBMFont:create(b, fntFile)
		end

		result_num:setAnchorPoint(0.5, 0.5)
		result_num:setScale(0.62)
		result_num:addTo(panel, 1):posite(11 + i * 22 + location, 27)
		panel:setContentSize(22 + i * 22 + location, 27)
	end
end

function JumpMediator:succOnStage(stage, hasGetReward)
	self._batBackBtn:setTouchEnabled(true)

	if stage.index == self._stageDataList[1].index then
		self._roleNode:stopAllActions()
		self._roleNode:setPosition(self._roleNode:getPositionX(), stage.stageModel:getPositionY() + stage.stageModel:getContentSize().height * self._standHighth)
		self:moveWithStage(stage)
		self._roleNode:playAnimation(0, "stand", true)
		self._roleNode:stopAllActions()
		LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

		self._timeSchedulerInteract = nil

		self._mainPanel:setTouchEnabled(true)

		if hasGetReward and not stage.getReward then
			stage.getReward = true

			self:getStageReward(stage)
		end

		return
	end

	self._roleNode:stopAllActions()

	local stagescore = self:getStageScore(stage.index)

	self:updateScore(stagescore)

	if hasGetReward and not stage.getReward then
		stage.getReward = true

		self:getStageReward(stage)
	end

	self:setProgressPercent(stage.index)
	self._roleNode:setPositionY(stage.stageModel:getPositionY() + stage.stageModel:getContentSize().height * self._standHighth)
	self:moveWithStage(stage)

	if self._role2 then
		self._role2:playAnimation(0, "jump3", false)
		self._role2:registerSpineEventHandler(handler(self, self.spineHandler), sp.EventType.ANIMATION_COMPLETE)
	else
		self._roleNode:playAnimation(0, "jump3", false)
		self._roleNode:registerSpineEventHandler(handler(self, self.spineHandler), sp.EventType.ANIMATION_COMPLETE)
	end

	LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

	self._timeSchedulerInteract = nil

	if stage.index == #self._jumpStageCache then
		self._stageDataList[1].index = stage.index

		self:showCongratulation()
	else
		for i = 1, #self._scoreItemList do
			if self._scoreItemList[i].item and self._scoreItemList[i].item:getPositionX() < 0 then
				self._scoreItemList[i].item:removeFromParent()

				self._scoreItemList[i].item = nil
			end
		end

		self:stageMove(stage)
	end
end

function JumpMediator:spineHandler(event)
	self._roleNode:playAnimation(0, "stand", true)
end

function JumpMediator:getFriendstage(stage)
	if stage.friend then
		self:updateScore(self._friendScore)

		do
			local friendpnl = stage.stageModel:getChildByTag(2222)

			if friendpnl then
				stage.stageModel:removeChildByTag(2222)
			end

			local flyFriendScore = cc.MovieClip:create("jszdhbb_defenchidaoju")
			local getassist = ccui.ImageView:create("img_Thdzl.png", ccui.TextureResType.plistType)

			getassist:setAnchorPoint(0, 0)
			getassist:addTo(flyFriendScore, 1):posite(0, 0)

			local getassist_width = getassist:getContentSize().width

			flyFriendScore:addTo(self._mainPanel, 2):posite(stage.stageModel:getPositionX(), stage.stageModel:getPositionY() + 200)
			flyFriendScore:addEndCallback(function()
				flyFriendScore:stop()
				flyFriendScore:removeFromParent()
			end)
		end

		return
	end
end

function JumpMediator:moveWithStage(stage, isFirst)
	if stage.movement ~= 0 then
		self._role2 = self:createHero()

		self._role2:setAnchorPoint(0.5, 0)
		self._role2:setScale(0.56 / stage.widthScale, 0.56)
		self._role2:playAnimation(0, "stand", true)
		self._roleNode:setVisible(false)

		local posX = self._roleNode:getPositionX() - stage.stageModel:getPositionX()

		posX = posX / stage.widthScale

		local posY = stage.stageModel:getContentSize().height * self._standHighth

		self._role2:addTo(stage.stageModel, 1):posite(0, 0)
		self._role2:setPosition(posX, posY)

		if isFirst then
			self._role2:setPositionX(stage.stageModel:getContentSize().width / 2)
		end
	end
end

function JumpMediator:initStageReward(stage)
	local flyRewardDate = self:randomStageReward(stage)

	if not flyRewardDate then
		return
	end

	local flyreward = ccui.Layout:create()

	flyreward:setAnchorPoint(0.5, 0)
	flyRewardDate.flyreward_icon:addTo(flyreward, 1):center(flyreward:getContentSize())
	flyreward:setScale(1 / stage.widthScale, 1)
	flyreward:setTag(1920)

	stage.flyreward = flyreward
	stage.reward = flyRewardDate.reward
	stage.rewardnum = flyRewardDate.reward_num
end

function JumpMediator:getStageReward(stage)
	if not stage.rewardId or stage.rewardId == "" then
		return
	end

	if stage.rewardLength then
		-- block empty
	end

	local reward = ConfigReader:getRecordById("Reward", stage.rewardId).Content[1]
	local rewardType = reward.code
	local rewardAmount = reward.amount

	if rewardType == CurrencyIdKind.kGold then
		AudioEngine:getInstance():playEffect("Se_Effect_Eat_Coin")
		self:writeGoldNum(rewardAmount)
	elseif rewardType == CurrencyIdKind.kDiamond then
		AudioEngine:getInstance():playEffect("Se_Effect_Eat_Diamond")
		self:writeDiamondNum(rewardAmount)
	else
		AudioEngine:getInstance():playEffect("Se_Effect_Eat_Award")
		self:writeHeropicNum(rewardAmount)
	end

	if not stage.flyreward then
		return
	end

	stage.flyreward:setVisible(false)

	local anim = cc.MovieClip:create("reward_meishidazuozhantiaoyitiao")
	local iconNode = anim:getChildByName("icon")

	if rewardType == CurrencyIdKind.kGold or rewardType == CurrencyIdKind.kDiamond then
		local icon = stage.flyreward:clone()

		icon:setVisible(true)
		iconNode:removeAllChildren()
		icon:addTo(iconNode):center(iconNode:getContentSize())
	end

	anim:addTo(stage.flyreward:getParent()):posite(stage.flyreward:getPosition())
	anim:addEndCallback(function()
		stage.flyreward:removeFromParent()

		stage.flyreward = nil

		anim:stop()
		anim:removeFromParent()
	end)
end

function JumpMediator:randomStageReward(stage)
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", stage.rewardId, "Content") or {}

	if not rewards[1] then
		return
	end

	local reward = rewards[1]
	local reward_num = reward.amount

	self._rewardData = {
		amount = 0,
		code = reward.code,
		type = reward.type
	}

	local flyreward_icon

	if self._rewardData.code == CurrencyIdKind.kGold or self._rewardData.code == CurrencyIdKind.kDiamond then
		flyreward_icon = IconFactory:createRewardIcon(self._rewardData, {
			showAmount = false,
			isWidget = true
		})

		flyreward_icon:setScale(0.5, 0.5)
	else
		flyreward_icon = ccui.ImageView:create("Jump_ico_jl_4.png", ccui.TextureResType.plistType)
	end

	local flyreward_icon_width = flyreward_icon:getContentSize().width / 2

	flyreward_icon:setAnchorPoint(0.5, 0)

	return {
		flyreward_icon = flyreward_icon,
		flyreward_icon_width = flyreward_icon_width,
		reward = reward,
		reward_num = reward_num
	}
end

function JumpMediator:failOnStage(direction, stage)
	AudioEngine:getInstance():playEffect("Se_Effect_Knock_Fall")

	if self._timeSchedulerInteract then
		LuaScheduler:getInstance():unschedule(self._timeSchedulerInteract)

		self._timeSchedulerInteract = nil
	end

	self._mainPanel:setTouchEnabled(false)
	self._roleNode:stopAction(self.jumpAction)
	self._roleNode:stopAnimation()
	stage.stageModel:stopAllActions()
	self._roleNode:stopAllActions()

	if direction == "l" then
		self._roleNode:playAnimation(0, "falldown", false)
		self._roleNode:runAction(cc.MoveBy:create(0.7, cc.p(0, 0 - self._roleNode:getPositionY() - 200)))
		self._roleNode:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			self:showResult()
		end)))

		return
	end

	self._roleNode:setPosition(self._roleNode:getPositionX(), stage.posY + stage.stageModel:getContentSize().height * self._standHighth)
	self._roleNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.7, cc.p(0, 0 - self._roleNode:getPositionY() - 200)), cc.DelayTime:create(1), cc.CallFunc:create(function()
		self:showResult()
	end)))
end

function JumpMediator:updateScore(sc)
	self._score = self._score + sc

	self._scoreLabel:setString(Strings:get("Activity_Jump_UI_5", {
		Num = self._score
	}))
end

function JumpMediator:showResult(stageid)
	if self._showResult then
		return
	end

	self._showResult = true

	local stageIndex

	if self._stageDataList[1] then
		stageIndex = self._stageDataList[1].index
	end

	local preHightScore = self._activity:getHighestScore()
	local data = {
		modelId = "Model_CLMan",
		isWin = self._score > 0,
		stage = stageIndex,
		score = self._score,
		highscore = preHightScore,
		todaytimes = self._activity:getGameTimes(),
		totaltimes = self._activity:getDailyGameTimes(),
		isHightScore = preHightScore < self._score,
		activityId = self._activityId,
		event = EVT_JUMP_PLAYAGAIN,
		isGetRewardLimit = self._jumpSystem:isGetRewardLimit(),
		buytimes = self._activity:getBuyTimes(),
		buymaxtimes = self._jumpSystem:getCostBuyMaxTimes(),
		eachbuynum = self._jumpSystem:getEachBuyNum(),
		costid = self._jumpSystem:getBuyCostItemId(),
		amountlist = self._jumpSystem:getCostAmountList()
	}

	if preHightScore < self._score then
		self._preHightScore = self._score
	end

	local serviceData = {
		score = self._score,
		stage = stageIndex,
		rewards = {
			{
				type = 2,
				code = CurrencyIdKind.kGold,
				amount = self._goldNum
			},
			{
				type = 2,
				code = CurrencyIdKind.kDiamond,
				amount = self._diamondNum
			},
			{
				type = 2,
				code = self._rewardHeroPieceId,
				amount = self._heroPieceNum
			}
		}
	}

	if runType == "ONLINE" then
		local doActivityType = 103

		self._miniGameSystem:requestActivityGameResult(self._activity:getId(), serviceData, function(response)
			if response.resCode == GS_SUCCESS then
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if data and data.ignoreRefresh and data.ignoreRefresh == true then
						-- block empty
					else
						outSelf:refreshMainView()
					end
				end

				data.rewards = response.data.rewards
				data.highscore = self._activity:getHighestScore()

				local view = self:getInjector():getInstance("MiniGameResultView")

				self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {}, data, delegate))
			else
				self:refreshMainView()
			end
		end, doActivityType)
	end
end

function JumpMediator:restartGame(event)
	local doActivityType = 101

	self._miniGameSystem:requestActivityGameBegin(self._activity:getId(), function()
		return
	end, doActivityType)
end

function JumpMediator:refreshMainView()
	self:refreshData()
	self:cleanGameWarData()
	self:refreshRightMainView()
	self:refreshRedPoints()
end

function JumpMediator:cleanGameWarData()
	self:stopMoveWithStage()
	self:cleanStageMove()

	for k, v in pairs(self._stageDataList) do
		self:resetStage(v.stageModel)
	end

	for i = 1, #self._stageDataList do
		self._stageDataList[1].stageModel:setVisible(false)

		if self._stageDataList[i] and self._stageDataList[i].flyreward then
			self._stageDataList[i].flyreward:removeFromParent()
		end

		table.remove(self._stageDataList, 1)
	end

	if self._jumpStageCache then
		for i = 1, #self._jumpStageCache do
			table.remove(self._jumpStageCache)
		end
	end

	if self._scoreItemList then
		for i = 1, #self._scoreItemList do
			if self._scoreItemList[i].item then
				self._scoreItemList[i].item:removeFromParent()
			end
		end

		self._scoreItemList = {}
	end
end

function JumpMediator:cleanStageMove()
	for k, v in pairs(self._stageDataList) do
		v.stageModel:stopAllActions()
	end
end

function JumpMediator:setProgressPercent(progress)
	if progress == nil then
		progress = 1
	end

	if #self._jumpStageCache >= 1 then
		local size = self._rewardPanel:getChildByName("img"):getContentSize()
		local per = progress / #self._jumpStageCache

		self._loadingBarNode:setPercent(per * 100)
		self._progressNumLabel:setString(progress)
		self._progressNumLabel:setPositionX(21 + per * size.width)
		self._percentCursor:setPositionX(21 + per * size.width)
	else
		return false
	end
end

function JumpMediator:showCongratulation()
	self._showCongratulation = true

	self._mainPanel:setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Effect_Candy_Success")

	self._succAnim = cc.MovieClip:create("tongguan_meishidazuozhantiaoyitiao")

	self._succAnim:addTo(self._mainPanel, 1):center(self._mainPanel:getContentSize())
	self._succAnim:addEndCallback(function()
		if self._succAnim then
			self._succAnim:stop()
			self._succAnim:removeFromParent()
			self:showResult(#self._jumpStageCache)

			self._showCongratulation = false
		end
	end)
end

function JumpMediator:checkRewardLimit()
	local goldlimit, diamondlimit, herolimit = false, false, false

	if self._goldGetCount == self._jumpData:getGoldLimit() then
		goldlimit = true
	end

	if self._diamondGetCount == self._jumpData:getDiamondLimit() then
		diamondlimit = true
	end

	if goldlimit and diamondlimit and (self._fragGetCount == self._jumpData:getFragLimit() or nil) and true then
		return true
	else
		return false
	end
end

function JumpMediator:writeGoldNum(num)
	if self._goldGetCount == self._jumpData:getGoldLimit() then
		return
	end

	if self._goldGetCount + num >= self._jumpData:getGoldLimit() then
		self._goldNum = self._jumpData:getGoldLimit() - self._goldGetCount + self._goldNum
		self._goldGetCount = self._jumpData:getGoldLimit()

		self._goldNumLabel:setString(self._goldNum)
	else
		self._goldNum = self._goldNum + num
		self._goldGetCount = self._goldGetCount + num

		self._goldNumLabel:setString(self._goldNum)
	end
end

function JumpMediator:writeDiamondNum(num)
	if self._diamondGetCount == self._jumpData:getDiamondLimit() then
		return
	end

	if self._diamondGetCount + num >= self._jumpData:getDiamondLimit() then
		self._diamondNum = self._diamondNum + self._jumpData:getDiamondLimit() - self._diamondGetCount
		self._diamondGetCount = self._jumpData:getDiamondLimit()

		self._diamondNumLabel:setString(self._diamondNum)
	else
		self._diamondNum = self._diamondNum + num
		self._diamondGetCount = self._diamondGetCount + num

		self._diamondNumLabel:setString(self._diamondNum)
	end
end

function JumpMediator:writeHeropicNum(num)
	if self._fragGetCount == self._jumpData:getFragLimit() then
		return
	end

	if self._fragGetCount + num >= self._jumpData:getFragLimit() then
		self._heroPieceNum = self._jumpData:getFragLimit() - self._fragGetCount + self._heroPieceNum
		self._fragGetCount = self._jumpData:getFragLimit()

		self._heroPieceNumLabel:setString(self._heroPieceNum)
	else
		self._heroPieceNum = self._heroPieceNum + num
		self._fragGetCount = self._fragGetCount + num

		self._heroPieceNumLabel:setString(self._heroPieceNum)
	end
end

function JumpMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:cleanGameWarData()
		self:dismiss()
	end
end

function JumpMediator:onClickRank(sender, eventType)
	self._miniGameSystem:requestActivityRankData(RankType.kJump, self._activityId, 1, 20, function()
		local view = self:getInjector():getInstance("MiniGameRankView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			type = MiniGameType.kJump,
			evn = MiniGameEvn.kActivity,
			activityId = self._activityId,
			rankNum = self._activity:getActivityConfig().maximumShow,
			rankType = RankType.kJump
		}, nil))
	end)
end

function JumpMediator:onClickReward(sender, eventType)
	local view = self:getInjector():getInstance("MiniGameRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}, nil))
end

function JumpMediator:onClickRule(sender, eventType)
	local rewardStr = ""
	local rewardList = self._jumpSystem:getRewardMaxList()
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
			value = rewardStr,
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function JumpMediator:onClickBatBack(sender, eventType)
	if self._showCongratulation or self._showResult then
		return
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
	data.eventconfirm = EVT_JUMP_QUIT_SUCC

	local view = self:getInjector():getInstance("MiniGameQuitConfirmView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function JumpMediator:buyTimes()
	local buytimes = self._activity:getBuyTimes()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if not outSelf._bagSystem:checkCostEnough(outSelf._jumpSystem:getBuyCostItemId(), outSelf._jumpSystem:getCostBuyTimes(buytimes + 1), {
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
			num = self._jumpSystem:getCostBuyTimes(buytimes + 1),
			count = self._jumpSystem:getEachBuyNum()
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function JumpMediator:checkBuyTimes(call)
	local times = self._activity:getGameTimes()
	local buytimes = self._activity:getBuyTimes()
	local maxtimes = self._jumpSystem:getCostBuyMaxTimes()

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

function JumpMediator:checkRewardLimitTips()
	local isRewardLimit = self._jumpSystem:isGetRewardLimit()

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

function JumpMediator:onClickBegin(sender, eventType)
	local function callBack()
		if not self:checkRewardLimitTips() then
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

function JumpMediator:onClickAddTimes(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local function callBack()
			if not self:checkRewardLimitTips() then
				return true
			end

			return false
		end

		if not self:checkBuyTimes(callBack) then
			return
		end
	end
end
