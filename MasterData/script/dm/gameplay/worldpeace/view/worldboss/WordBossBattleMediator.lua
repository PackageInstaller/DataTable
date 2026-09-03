-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WordBossBattleMediator.lua

WordBossBattleMediator = class("WordBossBattleMediator", WordPeaceBattleMediator, _M)

WordBossBattleMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordBossBattleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WordBossBattleMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
WordBossBattleMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	btn_rule = {
		func = "onClickRule"
	}
}

function WordBossBattleMediator:initialize()
	super.initialize(self)
end

function WordBossBattleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function WordBossBattleMediator:openRewardPanel()
	local view = self:getInjector():getInstance("WordBossFinishView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		cfg = self._curCfg,
		dmg = self._curDmg,
		bossId = self._bossId,
		parent = self
	}))
end

function WordBossBattleMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")
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

function WordBossBattleMediator:prepareBattle(data)
	self._wordPeaceGame = WordPeaceGame:new({
		bossCreater = WordBossBoss,
		ballCreater = WorldBossBall
	})

	self._wordPeaceGame:setDisplayStage(self:getView())
	self._wordPeaceGame:setDisplayMode(K_RENDER_DISPLAYMODE.WORLDBOSS)
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
end

function WordBossBattleMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local sequence = cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		self:getView():setVisible(true)
		storyDirector:setClickEnv("worldboss.btngo", self:getView():getChildByName("btngo"), function()
			self:onSupport(true)
		end)
		storyDirector:notifyWaiting("enter_WorldBossMediator")
	end))

	self:getView():runAction(sequence)
end

function WordBossBattleMediator:onInfoBtn()
	local selectNode = self._worldPeaceHandWidget:getSelectNode()

	if selectNode then
		local dispatcher = DmGame:getInstance()
		local view = dispatcher._injector:getInstance("WordPeaceTeamInfoView")

		dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			data = selectNode.teamInfo,
			wordPeace = self._wordPeaceGame
		}))
	end
end

function WordBossBattleMediator:enterWithData(data)
	super.enterWithData(self, data)

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() then
		self:getView():setVisible(false)
	end

	local huishou = self._view:getChildByName("btngo_0")

	huishou:setVisible(false)

	local infoBtn = self._view:getChildByName("btngo_0_0")

	infoBtn:setVisible(true)
	self:getView():getChildByName("barHP"):setPercent(0)
	self:updateHpExp()
	self:refreshRank()

	local boxBtn = self._view:getChildByName("box")

	boxBtn:setTouchEnabled(true)
	boxBtn:addClickEventListener(function()
		self._isOpenFinish = true

		local view = self:getInjector():getInstance("WordBossFinishView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			cfg = self._curCfg,
			dmg = self._curDmg,
			bossId = self._bossId,
			parent = self
		}))
	end)

	local fix_shijieboss = cc.MovieClip:create("loop_shijieboss")

	fix_shijieboss:addTo(boxBtn:getParent())
	fix_shijieboss:setPosition(boxBtn:getPosition())
	fix_shijieboss:setLocalZOrder(1)
	boxBtn:setLocalZOrder(2)
	fix_shijieboss:setName("boxAnim")

	local fix_shijieboss = cc.MovieClip:create("max_shijieboss")

	fix_shijieboss:addTo(boxBtn:getParent())
	fix_shijieboss:setPosition(boxBtn:getPosition())
	fix_shijieboss:setLocalZOrder(1)
	boxBtn:setLocalZOrder(2)
	fix_shijieboss:setName("boxMaxAnim")
	fix_shijieboss:setVisible(true)
	boxBtn:changeParent(fix_shijieboss:getChildByName("box"))
	boxBtn:center(fix_shijieboss:getChildByName("box"):getContentSize())
	fix_shijieboss:gotoAndStop(1)

	self._boxAnim = fix_shijieboss

	fix_shijieboss:addEndCallback(function(cid, mc)
		fix_shijieboss:gotoAndStop(1)
	end)
	self:updateBottomView()
	self:setupClickEnvs()
	self:mapEventListeners()

	local btngoTxt = self._view:getChildByFullName("btngo.Text_68")

	btngoTxt:setVisible(false)
end

function WordBossBattleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.refreshBattleField)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_PLAYER_REFRESH, self, self.updateBottomView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORLDBOSSHP_REFRESH, self, self.updateHpExp)
end

function WordBossBattleMediator:getSortRankList()
	self._rankMap = self._worldPeaceSystem:getWorldBoss():getRankMap()

	local list = {}

	for k, v in pairs(self._rankMap) do
		list[#list + 1] = v
	end

	table.sort(list, function(a, b)
		return a.hurt > b.hurt
	end)

	for i, v in pairs(list) do
		self._rankMap[v.rid].rank = i
	end

	return list
end

function WordBossBattleMediator:refreshRank()
	self._rankMap = self._worldPeaceSystem:getWorldBoss():getRankMap()

	local rankList = self:getSortRankList()
	local list = self:getView():getChildByFullName("rankinfo.list")
	local cell = self:getView():getChildByFullName("rankinfo.cell")

	list:removeAllItems()
	list:setScrollBarEnabled(false)

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local rid = player:getRid()

	for k, v in pairs(rankList) do
		local cell_ = cell:clone()

		cell_:getChildByName("name"):setString(v.nickName)
		cell_:getChildByName("value"):setString(CurrencySystem:formatCurrencyString(tonumber(math.floor(v.hurt))))
		cell_:getChildByName("rank"):setString(k)
		list:pushBackCustomItem(cell_)

		if v.rid == rid then
			setTextWithFontStyle(cell_:getChildByName("name"), "FontNumberText")
			setTextWithFontStyle(cell_:getChildByName("value"), "FontNumberText")
			setTextWithFontStyle(cell_:getChildByName("rank"), "FontNumberText")
		else
			setTextWithFontStyle(cell_:getChildByName("name"), "FontTipsText")
			setTextWithFontStyle(cell_:getChildByName("value"), "FontTipsText")
			setTextWithFontStyle(cell_:getChildByName("rank"), "FontTipsText")
		end
	end

	local myData = self._rankMap[rid]

	if not myData then
		myData = {
			nickName = player:getNickName(),
			rid = player:getRid()
		}
		myData.hurt = 0
		myData.rank = -1
	end

	local list = self:getView():getChildByFullName("rankinfo.Image_65_0")

	list:getChildByName("rank_0"):setString(CurrencySystem:formatCurrencyString(tonumber(math.floor(myData.hurt))))
	list:getChildByName("rank"):setString(myData.rank)
	list:getChildByName("rank_1"):setString(myData.nickName)
	list:getChildByName("rank_0"):setVisible(myData.rank > 0)
	list:getChildByName("rank"):setVisible(myData.rank > 0)
	list:getChildByName("rank_1"):setVisible(myData.rank > 0)
	list:getChildByName("norank"):setVisible(myData.rank < 0)
end

function WordBossBattleMediator:startMainLoop()
	local status = self._worldPeaceSystem:getWorldBoss():getStatus()

	if self._worldPeaceSystem:getWorldBoss():getRewardStatus() == 1 or status == WorldBossStatus.kFinish then
		self:battleEnd(true)

		return
	end

	self._matchBollList = self._worldPeaceSystem:getWorldBoss():getMatchBollList()
	self._attackList = self._worldPeaceSystem:getWorldBoss():getAttackBollList()

	self._wordPeaceGame:setHandLogic(self._worldPeaceHandWidget)

	self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self._wordPeaceGame:step(dt)
		self._worldPeaceSystem:step(dt)
		self:update()
	end, 0.03333333333333333, false)

	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)

	self._wordPeaceGame:createBattleFieldByBoss(bossData, cc.p(568, 350), {
		0.8,
		0.7
	})

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques, self._bossId)
	self:initMatchPlayerBolls()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() then
		local challengeTime = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content
		local timeText = self:getView():getChildByFullName("Panel_time.Text_time")

		timeText:setString(TimeUtil:formatTime("${MM}:${SS}", math.max(0, challengeTime)))

		return
	end

	self:startTimer()
end

function WordBossBattleMediator:startTimer()
	local challengeTime = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content
	local timeText = self:getView():getChildByFullName("Panel_time.Text_time")
	local worldBoss = self._worldPeaceSystem:getWorldBoss()
	local count = 0

	timeText:setString(TimeUtil:formatTime("${MM}:${SS}", math.max(0, challengeTime)))

	local function update()
		local startAttackTime = worldBoss:getLastAttackTime() * 0.001
		local curTime = self._gameServerAgent:remoteTimestamp()
		local remainTime = challengeTime + startAttackTime - curTime

		timeText:setString(TimeUtil:formatTime("${MM}:${SS}", math.max(0, remainTime)))

		if remainTime <= 0 then
			self:battleEnd()
		end

		if count > 0 then
			self:addMatchPlayerBollForBoss()
		end

		count = count + 1

		self:refreshRank()
	end

	self._worldBossTimer = LuaScheduler:getInstance():schedule(update, 1, true)
end

function WordBossBattleMediator:updateHpExp(event)
	local data = {}

	if event then
		data = event:getData()
	else
		data.isMyth = true
	end

	if data.isMyth and (not data.actor or data.actor:getSp() ~= 2 or true) then
		local bossCfg = ConfigReader:getRecordById("WorldBoss", self._bossId)
		local battleField = self._worldPeaceSystem:getBattlefield()
		local bossData = battleField:getBossById(self._bossId)
		local index = bossData:getIndex()
		local curCfg = bossCfg.DmgReward[index + 1]
		local maxHp = curCfg.Blood
		local curHp = bossData:getHpr()

		if self:getView():getChildByName("barHP"):getPercent() > curHp / maxHp * 100 and self._boxAnim then
			self._boxAnim:gotoAndPlay(1)
		end

		self:getView():getChildByFullName("bg2.cnt"):setString("x" .. index)
		self:getView():getChildByName("hp"):setString(curHp .. "/" .. maxHp)
		self:getView():getChildByFullName("bg2"):setLocalZOrder(10)

		self._curCfg = curCfg
		self._curDmg = curHp

		self:getView():getChildByName("barHP"):runAction(PercentTo:create(0.1, curHp / maxHp * 100))

		if curHp == 0 and not self._changeBoss and not self._battleEnd then
			if index + 1 < #bossCfg.DmgReward then
				self._changeBoss = true

				self:changeNextBoss()
			else
				self:battleEnd()
			end
		end
	end

	self:refreshMatchHurt(data.actor)
end

function WordBossBattleMediator:changeNextBoss()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)
	local param = {
		hurt = bossData:getMhp() - bossData:getHpr(),
		bossId = self._bossId
	}

	self._worldPeaceSystem:worldBossFinish(param, true, function()
		self._changeBoss = false

		local battleField = self._worldPeaceSystem:getBattlefield()
		local bossData = battleField:getBossById(self._bossId)

		self._wordPeaceGame:changeNextWorldBoss(bossData)
	end)
end

function WordBossBattleMediator:refreshBattleField(data)
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)

	self._wordPeaceGame:clearQueueCommond()
	self._wordPeaceGame:createBattleFieldByBoss(bossData, cc.p(568, 350), {
		0.8,
		0.7
	})

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques, self._bossId)

	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	self._worldPeaceHandWidget:updateInfo(playerInfo)

	local data = data:getData()

	if data and data.collectInfo then
		for k, v in pairs(data.collectInfo) do
			if v == "reload" then
				self:backToCard(k)
			else
				self._wordPeaceGame:getMemberFactory():destoryMemberById(k)
			end
		end
	end

	self._refreshLogSwitch = self._refreshLogSwitch or 0

	if self._refreshLogSwitch % 10 == 0 then
		self:refreshRank()
	end

	self._refreshLogSwitch = self._refreshLogSwitch + 1

	local wordBoss = self._developSystem:getWorldBoss()
end

function WordBossBattleMediator:checkTeamState()
	return true
end

function WordBossBattleMediator:getAttackFunction()
	return self._worldPeaceSystem.attackWordBossBoss
end

function WordBossBattleMediator:getSpeedUpFunction()
	return self._worldPeaceSystem.worldBossSpeedUp
end

function WordBossBattleMediator:setUpBottomView()
	local bottomnode = self:getView():getChildByName("bottomnode")
	local worldPeaceHandWidget = WorldBossHandWidget:new(bottomnode, self)

	self:getInjector():injectInto(worldPeaceHandWidget)

	self._worldPeaceHandWidget = worldPeaceHandWidget

	self:updateBottomView()
end

function WordBossBattleMediator:handleBgDisplayMode()
	return
end

function WordBossBattleMediator:battleEnd(notRequest)
	self._battleEnd = true

	if self._worldBossTimer then
		self._worldBossTimer:stop()

		self._worldBossTimer = nil
	end

	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)

	bossData:setATeams({})

	for k, v in pairs(playerInfo:getTeamDataList()) do
		playerInfo:getTeamStatus()[k] = "REST"

		self._wordPeaceGame:getMemberFactory():destoryMemberById(k)
	end

	if self._matchBollList then
		for i, bollList in pairs(self._matchBollList) do
			for i, boll in pairs(bollList) do
				self._wordPeaceGame:getMemberFactory():destoryMemberById(boll:getTeamKey())
			end
		end
	end

	self._worldPeaceHandWidget:updateInfo(playerInfo)

	if notRequest then
		self:openRewardPanel()
	else
		local param = {
			hurt = bossData:getMhp() - bossData:getHpr(),
			bossId = self._bossId
		}

		self._worldPeaceSystem:worldBossFinish(param, true, function()
			if not self._isOpenFinish then
				self._isOpenFinish = true

				self:openRewardPanel()
			else
				self:dispatch(Event:new(EVT_WORDPEACE_BATTLEFEILD_REFRESH))
			end
		end)
	end
end

function WordBossBattleMediator:refreshOprateBtn()
	local selectNode = self._worldPeaceHandWidget:getSelectNode()

	if not selectNode then
		return
	end

	local v = selectNode.teamInfo
	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	if self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST then
		self._view:getChildByName("btngo"):loadTexture("Worldboss_btn_gongji.png", ccui.TextureResType.plistType)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Attack"))
		self._view:getChildByName("btngo"):setVisible(true)
		self._view:getChildByName("btngo_0"):setVisible(false)
	elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING then
		self._view:getChildByName("btngo"):loadTexture("Worldboss_btn_gongji.png", ccui.TextureResType.plistType)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Speedup"))
		self._view:getChildByName("btngo"):setVisible(true)
		self._view:getChildByName("btngo_0"):setVisible(true)
	elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING then
		self._view:getChildByName("btngo"):setVisible(false)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Protecting"))
		self._view:getChildByName("btngo_0"):setVisible(true)
	end

	local canAttack = self._worldPeaceSystem:checkCanAttack(self._bossId, v.camp)

	self._view:getChildByName("btngo"):setVisible(true)
	self._view:getChildByName("btngo_0"):setVisible(false)
end

function WordBossBattleMediator:isCanAttack(teamKey)
	local limit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossMin", "content")
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local teamData = playerInfo:getTeamDataList()[teamKey]
	local heroDataList = teamData.heroDataList

	if limit <= table.nums(heroDataList) then
		return true
	end

	return false
end

function WordBossBattleMediator:onSupport(isGuide)
	if self._btnAnimRun then
		return
	end

	local function handle()
		if not self._worldPeaceSystem:isBattleTime() then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Error_80604")
			}))
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		if self._worldPeaceHandWidget then
			local selectNode = self._worldPeaceHandWidget:getSelectNode()

			if selectNode then
				local teamInfo = selectNode.teamInfo

				if not self:isCanAttack(teamInfo.teamKey) then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Error_80604")
					}))
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

					return
				end

				if self._worldPeaceSystem:getTeamState(teamInfo.teamKey) == k_TEAM_STATE.BATTLEING then
					self:runSupportAnim()

					self._view:getChildByName("btngo").__cntnum = self._view:getChildByName("btngo").__cntnum or 0
					self._view:getChildByName("btngo").__cntnum = self._view:getChildByName("btngo").__cntnum + 1

					local delay = cc.DelayTime:create(5)
					local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
						self._view:getChildByName("btngo").__cntnum = 0
					end))

					self._view:getChildByName("btngo"):runAction(sequence)

					local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(teamInfo.teamKey)

					if self._view:getChildByName("btngo").__cntnum >= 0 or memeber and memeber:getSp() == 1 then
						if memeber then
							local sp = memeber:getSpCount() or 1
							local spConfig = self._worldPeaceSystem:getWorldBossSpeed()

							if sp < 3 then
								memeber:setSpCount(sp + 1)
								memeber:setSp(spConfig[sp + 1])
								memeber:resetTrans()
								memeber:setState(K_WORLD_MEMBER_SATGE.Attack)
								self:refreshOprateBtn()
							end
						end

						self._view:getChildByName("btngo").__cntnum = 0
					end

					return
				end

				if self._worldPeaceSystem:getTeamState(teamInfo.teamKey) ~= k_TEAM_STATE.REST then
					return
				end

				if not self:checkTeamState(selectNode) then
					return
				end

				self:runSupportAnim()

				local boss = self._worldPeaceSystem:getBattlefield():getBossById(self._bossId)
				local playerInfo = self._worldPeaceSystem:getMainPlayer()
				local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
				local player = developSystem:getPlayer()
				local heroInfo = teamInfo.heroDataList[teamInfo.topHero]
				local rate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleFloorHurt", "content")
				local bossCfg = ConfigReader:getRecordById("WorldBoss", self._bossId)
				local debugData = {
					def = 0,
					gId = "3",
					sp = 1,
					isMyth = true,
					spCount = 1,
					nickName = player:getNickName(),
					teamKey = teamInfo.teamKey,
					atk = math.max(heroInfo.atk - bossCfg.Def, heroInfo.atk * rate),
					heroId = teamInfo.topHero,
					hpr = selectNode.curHp,
					rid = player:getRid(),
					st = teamInfo.st,
					ra = teamInfo.ra,
					cPos = playerInfo:getCPos(),
					mPhase = playerInfo:getMPhase()
				}
				local boss = self._worldPeaceSystem:getBattlefield():getBossById(self._bossId)

				boss:getATeams()[teamInfo.teamKey] = Boll:new(teamInfo.teamKey)

				boss:getATeams()[teamInfo.teamKey]:synchronize(debugData)
				boss:getATeams()[teamInfo.teamKey]:setGInfo(playerInfo:getGroupInfo())
				boss:getATeams()[teamInfo.teamKey]:setIsProtect(false)
				boss:getATeams()[teamInfo.teamKey]:setOrder(1)

				local teamList = self._worldPeaceSystem:getMainPlayer():getTeamDataList()
				local player = {}

				player.teamStatus = {}

				for k, v in pairs(teamList) do
					local status = self._worldPeaceSystem:getMainPlayer():getTeamStatus()[k]

					if not status then
						player.teamStatus[k] = "REST"
					end

					player.teamStatus[k] = status
					player.teamStatus[teamInfo.teamKey] = self._bossId
				end

				self._worldPeaceSystem:getMainPlayer():synchronize({
					player = player
				})

				local bossInstance = self._wordPeaceGame:getMemberFactory():getMemberById(self._bossId)

				self._wordPeaceGame:addBollForBossRightNow({
					isAtk = true,
					scale = 0.8,
					boss = bossInstance,
					bolldata = boss:getATeams()[teamInfo.teamKey]
				})
				self._worldPeaceHandWidget:updateInfo(playerInfo)
				self._view:getChildByName("btngo_0"):setVisible(true)
				self:refreshOprateBtn()
			end
		end
	end

	if isGuide then
		self._worldPeaceSystem:startAttackWordBoss({}, true, function()
			self._worldPeaceSystem:createMatchPlayerBoll(self._bossId)

			local playerInfo = self._worldPeaceSystem:getMainPlayer()

			self._worldPeaceHandWidget:updateInfo(playerInfo, true)
			handle()
			self:startTimer()
		end)
	else
		handle()
	end
end

function WordBossBattleMediator:onClickBack()
	if self._closeCallBack then
		self._closeCallBack()
	end

	if not self._battleEnd then
		local battleField = self._worldPeaceSystem:getBattlefield()
		local bossData = battleField:getBossById(self._bossId)
		local param = {
			hurt = bossData:getMhp() - bossData:getHpr(),
			bossId = self._bossId
		}

		self._worldPeaceSystem:getWorldBoss():setStatus(WorldBossStatus.kContinue)
		self._worldPeaceSystem:worldBossFinish(param, true, function()
			return
		end)
	elseif self._worldPeaceSystem:getWorldBoss():getRewardStatus() == 1 then
		self._worldPeaceSystem:getWorldBoss():setStatus(WorldBossStatus.kOver)
	end

	self:dismiss()
end

function WordBossBattleMediator:initMatchPlayerBolls()
	self._matchBollList = self._worldPeaceSystem:getWorldBoss():getMatchBollList()
	self._attackList = self._worldPeaceSystem:getWorldBoss():getAttackBollList()

	if #self._matchBollList > 0 then
		for i, boll in pairs(self._attackList) do
			self._wordPeaceGame:addBollForBoss(self._bossId, boll, 0.7, true)
		end
	end
end

function WordBossBattleMediator:addMatchPlayerBollForBoss()
	for i, bollList in pairs(self._matchBollList) do
		local random1 = math.random(1, 10)

		if random1 < 10 then
			local random = math.random(1, #bollList)
			local boll = bollList[random]

			if boll then
				local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(boll:getTeamKey())

				if memeber then
					self:changeBollSp(boll:getTeamKey(), boll)
				else
					self._wordPeaceGame:addBollForBoss(self._bossId, boll, 0.7, true)

					self._attackList[#self._attackList + 1] = boll
				end
			end
		end
	end
end

function WordBossBattleMediator:changeBollSp(teamKey, boll)
	local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(teamKey)

	if memeber then
		local sp = memeber:getSpCount()
		local spConfig = self._worldPeaceSystem:getWorldBossSpeed()

		if sp < 3 then
			memeber:setSpCount(math.min(sp + 1, 3))
			memeber:setSp(spConfig[memeber:getSpCount()])
			memeber:resetTrans()
			memeber:setState(K_WORLD_MEMBER_SATGE.Attack)
			boll:setSp(spConfig[memeber:getSpCount()])
			boll:setSpCount(math.min(sp + 1, 3))
		end
	end
end

function WordBossBattleMediator:refreshMatchHurt(boll)
	if not boll then
		return
	end

	local bollData = boll:getBollData()

	self._rankMap = self._worldPeaceSystem:getWorldBoss():getRankMap()

	if not self._rankMap[bollData:getRid()] then
		self._rankMap[bollData:getRid()] = {}
		self._rankMap[bollData:getRid()].nickName = bollData:getNickName()
		self._rankMap[bollData:getRid()].rid = bollData:getRid()
		self._rankMap[bollData:getRid()].hurt = 0
	end

	self._rankMap[bollData:getRid()].hurt = self._rankMap[bollData:getRid()].hurt + bollData:getAtk()
end

function WordBossBattleMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossRule", "content")
	local timeList = self._worldPeaceSystem:getWorldBossExtraRewardTime()
	local param = {}

	param.Time = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content

	local count = 0

	for i, time in pairs(timeList) do
		count = count + 1
		param["Time" .. count] = TimeUtil:localDate("%H:%M", time.startT)
		count = count + 1
		param["Time" .. count] = TimeUtil:localDate("%H:%M", time.endT)
	end

	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = param
	}))
end
