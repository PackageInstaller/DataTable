-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengeBattleEndMediator.lua

DreamChallengeBattleEndMediator = class("DreamChallengeBattleEndMediator", DmPopupViewMediator, _M)

DreamChallengeBattleEndMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["content.touchPanel"] = "onTouchMaskLayer",
	["content.btnStatistic"] = "onTouchStatistic"
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kHeroPos = {
	cc.p(60, 260),
	cc.p(180, 260),
	cc.p(300, 260),
	cc.p(420, 260),
	cc.p(540, 260),
	cc.p(60, 115),
	cc.p(180, 115),
	cc.p(300, 115),
	cc.p(420, 115),
	(cc.p(540, 115))
}

function DreamChallengeBattleEndMediator:initialize()
	super.initialize(self)
end

function DreamChallengeBattleEndMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_minigame_win_view")
	super.dispose(self)
end

function DreamChallengeBattleEndMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamChallengeBattleEndMediator:onRemove()
	super.onRemove(self)
end

function DreamChallengeBattleEndMediator:enterWithData(data)
	self._data = data.data
	self._dreamId = data.dreamId
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._teamHeros = self._dreamSystem:getBattleTeam():getHeroes()
	self._teamNpc = self._dreamSystem:getNpc(self._dreamId, self._mapId, self._pointId)

	self:initWidget()
	self:refreshView()
end

function DreamChallengeBattleEndMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._wordPanel = self._main:getChildByFullName("word")

	if self._data.pass then
		AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")
	else
		AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
	end

	self._pointNameDi = self._main:getChildByFullName("pointName")
	self._pointName = self._main:getChildByFullName("pointName.name")
	self._teamListBase = self._main:getChildByFullName("teamList")
	self._heroClone = self:getView():getChildByFullName("myPetClone")
	self._maskLayer = self._main:getChildByFullName("touchPanel")

	self._maskLayer:setVisible(false)
end

function DreamChallengeBattleEndMediator:refreshView()
	self._teamListBase:setVisible(true)
	self._teamListBase:setOpacity(0)
	self._pointNameDi:setOpacity(0)
	self._pointName:setString(self._dreamSystem:getMapName(self._dreamId) .. "-" .. self._dreamSystem:getPointName(self._mapId) .. "-" .. self._dreamSystem:getBattleName(self._pointId))

	local anim = cc.MovieClip:create(self._data.pass and "shengli_fubenjiesuan" or "shibai_fubenjiesuan")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addTo(self._main:getChildByName("animNode"))
	anim:addCallbackAtFrame(9, function()
		self._wordPanel:fadeIn({
			time = 0.3333333333333333
		})
		self._pointNameDi:fadeIn({
			time = 0.3333333333333333
		})
	end)
	anim:addCallbackAtFrame(17, function()
		self._teamListBase:fadeIn({
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
		mvpSprite:setPosition(cc.p(-200, -200))

		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
		local heroMvpText = ""

		if roleId then
			heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
		end

		if heroMvpText then
			self._wordPanel:setVisible(true)

			local text = self._wordPanel:getChildByName("text")

			text:setString(Strings:get(heroMvpText))

			local image1 = self._wordPanel:getChildByFullName("image1")
			local image2 = self._wordPanel:getChildByFullName("image2")
			local size = text:getContentSize()

			image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
		else
			self._wordPanel:setVisible(false)
		end
	end
end

function DreamChallengeBattleEndMediator:initWinView()
	self._teamListBase:removeAllChildren()
	self._maskLayer:setVisible(true)

	local i = 0

	local function showHero(heros)
		if #heros == 0 then
			return
		end

		local heroInfo = table.remove(heros, 1)

		i = i + 1

		local layout = self._heroClone:clone()

		layout:setScale(0.65)
		self:setHero(layout, heroInfo)
		layout:addTo(self._teamListBase):setPosition(kHeroPos[i])

		local scale = cc.ScaleTo:create(0.2, 0.6)
		local fadeIn = cc.FadeIn:create(0.2)
		local spawn = cc.Spawn:create(scale, fadeIn)

		layout:runAction(spawn)
		performWithDelay(self:getView(), function()
			showHero(heros)
		end, i * 0.05)
	end

	showHero(self:mergeBattleHeroTeam(self._teamNpc, self._teamHeros))
end

function DreamChallengeBattleEndMediator:mergeBattleHeroTeam(npc, team)
	local heros = {}

	for i = 1, #npc do
		table.insert(heros, self._dreamSystem:getNpcInfo(npc[i]))
	end

	for i = 1, #team do
		table.insert(heros, self._dreamSystem:getHeroInfo(team[i]))
	end

	return heros
end

function DreamChallengeBattleEndMediator:setHero(node, info)
	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

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
		local isShow = self._dreamSystem:checkHeroRecomand(self._dreamId, self._mapId, info.heroId)
		local isAwaken = self._dreamSystem:checkHeroAwaken(info.heroId)
		local isFullStar = self._dreamSystem:checkHeroFullStar(info.heroId)

		node:getChildByName("help"):setVisible(false)
		except:setVisible(isShow or isAwaken or isFullStar)

		if isShow or isAwaken or isFullStar then
			local text = except:getChildByName("text")

			if isShow then
				text:setString(Strings:get("clubBoss_46"))
				text:setColor(cc.c3b(255, 203, 63))
			else
				text:setString(Strings:get("LOGIN_UI13"))
				text:setColor(cc.c3b(255, 255, 255))
			end
		end

		if node:getChildByName("fatigueBg") then
			local isTired = self._dreamSystem:checkHeroTired(self._dreamId, self._mapId, info.heroId)

			node:getChildByName("fatigueBg"):setCascadeColorEnabled(false)
			node:getChildByName("fatigueBg"):setVisible(isTired)
			node:setColor(isTired and cc.c3b(150, 150, 150) or cc.c3b(250, 250, 250))

			local fatigueTxt = node:getChildByName("fatigueBg"):getChildByName("fatigueTxt")

			if fatigueTxt then
				fatigueTxt:setString(Strings:get("clubBoss_49"))
			end
		end

		local tiredLabel = node:getChildByName("tiredNum")

		tiredLabel:setString(tostring(self._dreamSystem:getPointFatigueByHeroId(self._dreamId, self._mapId, info.heroId)) .. "/" .. tostring(self._dreamSystem:getPointFatigue(self._dreamId, self._mapId)))
	else
		except:setVisible(false)
		levelImage:setVisible(false)
		level:setVisible(false)
		node:getChildByName("help"):setVisible(true)
		node:getChildByName("fatigueBg"):setVisible(false)
		node:getChildByName("tiredNum"):setVisible(false)
	end
end

function DreamChallengeBattleEndMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)

	local team = self._dreamSystem:getBattleTeam()
	local data = {
		fromBattle = true,
		mapId = self._dreamId,
		pointId = self._mapId,
		battleId = self._pointId,
		team = team,
		stageType = StageTeamType.DREAM
	}

	BattleLoader:popBattleView(self, nil, "DreamChallengeMainView", data)
end

function DreamChallengeBattleEndMediator:onTouchStatistic()
	local data = self._data.statist
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end
