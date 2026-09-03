-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossBattleEndMediator.lua

CooperateBossBattleEndMediator = class("CooperateBossBattleEndMediator", DmPopupViewMediator)

CooperateBossBattleEndMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CooperateBossBattleEndMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
CooperateBossBattleEndMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")

local kBtnHandlers = {}
local Battle_End_State = {
	State_Join = 2,
	State_MVP = 1,
	State_Lose = 3,
	State_Escape = 4
}

function CooperateBossBattleEndMediator:initialize()
	super.initialize(self)
end

function CooperateBossBattleEndMediator:dispose()
	self:getView():stopAllActions()
	super.dispose(self)
end

function CooperateBossBattleEndMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossBattleEndMediator:mapEventListeners()
	return
end

function CooperateBossBattleEndMediator:enterWithData(data)
	self:initView()
	self:initData(data)
	self:refreshView()
end

function CooperateBossBattleEndMediator:resumeWithData()
	return
end

function CooperateBossBattleEndMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._winPanel = self._main:getChildByFullName("winPanel")
	self._animNode = self._main:getChildByFullName("animNode")
	self._titleText = self._winPanel:getChildByFullName("title")
	self._wordPanel = self._main:getChildByFullName("word")
	self._bubleText = self._main:getChildByFullName("word.text")
	self._resultPanel1 = self._winPanel:getChildByFullName("invite")
	self._resultPanel2 = self._winPanel:getChildByFullName("invite1")
	self._resultPanel3 = self._winPanel:getChildByFullName("invite2")
	self._loadingBar = self._resultPanel2:getChildByFullName("loadingBar")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._leftBloodText = self._resultPanel2:getChildByFullName("leaveNum")
	self._hurtText = self._winPanel:getChildByFullName("fightNum")
	self._touchPanel = self._main:getChildByFullName("touchPanel")
	self._kill = self._winPanel:getChildByName("kill")

	self._touchPanel:setSwallowTouches(false)
	self._winPanel:setSwallowTouches(false)

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(222, 172, 108, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._hurtText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))
	self._resultPanel1:setVisible(false)
	self._resultPanel2:setVisible(false)
	self._resultPanel3:setVisible(false)
end

function CooperateBossBattleEndMediator:initData(data)
	self._bossId = data.bossId
	self._bossLevel = data.bossLevel
	self._bossConfigId = data.configId
	self._hurt = data.hurt
	self._bossState = data.bossState
	self._leftBlood = tonumber(data.blood) or 0
	self._playerId = data.playerId
	self._rewards = data.rewards
	self._finishBattlePid = data.finishBattlePid
	self._finishBattleName = data.finishBattleName
	self._state = nil

	if self._bossState == kCooperateBossEnemyState.kDead then
		local player = self._developSystem:getPlayer()
		local id = player:getRid()

		self._state = self._finishBattlePid and self._finishBattlePid == self._playerId and self._hurt > 0 and Battle_End_State.State_MVP or Battle_End_State.State_Join
	else
		self._state = self._bossState == kCooperateBossEnemyState.kEscaped and Battle_End_State.State_Escape or Battle_End_State.State_Lose
	end

	self._data = data
end

function CooperateBossBattleEndMediator:refreshView()
	self._winPanel:setVisible(true)
	self._winPanel:setOpacity(0)

	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addTo(self._main:getChildByName("animNode"))
	anim:addCallbackAtFrame(9, function()
		self._wordPanel:fadeIn({
			time = 0.3333333333333333
		})
	end)
	anim:addCallbackAtFrame(17, function()
		self._winPanel:fadeIn({
			time = 0.2
		})
		self:initWinView()
	end)

	local battleStatist = self._data.statist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local team = developSystem:getSpTeamByType(StageTeamType.CRUSADE)
	local mvpPoint = 0
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(team:getMasterId())
	local model = masterData:getModel()

	for k, v in pairs(playerBattleData.unitSummary) do
		local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Type")

		if roleType == RoleModelType.kHero then
			local unitMvpPoint = 0
			local _unitDmg = v.damage

			if _unitDmg then
				unitMvpPoint = unitMvpPoint + _unitDmg
			end

			local _unitCure = v.cure

			if _unitCure then
				unitMvpPoint = unitMvpPoint + _unitCure
			end

			if mvpPoint < unitMvpPoint then
				mvpPoint = unitMvpPoint
				model = v.model
			end
		end
	end

	if model then
		local roleNode = anim:getChildByName("roleNode")

		model = IconFactory:getSpMvpBattleEndMid(model)

		local mvpSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe17",
			id = model
		})

		mvpSprite:addTo(roleNode)
		mvpSprite:setScale(0.8)
		mvpSprite:setPosition(cc.p(cc.p(-200, -200)))

		local winNode = anim:getChildByFullName("winNode")
		local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

		winAnim:addEndCallback(function()
			winAnim:stop()
		end)
		winAnim:addTo(winNode)

		local winPanel = winAnim:getChildByFullName("winTitle")
		local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

		title:addTo(winPanel)

		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
		local heroMvpText = ""

		if roleId then
			heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
		end

		if heroMvpText then
			self._wordPanel:setVisible(true)
			self._bubleText:setString(Strings:get(heroMvpText))

			local image1 = self._wordPanel:getChildByFullName("image1")
			local image2 = self._wordPanel:getChildByFullName("image2")
			local size = self._bubleText:getContentSize()

			image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
		else
			self._wordPanel:setVisible(false)
		end
	end
end

function CooperateBossBattleEndMediator:initWinView()
	self._titleText:setString(Strings:get("CooperateBoss_UI03", {
		name = self._cooperateBossSystem:getBossName(self._bossConfigId),
		lv = self:getBossLevel()
	}))
	self._hurtText:setString(self:getShowHurt())
	self._kill:setVisible(false)

	if self._state == Battle_End_State.State_Escape then
		self._resultPanel3:setVisible(true)
		self._resultPanel3:setString(Strings:get("CooperateBoss_AfterBattle_UI05"))
	elseif self._state == Battle_End_State.State_MVP then
		self._resultPanel1:setVisible(true)
		self._kill:setVisible(true)
	elseif self._state == Battle_End_State.State_Join then
		self._resultPanel3:setVisible(true)
		self._resultPanel3:setString(Strings:get("CooperateBoss_AfterBattle_UI04", {
			playerName = self._finishBattleName
		}))
	else
		self._resultPanel2:setVisible(true)
		self._loadingBar:setPercent(self._leftBlood * 100)
		self._leftBloodText:setString(self._leftBlood * 100 .. "%")
	end
end

function CooperateBossBattleEndMediator:getShowHurt()
	local strLen = string.len(self._hurt)
	local commaCount = math.floor((strLen - 1) / 3)
	local newstr = commaCount > 0 and "" or self._hurt
	local index = 0

	for i = 1, commaCount do
		index = strLen + 1 - 3 * i

		local s = string.sub(self._hurt, strLen + 1 - 3 * i, strLen + 1 - 3 * i + 2)

		newstr = newstr == "" and s or s .. "," .. newstr
	end

	if index > 1 then
		newstr = string.sub(self._hurt, 1, index - 1) .. "," .. newstr
	end

	return newstr
end

function CooperateBossBattleEndMediator:onRewardClicked(sender, eventType)
	return
end

function CooperateBossBattleEndMediator:onTouchMaskLayer()
	local state = self._cooperateBossSystem:getcooperateBossState()

	if kCooperateBossState.kEnd == state then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))
		BattleLoader:popBattleView(self, {
			viewName = "homeView",
			userdata = {}
		})

		return
	end

	if self._bossState == kCooperateBossEnemyState.kEscaped then
		local function callback(data)
			local viewName = self._cooperateBossSystem:getCurBossRootView()

			if viewName and viewName == "CooperateBossMainView" then
				local viewData = {
					viewName = viewName,
					viewData = data
				}

				BattleLoader:popBattleView(self, viewData)
			else
				local viewData = {
					viewName = viewName
				}

				BattleLoader:popBattleView(self, viewData)
			end
		end

		self._cooperateBossSystem:requestCooperateBossMain(callback)
	elseif self._bossState == kCooperateBossEnemyState.kDead then
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)

		local function callback(data)
			BattleLoader:popBattleView(self, nil, "CooperateBossInviteFriendView", data)
		end

		self._cooperateBossSystem:requestCooperateBossFriendInvite(self._bossId, callback)
	else
		local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
		local bossSDtartTime = self._cooperateBossSystem:getCurBossCreateTime()
		local endTime = bossSDtartTime + ConfigReader:getDataByNameIdAndKey("CooperateBossMain", self._bossConfigId, "Time")

		if endTime <= remoteTimestamp then
			local function callback(data)
				local viewName = self._cooperateBossSystem:getCurBossRootView()

				if viewName and viewName == "CooperateBossMainView" then
					local viewData = {
						viewName = viewName,
						viewData = data
					}

					BattleLoader:popBattleView(self, viewData)
				else
					local viewData = {
						viewName = viewName
					}

					BattleLoader:popBattleView(self, viewData)
				end
			end

			self._cooperateBossSystem:requestCooperateBossMain(callback)
		else
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)

			local function callback(data)
				BattleLoader:popBattleView(self, nil, "CooperateBossInviteFriendView", data)
			end

			self._cooperateBossSystem:requestCooperateBossFriendInvite(self._bossId, callback)
		end
	end
end

function CooperateBossBattleEndMediator:getRoleModelId()
	local congfigId = self._bossConfigId

	return (ConfigReader:getDataByNameIdAndKey("CooperateBossMain", congfigId, "RoleModel"))
end

function CooperateBossBattleEndMediator:getBossLevel()
	return self._bossLevel
end
