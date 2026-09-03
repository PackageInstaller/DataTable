-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKMatchMediator.lua

RTPKMatchMediator = class("RTPKMatchMediator", DmAreaViewMediator, _M)

RTPKMatchMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RTPKMatchMediator:has("_rtpkSystem", {
	is = "r"
}):injectWith("RTPKSystem")
RTPKMatchMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")
RTPKMatchMediator:has("_controller", {
	is = "r"
}):injectWith("RTPVPController")

function RTPKMatchMediator:initialize()
	super.initialize(self)
end

function RTPKMatchMediator:dispose()
	if self._timer ~= nil then
		self._timer:stop()

		self._timer = nil
	end

	if self._delayTask then
		cancelDelayCall(self._delayTask)

		self._delayTask = nil
	end

	super.dispose(self)
end

function RTPKMatchMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._matchingPanel = self._main:getChildByName("matching")
	self._matchSuccPanel = self._main:getChildByName("matchsucc")

	self._matchSuccPanel:setVisible(false)

	self._matchBtn = self:bindWidget("main.matching.btn_match", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_3",
			func = bind1(self.onClickCancel, self)
		}
	})
end

function RTPKMatchMediator:enterWithData(data)
	self._delegate = data.delegate
	self._rtpk = self._rtpkSystem:getRtpk()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._buffData = self._rtpkSystem:getSeasonBuffData()

	self:mapEventListeners()
	self:setupView()
end

function RTPKMatchMediator:resumeWithData(data)
	super.resumeWithData(self, data)
end

function RTPKMatchMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPK_CANCELMATCH, self, self.onCancelMatchCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPK_MATCHSUCC, self, self.onMatchSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_MATCH, self, self._enterBattleScene)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_CONN_SUCC, self, self._connectSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_RESULT, self, self._battleResult)
end

function RTPKMatchMediator:setupView()
	self:addMatchAnim()
	self:createTimer()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Story_Danger_2")
end

function RTPKMatchMediator:createTimer()
	local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "RTPK_FristMatchTime", "content") + 5
	local tickCount = 0
	local pvpWaitTime = 0

	local function update()
		local matchText = self._matchingPanel:getChildByName("Text_1")

		matchText:setString(Strings:get("RTPK_Matching", {
			countdown = time - tickCount
		}))

		tickCount = tickCount + 1

		if tickCount > time and not self._enterPvp then
			self._delegate._needShowTips = true

			self:dismiss()
		end

		if self._enterPvp and not self._enterBattle then
			pvpWaitTime = pvpWaitTime + 1

			if pvpWaitTime >= 35 then
				self:dismiss()
			end
		end
	end

	if self._timer == nil then
		self._timer = LuaScheduler:getInstance():schedule(update, 1, true)
	end
end

function RTPKMatchMediator:addMatchAnim()
	local anim = cc.MovieClip:create("main_tiantipipeijiemian")

	anim:addTo(self._matchingPanel, 6):posite(488, 410)
end

function RTPKMatchMediator:addMatchSuccAnim(data)
	local anim = cc.MovieClip:create("main_tiantipipei")

	anim:addTo(self._matchSuccPanel, 6):posite(578, 305)

	self._matchSuccAnim = anim

	anim:addCallbackAtFrame(70, function()
		anim:stop()
		anim:clearCallbacks()

		if data.type == "ROBOT" then
			self._enterBattle = true
			self._delayTask = delayCallByTime(100, function()
				self._rtpkSystem:enterRobotBattle(data)
			end)
		else
			self._rtpkSystem:enterRTPVP(data.ip, tonumber(data.port), data.room, data.br, "orrtpk")
		end
	end)
end

function RTPKMatchMediator:setMyselfInfo(data)
	self._settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()

	local serverInfo = self._loginSystem:getCurServer()
	local gradeData = self._rtpk:getCurGrade()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local heroId = customDataSystem:getValue(PrefixType.kGlobal, "BoardHeroId", -1)
	local heroData = self._heroSystem:getHeroById(heroId)
	local panel = self._matchSuccPanel:getChildByName("myself")
	local player = self._developSystem:getPlayer()
	local infoPanel = panel:getChildByName("Node_info")
	local nameText = infoPanel:getChildByName("Text_name")
	local serverText = infoPanel:getChildByName("Text_server")
	local combatText = infoPanel:getChildByName("Text_combat")
	local gradeText = infoPanel:getChildByName("Text_grade")
	local scoreText = infoPanel:getChildByName("Text_score")
	local heroNode = panel:getChildByName("hero")
	local levelText = infoPanel:getChildByName("Text_level")
	local headNode = infoPanel:getChildByName("head")

	nameText:setString(player:getNickName())
	serverText:setString(Strings:get("RTPK_Record_UI01", {
		serverId = serverInfo:getSecId(),
		serverName = serverInfo:getName()
	}))
	gradeText:setString(Strings:get(gradeData.Name))
	scoreText:setString(Strings:get("RTPK_Match_Showscore", {
		score = self._rtpk:getCurScore()
	}))

	if self._buffData.levelLimit then
		combatText:setString(self._buffData.levelLimit.name)
	else
		combatText:setString(Strings:get("RTPK_PlayerPower", {
			power = data.br.combat
		}))
	end

	local role = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = heroData:getModel(),
		useAnim = self._settingModel:getRoleDynamic()
	})

	role:setTouchEnabled(true)
	role:setScale(0.65)
	role:addTo(heroNode):posite(70, -60)

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = player:getHeadId(),
		size = cc.size(93, 94),
		headFrameId = player:getCurHeadFrame()
	})

	headicon:addTo(headNode)
	headicon:setScale(0.75)
	oldIcon:setScale(0.5)
	levelText:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. player:getLevel())

	local iconImg = infoPanel:getChildByName("Image_icon")

	iconImg:removeAllChildren()

	local icon = IconFactory:createRTPKGradeIcon(gradeData.Id)

	icon:addTo(iconImg):center(iconImg:getContentSize()):offset(0, 17):setScale(0.4)
	self:runAction(panel:getChildByName("Image_10"), 0, cc.p(-500, 0), cc.p(0, 0))
	self:runAction(heroNode, 0.1, cc.p(-500, 0), cc.p(30, 0))
	self:runAction(infoPanel, 0.2, cc.p(0, 0), cc.p(0, 0))

	if infoPanel:getChildByName("title") then
		infoPanel:removeChildByName("title")
	end

	if player:getCurTitleId() ~= "" then
		local icon = IconFactory:createTitleIcon({
			id = player:getCurTitleId()
		})

		icon:addTo(infoPanel):posite(145, 90)
		icon:setName("title")
		icon:setScale(0.53)
		nameText:setPositionY(139)
		combatText:setPositionY(112)
		serverText:setPositionY(163)
	else
		nameText:setPositionY(126)
		combatText:setPositionY(99)
		serverText:setPositionY(150)
	end
end

function RTPKMatchMediator:setRivalInfo(data)
	local rivalInfo = data.rival
	local gradeData = self._rtpkSystem:getGradeConfigByScore(rivalInfo.p)
	local panel = self._matchSuccPanel:getChildByName("rival")
	local infoPanel = panel:getChildByName("Node_info")
	local nameText = infoPanel:getChildByName("Text_name")
	local serverText = infoPanel:getChildByName("Text_server")
	local combatText = infoPanel:getChildByName("Text_combat")
	local gradeText = infoPanel:getChildByName("Text_grade")
	local scoreText = infoPanel:getChildByName("Text_score")
	local heroNode = panel:getChildByName("hero")
	local levelText = infoPanel:getChildByName("Text_level")
	local headNode = infoPanel:getChildByName("head")

	nameText:setString(rivalInfo.n)

	local serverId = self._rtpkSystem:getServerIdByRid(rivalInfo.r)
	local serverInfo = self._loginSystem:getLogin():getServerBySec(serverId)

	serverText:setString(Strings:get("RTPK_Record_UI01", {
		serverId = serverId,
		serverName = serverInfo:getName()
	}))
	gradeText:setString(Strings:get(gradeData.Name))
	scoreText:setString(Strings:get("RTPK_Match_Showscore", {
		score = rivalInfo.p
	}))

	if self._buffData.levelLimit then
		combatText:setString(self._buffData.levelLimit.name)
	else
		combatText:setString(Strings:get("RTPK_PlayerPower", {
			power = rivalInfo.c
		}))
	end

	local model = IconFactory:getRoleModelByKey("HeroBase", rivalInfo.s or "ZTXChang")
	local sfModel = ConfigReader:getDataByNameIdAndKey("Surface", rivalInfo.sf, "Model")
	local role = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = sfModel or model,
		useAnim = self._settingModel:getRoleDynamic()
	})

	role:setTouchEnabled(true)
	role:setScale(0.65)
	role:addTo(heroNode):posite(70, -60)
	heroNode:setScaleX(-1)

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = rivalInfo.h,
		size = cc.size(93, 94),
		headFrameId = rivalInfo.f
	})

	headicon:addTo(headNode)
	headicon:setScale(0.75)
	oldIcon:setScale(0.5)
	levelText:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. rivalInfo.l)

	local iconImg = infoPanel:getChildByName("Image_icon")

	iconImg:removeAllChildren()

	local icon = IconFactory:createRTPKGradeIcon(gradeData.Id)

	icon:addTo(iconImg):center(iconImg:getContentSize()):offset(0, 17):setScale(0.4)

	if infoPanel:getChildByName("title") then
		infoPanel:removeChildByName("title")
	end

	if rivalInfo.title ~= nil and rivalInfo.title ~= "" then
		local icon = IconFactory:createTitleIcon({
			id = rivalInfo.title
		})

		icon:addTo(infoPanel):posite(-145, 90)
		icon:setName("title")
		icon:setScale(0.53)
		nameText:posite(-106, 139)
		combatText:posite(-106, 112)
		serverText:posite(-106, 163)
	else
		nameText:posite(-106, 126)
		combatText:posite(-106, 99)
		serverText:posite(-106, 150)
	end

	self:runAction(panel:getChildByName("Image_10"), 0, cc.p(500, 0), cc.p(0, 0))
	self:runAction(heroNode, 0.1, cc.p(500, 0), cc.p(-30, 0))
	self:runAction(infoPanel, 0.2, cc.p(0, 0), cc.p(0, 0))
end

function RTPKMatchMediator:runAction(node, delay, offset1, offset2)
	local initPos = cc.p(node:getPosition())

	node:setPosition(initPos.x + offset1.x, initPos.y + offset1.y)
	node:setOpacity(0)

	local delay = cc.DelayTime:create(delay)
	local fadeIn = cc.FadeIn:create(0.3)
	local move1 = cc.MoveTo:create(0.2, cc.p(initPos.x + offset2.x, initPos.y + offset2.y))
	local move2 = cc.MoveTo:create(0.1, initPos)

	node:runAction(cc.Sequence:create(delay, cc.Spawn:create(fadeIn, cc.Sequence:create(move1, move2))))
end

function RTPKMatchMediator:onClickCancel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._rtpkSystem:requestCancelMatch()
	end
end

function RTPKMatchMediator:onCancelMatchCallback()
	self:dismiss()
end

function RTPKMatchMediator:onMatchSucc(event)
	local data = event:getData()

	self._enterPvp = true

	self._matchingPanel:setVisible(false)
	self._matchSuccPanel:setVisible(true)
	self:setMyselfInfo(data)
	self:setRivalInfo(data)
	self:addMatchSuccAnim(data)
	self:runAction(self._matchSuccPanel:getChildByName("Text_18"), 0.3, cc.p(0, -100), cc.p(0, 0))
	AudioEngine:getInstance():playBackgroundMusic("Se_Alert_Common_Pic")
end

function RTPKMatchMediator:_enterBattleScene(evt)
	local battleData = self._controller:fetchBattleData(evt:getData(), {
		battleType = "orrtpk",
		seasonId = self._rtpk:getSeasonId()
	})

	self._rtpkSystem:enterPvpBattle(battleData)

	self._enterBattle = true
end

function RTPKMatchMediator:_connectSucc()
	self._rtpkSystem:connectSucc()
end

function RTPKMatchMediator:_battleResult()
	self._enterBattle = true

	self._rtpkSystem:pvpBattleFinish()
	self._controller:clearBattleFinishData()
end
