-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerBattleWinMediator.lua

TowerBattleWinMediator = class("TowerBattleWinMediator", DmPopupViewMediator, _M)

TowerBattleWinMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.btnStatistic"] = "onTouchStatistic"
}

function TowerBattleWinMediator:initialize()
	super.initialize(self)
end

function TowerBattleWinMediator:dispose()
	if self._audioEffectId then
		AudioEngine:getInstance():stopEffect(self._audioEffectId)

		self._audioEffectId = nil
	end

	super.dispose(self)
end

function TowerBattleWinMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")

	self:getView():getChildByFullName("common_btn_info_1"):setVisible(false)

	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("DataStatistics") then
		btn:setVisible(false)
	end
end

function TowerBattleWinMediator:onRemove()
	super.onRemove(self)
end

function TowerBattleWinMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._data = data
	self._rewards = data.reward
	self._rewards = self._towerSystem:sortRewards(self._rewards)
	self._touchClose = false

	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function TowerBattleWinMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._wordPanel = self._main:getChildByName("word")
end

function TowerBattleWinMediator:refreshView()
	self:showHeroPanel()
end

function TowerBattleWinMediator:showHeroPanelAnim()
	local function showReward(rewards)
		for k, v in ipairs(rewards) do
			local layout = ccui.Layout:create()

			if k == 1 then
				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 50))

				local secondRewardText = ccui.Text:create(Strings:get("Tower_Normal_Reward"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
				secondRewardText:ignoreContentAdaptWithSize(false)
				secondRewardText:setContentSize(cc.size(107, 28))
				secondRewardText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				secondRewardText:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
				secondRewardText:setString(Strings:get("BLOCKSP_UI21"))
			end

			layout:setContentSize(cc.size(100.5, 85))

			local icon = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
				needDelay = true
			})
			icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
			icon:setScaleNotCascade(0.75)
			self._rewardListView:pushBackCustomItem(layout)
		end

		local items = self._rewardListView:getItems()

		for i = 1, #items do
			local _item = items[i]:getChildByName("rewardIcon")

			if _item then
				local posX, posY = _item:getPosition()

				_item:setPositionX(posX + 30)
				_item:setPositionY(posY + 5)
				_item:setOpacity(0)
				_item:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY + 5))))
			else
				_item = items[i]:getChildByName("line")

				_item:setOpacity(0)
				_item:runAction(cc.FadeIn:create(0.2))
			end
		end
	end

	self._rewardPanel:setVisible(false)

	local anim = cc.MovieClip:create("stageshengli_fubenjiesuan")
	local bgPanel = self._main:getChildByName("heroAndBgPanel")
	local mvpSpritePanel = anim:getChildByName("roleNode")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(cc.p(-200, -200)))
	anim:addCallbackAtFrame(45, function()
		anim:stop()

		self._touchClose = true

		self._rewardPanel:setVisible(true)
		showReward(self._rewards)
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())
	anim:gotoAndPlay(1)
end

function TowerBattleWinMediator:showHeroPanel()
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

	local mvpPoint = 0
	local tower = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	local team = tower:getTeam()
	local towerMasterId
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

	local mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	mvpSprite:setScale(0.8)

	self._mvpSprite = mvpSprite

	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
	local heroMvpText

	if roleId then
		heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
	end

	if heroMvpText then
		self._mvpAudioEffect = "Voice_" .. roleId .. "_" .. 31

		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 30, posY - size.height - 10))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
	end

	self:showHeroPanelAnim()
end

function TowerBattleWinMediator:leaveWithData()
	self:onTouchLayout()
end

function TowerBattleWinMediator:onTouchLayout(sender, eventType)
	if not self._touchClose then
		return
	end

	local towerId = self._towerSystem:getCurTowerId()
	local tower = self._towerSystem:getTowerDataById(towerId)
	local isOpenBuff = self._towerSystem:checkTowerBuffChoose(false)

	if isOpenBuff then
		local buffs = tower:getPointBuffs() or {}

		BattleLoader:popBattleView(self, {}, "TowerBuffChooseView", {
			buffs = buffs
		})

		return
	end

	local isOpenCard = self._towerSystem:checkTowerCardsChoose(false)

	if isOpenCard then
		local cards = tower:getPointCards() or {}

		BattleLoader:popBattleView(self, {}, "TowerCardsChooseView", {
			cards = cards
		})

		return
	end

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

function TowerBattleWinMediator:onTouchStatistic()
	local data = self._data.battleStatist
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function TowerBattleWinMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end
end

function TowerBattleWinMediator:onTouchMaskLayer()
	return
end
