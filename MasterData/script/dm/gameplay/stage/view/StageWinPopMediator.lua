-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageWinPopMediator.lua

StageWinPopMediator = class("StageWinPopMediator", DmPopupViewMediator, _M)

StageWinPopMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.btnStatistic"] = "onTouchStatistic"
}
local starDiamondCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BlockStarDiamond", "content").num

function StageWinPopMediator:initialize()
	super.initialize(self)
end

function StageWinPopMediator:dispose()
	if self._audioEffectId then
		AudioEngine:getInstance():stopEffect(self._audioEffectId)

		self._audioEffectId = nil
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_minigame_win_view")
	super.dispose(self)
end

function StageWinPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("DataStatistics") then
		btn:setVisible(false)
	end
end

function StageWinPopMediator:onRemove()
	super.onRemove(self)
end

function StageWinPopMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._data = data
	self._starNum = 0
	self._stars = {}

	if self._data.stars then
		for _, index in pairs(self._data.stars) do
			self._starNum = self._starNum + 1
			self._stars[index] = true
		end
	end

	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function StageWinPopMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._level = self:getView():getChildByFullName("content.mLevelNum")
	self._exp = self:getView():getChildByFullName("content.mExpNum")

	local expBarSp = cc.Sprite:create("asset/common/sl_bar_02.png")
	local progressTimer = cc.ProgressTimer:create(expBarSp)
	local timerDi = self._main:getChildByName("timerDi")

	progressTimer:setAnchorPoint(0, 0)
	progressTimer:setPosition(1, 1)
	progressTimer:addTo(timerDi)
	progressTimer:setType(1)
	progressTimer:setMidpoint(cc.p(0, 0))
	progressTimer:setBarChangeRate(cc.p(1, 0))

	self._playerExpTimer = progressTimer
	self._starPanel = self._main:getChildByFullName("Panel_star")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._wordPanel = self._main:getChildByName("word")
	self._expPanel = self._main:getChildByFullName("Panel_exp")
	self._state = 1
end

function StageWinPopMediator:refreshView()
	self:showHeroPanel()
	performWithDelay(self:getView(), function()
		if self._state == 1 then
			self:showExpPanel()
		end
	end, 2.2)
end

function StageWinPopMediator:showHeroPanelAnim()
	self._starPanel:setVisible(false)
	self._rewardPanel:setVisible(false)

	local lv = self._main:getChildByName("lvLabel")

	lv:setVisible(false)

	local lvName = self._main:getChildByName("mLevelNum")

	lvName:setVisible(false)

	local exp = self._main:getChildByName("expImg")

	exp:setVisible(false)

	local expNum = self._main:getChildByName("mExpNum")

	expNum:setVisible(false)

	local timer = self._main:getChildByName("timerDi")

	timer:setVisible(false)

	local anim = cc.MovieClip:create("stageshengli_fubenjiesuan")
	local bgPanel = self._main:getChildByName("heroAndBgPanel")
	local mvpSpritePanel = anim:getChildByName("roleNode")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(-200, -200))
	anim:addCallbackAtFrame(45, function()
		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())
	anim:gotoAndPlay(1)
end

function StageWinPopMediator:getBatCompMaxHeroModel()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local team = developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)
	local heroSystem = developSystem:getHeroSystem()
	local player = developSystem:getPlayer()
	local maxCombat = 0
	local maxCombatHero
	local model = ConfigReader:getDataByNameIdAndKey("MasterBase", team:getMasterId(), "RoleModel")

	for k, v in pairs(team._heroes) do
		local heroInfo = heroSystem:getHeroById(v)
		local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", heroInfo:getModel(), "Type")

		if roleType == RoleModelType.kHero and maxCombat < heroInfo:getCombat() then
			maxCombat = heroInfo:getCombat()
			maxCombatHero = heroInfo
		end
	end

	return maxCombatHero:getModel()
end

function StageWinPopMediator:showHeroPanel()
	self._state = 1
	self._levelUpExpBar = {}
	self._normalExpBar = {}

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local model

	if self._data.statist then
		local battleStatist = self._data.statist.players
		local playerBattleData = battleStatist[player:getRid()]
		local team = developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)
		local mvpPoint = 0
		local masterSystem = developSystem:getMasterSystem()
		local masterData = masterSystem:getMasterById(team:getMasterId())

		model = masterData:getModel()

		for k, v in pairs(playerBattleData.unitSummary or {}) do
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
	end

	if not self._data.statist then
		model = self:getBatCompMaxHeroModel()

		self:getView():getChildByFullName("content.btnStatistic"):setVisible(false)
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

	local herosAnim = cc.MovieClip:create("kapai_zhandoujiesuan")

	herosAnim:addTo(self._expPanel):posite(160, 85)
	herosAnim:addCallbackAtFrame(45, function()
		if self._mvpAudioEffect then
			self._audioEffectId = AudioEngine:getInstance():playRoleEffect(self._mvpAudioEffect, false)
		end

		herosAnim:stop()
	end)
	herosAnim:stop()

	self._herosAnim = herosAnim

	local cloneCell = self._expPanel:getChildByName("clone_cell")
	local heroSystem = developSystem:getHeroSystem()
	local rowTeam = self._stageSystem:getBattleTeam()
	local rowTeamHeroes = rowTeam.teamHeroInfo
	local i = 0
	local lineCellCount = 5

	for id, v in pairs(rowTeamHeroes) do
		i = i + 1

		local heroInfo = heroSystem:getHeroById(id)
		local heroData = {
			id = id,
			level = v.level,
			star = heroInfo:getStar(),
			quality = heroInfo:getQuality(),
			rarity = heroInfo:getRarity(),
			qualityLevel = heroInfo:getQualityLevel(),
			name = heroInfo:getName(),
			roleModel = heroInfo:getModel()
		}
		local cell = cloneCell:clone()
		local icon = IconFactory:createHeroLargeNotRemoveIcon(heroData, {
			hideName = true
		})
		local imageNode = icon:getChildByFullName("main.actionNode.image")

		imageNode:setVisible(true)
		icon:setScale(0.6)

		local lvText = icon:getChildByFullName("main.actionNode.level")

		lvText:setScale(1.67)
		icon:addTo(cell):posite(43, 66):setTag(10)

		local expBarSp = cc.Sprite:createWithSpriteFrameName("common_bar_l03.png")
		local progressTimer = cc.ProgressTimer:create(expBarSp)

		progressTimer:addTo(cell):posite(41, -3.9):setName("progressTimer")
		progressTimer:setScaleX(19.5)
		progressTimer:setScaleY(0.5)
		progressTimer:setVisible(false)
		progressTimer:setType(1)
		progressTimer:setMidpoint(cc.p(0, 0))
		progressTimer:setBarChangeRate(cc.p(1, 0))

		local expBar = cell:getChildByName("expBar")
		local exp
		local heroExp = heroInfo:getExp()
		local heroLevel = heroInfo:getLevel()
		local maxExpAmount = heroSystem:getNextLvlAddExp(id, v.level)
		local expBarAmount = v.exp

		expBar:setPercent(expBarAmount * 100 / maxExpAmount)
		progressTimer:setPercentage(expBarAmount * 100 / maxExpAmount)

		expBar.nextPercent = heroExp * 100 / heroSystem:getNextLvlAddExp(id, heroInfo:getLevel())
		expBar.nextLevel = heroLevel

		if heroLevel ~= v.level then
			self._levelUpExpBar[#self._levelUpExpBar + 1] = expBar
			exp = "Exp +" .. self._data.rewards.heroExp
		else
			self._normalExpBar[#self._normalExpBar + 1] = expBar
			exp = "Exp +" .. tostring(heroExp - v.exp)
		end

		local namePanel = icon:getChildByFullName("main.actionNode.namePanel")
		local nameLabel = namePanel:getChildByName("name")

		nameLabel:setString(exp)
		nameLabel:setScale(1.67)
		nameLabel:setVisible(true)
		nameLabel:setPosition(24, 10)

		local _cellAnimPanel = herosAnim:getChildByName("hero" .. i)

		cell:addTo(_cellAnimPanel)

		local j = i % lineCellCount

		if j == 0 then
			j = lineCellCount
		end

		local tail = j * 20

		cell:setPositionX(cell:getPositionX() + tail)

		if lineCellCount < i then
			cell:setPositionY(cell:getPositionY() - 15)
		end

		cell:setVisible(true)
	end

	herosAnim:addCallbackAtFrame(30, function()
		for k, v in ipairs(self._normalExpBar) do
			local curPercent = v:getPercent()
			local nextPercent = v.nextPercent
			local progressTimer = v:getParent():getChildByName("progressTimer")

			progressTimer:setVisible(true)
			v:setVisible(false)
			v:setPercent(nextPercent)

			local actions = {}

			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, curPercent, nextPercent)
			actions[#actions + 1] = cc.CallFunc:create(function()
				progressTimer:setVisible(false)
				v:setVisible(true)
			end)

			progressTimer:runAction(cc.Sequence:create(unpack(actions)))
		end

		for k, v in ipairs(self._levelUpExpBar) do
			local curPercent = v:getPercent()
			local nextPercent = v.nextPercent
			local cell = v:getParent()
			local progressTimer = cell:getChildByName("progressTimer")

			progressTimer:setVisible(true)
			v:setVisible(false)
			v:setPercent(nextPercent)

			local actions = {}

			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, curPercent, 100)
			actions[#actions + 1] = cc.CallFunc:create(function()
				local mc = cc.MovieClip:create("liuguangss_zhandoujiesuan")

				mc:addEndCallback(function()
					mc:stop()
				end)
				mc:setScaleX(0.42)
				mc:setScaleY(0.45)
				mc:addTo(cell):posite(42.3, 52)

				local flashMc = cc.MovieClip:create("lizi_zhandoujiesuan")

				flashMc:addTo(cell):posite(42.3, 52)
				flashMc:addEndCallback(function()
					flashMc:stop()
				end)

				local levelUpAnim = cc.MovieClip:create("sjt_zhandoujiesuant")

				levelUpAnim:addTo(cell):posite(75, 66)

				local extraLevelPanel = v:getParent():getChildByTag(10):getChildByFullName("main.actionNode.level")

				extraLevelPanel:setString("Lv." .. v.nextLevel)
			end)
			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, 0, nextPercent)
			actions[#actions + 1] = cc.CallFunc:create(function()
				progressTimer:setVisible(false)
				v:setVisible(true)
			end)

			progressTimer:runAction(cc.Sequence:create(unpack(actions)))
		end
	end)
	herosAnim:gotoAndPlay(1)
end

function StageWinPopMediator:showExpPanel()
	self._state = 2

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerLevel = player:getLevel()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(playerLevel))
	local currentExp = player:getExp()
	local playerGotExp = self._data.rewards.playerExp
	local oldPercent, nextPercent, isLevelUp

	if not playerGotExp then
		oldPercent = 0
		nextPercent = currentExp / config.PlayerExp * 100
		isLevelUp = false
	elseif currentExp < playerGotExp then
		isLevelUp = true

		local lastLevelCfg = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel() - 1))

		oldPercent = (currentExp + lastLevelCfg.PlayerExp - playerGotExp) / lastLevelCfg.PlayerExp * 100
		nextPercent = currentExp / config.PlayerExp * 100
	else
		isLevelUp = false
		oldPercent = (currentExp - playerGotExp) / config.PlayerExp * 100
		nextPercent = currentExp / config.PlayerExp * 100
	end

	if isLevelUp then
		self._level:setString(playerLevel - 1)
	else
		self._level:setString(playerLevel)
	end

	local point = self._stageSystem:getPointById(self._data.pointId)
	local oldStarState = point:getOldStar() or {}
	local starPanel = self._starPanel
	local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
	local starCondition = point:getStarCondition()

	for i = 1, 3 do
		local diamondNode = self._starPanel:getChildByFullName("star" .. i .. ".diamond")

		if self._stars[i] then
			if oldStarState[i] then
				diamondNode:setColor(cc.c3b(127, 127, 127))
				diamondNode:getChildByName("diamondNum"):setVisible(false)
				diamondNode:getChildByName("onFinish"):setVisible(true)
			else
				diamondNode:setColor(cc.c3b(255, 255, 255))
				diamondNode:getChildByName("onFinish"):setVisible(true)

				local diamondNum = diamondNode:getChildByName("diamondNum")

				diamondNum:setVisible(true)
				diamondNum:setString("+" .. starDiamondCount)
			end
		else
			diamondNode:setColor(cc.c3b(255, 255, 255))
			diamondNode:getChildByName("onFinish"):setVisible(false)

			local diamondNum = diamondNode:getChildByName("diamondNum")

			diamondNum:setVisible(true)
			diamondNum:setString("+" .. starDiamondCount)
		end

		local star = starPanel:getChildByFullName("star" .. i)
		local labelText = star:getChildByFullName("text")

		labelText:setString(Strings:get(descs[starCondition[i].type], {
			value = starCondition[i].value
		}))
	end

	self:initRewardPanel()

	local function showReward(rewards)
		local hasFirstRewards

		if self._data.rewards.firstRewards then
			hasFirstRewards = true

			for k, v in ipairs(self._data.rewards.firstRewards) do
				local layout = ccui.Layout:create()

				if k == 1 then
					local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

					extMc:addEndCallback(function()
						extMc:stop()
					end)
					extMc:addTo(layout)
					extMc:setPosition(cc.p(35, 45))

					local firstRewardText = ccui.Text:create(Strings:get("Stage_Win_FirstReward"), TTF_FONT_FZYH_M, 24)
					local mcPanel = extMc:getChildByName("lastText")

					firstRewardText:addTo(mcPanel):posite(-2, 1)

					local lineGradiantVec2 = {
						{
							ratio = 0.1,
							color = cc.c4b(255, 255, 255, 255)
						},
						{
							ratio = 0.9,
							color = cc.c4b(254, 245, 162, 255)
						}
					}

					firstRewardText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
						x = 0,
						y = -1
					}))
					firstRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
					firstRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
					firstRewardText:getVirtualRenderer():setDimensions(100, 38)
				end

				layout:setContentSize(cc.size(100.5, 85))

				local icon = IconFactory:createRewardIcon(v, {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
					needDelay = true
				})
				icon:setScaleNotCascade(0.8)
				icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
				self._rewardListView:pushBackCustomItem(layout)
			end
		end

		for k, v in ipairs(self._data.rewards.itemRewards) do
			local layout = ccui.Layout:create()

			if k == 1 then
				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 45))

				local secondRewardText = ccui.Text:create(Strings:get("Stage_Win_CommonReward"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
				secondRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				secondRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				secondRewardText:getVirtualRenderer():setDimensions(100, 38)

				if hasFirstRewards then
					local imaLayout = ccui.Layout:create()

					imaLayout:setContentSize(cc.size(20, 84))

					local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

					image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
					self._rewardListView:pushBackCustomItem(imaLayout)
				end
			end

			layout:setContentSize(cc.size(100.5, 85))

			local icon = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
				needDelay = true
			})
			icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
			icon:setScaleNotCascade(0.8)
			self._rewardListView:pushBackCustomItem(layout)
		end

		local items = self._rewardListView:getItems()

		for i = 1, #items do
			local _item = items[i]:getChildByName("rewardIcon")

			if _item then
				local posX, posY = _item:getPosition()

				_item:setPositionX(posX + 30)
				_item:setOpacity(0)
				_item:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
			else
				_item = items[i]:getChildByName("line")

				_item:setOpacity(0)
				_item:runAction(cc.FadeIn:create(0.2))
			end
		end

		performWithDelay(self._main, function()
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local guideAgent = storyDirector:getGuideAgent()

			if guideAgent:isGuiding() then
				if self._data.pointId == "M01S03" and self._data.rewards.firstRewards then
					local heroId = "FTLEShi"

					for i, v in ipairs(self._data.rewards.firstRewards) do
						if v.type == 3 then
							heroId = v.code
						end
					end

					StatisticSystem:send({
						point = "guide_main_stage_1_3_17",
						type = "loginpoint"
					})

					local view = self:getInjector():getInstance("newHeroView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
						heroId = heroId
					}))

					self.guidePlaySta = nil
				elseif self._data.pointId == "M01S01" then
					local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Hero", "content")
					local heroId = content[1]

					StatisticSystem:send({
						point = "story01_1a_getHero",
						type = "loginpoint"
					})

					local view = self:getInjector():getInstance("newHeroView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
						heroId = heroId
					}))

					self.guidePlaySta = nil
				end
			end
		end, 1.2)
	end

	local actOffSet = 680

	self._starPanel:setVisible(true)

	local _star1 = self._starPanel:getChildByFullName("star1")
	local posX1, posY1 = _star1:getPosition()
	local _star2 = self._starPanel:getChildByFullName("star2")
	local posX2, posY2 = _star2:getPosition()
	local _star3 = self._starPanel:getChildByFullName("star3")
	local posX3, posY3 = _star3:getPosition()

	_star1:setPositionX(posX1 + actOffSet)
	_star2:setPositionX(posX2 + actOffSet)
	_star3:setPositionX(posX3 + actOffSet)

	local spacePx = 13
	local lv = self._main:getChildByName("lvLabel")

	lv:setVisible(true)

	local posX4, posY4 = lv:getPosition()

	lv:setPositionX(posX4 + actOffSet)

	local lvName = self._main:getChildByName("mLevelNum")

	lvName:setVisible(true)

	local posX5, posY5 = lvName:getPosition()

	lvName:setPositionX(posX5 + actOffSet)

	local exp = self._main:getChildByName("expImg")

	exp:setVisible(true)

	local posX6, posY6 = exp:getPosition()

	exp:setPositionX(posX6 + actOffSet)

	local expNum = self._main:getChildByName("mExpNum")

	expNum:setVisible(true)

	local posX7, posY7 = expNum:getPosition()

	expNum:setPositionX(posX7 + actOffSet)

	local timer = self._main:getChildByName("timerDi")

	timer:setVisible(true)

	local posX8, posY8 = timer:getPosition()

	timer:setPositionX(posX8 + actOffSet)

	posX5 = posX8 - lvName:getContentSize().width - spacePx
	posX4 = posX5 - lv:getContentSize().width - spacePx

	self._herosAnim:addCallbackAtFrame(108, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX1, posY1)))

		easeBackOutAni:update(1)
		_star1:runAction(easeBackOutAni)
		lv:runAction(cc.MoveTo:create(0.5, cc.p(posX4, posY4)))
		lvName:runAction(cc.MoveTo:create(0.5, cc.p(posX5, posY5)))
		exp:runAction(cc.MoveTo:create(0.5, cc.p(posX6, posY6)))
		expNum:runAction(cc.MoveTo:create(0.5, cc.p(posX7, posY7)))
		timer:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(posX8, posY8)), cc.CallFunc:create(function()
			if isLevelUp then
				self._playerExpTimer:runAction(cc.Sequence:create(cc.ProgressFromTo:create(0.4, oldPercent, 100), cc.CallFunc:create(function()
					self._level:setString(playerLevel)
				end), cc.ProgressFromTo:create(0.4, 0, nextPercent)))
			else
				self._playerExpTimer:runAction(cc.ProgressFromTo:create(0.4, oldPercent, nextPercent))
			end
		end)))
	end)
	self._herosAnim:addCallbackAtFrame(113, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX2, posY2)))

		easeBackOutAni:update(0.8)
		_star2:runAction(easeBackOutAni)
	end)
	self._herosAnim:addCallbackAtFrame(118, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX3, posY3)))

		easeBackOutAni:update(0.6)
		_star3:runAction(easeBackOutAni)
	end)
	self._herosAnim:addCallbackAtFrame(130, function()
		self._herosAnim:stop()
		self._rewardPanel:setVisible(true)
		showReward(self._data.rewards.itemRewards)
		self:setPointStarCondition()
	end)
	self._herosAnim:gotoAndPlay(90)
end

function StageWinPopMediator:setPointStarCondition()
	local starCount = 0

	for i = 1, 3 do
		if self._stars[i] then
			starCount = i

			local _starBg = self._starPanel:getChildByFullName("star" .. i .. ".star")
			local anim = cc.MovieClip:create("aa_yinghunshengxing")

			anim:addTo(_starBg):setName("starAnim")
			anim:addEndCallback(function()
				anim:gotoAndPlay(30)
			end)
			anim:setPosition(cc.p(33, 45))
			anim:stop()
			performWithDelay(_starBg, function()
				anim:gotoAndPlay(1)
				AudioEngine:getInstance():playEffect("Se_Effect_Win_Star", false)
			end, 0.15 * i)
		end
	end

	if starCount ~= 0 then
		performWithDelay(self:getView(), function()
			AudioEngine:getInstance():playEffect("Se_Effect_Star_Shine", false)
		end, 0.05 + 0.15 * starCount)
	end
end

function StageWinPopMediator:initRewardPanel()
	local crystalAmount = 0
	local goldAmount = 0

	if self._data.rewards.goldReward then
		goldAmount = tonumber(self._data.rewards.goldReward)
	end

	if self._data.rewards.crystalReward then
		crystalAmount = tonumber(self._data.rewards.crystalReward)
	end

	self._data.rewards.itemRewards = self._data.rewards.itemRewards or {}

	if self._data.rewards.playerExp then
		self._exp:setString("+" .. self._data.rewards.playerExp)
	else
		self._exp:setString("0")
	end

	if goldAmount > 0 then
		local _tab = self._data.rewards.itemRewards
		local tag = false

		for _, v in ipairs(_tab) do
			if v.code == "IR_Gold" and v.type == 2 then
				v.amount = v.amount + goldAmount
				tag = true

				break
			end
		end

		if not tag then
			local goldRewardTable = {}

			goldRewardTable.amount = goldAmount
			goldRewardTable.code = "IR_Gold"
			goldRewardTable.type = 2
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = goldRewardTable
		end
	end

	if crystalAmount > 0 then
		local _tab = self._data.rewards.itemRewards
		local tag = false

		for _, v in ipairs(_tab) do
			if v.code == "IR_Crystal" and v.type == 2 then
				v.amount = v.amount + crystalAmount
				tag = true

				break
			end
		end

		if not tag then
			local crystalRewardTable = {}

			crystalRewardTable.amount = crystalAmount
			crystalRewardTable.code = "IR_Crystal"
			crystalRewardTable.type = 2
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = crystalRewardTable
		end
	end

	if self._data.rewards.activityExtraReward then
		for _, v in ipairs(self._data.rewards.activityExtraReward) do
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = v
		end
	end

	for k, v in ipairs(self._data.rewards.itemRewards) do
		if v.type == RewardType.kExp then
			v.quality = 100
		elseif v.type == RewardType.kHero then
			v.quality = RewardSystem:getQuality(v) + 50
		else
			local quality = RewardSystem:getQuality(v)

			v.quality = quality == nil and 0 or quality
		end
	end

	table.sort(self._data.rewards.itemRewards, function(a, b)
		return a.quality > b.quality
	end)

	local firstRewardList = self._data.rewards.firstRewards

	if firstRewardList and #firstRewardList > 0 then
		local replaceConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayer_StageShowReward", "content")

		for k, v in pairs(replaceConfig) do
			if self._data.pointId == k then
				local replaceRewards = ConfigReader:getDataByNameIdAndKey("Reward", v, "Content")

				for i = 1, #replaceRewards do
					firstRewardList[#firstRewardList + 1] = replaceRewards[i]
				end

				break
			end
		end

		for k, v in ipairs(firstRewardList) do
			v.quality = v.type == RewardType.kExp and 100 or v.type == RewardType.kHero and RewardSystem:getQuality(v) + 50 or RewardSystem:getQuality(v)
		end

		table.sort(firstRewardList, function(a, b)
			return a.quality > b.quality
		end)
	end
end

function StageWinPopMediator:leaveWithData()
	self:onTouchLayout()
end

function StageWinPopMediator:onTouchLayout(sender, eventType)
	if self.guidePlaySta then
		return
	end

	if self._state == 1 then
		self:showExpPanel()

		return
	end

	if self._state ~= 2 then
		return
	end

	self._state = 3

	self._stageSystem:requestStageProgress(function()
		local pointId = self._data.pointId
		local guideSystem = self:getInjector():getInstance(GuideSystem)
		local isRunGuide = guideSystem:runGuideByStage(pointId)

		if self._data.quickCross then
			self:dispatch(Event:new(EVT_STAGE_QUICK_CROSS))
			self:close()

			return
		end

		if isRunGuide and guideSystem:isToHome(pointId) then
			BattleLoader:popBattleView(self, {
				viewName = "homeView",
				userdata = {}
			})

			return
		end

		BattleLoader:popBattleView(self, {})
	end, false)
end

function StageWinPopMediator:onTouchStatistic()
	local data = self._data.statist
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function StageWinPopMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() and self._data.pointId == "M01S03" and self._data.rewards.firstRewards and self._data.rewards.firstRewards[1] and self._data.rewards.firstRewards[1].code then
		self.guidePlaySta = true
	end

	if guideAgent:isGuiding() and self._data.pointId == "M01S01" then
		self.guidePlaySta = true
	end

	storyDirector:notifyWaiting("enter_minigame_win_view")

	if guideAgent:isGuiding() then
		local statisticName
		local pointId = self._data.pointId

		if pointId == "M01S01" then
			statisticName = "guide_main_stage_1_1_17"
		elseif pointId == "M01S02" then
			statisticName = "guide_main_stage_1_2_14"
		elseif pointId == "M01S03" then
			statisticName = "guide_main_stage_1_3_18"
		elseif pointId == "M01S04" then
			statisticName = "guide_main_stage_1_4_8"
		elseif pointId == "M02S01" then
			statisticName = "guide_main_stage_2_1_7"
		end

		if statisticName then
			StatisticSystem:send({
				type = "loginpoint",
				point = statisticName
			})
		end
	end
end

function StageWinPopMediator:onTouchMaskLayer()
	return
end
