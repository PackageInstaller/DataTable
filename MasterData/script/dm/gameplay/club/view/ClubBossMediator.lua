-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossMediator.lua

ClubBossMediator = class("ClubBossMediator", DmAreaViewMediator)

ClubBossMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubBossMediator:has("_heroSystem", {
	is = "r"
}):injectWith("HeroSystem")
ClubBossMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ClubBossMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.bottomAttackNode.challenge_btn"] = {
		ignoreClickAudio = false,
		func = "onClickChallenge"
	},
	["main.heroNode.bossPanel.bossInfoNode.heroPanel"] = {
		ignoreClickAudio = false,
		func = "onClickHeroPanel"
	},
	["main.bottomAttackNode.infoBtn"] = {
		ignoreClickAudio = false,
		func = "onClickInfoBtn"
	},
	["main.bottomAttackNode.rankPanel"] = {
		ignoreClickAudio = false,
		func = "onClickRankPanel"
	},
	["main.bottomAttackNode.recordPanel"] = {
		ignoreClickAudio = false,
		func = "onClickRecordPanel"
	},
	["main.rewardNode.boxNode.boxPanel"] = {
		ignoreClickAudio = false,
		func = "onClickBox"
	},
	["main.rewardNode.butonNode.btnPanel"] = {
		ignoreClickAudio = false,
		func = "onClickShowReward"
	},
	["main.heroNode.left.button"] = {
		ignoreClickAudio = false,
		func = "onLeftClick"
	},
	["main.heroNode.right.button"] = {
		ignoreClickAudio = false,
		func = "onRightClick"
	}
}

function ClubBossMediator:initialize()
	super.initialize(self)
end

function ClubBossMediator:dispose()
	self:stopTimer()
	self:dispatch(Event:new(EVT_CLUBOSSREDPOINT_REFRESH))
	super.dispose(self)
end

function ClubBossMediator:onRegister()
	self._heroSystem = self._developSystem:getHeroSystem()

	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()

	self._showChallengeNode = false
	self._showInfoNode = false
	self._doingKillAnim = false
	self._goToBack = false
	self._delayDoKillAnim = false
end

function ClubBossMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_REFRESH, self, self.onDoRefrsh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_REFRESH_HURTANDHP, self, self.refreshHurtAndHp)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_REFRESH_BATTLECOUNT, self, self.refreshBattleCount)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_KILLED, self, self.doBossKilledLogic)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_BACKMAINVIEW, self, self.onBackToThisView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_REFRESH_HURTREWARD, self, self.onDoRefrshHurtReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.onForcedLevel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_RESET_DONE, self, self.doReset)
end

function ClubBossMediator:enterWithData(data)
	if data and data.viewType then
		self._viewType = data.viewType
	end

	self._goToBack = false
	self._doingKillAnim = false
	self._enterDoKillAnim = false
	self._delayDoKillAnim = false

	self:initData()
	self:initNodes()
	self:setupTopInfoWidget()
	self:doSomeNotChangeUI()
	self:doSomeChangeUI()
	self:runStartAction()
	self:checkSomethingAfterBattleWhenChangeSecen()

	if self._viewType == ClubHallType.kActivityBoss and self._clubSystem:getClubBossKilled(self._viewType) and data and data.goToActivityBoss == true then
		self._enterDoKillAnim = true
	end

	if self._viewType == ClubHallType.kBoss then
		if self._clubSystem:getClubBossKilled(self._viewType) and data and data.goToBoss == true then
			self._enterDoKillAnim = true
			self._killNum = self._clubSystem:getClubKillPoint()
		end

		self._clubSystem:resetClubBossTabRed()
	end

	self:setupClickEnvs()
end

function ClubBossMediator:setViewType(viewType)
	self._viewType = viewType
end

function ClubBossMediator:onDoRefrsh(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	self:refreshData()
	self:refreshView()
end

function ClubBossMediator:onDoRefrshHurtReward(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	self:refreshData()

	if self._clubBossInfo:getHurt() < self._clubBossInfo:getHurtTarget() then
		self._rewardBoxImage1:setVisible(true)
		self._rewardBoxImage2:setVisible(false)
		self._rewardBoxImage3:setVisible(false)
	end

	if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() then
		self._rewardBoxImage1:setVisible(false)
		self._rewardBoxImage2:setVisible(false)
		self._rewardBoxImage3:setVisible(false)

		if self._clubBossInfo:getHasGetHurtAward() == false then
			self._rewardBoxImage2:setVisible(true)
		end

		if self._clubBossInfo:getHasGetHurtAward() == true then
			self._rewardBoxImage3:setVisible(true)
		end
	end
end

function ClubBossMediator:onBackToThisView(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	if self._delayDoKillAnim then
		self._delayDoKillAnim = false

		self:doBossKilledAnim()
	end
end

function ClubBossMediator:checkSomethingAfterBattleWhenChangeSecen()
	local reward = self._clubSystem:getKillReward()

	if reward then
		self._clubSystem:clearKillReward()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = false,
			rewards = reward
		}))
	end
end

function ClubBossMediator:afterBattle(event)
	local reward = self._clubSystem:getKillReward()

	if reward then
		self._clubSystem:clearKillReward()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = false,
			rewards = reward
		}))
	end
end

function ClubBossMediator:isKillPoint()
	local clubBlockPointNum = 6
	local ids = string.split(self._nowId, "_")
	local tmpNum = tonumber(ids[2]) % clubBlockPointNum

	if tmpNum == 0 then
		tmpNum = clubBlockPointNum
	end

	if tmpNum == self._killNum then
		return true
	end
end

function ClubBossMediator:refreshHurtAndHp(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	if not self:isKillPoint() then
		return
	end

	self:refreshData()

	if self._clubBossInfo ~= nil then
		self._rewardCurrentExp:setString(tostring(self._clubBossInfo:getHurt()))
		self._rewardMaxExp:setString("/" .. tostring(self._clubBossInfo:getHurtTarget()))
		self._rewardLoadingBar:setPercent(self._clubBossInfo:getHurt() / self._clubBossInfo:getHurtTarget() * 100)

		if self._currentBossPoints:getId() == self._nowId then
			self._heroLoadingBar:setPercent(100 - self._clubBossInfo:getHpRate() * 100)
		elseif self._clubBossInfo:isBossPassed(self._currentBossPoints:getId()) then
			self._heroLoadingBar:setPercent(0)
		else
			self._heroLoadingBar:setPercent(100)
		end

		local maxHp = math.floor(self._currentBossPoints:getBossHp() + 0.5)
		local curHp = math.floor(maxHp * self._clubBossInfo:getHpRate() + 0.5)

		self._heroLoadingText:setString(tostring(curHp) .. "/" .. tostring(maxHp))

		if self._clubBossInfo:getHurt() < self._clubBossInfo:getHurtTarget() then
			self._rewardBoxImage1:setVisible(true)
			self._rewardBoxImage2:setVisible(false)
			self._rewardBoxImage3:setVisible(false)
		end

		if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() then
			self._rewardBoxImage1:setVisible(false)
			self._rewardBoxImage2:setVisible(false)
			self._rewardBoxImage3:setVisible(false)

			if self._clubBossInfo:getHasGetHurtAward() == false then
				self._rewardBoxImage2:setVisible(true)
			end

			if self._clubBossInfo:getHasGetHurtAward() == true then
				self._rewardBoxImage3:setVisible(true)
			end
		end
	end
end

function ClubBossMediator:refreshData()
	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(self._viewType)
	self._currentBossPoints = self._clubBossInfo:getBossPointsById(self._nowId)
end

function ClubBossMediator:refreshView()
	self:refreshRedPoint()
	self:setScore()
	self:doSomeChangeUI()
end

function ClubBossMediator:refreshViewWithAnim(useAnim)
	self._goToBack = false
	self._doingKillAnim = false

	self:doSomeNotChangeUI()
	self:doSomeChangeUI()
	self:runStartAction()
	self:refreshRedPoint()
end

function ClubBossMediator:refreshRedPoint()
	local redPoint = self._mainPanel:getChildByFullName("rewardNode.butonNode.redPoint")

	redPoint:setVisible(self._clubBossInfo:checkHasRewardCanGet())
end

function ClubBossMediator:initData()
	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(self._viewType)
	self._nowId = self._clubBossInfo:getNowPoint()
	self._currentBossPoints = self._clubBossInfo:getBossPointsById(self._nowId)
end

function ClubBossMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._mainBg = self._mainPanel:getChildByFullName("ImageBg")
	self._timeNode = self._mainPanel:getChildByFullName("timeNode")

	self._timeNode:setVisible(false)

	self._integralNode = self._mainPanel:getChildByFullName("integralNode")

	self._integralNode:setVisible(false)

	self._integralButton = self._integralNode:getChildByFullName("infoButton")
	self._bossPanel = self._mainPanel:getChildByFullName("heroNode.bossPanel")
	self._battleAnimNode = self._bossPanel:getChildByFullName("battleAnimNode")

	self._battleAnimNode:setVisible(false)

	self._talkNode = self._bossPanel:getChildByFullName("talkNode")
	self._talkText = self._talkNode:getChildByFullName("Text_talk")
	self._rewardPanel = self._mainPanel:getChildByFullName("rewardNode.rewardPanel")
	self._roundLab = self._mainPanel:getChildByFullName("zhoumuNode.num")
	self._heroNode = self._bossPanel:getChildByFullName("bossInfoNode.heroNode")
	self._heroInfoNode = self._bossPanel:getChildByFullName("bossInfoNode.infoNode")
	self._heroLoadingBar = self._heroInfoNode:getChildByFullName("barNode.loadingBar")
	self._heroLoadingText = self._heroInfoNode:getChildByFullName("barNode.loadingText")
	self._heroNameText = self._heroInfoNode:getChildByFullName("nameNode.nameText")
	self._heroSkillNode = self._heroInfoNode:getChildByFullName("skillNode")
	self._skillClonePanel = self._heroInfoNode:getChildByFullName("skillClonePanel")

	self._skillClonePanel:setVisible(false)

	self._skillTipPanel = self._heroInfoNode:getChildByName("skillTipPanel")

	self._skillTipPanel:setVisible(false)

	self._leftBtn = self._mainPanel:getChildByFullName("heroNode.left")
	self._rightBtn = self._mainPanel:getChildByFullName("heroNode.right")
	self._bottomAttackNode = self._mainPanel:getChildByFullName("bottomAttackNode")
	self._btnBasePanel = self._mainPanel:getChildByFullName("bottomAttackNode.btnPanel")

	self._btnBasePanel:setVisible(false)

	local textPanel1 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel1")

	textPanel1:setVisible(false)

	local textPanel2 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel2")

	textPanel2:setVisible(false)

	local textPanel3 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel3")

	textPanel3:setVisible(false)

	local textPanel4 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel4")

	textPanel4:setVisible(false)

	local attackPanel3 = self._mainPanel:getChildByFullName("bottomAttackNode.attackPanel3")

	attackPanel3:setVisible(false)

	local attackPanel4 = self._mainPanel:getChildByFullName("bottomAttackNode.attackPanel4")

	attackPanel4:setVisible(false)

	local desPanel = self._mainPanel:getChildByFullName("bottomAttackNode.desPanel")

	desPanel:setVisible(false)

	local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")

	haveHeroPanel:setVisible(false)

	local battleText = self._mainPanel:getChildByFullName("bottomAttackNode.battleText")

	battleText:setVisible(false)

	local rankPanel = self._mainPanel:getChildByFullName("bottomAttackNode.rankPanel")

	if self._viewType == ClubHallType.kActivityBoss then
		rankPanel:setVisible(false)
	end

	local recordPanel = self._mainPanel:getChildByFullName("bottomAttackNode.recordPanel")

	if self._viewType == ClubHallType.kActivityBoss then
		recordPanel:setVisible(false)
	end

	self._rewardLoadingBar = self._mainPanel:getChildByFullName("rewardNode.barNode.loadingBar")
	self._rewardCurrentExp = self._mainPanel:getChildByFullName("rewardNode.barNode.currentExp")
	self._rewardMaxExp = self._mainPanel:getChildByFullName("rewardNode.barNode.maxExp")
	self._rewardBoxImage1 = self._mainPanel:getChildByFullName("rewardNode.boxNode.boxImage1")
	self._rewardBoxImage2 = self._mainPanel:getChildByFullName("rewardNode.boxNode.boxImage2")
	self._rewardBoxImage3 = self._mainPanel:getChildByFullName("rewardNode.boxNode.boxImage3")

	local guide_panel_1 = self:getView():getChildByFullName("main.guide_panel_1")
	local guide_panel_2 = self:getView():getChildByFullName("main.guide_panel_2")
	local guide_panel_3 = self:getView():getChildByFullName("main.guide_panel_3")

	guide_panel_1:setVisible(false)
	guide_panel_2:setVisible(false)
	guide_panel_3:setVisible(false)

	self._passMask = self:getView():getChildByFullName("passMask")

	self._passMask:setLocalZOrder(9999)

	local anim = cc.MovieClip:create("eff_all_shetuantongguan")

	anim:setPosition(cc.p(693, 426))
	anim:addTo(self._passMask):offset(0, 0)
	anim:addEndCallback(function()
		anim:stop()
	end)
	self._passMask:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._passMask:setVisible(false)
			self._clubSystem:requestClubBossInfo(function()
				self:initData()
				self:refreshViewWithAnim(true)
			end, true, self._viewType)
		end
	end)

	self._passMaskAnim = anim
end

function ClubBossMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Club_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local title = Strings:get("ClubNew_UI_28")
	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = (self._viewType == ClubHallType.kActivityBoss or nil) and Strings:get("ClubNew_UI_29")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ClubBossMediator:showPassAnim()
	self._passMask:setVisible(true)
	self._passMaskAnim:gotoAndPlay(1)
end

function ClubBossMediator:doSomeNotChangeUI()
	self:setStarAndEndTime()
	self:addBottomAnimation()

	if self._clubBossInfo ~= nil then
		local anim = cc.MovieClip:create("zdxunhuan_shetuantaofa")

		anim:addTo(self._battleAnimNode, 1)
		anim:gotoAndPlay(1)

		local battleNode = anim:getChildByName("battleNode")
		local battleText = self._mainPanel:getChildByFullName("bottomAttackNode.battleText")
		local battleCloneText = battleText:clone()

		battleCloneText:setVisible(true)
		battleCloneText:addTo(battleNode):posite(-5, 8)
	end
end

function ClubBossMediator:addBottomAnimation()
	local oldAnim = self._bottomAttackNode:getChildByTag(12345)

	if oldAnim then
		oldAnim:removeFromParent(true)

		self._bottomAnim = nil
		self._challengeAnimNode = nil
		self._challengeCanNotBg = nil
		self._challengeRemainText = nil
		self._challengeMask = nil
	end

	local anim = cc.MovieClip:create("changkuang_shetuantaofa")

	anim:addTo(self._bottomAttackNode, 1)
	anim:setPosition(cc.p(662, 93))

	self._bottomAnim = anim

	anim:setTag(12345)
	anim:gotoAndStop(1)

	local currentSeasonConfig = self._clubBossInfo:getCurrentSeasonConfig()
	local heroNode1 = anim:getChildByName("heroNode1")
	local bgImage = ccui.ImageView:create("asset/commonRaw/common_bd_ssr01.png", ccui.TextureResType.localType)

	bgImage:setScale(0.3)
	bgImage:setPositionY(0)
	bgImage:addTo(heroNode1)

	local oneHero = currentSeasonConfig.ExcellentHero[1].Hero[1]

	if oneHero ~= nil then
		local config = ConfigReader:getRecordById("HeroBase", oneHero)
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = config.RoleModel
		})

		bgImage:addChild(heroImg)
		heroImg:setPosition(cc.p(116.5, 116.5))
		heroImg:setScale(0.625)

		local data = {
			text1 = "clubBoss_51",
			rightOff_x = 40,
			downOff_y = 60,
			type = RewardType.kRewardLink
		}

		IconFactory:bindTouchHander(heroImg, SomeWordTouchHandler:new(self), data, {
			needDelay = true
		})

		if self._heroSystem:hasHero(oneHero) then
			local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")
			local haveHero = haveHeroPanel:clone()

			haveHero:setVisible(true)
			bgImage:addChild(haveHero)
			haveHero:setScale(2.5)
			haveHero:setPosition(cc.p(116.5, 220))
		end
	end

	anim:addCallbackAtFrame(2, function()
		local desTextNode = anim:getChildByName("desTextNode")
		local desPanelNode = self._mainPanel:getChildByFullName("bottomAttackNode.desPanel")
		local desPanel = desPanelNode:clone()

		desPanel:setVisible(true)

		local Text_63 = desPanel:getChildByName("Text_63")
		local Text_64 = desPanel:getChildByName("Text_64")

		self:setOutline(Text_63)
		self:setOutline(Text_64)

		if self._viewType == ClubHallType.kActivityBoss then
			Text_63:setString(Strings:get("Club_ActivityBoss_15"))
		end

		desPanel:addTo(desTextNode)
		desPanel:setPosition(cc.p(-90, -55))
	end)
	anim:addCallbackAtFrame(3, function()
		local heroNode2 = anim:getChildByName("heroNode2")
		local bgImage = ccui.ImageView:create("asset/commonRaw/common_bd_ssr01.png", ccui.TextureResType.localType)

		bgImage:setScale(0.3)
		bgImage:setPositionY(0)
		bgImage:addTo(heroNode2)

		local oneHero = currentSeasonConfig.ExcellentHero[1].Hero[2]

		if oneHero ~= nil then
			local config = ConfigReader:getRecordById("HeroBase", oneHero)
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			bgImage:addChild(heroImg)
			heroImg:setPosition(cc.p(116.5, 116.5))
			heroImg:setScale(0.625)

			local data = {
				downOff_y = 60,
				text1 = "clubBoss_51",
				type = RewardType.kRewardLink
			}

			IconFactory:bindTouchHander(heroImg, SomeWordTouchHandler:new(self), data, {
				needDelay = true
			})

			if self._heroSystem:hasHero(oneHero) then
				local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")
				local haveHero = haveHeroPanel:clone()

				haveHero:setVisible(true)
				bgImage:addChild(haveHero)
				haveHero:setScale(2.5)
				haveHero:setPosition(cc.p(116.5, 220))
			end
		end

		local textPanel1 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel1")
		local textPanel = textPanel1:clone()

		textPanel:setVisible(true)

		local text1 = anim:getChildByName("text1")

		textPanel:addTo(text1)
		textPanel:setPosition(cc.p(0, -2))

		local effectText = textPanel:getChildByName("attackText")

		self:setOutline(effectText)

		if currentSeasonConfig.ExcellentHero[1].Effect ~= nil then
			local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", currentSeasonConfig.ExcellentHero[1].Effect)

			if effectConfig then
				effectText:setString(Strings:get(effectConfig.EffectDesc))
			end
		end
	end)
	anim:addCallbackAtFrame(4, function()
		local heroNode3 = anim:getChildByName("heroNode3")
		local bgImage = ccui.ImageView:create("asset/commonRaw/common_bd_ssr01.png", ccui.TextureResType.localType)

		bgImage:setScale(0.3)
		bgImage:setPositionY(0)
		bgImage:addTo(heroNode3)

		local oneHero = currentSeasonConfig.ExcellentHero[2].Hero[1]

		if oneHero ~= nil then
			local config = ConfigReader:getRecordById("HeroBase", oneHero)
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			bgImage:addChild(heroImg)
			heroImg:setPosition(cc.p(116.5, 116.5))
			heroImg:setScale(0.625)

			local data = {
				downOff_y = 60,
				text1 = "clubBoss_51",
				type = RewardType.kRewardLink
			}

			IconFactory:bindTouchHander(heroImg, SomeWordTouchHandler:new(self), data, {
				needDelay = true
			})

			if self._heroSystem:hasHero(oneHero) then
				local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")
				local haveHero = haveHeroPanel:clone()

				haveHero:setVisible(true)
				bgImage:addChild(haveHero)
				haveHero:setScale(2.5)
				haveHero:setPosition(cc.p(116.5, 220))
			end
		end
	end)
	anim:addCallbackAtFrame(5, function()
		local infoNode = anim:getChildByName("infoNode")
		local infoImage = ccui.ImageView:create("asset/common/common_btn_xq.png", ccui.TextureResType.localType)

		infoImage:setScale(0.45)
		infoImage:setPosition(cc.p(-300, 3))
		infoImage:addTo(infoNode)

		self._showInfoNode = true
	end)
	anim:addCallbackAtFrame(6, function()
		local heroNode4 = anim:getChildByName("heroNode4")
		local bgImage = ccui.ImageView:create("asset/commonRaw/common_bd_ssr01.png", ccui.TextureResType.localType)

		bgImage:setScale(0.3)
		bgImage:setPosition(cc.p(0, 0))
		bgImage:addTo(heroNode4)

		local oneHero = currentSeasonConfig.ExcellentHero[2].Hero[2]

		if oneHero ~= nil then
			local config = ConfigReader:getRecordById("HeroBase", oneHero)
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			bgImage:addChild(heroImg)
			heroImg:setPosition(cc.p(116.5, 116.5))
			heroImg:setScale(0.625)

			local data = {
				downOff_y = 60,
				text1 = "clubBoss_51",
				type = RewardType.kRewardLink
			}

			IconFactory:bindTouchHander(heroImg, SomeWordTouchHandler:new(self), data, {
				needDelay = true
			})

			if self._heroSystem:hasHero(oneHero) then
				local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")
				local haveHero = haveHeroPanel:clone()

				haveHero:setVisible(true)
				bgImage:addChild(haveHero)
				haveHero:setScale(2.5)
				haveHero:setPosition(cc.p(116.5, 220))
			end
		end

		local textPanel2 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel2")
		local textPanel = textPanel2:clone()

		textPanel:setVisible(true)

		local text2 = anim:getChildByName("text2")

		textPanel:addTo(text2)
		textPanel:setPosition(cc.p(0, -2))

		local effectText = textPanel:getChildByName("attackText")

		self:setOutline(effectText)

		if currentSeasonConfig.ExcellentHero[1].Effect ~= nil then
			local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", currentSeasonConfig.ExcellentHero[2].Effect)

			if effectConfig then
				effectText:setString(Strings:get(effectConfig.EffectDesc))
			end
		end
	end)
	anim:addCallbackAtFrame(8, function()
		local heroNode5 = anim:getChildByName("heroNode5")
		local bgImage = ccui.ImageView:create("asset/commonRaw/common_bd_ssr01.png", ccui.TextureResType.localType)

		bgImage:setScale(0.3)
		bgImage:setPositionY(0)
		bgImage:addTo(heroNode5)

		local oneHero = currentSeasonConfig.ExcellentHero[2].Hero[3]

		if oneHero ~= nil then
			local config = ConfigReader:getRecordById("HeroBase", oneHero)
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			bgImage:addChild(heroImg)
			heroImg:setPosition(cc.p(116.5, 116.5))
			heroImg:setScale(0.625)

			local data = {
				downOff_y = 60,
				text1 = "clubBoss_51",
				type = RewardType.kRewardLink
			}

			IconFactory:bindTouchHander(heroImg, SomeWordTouchHandler:new(self), data, {
				needDelay = true
			})

			if self._heroSystem:hasHero(oneHero) then
				local haveHeroPanel = self._mainPanel:getChildByFullName("bottomAttackNode.haveHeroPanel")
				local haveHero = haveHeroPanel:clone()

				haveHero:setVisible(true)
				bgImage:addChild(haveHero)
				haveHero:setScale(2.5)
				haveHero:setPosition(cc.p(116.5, 220))
			end
		end
	end)
	anim:addCallbackAtFrame(9, function()
		local attackIPanel3 = self._mainPanel:getChildByFullName("bottomAttackNode.attackPanel4")
		local attackPane = attackIPanel3:clone()

		attackPane:setVisible(true)

		local heroNode6 = anim:getChildByName("heroNode6")

		attackPane:addTo(heroNode6)
		attackPane:setPosition(cc.p(0, 0))

		local data = {
			downOff_y = 0,
			text1 = "clubBoss_52",
			type = RewardType.kRewardLink
		}
		local Image = attackPane:getChildByName("Image")

		IconFactory:bindTouchHander(Image, SomeWordTouchHandler:new(self), data, {
			needDelay = true
		})
	end)
	anim:addCallbackAtFrame(11, function()
		local textPanel3 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel4")
		local textPanel = textPanel3:clone()

		textPanel:setVisible(true)

		local text3 = anim:getChildByName("text3")

		textPanel:addTo(text3)
		textPanel:setPosition(cc.p(0, -2))

		local effectText = textPanel:getChildByName("attackText")

		self:setOutline(effectText)

		if currentSeasonConfig.AwakenAttrEffect ~= nil then
			local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", currentSeasonConfig.AwakenAttrEffect)

			if effectConfig then
				effectText:setString(Strings:get(effectConfig.EffectDesc))
			end
		end
	end)
	anim:addCallbackAtFrame(13, function()
		local attackIPanel4 = self._mainPanel:getChildByFullName("bottomAttackNode.attackPanel3")
		local attackPane = attackIPanel4:clone()

		attackPane:setVisible(true)

		local heroNode7 = anim:getChildByName("heroNode7")

		attackPane:addTo(heroNode7)
		attackPane:setPosition(cc.p(0, 0))

		local data = {
			downOff_y = 0,
			text1 = "clubBoss_52",
			type = RewardType.kRewardLink
		}
		local Image = attackPane:getChildByName("Image")

		IconFactory:bindTouchHander(Image, SomeWordTouchHandler:new(self), data, {
			needDelay = true
		})
	end)
	anim:addCallbackAtFrame(15, function()
		local textPanel4 = self._mainPanel:getChildByFullName("bottomAttackNode.textPanel3")
		local textPanel = textPanel4:clone()

		textPanel:setVisible(true)

		local text4 = anim:getChildByName("text4")

		textPanel:addTo(text4)
		textPanel:setPosition(cc.p(0, -2))

		local effectText = textPanel:getChildByName("attackText")

		self:setOutline(effectText)

		if currentSeasonConfig.StarsAttrEffect ~= nil then
			local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", currentSeasonConfig.StarsAttrEffect)

			if effectConfig then
				effectText:setString(Strings:get(effectConfig.EffectDesc))
			end
		end
	end)
	anim:addCallbackAtFrame(18, function()
		local challengeNode = anim:getChildByName("challengeNode")

		self._btnPanel = self._btnBasePanel:clone()
		self._challengeAnimNode = self._btnPanel:getChildByName("animNode")
		self._challengeCanNotBg = self._btnPanel:getChildByName("canNotBg")
		self._challengeMask = self._btnPanel:getChildByName("mask")

		local tiaoImage = self._challengeCanNotBg:getChildByName("tiaoImage")
		local zhanImage = self._challengeCanNotBg:getChildByName("zhanImage")

		tiaoImage:setGray(true)
		zhanImage:setGray(true)

		local curLanage = getCurrentLanguage()

		if curLanage ~= GameLanguageType.CN then
			tiaoImage:setVisible(false)
			zhanImage:setVisible(false)

			local tiaoImage_other = ccui.ImageView:create("tiao_zhuxianguanka_UIjiaohudongxiaoimage.png", 1)

			tiaoImage_other:setPosition(cc.p(142.5, 85))
			self._challengeCanNotBg:addChild(tiaoImage_other)
			tiaoImage_other:setGray(true)
		end

		self._challengeRemainText = self._btnPanel:getChildByName("RemainText")

		self:setOutline(self._challengeRemainText)

		local btnAnim = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

		btnAnim:setScale(0.8)
		btnAnim:addTo(self._challengeAnimNode)
		btnAnim:setOpacity(0)
		btnAnim:runAction(cc.FadeIn:create(0.5))
		self._btnPanel:setVisible(true)
		self._btnPanel:addTo(challengeNode)
		self._btnPanel:setPosition(cc.p(0, -10))
		self._challengeRemainText:setString(Strings:get("Club_Boss_11", {
			nums = self._clubBossInfo:getBossFightTimes()
		}))

		if self._clubBossInfo:getBossFightTimes() <= 0 then
			self._challengeMask:setVisible(false)
			self._challengeCanNotBg:setVisible(true)
			self._challengeAnimNode:setVisible(false)
		elseif self._nowId == self._clubBossInfo:getNowPoint() then
			self._challengeMask:setVisible(false)
			self._challengeCanNotBg:setVisible(false)
			self._challengeAnimNode:setVisible(true)
		else
			if self._clubBossInfo:isBossPassed(self._currentBossPoints:getId()) then
				self._challengeMask:getChildByName("Text_67"):setString(Strings:get("ClubBoss_Tip3"))
			else
				self._challengeMask:getChildByName("Text_67"):setString(Strings:get("ClubBoss_Tip4"))
			end

			self._challengeMask:setVisible(true)
			self._challengeCanNotBg:setVisible(true)
			self._challengeAnimNode:setVisible(false)
		end

		self._showChallengeNode = true
	end)
	anim:addCallbackAtFrame(180, function()
		anim:stop()
	end)
end

function ClubBossMediator:doSomeChangeUI(isEnter)
	if self._skillTipPanel:isVisible() then
		self._skillTipPanel:setVisible(false)
	end

	local clubBlockPointNum = 6
	local ids = string.split(self._nowId, "_")
	local tmpNum = tonumber(ids[2]) % clubBlockPointNum

	if tmpNum == 0 then
		tmpNum = clubBlockPointNum
	end

	self._leftBtn:setVisible(tmpNum ~= 1)
	self._rightBtn:setVisible(tmpNum ~= 6)

	if self._clubBossInfo ~= nil then
		self._roundLab:setString(Strings:get("ClubBoss_Turn3", {
			Num = self._clubBossInfo:getCurRound()
		}))

		if self._clubBossInfo:getPassAll() then
			self._heroSkillNode:setVisible(false)

			local barNode = self._heroInfoNode:getChildByFullName("barNode")

			barNode:setVisible(false)

			local nameNode = self._heroInfoNode:getChildByFullName("nameNode")

			nameNode:setVisible(false)
		end

		self._rewardCurrentExp:setString(tostring(self._clubBossInfo:getHurt()))
		self._rewardMaxExp:setString("/" .. tostring(self._clubBossInfo:getHurtTarget()))
		self._rewardLoadingBar:setPercent(self._clubBossInfo:getHurt() / self._clubBossInfo:getHurtTarget() * 100)

		if self._clubBossInfo:getNowPoint() == self._nowId then
			local rate = self._clubBossInfo:getHpRate() * 100

			self._heroLoadingBar:setPercent(rate)

			local maxHp = math.floor(self._currentBossPoints:getBossHp() + 0.5)
			local curHp = math.floor(maxHp * self._clubBossInfo:getHpRate() + 0.5)

			self._heroLoadingText:setString(tostring(curHp) .. "/" .. tostring(maxHp))
		elseif self._clubBossInfo:isBossPassed(self._currentBossPoints:getId()) then
			self._heroLoadingBar:setPercent(0)

			local maxHp = math.floor(self._currentBossPoints:getBossHp() + 0.5)
			local curHp = math.floor(maxHp * self._clubBossInfo:getHpRate() + 0.5)

			self._heroLoadingText:setString("0/" .. tostring(maxHp))
		else
			local maxHp = math.floor(self._currentBossPoints:getBossHp() + 0.5)

			self._heroLoadingText:setString(tostring(maxHp) .. "/" .. tostring(maxHp))
			self._heroLoadingBar:setPercent(100)
		end

		if self._clubBossInfo:getHurt() < self._clubBossInfo:getHurtTarget() then
			self._rewardBoxImage1:setVisible(true)
			self._rewardBoxImage2:setVisible(false)
			self._rewardBoxImage3:setVisible(false)
		end

		if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() then
			self._rewardBoxImage1:setVisible(false)
			self._rewardBoxImage2:setVisible(false)
			self._rewardBoxImage3:setVisible(false)

			if self._clubBossInfo:getHasGetHurtAward() == false then
				self._rewardBoxImage2:setVisible(true)

				if self._clubSystem:checkBossDelayHurtRewardMark(self._viewType) == false then
					self._rewardBoxImage2:getChildByFullName("redPoint"):setVisible(false)
				end
			end

			if self._clubBossInfo:getHasGetHurtAward() == true then
				self._rewardBoxImage3:setVisible(true)
			end
		end

		if self._showChallengeNode and self._challengeRemainText then
			self._challengeRemainText:setString(Strings:get("Club_Boss_11", {
				nums = self._clubBossInfo:getBossFightTimes()
			}))

			if self._clubBossInfo:getBossFightTimes() <= 0 then
				self._challengeCanNotBg:setVisible(true)
				self._challengeAnimNode:setVisible(false)
			else
				self._challengeCanNotBg:setVisible(false)
				self._challengeAnimNode:setVisible(true)
			end
		end
	end

	self._heroNode:removeAllChildren()

	if self._currentBossPoints ~= nil then
		local currentBlockConfig = self._currentBossPoints:getBlockConfig()

		if currentBlockConfig ~= nil then
			if currentBlockConfig.PointHead ~= nil then
				local anim = cc.MovieClip:create("rend_shetuantaofa")

				anim:addTo(self._heroNode, 1)
				anim:setPositionY(-100)

				self._heroAnim = anim

				local isPass = self._clubBossInfo:isBossPassed(self._currentBossPoints:getId()) or tmpNum == self._killNum
				local heroBaseNode1 = anim:getChildByName("heroBaseNode1")
				local modelSprite = IconFactory:createRoleIconSpriteNew({
					frameId = "bustframe9",
					id = currentBlockConfig.PointHead,
					useAnim = not isPass
				})

				modelSprite:setScale(0.7)
				modelSprite:setGray(isPass)
				modelSprite:setPosition(cc.p(80, 30))
				heroBaseNode1:addChild(modelSprite)
				anim:gotoAndStop(45)
				self._bossPanel:getChildByFullName("bossInfoNode.Image_58"):setVisible(isPass)
				anim:addCallbackAtFrame(52, function()
					local heroMiddleNode1 = anim:getChildByName("heroMiddleNode1")
					local modelSprite1 = IconFactory:createRoleIconSpriteNew({
						useAnim = true,
						frameId = "bustframe9",
						id = currentBlockConfig.PointHead
					})

					modelSprite1:setScale(0.7)
					modelSprite1:setPosition(cc.p(80, 30))
					heroMiddleNode1:addChild(modelSprite1)

					local heroMiddleNode2 = anim:getChildByName("heroMiddleNode2")
					local modelSprite2 = IconFactory:createRoleIconSpriteNew({
						useAnim = true,
						frameId = "bustframe9",
						id = currentBlockConfig.PointHead
					})

					modelSprite2:setScale(0.7)
					modelSprite2:setPosition(cc.p(80, 30))
					heroMiddleNode2:addChild(modelSprite2)
				end)
				anim:addCallbackAtFrame(75, function()
					self:afterKillAnim()
				end)
				anim:addCallbackAtFrame(92, function()
					anim:stop()
				end)
			end

			if currentBlockConfig.EnemyMaster ~= nil then
				local EnemyMasterConfig = ConfigReader:getRecordById("EnemyMaster", currentBlockConfig.EnemyMaster)
				local allSkillVector = {}

				if EnemyMasterConfig.MasterSkill1 ~= nil and EnemyMasterConfig.MasterSkill1 ~= "" then
					allSkillVector[1] = EnemyMasterConfig.MasterSkill1
				end

				if EnemyMasterConfig.MasterSkill2 ~= nil and EnemyMasterConfig.MasterSkill2 ~= "" then
					allSkillVector[2] = EnemyMasterConfig.MasterSkill2
				end

				if EnemyMasterConfig.MasterSkill3 ~= nil and EnemyMasterConfig.MasterSkill3 ~= "" then
					allSkillVector[3] = EnemyMasterConfig.MasterSkill3
				end

				self._heroSkillNode:removeAllChildren()

				local anim = cc.MovieClip:create("jn_shetuantaofa")

				anim:addTo(self._heroSkillNode, 1)

				if isEnter then
					anim:gotoAndStop(1)
				else
					anim:gotoAndPlay(1)
				end

				anim:setPosition(cc.p(0, 0))

				self._SkillAnim = anim

				local skillNode1 = anim:getChildByName("skillNode1")
				local skillId = allSkillVector[1]
				local newSkillNode = IconFactory:createHeroSkillIcon({
					isLock = false,
					id = skillId
				}, {
					hideLevel = true,
					isWidget = true
				})

				newSkillNode:addTo(skillNode1)
				newSkillNode:setScale(0.5)

				local maskLayer = self._skillClonePanel:clone()

				maskLayer:setPosition(cc.p(0, 0))
				skillNode1:addChild(maskLayer)
				maskLayer:setTouchEnabled(true)
				maskLayer:setVisible(true)
				maskLayer:addClickEventListener(function()
					self:onClickSkill(skillId)
				end)
				anim:addCallbackAtFrame(3, function()
					local skillNode2 = anim:getChildByName("skillNode2")

					if #allSkillVector >= 2 then
						local skillId = allSkillVector[2]
						local newSkillNode = IconFactory:createHeroSkillIcon({
							isLock = false,
							id = skillId
						}, {
							hideLevel = true,
							isWidget = true
						})

						newSkillNode:addTo(skillNode2)
						newSkillNode:setScale(0.5)

						local maskLayer = self._skillClonePanel:clone()

						maskLayer:setPosition(cc.p(0, 0))
						skillNode2:addChild(maskLayer)
						maskLayer:setTouchEnabled(true)
						maskLayer:setVisible(true)
						maskLayer:addClickEventListener(function()
							self:onClickSkill(skillId)
						end)
					end
				end)
				anim:addCallbackAtFrame(5, function()
					local skillNode3 = anim:getChildByName("skillNode3")

					if #allSkillVector >= 3 then
						local skillId = allSkillVector[3]
						local newSkillNode = IconFactory:createHeroSkillIcon({
							isLock = false,
							id = skillId
						}, {
							hideLevel = true,
							isWidget = true
						})

						newSkillNode:addTo(skillNode3)
						newSkillNode:setScale(0.5)

						local maskLayer = self._skillClonePanel:clone()

						maskLayer:setPosition(cc.p(0, 0))
						skillNode3:addChild(maskLayer)
						maskLayer:setTouchEnabled(true)
						maskLayer:setVisible(true)
						maskLayer:addClickEventListener(function()
							self:onClickSkill(skillId)
						end)
					end
				end)
				anim:addCallbackAtFrame(180, function()
					anim:stop()
				end)
			end
		end

		local tableConfig = self._currentBossPoints:getTableConfig()

		if tableConfig ~= nil then
			local currentBlockConfig = self._currentBossPoints:getBlockConfig()
			local pointName = ""

			if tableConfig.Name ~= nil then
				pointName = self._currentBossPoints:getPointName()
				pointName = pointName .. "   "
			end

			if currentBlockConfig.Name ~= nil then
				pointName = pointName .. Strings:get(currentBlockConfig.Name)
			end

			self._heroNameText:setString(Strings:get("ClubBoss_UI2", {
				Num = self._currentBossPoints:getNum()
			}) .. "  " .. pointName)
		end

		self:createRewardView()
	end

	local skillTouchPanel = self._skillTipPanel:getChildByName("skillTouchPanel")

	skillTouchPanel:addClickEventListener(function()
		if self._skillTipPanel:isVisible() then
			self._skillTipPanel:setVisible(false)
		end
	end)
end

function ClubBossMediator:createRewardView()
	local curRound = self._clubBossInfo:getCurRound()
	local allRewards = {}

	for i = 1, 6 do
		local info = self._clubBossInfo:getBossPointsById(tostring(curRound) .. "_" .. tostring(i))
		local rewardId = info:getTableConfig().ShowKillReward
		local rewards = table.deepcopy(ConfigReader:getRecordById("Reward", rewardId).Content, {})

		for i = 1, #rewards do
			local tmpReward = rewards[i]

			if allRewards[tmpReward.code] then
				allRewards[tmpReward.code].amount = allRewards[tmpReward.code].amount + tmpReward.amount
			else
				allRewards[tmpReward.code] = tmpReward
			end
		end
	end

	local allRewardsArr = {}

	for _, v in pairs(allRewards) do
		table.insert(allRewardsArr, v)
	end

	for i = 1, 8 do
		local panel = self._rewardPanel:getChildByFullName("item" .. i)

		if i <= #allRewardsArr then
			panel:setVisible(true)
			self:createCell(panel, allRewardsArr[i])
		else
			panel:setVisible(false)
		end
	end
end

function ClubBossMediator:createCell(cell, data)
	cell:removeAllChildren()

	local rewardIcon = IconFactory:createRewardIcon(data, {
		isWidget = true
	})

	IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
		needDelay = true
	})
	cell:addChild(rewardIcon)
	rewardIcon:setPosition(cc.p(32.5, 32.5))
	rewardIcon:setScaleNotCascade(0.6)
end

function ClubBossMediator:setupView()
	return
end

function ClubBossMediator:setOutline(text)
	text:enableOutline(cc.c4b(0, 0, 0, 127), 1)
end

function ClubBossMediator:onClickInfoBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		if self._showInfoNode == false then
			return
		end

		local RuleDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_RuleTranslate", "content")

		if self._viewType == ClubHallType.kActivityBoss then
			local summerActivity = self._clubSystem:getClubBossSummerActivity()

			if summerActivity then
				RuleDesc = summerActivity:getActivityConfig().RuleDesc
			end
		end

		local resetInfo = ConfigReader:getDataByNameIdAndKey("Reset", "ClubBlock_Reset", "ResetSystem")
		local week = TimeUtil:getLocalWeekByRemote(resetInfo.resetDate[1])

		startTime = TimeUtil:localDate("%H:%M:%S", TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = string.split(resetInfo.resetTime[1], ":")[1],
			min = string.split(resetInfo.resetTime[1], ":")[2],
			sec = string.split(resetInfo.resetTime[1], ":")[3]
		}))

		local view = self:getInjector():getInstance("ArenaRuleView")
		local weekStr = Strings:get("Time_Title1_Rule_" .. week)
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			useParam = true,
			rule = RuleDesc,
			param1 = weekStr .. startTime
		}, nil)

		self:dispatch(event)
	end
end

function ClubBossMediator:onClickChallenge(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		if self._showChallengeNode == false then
			return
		end

		if self._clubBossInfo:getBossFightTimes() <= 0 then
			local tips = Strings:get("clubBoss_36")

			if self._viewType == ClubHallType.kActivityBoss then
				tips = Strings:get("Club_ActivityBoss_16")
			end

			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = (self._viewType == ClubHallType.kBoss and self:checkJoinToday() == true or nil) and Strings:get("clubBoss_61")
			}))

			return
		end

		local isPass = self._clubBossInfo:isBossPassed(self._currentBossPoints:getId()) or self:isKillPoint()

		if self._nowId ~= self._clubBossInfo:getNowPoint() then
			if not isPass then
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("ClubBoss_Tip4")
				}))
			end

			return
		end

		if self._clubBossInfo:getPassAll() then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("clubBoss_48")
			}))

			return
		end

		self._clubSystem:onClickEditTeam(self._viewType)
	end
end

function ClubBossMediator:onClickBox(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		local data = {}

		data.viewType = self._viewType

		local view = self:getInjector():getInstance("ClubBossGainRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end
end

function ClubBossMediator:onClickRankPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		self._clubSystem:showRankView()
	end
end

function ClubBossMediator:onClickRecordPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		self._clubSystem:showClubBossRecordView(self._viewType)
	end
end

function ClubBossMediator:onClickHeroPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._doingKillAnim or self._enterDoKillAnim then
			return
		end

		self:showTalkWord(false)
	end
end

function ClubBossMediator:onClickShowReward(sender, eventType)
	if self._doingKillAnim or self._enterDoKillAnim then
		return
	end

	if eventType == ccui.TouchEventType.ended then
		local data = {}

		data.viewType = self._viewType

		local view = self:getInjector():getInstance("ClubBossShowAllBossView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end
end

function ClubBossMediator:onClickIntegralButton()
	if self._doingKillAnim or self._enterDoKillAnim then
		return
	end

	local view = self:getInjector():getInstance("ClubBossActivityScoreView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil))
end

function ClubBossMediator:onClickSkill(skillId)
	if self._doingKillAnim or self._enterDoKillAnim then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._skillTipPanel:setVisible(true)
	self:updateSkillDesc(skillId)
end

function ClubBossMediator:onLeftClick()
	local clubBlockPointNum = 6
	local ids = string.split(self._nowId, "_")
	local tmpNum = (tonumber(ids[2]) - 1) % clubBlockPointNum

	if tmpNum == 0 then
		tmpNum = clubBlockPointNum
	end

	self._nowId = tostring(self._clubBossInfo:getCurRound()) .. "_" .. tostring(tmpNum)

	self:refreshData()
	self:refreshViewWithAnim(true)
end

function ClubBossMediator:onRightClick()
	local clubBlockPointNum = 6
	local ids = string.split(self._nowId, "_")
	local tmpNum = (tonumber(ids[2]) + 1) % clubBlockPointNum

	if tmpNum == 0 then
		tmpNum = clubBlockPointNum
	end

	self._nowId = tostring(self._clubBossInfo:getCurRound()) .. "_" .. tostring(tmpNum)

	self:refreshData()
	self:refreshViewWithAnim(true)
end

function ClubBossMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ClubBossMediator:onForcedLevel(event)
	self:dismiss()
end

function ClubBossMediator:goToBack()
	self._goToBack = true

	self:stopTimer()
	self:getView():stopAllActions()
	self._mainPanel:stopAllActions()

	self._enterDoKillAnim = false

	self._clubSystem:clearClubBossKilled(self._viewType)
end

function ClubBossMediator:updateSkillDesc(skillId)
	local config = ConfigReader:getRecordById("Skill", skillId)
	local infoNode = self._skillTipPanel:getChildByFullName("infoNode")
	local iconPanel = infoNode:getChildByFullName("iconPanel")

	iconPanel:removeAllChildren()

	local newSkillNode = IconFactory:createHeroSkillIcon({
		isLock = false,
		id = skillId
	}, {
		hideLevel = true,
		isWidget = true
	})

	newSkillNode:addTo(iconPanel):center(iconPanel:getContentSize())
	newSkillNode:setScale(0.85)

	local typeIcon = infoNode:getChildByFullName("icon")

	typeIcon:setVisible(false)

	local name = infoNode:getChildByFullName("name")

	name:setString(Strings:get(config.Name))

	local bg = self._skillTipPanel:getChildByName("Image_bg")
	local desc = self._skillTipPanel:getChildByName("desc")
	local str = ""
	local style = {
		fontName = TTF_FONT_FZYH_M
	}

	if config.Desc and config.Desc ~= "" then
		str = ConfigReader:getEffectDesc("Skill", config.Desc, skillId, 1, style)
	end

	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skillId)

	if skillProto then
		local attrDescs = skillProto:getAttrDescs(1) or {}

		if attrDescs[1] then
			str = str .. attrDescs[1]
		end
	end

	desc:removeAllChildren()
	desc:setString("")

	local label = ccui.RichText:createWithXML(str, {})

	label:renderContent(290, 0)
	label:setAnchorPoint(cc.p(0, 0))
	label:addTo(desc)
	label:setPosition(cc.p(0, 0))

	local height = label:getContentSize().height + 114

	bg:setContentSize(cc.size(307, height))
	infoNode:setPositionY(height - 94)
end

function ClubBossMediator:getEquipInfo(data)
	local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
	local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

	if data.type == RewardType.kEquip or data.type == RewardType.kEquipExplore then
		local config = ConfigReader:getRecordById("HeroEquipBase", data.code)

		if not config.Rareity then
			return nil
		end

		local rarity = config.Rareity
		local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
		local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")

		return {
			id = data.code,
			rarity = rarity,
			star = star,
			level = level
		}
	end

	return nil
end

function ClubBossMediator:getQuality(code)
	local quality = 2
	local config = ConfigReader:getRecordById("ItemConfig", code)

	config = config or ConfigReader:getRecordById("Surface", code)
	config = config or ConfigReader:getRecordById("HeroEquipBase", code)
	config = config or ConfigReader:getRecordById("HeroBase", code)

	if config then
		return config.Quality
	end

	return quality
end

function ClubBossMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ClubBossMediator:onClickPlayerHead(data)
	if not data or data:getId() == nil then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._clubSystem:showMemberPlayerInfoView(data:getId())
end

function ClubBossMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/ClubBoss.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 10, false)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "end" then
			self._bottomAnim:gotoAndPlay(1)
			self._SkillAnim:gotoAndPlay(1)
			self:showTalkWord(false)

			if self._enterDoKillAnim then
				self._enterDoKillAnim = false

				self:doBossKilledAnim(true)
			end
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function ClubBossMediator:doBossKilledLogic(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	self._killNum = data.pointNum

	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()

	if self._goToBack then
		return
	end

	if topViewName ~= "ClubBossView" then
		self._delayDoKillAnim = true

		return
	end

	self:doBossKilledAnim(true)
end

function ClubBossMediator:doBossKilledAnim(notDelay)
	if not self:isKillPoint() then
		if self._killNum == 6 then
			self:showPassAnim()
		end

		return
	end

	self._doingKillAnim = true

	self._clubSystem:clearClubBossKilled(self._viewType)

	if notDelay then
		self:showTalkWord(true)
		self._skillTipPanel:setVisible(false)
		self._heroAnim:gotoAndPlay(50)
	else
		performWithDelay(self:getView(), function()
			self:showTalkWord(true)
			self._skillTipPanel:setVisible(false)
			self._heroAnim:gotoAndPlay(50)
		end, 1.2)
	end
end

function ClubBossMediator:afterKillAnim()
	self._doingKillAnim = false

	local ids = string.split(self._nowId, "_")

	if tonumber(ids[2]) == 6 then
		self:initData()
		self:refreshViewWithAnim(true)
		self:showPassAnim()
	else
		self._clubSystem:requestClubBossInfo(function()
			self:initData()
			self:refreshViewWithAnim(true)
		end, true, self._viewType)
	end
end

function ClubBossMediator:showTalkWord(isDead)
	local count = self._clubSystem:getClubBossBattleConunt(self._viewType, self._nowId)

	if count > 0 and isDead == false then
		self._talkNode:stopAllActions()
		self._talkNode:setVisible(false)

		return
	end

	local currentBlockConfig = self._currentBossPoints:getBlockConfig()
	local playVoice

	if currentBlockConfig.Bubble ~= nil then
		playVoice = currentBlockConfig.Bubble[math.random(1, #currentBlockConfig.Bubble)]
	end

	if isDead and currentBlockConfig.DeathBubble ~= nil then
		playVoice = currentBlockConfig.DeathBubble[1]
	end

	self:stopTalkEffect()

	local soundDesc = ConfigReader:getDataByNameIdAndKey("Sound", playVoice, "SoundDesc")

	if self._clubBossInfo:getPassAll() then
		soundDesc = "clubBoss_43"
	else
		self._heroEffect, _ = AudioEngine:getInstance():playEffect(playVoice, false)
	end

	if soundDesc ~= nil then
		self._talkNode:stopAllActions()
		self._talkNode:setVisible(true)
		self._talkText:setString(Strings:get(soundDesc))
		self._talkNode:setOpacity(0)

		local fadeAct = cc.FadeIn:create(0.25)
		local allDelayAction = cc.DelayTime:create(2.5)
		local fadeAct2 = cc.FadeOut:create(0.25)
		local callfunc1 = cc.CallFunc:create(function()
			self._talkNode:setVisible(false)
		end)
		local seqAll = cc.Sequence:create(fadeAct, allDelayAction, fadeAct2, callfunc1)

		self._talkNode:runAction(seqAll)
	end
end

function ClubBossMediator:stopTalkEffect()
	AudioEngine:getInstance():stopEffect(self._heroEffect)
end

function ClubBossMediator:doReset(event)
	local data = event:getData()

	local function goHomeView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:stopTimer()
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
	end

	if self._clubSystem:getClubBoss():getIsRestState() then
		goHomeView()

		return
	end

	if data and (data[ResetId.kClubBlockTimesReset] or data[ResetId.kClubBlockReset]) then
		goHomeView()
	end

	return false
end

function ClubBossMediator:setStarAndEndTime()
	self._timeNode:setVisible(false)

	if self._viewType == ClubHallType.kActivityBoss then
		local activity = self._clubSystem:getClubBossSummerActivity()

		if activity then
			local timeStamp = activity:getTimeFactor()
			local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[1], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}
			local startTime = TimeUtil:timeByRemoteDate(table)
			local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}
			local endTime = TimeUtil:timeByRemoteDate(table)
			local tb = TimeUtil:localDate("*t", startTime)
			local starTimeStr = tostring(tb.year) .. "." .. tostring(tb.month) .. "." .. tostring(tb.day)

			tb = TimeUtil:localDate("*t", endTime)

			local endTimeStr = tostring(tb.year) .. "." .. tostring(tb.month) .. "." .. tostring(tb.day)
			local str = starTimeStr .. " - " .. endTimeStr
			local timeText = self._timeNode:getChildByFullName("time")

			timeText:setString(str)
			self._timeNode:setVisible(true)
		end
	end
end

function ClubBossMediator:setScore()
	if self._viewType == ClubHallType.kActivityBoss then
		local integralText = self._integralNode:getChildByFullName("integralText")

		integralText:setString(tostring(self._clubBossInfo:getAllScore()))

		local des1, des2 = self._clubSystem:getAttrEffectValueForScore(self._clubBossInfo:getAllScore())
		local effectText = self._integralNode:getChildByFullName("effectText")

		effectText:setString(des1)
		self._integralNode:setVisible(true)
		self._integralButton:setTouchEnabled(true)
		self._integralButton:setVisible(true)
		self._integralButton:addClickEventListener(function()
			self:onClickIntegralButton()
		end)
	end
end

function ClubBossMediator:refreshBattleCount(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	local count = self._clubSystem:getClubBossBattleConunt(self._viewType, self._nowId)

	if count > 0 then
		self._battleAnimNode:setVisible(true)
		self._talkNode:stopAllActions()
		self._talkNode:setVisible(false)
	else
		self._battleAnimNode:setVisible(false)
	end
end

function ClubBossMediator:checkJoinToday()
	local lastJoinTime = self._developSystem:getPlayer():getClub():getInfo():getLastJoinTime()
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local baseTime = {
		sec = 0,
		min = 0,
		hour = 5
	}

	return (TimeUtil:isSameDay(lastJoinTime, curTime / 1000, baseTime))
end

function ClubBossMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local scriptNames = "guide_ClubBoss"
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	if guideSystem:checkGuideSwitchOpen(scriptNames) then
		local sequence = cc.Sequence:create(cc.CallFunc:create(function()
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local guide_panel_1 = self:getView():getChildByFullName("main.guide_panel_1")
			local guide_panel_2 = self:getView():getChildByFullName("main.guide_panel_2")
			local guide_panel_3 = self:getView():getChildByFullName("main.guide_panel_3")

			if guide_panel_1 then
				storyDirector:setClickEnv("ClubBossMediator.guide_panel_1", guide_panel_1, nil)
			end

			if guide_panel_2 then
				storyDirector:setClickEnv("ClubBossMediator.guide_panel_2", guide_panel_2, nil)
			end

			if guide_panel_3 then
				storyDirector:setClickEnv("ClubBossMediator.guide_panel_3", guide_panel_3, nil)
			end

			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(true)

			local guideAgent = storyDirector:getGuideAgent()
			local guideSaved = guideAgent:isSaved(scriptNames)

			if not guideSaved then
				guideAgent:trigger(scriptNames, nil, nil)
			end
		end))

		self:getView():runAction(sequence)
	end
end
