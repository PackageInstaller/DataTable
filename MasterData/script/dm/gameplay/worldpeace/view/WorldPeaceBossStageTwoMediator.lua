-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceBossStageTwoMediator.lua

WorldPeaceBossStageTwoMediator = class("WorldPeaceBossStageTwoMediator", DmAreaViewMediator, _M)

WorldPeaceBossStageTwoMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceBossStageTwoMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

function WorldPeaceBossStageTwoMediator:initialize()
	super.initialize(self)
end

function WorldPeaceBossStageTwoMediator:dispose()
	self._viewClose = true

	self:closeAllSche()
	super.dispose(self)
end

function WorldPeaceBossStageTwoMediator:closeAllSche()
	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end

	self:closeSche()
end

function WorldPeaceBossStageTwoMediator:onRegister()
	super.onRegister(self)
end

function WorldPeaceBossStageTwoMediator:closeSche()
	if self._hurtscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._hurtscheduler)

		self._hurtscheduler = nil
	end

	if self._timecheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timecheduler)

		self._timecheduler = nil
	end
end

function WorldPeaceBossStageTwoMediator:refreshBossList(data)
	local factor = 0.3

	dump(data, "data_____datadataWorldPeaceBossStageOneMediator")

	local offsetSize = AdjustUtils.getAdjustOffset()

	if data.leftBossId then
		dump(data.leftBossId, "data___refreshBossList__data")

		local bossWidget = ClubBossShow:new(data.leftBossId)

		bossWidget:getDisplayNode():addTo(self._view, -1):posite(-90, 290)
		bossWidget:getDisplayNode():setColorTransform(ColorTransform(1, 1, 1, factor))
		bossWidget:getDisplayNode():offset(-offsetSize.x, 0)
	end

	if data.rightBossId then
		local bossWidget = ClubBossShow:new(data.rightBossId)

		bossWidget:getDisplayNode():addTo(self._view, -1):posite(1220, 290)
		bossWidget:getDisplayNode():setColorTransform(ColorTransform(1, 1, 1, factor))
		bossWidget:getDisplayNode():offset(offsetSize.x, 0)
	end
end

function WorldPeaceBossStageTwoMediator:enterWithData(data)
	local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)

	self._curTime = gameServerAgent:remoteTimestamp()
	data = data or {}
	self._hasAnim = data.hasAnim
	self._bossId = data.bossId
	self._closeCallBack = data.closeCallBack
	self._infoPanel = self._view:getChildByName("infopanel")

	self._view:getChildByName("bg"):setLocalZOrder(-99)

	self._timeLabel = ccui.Text:create("111", TTF_FONT_FZYH_M, 33)

	self._timeLabel:addTo(self._view, 999):setPosition(1030, 140)
	self._timeLabel:setVisible(false)
	self._infoPanel:setVisible(false)

	if not self._clickAnim then
		self._clickAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

		self._clickAnim:addTo(self._view, 999):setPosition(1030, 95)
		self._clickAnim:setScale(1.2)
	end

	self._clickAnim:setVisible(false)

	if not self._clickSleepAnim then
		self._clickSleepAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

		self._clickSleepAnim:addTo(self._view, 999):setPosition(1030, 95)
		self._clickSleepAnim:setScale(1.2)
	end

	self._clickSleepAnim:setVisible(false)
	self:setupTopInfoWidget()
	self:initBattleLayer()

	local function play()
		local touchLayer = ccui.Layout:create()

		self._touchLayer = touchLayer

		touchLayer:setAnchorPoint(cc.p(0.5, 0.5))
		touchLayer:addTo(self._view, 99999):setPosition(1030, 100)
		touchLayer:setContentSize(cc.size(200, 200))
		touchLayer:setTouchEnabled(true)
		touchLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				self:onSupport()
			end
		end)

		self._btnName = ccui.Text:create("next", TTF_FONT_FZYH_M, 33)

		self._btnName:addTo(touchLayer, 99):center(touchLayer:getContentSize())
		self._btnName:setString(Strings:get("ClubBoss_Tips_01"))
		self:startMainLoop(data.boss)
		self:refreshTimes()
		self:checkCanAtkBoss()
		self:refreshBossList(data)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_BOSSDEAD_REFRESH, self, self.bossDead)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_RSETONE_REFRESH, self, self.stageOneRset)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.gameOver)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_GAMEOVER, self, self.gameOver)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.gameOver)
		self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_SET_BUFF_SUCC, self, self.selectBuff)
	end

	if data.showTimeAnim then
		local timeAnim = cc.MovieClip:create("daojishi_qiuqiudaojishi")

		timeAnim:addTo(self._view, 999):center(self._view:getContentSize())
		timeAnim:addCallbackAtFrame(30, function(cid, mc)
			return
		end)
		timeAnim:addCallbackAtFrame(60, function(cid, mc)
			return
		end)
		timeAnim:addCallbackAtFrame(72, function(cid, mc)
			timeAnim:removeFromParent(true)
			self:dispatch(ShowTipEvent({
				duration = 2,
				tip = Strings:get("ClubBoss_Tips_01")
			}))
			play()
		end)
		timeAnim:setPlaySpeed(1.4)
	else
		play()
	end
end

function WorldPeaceBossStageTwoMediator:gameOver(event)
	self:closeAllSche()
	self:dismiss()
end

function WorldPeaceBossStageTwoMediator:refreshTimes()
	self._timecheduler = self._timecheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self:checkCanAtkBoss()
	end, 1, false)
end

function WorldPeaceBossStageTwoMediator:checkCanAtkBoss()
	local clubBoss = self._clubSystem:getClubBossNew()
	local startTime = clubBoss:getTwoAtkTime() / 1000
	local atkShowList = {}
	local atkTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickTime", "content")
	local sleepTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_CoolTime", "content")
	local atkTimes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickNum", "content")

	self._sleep = false
	self._canAtk = false
	self._targetTime = atkShowList[1]

	local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)
	local curTime = gameServerAgent:remoteTimestamp()
	local changeTime = math.modf(curTime - startTime)

	if changeTime < atkTime then
		self._canAtk = atkTime - changeTime
	elseif changeTime <= sleepTime + atkTime then
		self._sleep = sleepTime + atkTime - changeTime
	end

	self._timeLabel:setLocalZOrder(999)
	self._timeLabel:setVisible(false)
	self._touchLayer:setVisible(true)
	self._clickSleepAnim:setVisible(false)

	self._gameFinish = false

	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local rid = developSystem:getRid()
	local boss = self._worldPeaceSystem:getBoss()
	local boll = self._wordPeaceGame:getMemberFactory():getMemberById(rid)

	if boll and index == #atkShowList then
		if boll._line then
			boll._line:setColorTransform(ColorTransform(1, 1, 1, 1))
		end

		boll:getDisplayNode():setOpacity(255)
	end

	local btnStr = Strings:get("ClubBoss_Tips_02")

	if self._canAtk then
		local value = 60 * math.modf(self._canAtk) / atkTime
		local timeStr = TimeUtil:formatTimeStr(self._canAtk)

		self._timeLabel:setString(timeStr)
		self._timeLabel:setVisible(true)
	elseif self._sleep then
		self._clickSleepAnim:setVisible(true)
		self._clickSleepAnim:gotoAndStop(1)

		local timeStr = TimeUtil:formatTimeStr(self._sleep + 1)

		self._timeLabel:setString(timeStr)
		self._timeLabel:setVisible(true)
		self._timeLabel:setLocalZOrder(9999)

		btnStr = Strings:get("ClubBoss_Tips_03")

		if atkTimes <= clubBoss:getTwoAtkTimes() then
			self._gameFinish = true

			self._clickSleepAnim:setVisible(true)
			self._clickSleepAnim:gotoAndStop(1)
			self._btnName:setString(Strings:get("ClubBoss_Tips_04"))
			self._timeLabel:setVisible(false)
		end
	elseif changeTime > sleepTime + atkTime and atkTimes <= clubBoss:getTwoAtkTimes() then
		self._gameFinish = true

		self._clickSleepAnim:setVisible(true)
		self._clickSleepAnim:gotoAndStop(1)

		btnStr = Strings:get("ClubBoss_Tips_04")
	end

	if self._btnName.btnStr and self._btnName.btnStr == btnStr then
		return
	end

	self._btnName:setString(btnStr)

	self._btnName.btnStr = btnStr
end

function WorldPeaceBossStageTwoMediator:startMainLoop(boss)
	self._wordPeaceGame = WordPeaceGame:new({
		ballCreater = WorldPeaceClubBossStageTwoBall,
		bossCreater = WorldPeaceStageTwoBoss
	})

	self._wordPeaceGame:setDisplayStage(self:getView())
	self._wordPeaceGame:setDisplayMode(K_RENDER_DISPLAYMODE.ALL)
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
	self._wordPeaceGame:getMemberFactory():setRandomPosRadius({
		280,
		350,
		320,
		450,
		500
	})
	self._wordPeaceGame:getMemberFactory():setRandomPosConfig({
		{
			maxnum = 20,
			radio = 18
		},
		{
			maxnum = 40,
			radio = 15
		},
		{
			maxnum = 48,
			radio = 5
		},
		{
			maxnum = 200,
			radio = 3
		},
		{
			maxnum = 800,
			radio = 2
		}
	})

	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()
	local rid = developSystem:getRid()
	local clubBoss = self._clubSystem:getClubBossNew()
	local heroes = clubBoss:getHeroes()
	local teamInfo = {
		def = 1,
		gId = "1",
		sp = 1,
		curHp = 0,
		maxHp = 1,
		isMyth = true,
		hpr = 0,
		atk = 1,
		nickName = playerName,
		teamKey = rid,
		rid = rid,
		heroId = heroes[1],
		atkList = {},
		posInfo = {
			distance = 450,
			radio = -21.4,
			pos = cc.p(1030, 100)
		},
		buff = {}
	}

	if boss:getPB() and boss:getPB()[rid] then
		teamInfo.buff = boss:getPB()[rid]
	end

	local playerBoll = ClubBossBoll:new(teamInfo.teamKey)

	self._playerBoll = playerBoll

	playerBoll:setOwner(true)
	playerBoll:synchronize(teamInfo)

	boss:getATeams()[teamInfo.teamKey] = playerBoll
	self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self._wordPeaceGame:step(dt)
	end, 0.03333333333333333, false)

	self._wordPeaceGame:createBattleFieldByClubBossTwo(boss, cc.p(568, 280), {
		1,
		0.5
	})
	self._wordPeaceGame:addBollForClubBossStageTwo(self._bossId, playerBoll, 1.4, true)

	self._hurtscheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self:refreshHurt()
		self:refreshRank(boss)
	end, 1, false)

	self:refreshHurt()
	self:refreshRank(boss)
end

function WorldPeaceBossStageTwoMediator:refreshHurt()
	if self.isAskServer then
		return
	end

	self._worldPeaceSystem:clubBossHeart({}, false, function(response)
		if self._viewClose then
			return
		end

		if response.data and response.data.boss then
			self.isAskServer = false

			local boss = self._worldPeaceSystem:getBoss(self._worldPeaceSystem:changeBossData(response.data))

			self._wordPeaceGame:createBattleFieldByClubBossTwo(boss, cc.p(568, 380), {
				1,
				0.5
			})

			self._playerCount = 0

			if boss:getATeams() then
				for k, v in pairs(boss:getATeams()) do
					self._playerCount = self._playerCount + 1
				end
			end

			if data and data.collectInfo then
				for k, v in pairs(data.collectInfo) do
					if v == "reload" then
						self:backToCard(k)
					else
						self._wordPeaceGame:getMemberFactory():destoryMemberById(k)
					end
				end
			end

			self:refreshRank(boss)
			ClubBossNewCreateBuffNode(self, boss)
		end
	end)

	self.isAskServer = true
end

function WorldPeaceBossStageTwoMediator:stageOneRset(event)
	self:closeSche()

	local data = self._clubSystem:getClubBossNew()
	local boss = data:getBossById(bossId)

	self._worldPeaceSystem:tryEnterCLubBossFiled({
		stage = 1,
		hasAnim = true,
		bossId = self._bossId
	}, true, function()
		self:dismiss()
	end)
end

function WorldPeaceBossStageTwoMediator:bossDead(boss)
	self:closeSche()

	local mainAnim = cc.MovieClip:create("boss_bao2_qiuqiufengyin")

	mainAnim:addTo(self:getView(), 999):center(self:getView():getContentSize())
	mainAnim:addCallbackAtFrame(30, function()
		mainAnim:stop()
		self:dismiss()
		self._clubSystem:showResultView(self._bossId)
	end)
end

function WorldPeaceBossStageTwoMediator:refreshRank(bossData)
	self._infoPanel:setVisible(true)

	local rank = bossData:getRank()

	if rank then
		for i = 1, 3 do
			local data = rank[i]
			local rankNum1 = self._infoPanel:getChildByName("rank" .. i)
			local rankNum2 = self._infoPanel:getChildByName("rank" .. i .. "_0")

			rankNum1:setVisible(data ~= nil)
			rankNum2:setVisible(data ~= nil)

			if data then
				rankNum1:setString(i .. "   " .. tostring(data.n))
				rankNum2:setString(CurrencySystem:formatCurrencyString(data.h))
			end
		end
	end

	local ownerNum = self._infoPanel:getChildByName("owner")
	local ownerName = self._infoPanel:getChildByName("owner1")
	local ownerHurt = self._infoPanel:getChildByName("owner2")
	local ownerRank = bossData:getOwnerRank()
	local rank = ownerRank.rank

	if rank <= -1 then
		rank = nil
	end

	ownerNum:setVisible(rank ~= nil)
	ownerName:setVisible(rank ~= nil)
	ownerHurt:setVisible(rank ~= nil)

	if rank then
		ownerNum:setString(tostring(rank))
		ownerName:setString(tostring(ownerRank.n))
		ownerHurt:setString(tostring(CurrencySystem:formatCurrencyString(ownerRank.h)))
	end
end

function WorldPeaceBossStageTwoMediator:onHuiShou()
	return
end

function WorldPeaceBossStageTwoMediator:onPlayerSupport()
	return
end

function WorldPeaceBossStageTwoMediator:runSupportAnim()
	self._btnAnimRun = true

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickLimit", "content")
	local speed = 1 / clubBoss_ClickLimit

	self._clickAnim:setPlaySpeed(speed * 3)
	self._clickAnim:setVisible(true)
	self._clickAnim:gotoAndPlay(1)
	self._clickAnim:addEndCallback(function(cid, mc)
		self._btnAnimRun = false

		self._clickAnim:setVisible(false)
		self._clickAnim:stop()
	end)
end

function WorldPeaceBossStageTwoMediator:onSupport()
	if self._gameFinish then
		AudioEngine:getInstance():playEffect("Se_Alert_Error")
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubBoss_Tips_05")
		}))

		return
	end

	if self._sleep then
		AudioEngine:getInstance():playEffect("Se_Alert_Error")
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80803")
		}))

		return
	end

	if self._btnAnimRun then
		return
	end

	self:runSupportAnim()

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickLimit", "content")

	clubBoss_ClickLimit = clubBoss_ClickLimit * 1000

	local speed = 1

	if self._costtime then
		local changeTime = math.abs(self._costtime - os.clock())

		if clubBoss_ClickLimit <= changeTime then
			return
		end

		if changeTime > 2 then
			changeTime = 1.3
		end

		speed = changeTime * 0.1
	end

	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()
	local rid = developSystem:getRid()

	self._onBattle = true

	if self._onBattle then
		local boss = self._worldPeaceSystem:getBoss()

		if boss:getATeams()[rid] then
			boss:getATeams()[rid]:setPreviewSp(speed)
		end

		local boll = self._wordPeaceGame:getMemberFactory():getMemberById(rid)

		if boll then
			boll:resetTrans()
			boll:setState(K_WORLD_MEMBER_SATGE.Attack)
		end

		self._worldPeaceSystem:clubBossTwoStageAttack({
			ignoreErrorTips = true
		})

		return
	end

	self._costtime = os.clock()
end

function WorldPeaceBossStageTwoMediator:resumeWithData()
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
end

function WorldPeaceBossStageTwoMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")

	topInfoNode:setVisible(true)

	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

local WorldPeaceLayer = {
	LabelLayer = 10,
	BollLayer = 5,
	UnderLayer = 1,
	BossLayer = 3,
	EffectLayer = 20,
	UILayer = 30
}

function WorldPeaceBossStageTwoMediator:initBattleLayer()
	self._touchPoint = {}
	self._touchHeroInfo = nil
	self._canTouchScaleSta = false
	self._mapTouchMove = false
	self._scrollView = self:getView():getChildByName("map")
	self._innnerContainer = self._scrollView:getInnerContainer()

	self._scrollView:setScrollBarEnabled(false)

	local node = cc.Node:create()

	node:setName("UnderLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UnderLayer)

	local node = cc.Node:create()

	node:setName("BossLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.BossLayer)

	local node = cc.Node:create()

	node:setName("BollLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.BollLayer)

	local node = cc.Node:create()

	node:setName("LabelLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.LabelLayer)

	local node = cc.Node:create()

	node:setName("EffectLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.EffectLayer)

	local node = cc.Node:create()

	node:setName("UILayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UILayer)
end

function WorldPeaceBossStageTwoMediator:onClickBack()
	dump(self._playerCount, "_playerCount__playerCount")

	if self._playerCount and self._playerCount > 0 then
		self._clubSystem:getClubBossNew():setBattleNumIng(self._playerCount)
	end

	if self._closeCallBack then
		self._closeCallBack()
	end

	self:dismiss()
end

function WorldPeaceBossStageTwoMediator:selectBuff()
	self:refreshHurt()
end
