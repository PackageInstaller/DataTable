-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerBattleLoseMediator.lua

TowerBattleLoseMediator = class("TowerBattleLoseMediator", DmPopupViewMediator, _M)

TowerBattleLoseMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
TowerBattleLoseMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerBattleLoseMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.btnStatistic"] = "onTouchStatistic"
}

function TowerBattleLoseMediator:initialize()
	super.initialize(self)
end

function TowerBattleLoseMediator:dispose()
	super.dispose(self)
end

function TowerBattleLoseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("DataStatistics") then
		btn:setVisible(false)
	end
end

function TowerBattleLoseMediator:onRemove()
	super.onRemove(self)
end

function TowerBattleLoseMediator:enterWithData(data)
	self._data = data
	self._touchClose = false

	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function TowerBattleLoseMediator:initWidget()
	self._bg = self:getView():getChildByName("content")
	self._tips = self._bg:getChildByName("tips")
	self._wordPanel = self._bg:getChildByName("word")

	if not self._data.title then
		local tip = Strings:get("Tower_1_UI_15")

		self._tips:getChildByName("Text_55"):setString(self._data.title)
	end
end

function TowerBattleLoseMediator:refreshView()
	local anim = cc.MovieClip:create("shibai_fubenjiesuan")
	local bgPanel = self._bg:getChildByName("heroAndBgPanel")

	anim:addCallbackAtFrame(45, function()
		self._touchClose = true

		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())

	local svpSpritePanel = anim:getChildByName("roleNode")

	self:initSvpRole()
	svpSpritePanel:addChild(self._svpSprite)
	self._svpSprite:setPosition(cc.p(cc.p(-200, -200)))
	anim:gotoAndPlay(1)
	self._tips:runAction(cc.FadeIn:create(0.6))
end

function TowerBattleLoseMediator:leaveWithData()
	self:onTouchLayout()
end

function TowerBattleLoseMediator:onTouchLayout(sender, eventType)
	if not self._touchClose then
		return
	end

	local towerId = self._towerSystem:getCurTowerId()
	local tower = self._towerSystem:getTowerDataById(towerId)

	if tower:getStatus() == kEnterFightStatus.END or tower:getReviveTimes() <= 0 then
		local data = self._towerSystem:getTowerFinishData()

		if data and data.stageFinish then
			BattleLoader:popBattleView(self, {}, "TowerChallengeEndView", data)
		end

		return
	end

	BattleLoader:popBattleView(self, {}, "TowerPointView", {
		towerId = towerId
	})
end

function TowerBattleLoseMediator:initSvpRole()
	local model
	local battleStatist = self._data.battleStatist
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local playerBattleData

	if battleStatist then
		local player = developSystem:getPlayer()

		if not self._data.loseId then
			local id = player:getRid()

			playerBattleData = battleStatist.players[id]
		end
	else
		playerBattleData = {
			unitSummary = {}
		}
	end

	local tower = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	local team = tower:getTeam()
	local towerMasterId
	local mvpPoint = 0
	local enemyMaster = ConfigReader:getDataByNameIdAndKey("TowerMaster", (team or nil) and team:getMasterId(), "Master")
	local model = ConfigReader:getDataByNameIdAndKey("EnemyMaster", enemyMaster, "RoleModel")

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

	model = IconFactory:getSpMvpBattleEndMid(model)

	local svpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	svpSprite:setScale(0.8)

	self._svpSprite = svpSprite

	local heroMvpText
	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")

	if roleId then
		heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "SVPText")
	end

	if heroMvpText then
		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 30, posY - size.height - 10))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
	end
end

function TowerBattleLoseMediator:onTouchStatistic()
	local data = self._data
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		players = data.battleStatist.players
	}))
end

function TowerBattleLoseMediator:setupClickEnvs()
	return
end

function TowerBattleLoseMediator:onTouchMaskLayer()
	return
end
