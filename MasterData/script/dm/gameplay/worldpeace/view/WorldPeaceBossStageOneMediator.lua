-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceBossStageOneMediator.lua

WorldPeaceBossStageOneMediator = class("WorldPeaceBossStageOneMediator", DmAreaViewMediator, _M)

WorldPeaceBossStageOneMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceBossStageOneMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

function WorldPeaceBossStageOneMediator:initialize()
	super.initialize(self)
end

function WorldPeaceBossStageOneMediator:dispose()
	self._viewClose = true

	self:closeAllSche()
	super.dispose(self)
end

function WorldPeaceBossStageOneMediator:closeAllSche()
	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end

	self:closeSchel()
end

function WorldPeaceBossStageOneMediator:closeSchel()
	if self._hurtscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._hurtscheduler)

		self._hurtscheduler = nil
	end
end

function WorldPeaceBossStageOneMediator:onRegister()
	super.onRegister(self)
end

function WorldPeaceBossStageOneMediator:enterWithData(data)
	data = data or {}
	self._bossId = data.bossId
	self._closeCallBack = data.closeCallBack
	self._infoPanel = self._view:getChildByName("infopanel")

	self._view:getChildByName("bg"):setLocalZOrder(-99)

	local btngo = self._view:getChildByName("btngo")

	self._btngo = btngo

	btngo:setVisible(true)
	btngo:setTouchEnabled(true)
	btngo:addClickEventListener(function()
		self:onSupport()
	end)

	self._btnGo = btngo
	self._btnName = btngo:getChildByName("Text_68")

	self._btnName:setString(Strings:get("Petrace_Text_81"))

	if not self._clickAnim then
		self._clickAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

		self._clickAnim:addTo(self._btnGo, 999):center(self._btnGo:getContentSize()):offset(0, -4)
	end

	self._clickAnim:setVisible(false)
	self:setupTopInfoWidget()
	self:initBattleLayer()
	self:startMainLoop(data.boss)
	self:checkAtkTimes()
	self:refreshBossList(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_ENTERTWO_REFRESH, self, self.enterTwo)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_PLAYERDEAD_REFRESH, self, self.playerDead)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_PLAYERUP_REFRESH, self, self.playerUp)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_GAMEOVER, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_SET_BUFF_SUCC, self, self.selectBuff)
end

function WorldPeaceBossStageOneMediator:refreshBossList(data)
	local factor = 0.3
	local offsetSize = AdjustUtils.getAdjustOffset()

	if data.leftBossId then
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

function WorldPeaceBossStageOneMediator:gameOver(event)
	self:closeAllSche()
	self:dismiss()
end

function WorldPeaceBossStageOneMediator:playerUp(event)
	self._btnName:setString(Strings:get("BATTLE_LABLE_ATK"))

	local data = event:getData()

	if data and data.playerInfoMap then
		local boss = self._worldPeaceSystem:getBoss()

		boss:synchronize({
			playerInfoMap = data.playerInfoMap
		})
	end

	self:refreshMyPlayer()
	self:checkAtkTimes()
end

function WorldPeaceBossStageOneMediator:bossDead(event)
	local mainAnim = cc.MovieClip:create("boss_bao2_qiuqiufengyin")

	mainAnim:addTo(self:getView(), 999):center(self:getView():getContentSize())

	local data = self._clubSystem:getClubBossNew()
	local boss = self._data:getBossById(bossId)

	self._worldPeaceSystem:tryEnterCLubBossFiled({
		stage = 2,
		hasAnim = true,
		bossId = self._bossId
	}, true)
	self:dismiss()
end

function WorldPeaceBossStageOneMediator:playerDead(event)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ClubBossNewEnemyView"), nil, {
		recover = true,
		bossId = self._bossId
	}))
end

function WorldPeaceBossStageOneMediator:enterTwo(event)
	self:closeAllSche()
	self._btngo:setVisible(false)

	local boss = self._wordPeaceGame:getMemberFactory():getMemberById(self._bossId)

	boss:getData():setCurHp(0)
	boss:updateInfo(boss:getData())

	local mainAnim = cc.MovieClip:create("boss_bao1_qiuqiufengyin")

	mainAnim:setPlaySpeed(0.8)
	mainAnim:addTo(self:getView(), 999):center(self:getView():getContentSize())
	mainAnim:addEndCallback(function(cid, mc)
		mc:stop()
		self._worldPeaceSystem:tryEnterCLubBossFiled({
			stage = 2,
			hasAnim = true,
			showTimeAnim = true,
			bossId = self._bossId
		}, true, function()
			self:dismiss()
		end)
	end)
end

function WorldPeaceBossStageOneMediator:refreshRank(bossData)
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

function WorldPeaceBossStageOneMediator:onHuiShou()
	return
end

function WorldPeaceBossStageOneMediator:onSupport()
	if self._btnAnimRun then
		return
	end

	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()

	self:runSupportAnim()

	local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)
	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickLimit", "content")

	clubBoss_ClickLimit = clubBoss_ClickLimit * 1000

	local speed = 1

	if self._costtime then
		local changeTime = math.abs(self._costtime - gameServerAgent:remoteTimestamp())

		self._costtime = gameServerAgent:remoteTimestamp()
		changeTime = changeTime * 1000

		if changeTime < clubBoss_ClickLimit then
			self._costtime = gameServerAgent:remoteTimestamp()

			return
		end

		if changeTime > 2 then
			changeTime = 1.3
		end

		speed = changeTime * 0.1
	end

	local rid = developSystem:getRid()

	if self._onBattle then
		local boss = self._worldPeaceSystem:getBoss()

		if boss:getATeams()[rid] then
			boss:getATeams()[rid]:setPreviewSp(speed)
		end

		local boll = self._wordPeaceGame:getMemberFactory():getMemberById(rid)

		if boll then
			boll:setAtk(boss:getMyAtk())
			boll:resetTrans()
			boll:setState(K_WORLD_MEMBER_SATGE.Attack)
		end

		self._worldPeaceSystem:clubBossOneStageAttack()

		return
	end

	self._onBattle = true

	local clubBoss = self._clubSystem:getClubBossNew()
	local boss = clubBoss:getBossById(self._bossId)
	local boll = self._wordPeaceGame:getMemberFactory():getMemberById(rid)

	if boll then
		local bollData = boll:getData()

		if bollData then
			local playerInfoMap = boss:getPlayerInfoMap()

			dump(playerInfoMap, "playerInfoMap_____playerInfoMap")

			local serverData = playerInfoMap[rid]

			if serverData then
				bollData:synchronize({
					isMyth = true,
					curHp = serverData.c,
					maxHp = serverData.m,
					heroId = serverData.h
				})
				boll:updateInfo(bollData)
			end
		end
	end

	local heroes = self._clubSystem:getClubBossNew():getHeroes()
	local teamInfo = {
		def = 1,
		gId = "1",
		sp = 1,
		curHp = -1,
		maxHp = 9999,
		isMyth = true,
		hpr = 0,
		nickName = playerName,
		teamKey = rid,
		atk = clubBoss:getOneAtk(),
		rid = rid,
		heroId = heroes[1],
		atkList = {},
		buff = {}
	}
	local boss = self._worldPeaceSystem:getBoss()

	if boss:getPB() and boss:getPB()[rid] then
		teamInfo.buff = boss:getPB()[rid]
	end

	boss:getATeams()[teamInfo.teamKey] = ClubBossBoll:new(teamInfo.teamKey)

	boss:getATeams()[teamInfo.teamKey]:synchronize(teamInfo)
	self._wordPeaceGame:addBollForClubBossStageOne(self._bossId, boss:getATeamByKey(teamInfo.teamKey), 1, true)
	self._btnName:setString(Strings:get("BATTLE_LABLE_ATK"))

	self._costtime = gameServerAgent:remoteTimestamp()
end

function WorldPeaceBossStageOneMediator:runSupportAnim()
	self._btnAnimRun = true

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_ClickLimit", "content")
	local speed = 1 / clubBoss_ClickLimit

	self._clickAnim:setPlaySpeed(speed * 2)
	self._clickAnim:setVisible(true)
	self._clickAnim:gotoAndPlay(1)
	self._clickAnim:addEndCallback(function(cid, mc)
		self._btnAnimRun = false

		self._clickAnim:setVisible(false)
		self._clickAnim:stop()
	end)
end

function WorldPeaceBossStageOneMediator:resumeWithData()
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
end

function WorldPeaceBossStageOneMediator:setupTopInfoWidget()
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

function WorldPeaceBossStageOneMediator:initBattleLayer()
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

function WorldPeaceBossStageOneMediator:startMainLoop(boss)
	self._wordPeaceGame = WordPeaceGame:new({
		ballCreater = WorldPeaceClubBossStageOneBall,
		bossCreater = WorldPeaceStageOneBoss
	})

	self._wordPeaceGame:setLabelCaptain(40)
	self._wordPeaceGame:setDisplayStage(self:getView())
	self._wordPeaceGame:setDisplayMode(K_RENDER_DISPLAYMODE.ALL)
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
	self._wordPeaceGame:getMemberFactory():setRandomPosRadius({
		230,
		300,
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

	self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self._wordPeaceGame:step(dt)
	end, 0.03333333333333333, false)

	self._wordPeaceGame:createBattleFieldByClubBoss(boss, cc.p(568, 280), {
		1,
		0.7
	})
	self:refreshRank(boss)

	self._hurtscheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self:refreshHurt()
		self:refreshMyPlayer()
	end, 1, false)

	self:refreshHurt()
	self:refreshMyPlayer()
end

function WorldPeaceBossStageOneMediator:refreshHurt()
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

			self._playerCount = 0

			if boss:getATeams() then
				for k, v in pairs(boss:getATeams()) do
					if v:getCurHp() > 0 then
						self._playerCount = self._playerCount + 1
					end
				end
			end

			local removeDatas = boss.removeDatas

			dump(removeDatas, "removeDatas___")
			self._wordPeaceGame:createBattleFieldByClubBoss(boss, cc.p(568, 380), {
				1,
				0.7
			})

			if removeDatas then
				for k, v in pairs(removeDatas) do
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

function WorldPeaceBossStageOneMediator:checkAtkTimes()
	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()
	local rid = developSystem:getRid()
	local boss = self._worldPeaceSystem:getBoss()
	local playerInfoMap = boss:getPlayerInfoMap()
	local clubBossNew = self._clubSystem:getClubBossNew()
	local resurgenceTimes = clubBossNew:getResurgenceTimes()
	local serverData = playerInfoMap[rid]

	dump(serverData, "serverData_____serverData")

	if serverData and serverData.c == 0 then
		local data = {
			battleEnter = true,
			recover = true,
			bossId = self._bossId
		}
		local var_29_0

		if resurgenceTimes.value == 0 then
			data = {
				battleEnter = true,
				recover = true,
				bossId = self._bossId
			}
			var_29_0 = self:getInjector():getInstance("ClubBossNewEnemyView")
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, var_29_0, nil, data))
	end

	self._btnGo:setVisible(true)

	if resurgenceTimes.value == 0 then
		local serverData = playerInfoMap[rid]

		if serverData and serverData.c == 0 then
			self._btnGo:setVisible(false)
		end
	end
end

function WorldPeaceBossStageOneMediator:refreshMyPlayer()
	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()
	local rid = developSystem:getRid()
	local boss = self._worldPeaceSystem:getBoss()
	local playerInfoMap = boss:getPlayerInfoMap()
	local clubBossNew = self._clubSystem:getClubBossNew()
	local resurgenceTimes = clubBossNew:getResurgenceTimes()

	self._btnGo:setVisible(true)

	if resurgenceTimes.value == 0 then
		local serverData = playerInfoMap[rid]

		if serverData and serverData.c == 0 then
			self._btnGo:setVisible(false)
		end
	end

	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local playerName = developSystem:getNickName()
	local rid = developSystem:getRid()
	local boss = self._worldPeaceSystem:getBoss()
	local playerInfoMap = boss:getPlayerInfoMap()
	local boll = self._wordPeaceGame:getMemberFactory():getMemberById(rid)

	if boll then
		local bollData = boll:getData()

		if bollData then
			local serverData = playerInfoMap[rid]

			if serverData then
				bollData:synchronize({
					isMyth = true,
					curHp = serverData.c,
					maxHp = serverData.m,
					heroId = serverData.h
				})
				boll:updateInfo(bollData)
			end
		end
	end
end

function WorldPeaceBossStageOneMediator:onClickBack()
	dump(self._playerCount, "_playerCount_____playerCount")

	if self._playerCount and self._playerCount > 0 then
		self._clubSystem:getClubBossNew():setBattleNumIng(self._playerCount)
	end

	if self._closeCallBack then
		self._closeCallBack()
	end

	self:dismiss()
end

function WorldPeaceBossStageOneMediator:selectBuff()
	self:refreshHurt()
end
