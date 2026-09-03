-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/view/DreamHouseBattleEndMediator.lua

DreamHouseBattleEndMediator = class("DreamHouseBattleEndMediator", DmPopupViewMediator, _M)

DreamHouseBattleEndMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")
DreamHouseBattleEndMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamHouseBattleEndMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.btnStatistic"] = "onTouchStatistic"
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function DreamHouseBattleEndMediator:initialize()
	super.initialize(self)
end

function DreamHouseBattleEndMediator:dispose()
	if self._audioEffectId then
		AudioEngine:getInstance():stopEffect(self._audioEffectId)

		self._audioEffectId = nil
	end

	super.dispose(self)
end

function DreamHouseBattleEndMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("DataStatistics") then
		btn:setVisible(false)
	end
end

function DreamHouseBattleEndMediator:onRemove()
	super.onRemove(self)
end

function DreamHouseBattleEndMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._data = data.data
	self._battleId = data.battleId
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._team = self._developSystem:getSpTeamByType(StageTeamType.HOUSE)

	local mapData = self._dreamSystem:getMapById(self._mapId)
	local pointData = mapData:getPointById(self._pointId)
	local battleStarData = pointData:getPoints()[self._battleId]
	local starData = {}

	if battleStarData then
		starData = battleStarData.stars
	end

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

	local cjson = require("cjson.safe")
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local data = customDataSystem:getValue(PrefixType.kGlobal, "DreamHouseTeamStates", "BattleSuccess")

	customDataSystem:setValue(PrefixType.kGlobal, "DreamHouseTeamStates", self._data.pass and self._battleId .. "BattleSuccess" or self._battleId .. "BattleFailed")
end

function DreamHouseBattleEndMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._starPanel = self._main:getChildByFullName("Panel_star")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._wordPanel = self._main:getChildByName("word")
	self._expPanel = self._main:getChildByFullName("Panel_exp")
	self._heroClone = self:getView():getChildByFullName("myPetClone")

	self._heroClone:setVisible(false)

	self._pointNameDi = self._main:getChildByFullName("pointName")
	self._pointName = self._main:getChildByFullName("pointName.name")
	self._state = 1
end

function DreamHouseBattleEndMediator:refreshView()
	self:showHeroPanel()
	performWithDelay(self:getView(), function()
		if self._state == 1 then
			self:showExpPanel()
		end
	end, 2.2)
end

function DreamHouseBattleEndMediator:showHeroPanelAnim()
	self._starPanel:setVisible(false)
	self._rewardPanel:setVisible(false)

	local anim = cc.MovieClip:create(self._data.pass and "shengli_fubenjiesuan" or "shibai_fubenjiesuan")
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

function DreamHouseBattleEndMediator:getBatCompMaxHeroModel()
	local team = self._team
	local heroSystem = self._developSystem:getHeroSystem()
	local player = self._developSystem:getPlayer()
	local maxCombat = 0
	local maxCombatHero
	local model = ConfigReader:getDataByNameIdAndKey("MasterBase", team:getMasterId(), "RoleModel")

	for k, v in pairs(team:getHeroes()) do
		local heroInfo = heroSystem:getHeroById(v)
		local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", heroInfo:getModel(), "Type")

		if roleType == RoleModelType.kHero and maxCombat < heroInfo:getCombat() then
			maxCombat = heroInfo:getCombat()
			maxCombatHero = heroInfo
		end
	end

	return maxCombatHero:getModel()
end

function DreamHouseBattleEndMediator:showHeroPanel()
	self._state = 1
	self._normalExpBar = {}

	local player = self._developSystem:getPlayer()
	local model

	if self._data.statist then
		local battleStatist = self._data.statist.players
		local playerBattleData = battleStatist[player:getRid()]
		local team = self._team
		local mvpPoint = 0
		local masterSystem = self._developSystem:getMasterSystem()
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

	if self._mapId then
		self._pointNameDi:setOpacity(0)

		local mapData = self._dreamSystem:getMapById(self._mapId)
		local pointData = mapData:getPointById(self._pointId)
		local mapName = Strings:get(mapData:getMapConfig().Name)
		local pointpName = pointData:getPointName()
		local battleName = pointData:getBattleNameById(self._battleId)

		self._pointName:setString(mapName .. "-" .. pointpName .. "-" .. battleName)
		self._pointNameDi:runAction(cc.FadeIn:create(0.6))
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
	local heroSystem = self._developSystem:getHeroSystem()
	local rowTeam = self._team
	local rowTeamHeroes = rowTeam:getHeroes()
	local lineCellCount = 5

	for i = 1, #rowTeamHeroes do
		local heroId = rowTeamHeroes[i]
		local cell = self._heroClone:clone()

		cell:setScale(0.65)
		self:setHero(cell, heroId)

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

	herosAnim:gotoAndPlay(1)
end

function DreamHouseBattleEndMediator:showExpPanel()
	self._state = 2

	local mapData = self._dreamSystem:getMapById(self._mapId)
	local pointData = mapData:getPointById(self._pointId)
	local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Star")
	local starPanel = self._starPanel

	self._starPanel:getChildByFullName("star1"):setVisible(false)
	self._starPanel:getChildByFullName("star2"):setVisible(false)
	self._starPanel:getChildByFullName("star3"):setVisible(false)

	for i = 1, #starCond do
		local star = starPanel:getChildByFullName("star" .. i)
		local labelText = star:getChildByFullName("text")

		labelText:setString(self._dreamSystem:getPointStarDesc(starCond[i]))
		self._starPanel:getChildByFullName("star" .. i):setVisible(true)
	end

	local function showReward(rewards)
		local hasFirstRewards

		self._rewardPanel:setVisible(false)

		if rewards and #rewards > 0 then
			hasFirstRewards = true

			for k, v in ipairs(rewards) do
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

			self._rewardPanel:setVisible(true)
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
	self._herosAnim:addCallbackAtFrame(108, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX1, posY1)))

		easeBackOutAni:update(1)
		_star1:runAction(easeBackOutAni)
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
		showReward(self._data.rewards or {})
		self:setPointStarCondition()
	end)
	self._herosAnim:gotoAndPlay(90)
end

function DreamHouseBattleEndMediator:setPointStarCondition()
	local starCount = 0
	local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Star")

	for i = 1, #starCond do
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

function DreamHouseBattleEndMediator:leaveWithData()
	self:onTouchLayout()
end

function DreamHouseBattleEndMediator:onTouchLayout(sender, eventType)
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

	local data = {
		fromBattle = true,
		mapId = self._mapId,
		pointId = self._pointId,
		battleId = self._battleId
	}

	BattleLoader:popBattleView(self, nil, "DreamHouseDetailView", data)
end

function DreamHouseBattleEndMediator:onTouchStatistic()
	local data = self._data.statist
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function DreamHouseBattleEndMediator:setHero(node, heroId)
	local heroSystem = self._developSystem:getHeroSystem()
	local heroInfo = heroSystem:getHeroById(heroId)
	local info = {
		isNpc = false,
		id = heroInfo:getId(),
		heroId = heroId,
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		rareity = heroInfo:getRarity(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		littleStar = heroInfo:getLittleStar(),
		combat = heroInfo:getCombat(),
		maxStar = heroInfo:getMaxStar(),
		awakenLevel = heroInfo:getAwakenStar()
	}

	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.6)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroImg:addTo(heroPanel):center(heroPanel:getContentSize())

	local weak = node:getChildByName("weak")
	local weakTop = node:getChildByName("weakTop")
	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()
	weak:removeAllChildren()
	weakTop:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())
		anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 1, bg1:getContentSize().height / 2 - 30))

		if info.rareity == 15 then
			anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 3, bg1:getContentSize().height / 2))
		end

		if info.rareity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rareity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	if info.awakenLevel and info.awakenLevel > 0 then
		local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

		anim:addTo(weak):center(weak:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)

		anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(weakTop):center(weakTop:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")

	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local levelImage = node:getChildByName("levelImage")
	local level = node:getChildByName("level")

	level:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = level:getContentSize().width

	levelImage:setScaleX((levelWidth + 20) / levelImageWidth)

	local starBg = node:getChildByName("starBg")
	local size = cc.size(148, 32)
	local width = size.width - (size.width / HeroStarCountMax - 2) * (HeroStarCountMax - info.maxStar)

	starBg:setContentSize(cc.size(width, size.height))

	for i = 1, HeroStarCountMax do
		local star = starBg:getChildByName("star_" .. i)

		star:setVisible(i <= info.maxStar)

		local path = i <= info.star and "img_yinghun_img_star_full.png" or i == info.star + 1 and info.littleStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

		if info.awakenLevel > 0 then
			path = "jx_img_star.png"
		end

		star:ignoreContentAdaptWithSize(true)
		star:setScale(0.4)
		star:loadTexture(path, 1)
	end

	local except = node:getChildByName("except")

	node:getChildByName("help"):setVisible(true)
	node:getChildByName("help"):loadTexture("asset/common/kazu_bg_yuan.png")

	if not info.isNpc then
		local isShow = self._dreamSystem:checkHeroRecomand(self._battleId, info.heroId)

		node:getChildByName("help"):setVisible(false)
		except:setVisible(isShow)

		if isShow then
			local text = except:getChildByName("text")

			text:setString(Strings:get("clubBoss_46"))
			text:setColor(cc.c3b(255, 203, 63))
		end

		if node:getChildByName("fatigueBg") then
			local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, self._battleId, info.heroId)

			node:getChildByName("fatigueBg"):setCascadeColorEnabled(false)
			node:getChildByName("fatigueBg"):setVisible(isTired)
			node:setColor(isTired and cc.c3b(150, 150, 150) or cc.c3b(250, 250, 250))

			local fatigueTxt = node:getChildByName("fatigueBg"):getChildByName("fatigueTxt")

			if fatigueTxt then
				fatigueTxt:setString(Strings:get("clubBoss_49"))
			end
		end

		local tiredLabel = node:getChildByName("tiredNum")

		tiredLabel:setVisible(false)
	else
		except:setVisible(false)
		levelImage:setVisible(false)
		level:setVisible(false)
		node:getChildByName("help"):setVisible(true)
		node:getChildByName("fatigueBg"):setVisible(false)
		node:getChildByName("tiredNum"):setVisible(false)
	end
end

function DreamHouseBattleEndMediator:onTouchMaskLayer()
	return
end
