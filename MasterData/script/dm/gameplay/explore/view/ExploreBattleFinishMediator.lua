-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreBattleFinishMediator.lua

ExploreBattleFinishMediator = class("ExploreBattleFinishMediator", DmPopupViewMediator, _M)

ExploreBattleFinishMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreBattleFinishMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ExploreBattleFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["content.panel_lose.masterBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMaster"
	},
	["content.panel_lose.heroBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHero"
	}
}
local MapAutoHPTips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapAutoHPTips", "content")

function ExploreBattleFinishMediator:initialize()
	super.initialize(self)
end

function ExploreBattleFinishMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_minigame_win_view")
	super.dispose(self)
end

function ExploreBattleFinishMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ExploreBattleFinishMediator:onRemove()
	super.onRemove(self)
end

function ExploreBattleFinishMediator:enterWithData(data)
	self._data = data
	self._isWin = self._data.report.win or false
	self._discoveryHp = self._data.report.discoveryHp or 0
	self._hpLost = self._data.report.hpLost or 0
	self._pointId = self._data.report.pointId
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._hpMax = self._exploreSystem:getHpMax()
	self._rewards = {}

	if not self._data.report.rewards then
		local rewards = {}

		local function isEquip(type)
			if type == RewardType.kEquip or type == RewardType.kEquipExplore then
				return true
			end

			return false
		end

		for i = 1, #rewards do
			local reward = rewards[i]

			if isEquip(reward.type) then
				for j = 1, reward.amount do
					table.insert(self._rewards, reward)
				end
			else
				table.insert(self._rewards, reward)
			end
		end

		self:initWidget()
		self:refreshView()

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_minigame_win_view")
	end
end

function ExploreBattleFinishMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._enoughTip = self._main:getChildByFullName("enougeTip")
	self._teamNum = self._main:getChildByFullName("teamNum")
	self._wordPanel = self._main:getChildByFullName("word")
	self._consumeLabel = self._main:getChildByFullName("node1.consumeLabel")
	self._dpLoadingBar = self._main:getChildByFullName("node2.mExpBar")
	self._dpLabel1 = self._main:getChildByFullName("node2.dpLabel_1")
	self._dpLabel2 = self._main:getChildByFullName("node2.dpLabel_2")
	self._winPanel = self._main:getChildByFullName("panel_win")
	self._losePanel = self._main:getChildByFullName("panel_lose")

	self._winPanel:setVisible(false)
	self._losePanel:setVisible(false)
	self._dpLoadingBar:setScale9Enabled(true)
	self._dpLoadingBar:setCapInsets(cc.rect(1, 1, 1, 1))
	GameStyle:setCommonOutlineEffect(self._teamNum)
	GameStyle:setCommonOutlineEffect(self._consumeLabel)
	GameStyle:setCommonOutlineEffect(self._dpLabel1)
	GameStyle:setCommonOutlineEffect(self._dpLabel2)
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("node1.text1"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("node2.text2"))
	GameStyle:setCommonOutlineEffect(self._losePanel:getChildByName("text"))
	GameStyle:setCommonOutlineEffect(self._wordPanel:getChildByName("text"))
end

function ExploreBattleFinishMediator:refreshView()
	self._consumeLabel:setString(self._hpLost)

	local teams = self._pointData:getTeams()
	local currentTeamId = tonumber(self._pointData:getCurrentTeamId())

	self._teamNum:setString(Strings:get("EXPLORE_UI107", {
		num = currentTeamId
	}))

	local hp = teams[currentTeamId]:getHp()

	self._dpLabel1:setString(hp)
	self._dpLabel2:setString("/" .. self._hpMax)
	self._dpLoadingBar:setPercent(hp / self._hpMax * 100)
	self._enoughTip:removeAllChildren()

	local tip = ""

	for i, v in pairs(MapAutoHPTips) do
		if hp >= v[1] and hp <= v[2] then
			tip = Strings:get(i, {
				fontName = TTF_FONT_FZYH_R
			})

			break
		end
	end

	if tip ~= "" then
		local contentText = ccui.RichText:createWithXML(tip, {})

		contentText:setAnchorPoint(cc.p(0, 0))
		contentText:addTo(self._enoughTip)
		ajustRichTextCustomWidth(contentText, 420)
	end

	local anim

	if self._isWin then
		anim = cc.MovieClip:create("shengli_fubenjiesuan")

		anim:addEndCallback(function()
			anim:stop()
		end)
		self._winPanel:setVisible(true)
	else
		anim = cc.MovieClip:create("shibai_fubenjiesuan")

		anim:addCallbackAtFrame(27, function()
			anim:stop()
		end)
		self._losePanel:setVisible(true)
	end

	anim:addTo(self._main:getChildByName("animNode"))
	anim:addCallbackAtFrame(9, function()
		self._wordPanel:fadeIn({
			time = 0.3333333333333333
		})
	end)

	local posX1 = self._teamNum:getPositionX()
	local posY1 = self._teamNum:getPositionY()
	local pos = cc.p(posX1, posY1)

	self._teamNum:setPositionX(posX1 - 30)
	self._teamNum:setOpacity(0)
	anim:addCallbackAtFrame(11, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		self._teamNum:runAction(cc.Spawn:create(fadeIn, moveTo))
	end)

	local node1 = self._main:getChildByFullName("node1")
	local posX2 = node1:getPositionX()
	local posY2 = node1:getPositionY()
	local pos = cc.p(posX2, posY2)

	node1:setPositionX(posX1 - 30)
	node1:setOpacity(0)
	anim:addCallbackAtFrame(13, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		node1:runAction(cc.Spawn:create(fadeIn, moveTo))
	end)

	local node2 = self._main:getChildByFullName("node2")
	local posX2 = node2:getPositionX()
	local posY2 = node2:getPositionY()
	local pos = cc.p(posX2, posY2)

	node2:setPositionX(posX1 - 30)
	node2:setOpacity(0)
	anim:addCallbackAtFrame(15, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		node2:runAction(cc.Spawn:create(fadeIn, moveTo))
	end)

	local posX2 = self._enoughTip:getPositionX()
	local posY2 = self._enoughTip:getPositionY()
	local pos = cc.p(posX2, posY2)

	self._enoughTip:setPositionX(posX1 - 30)
	self._enoughTip:setOpacity(0)
	self._winPanel:setOpacity(0)
	self._losePanel:setOpacity(0)
	anim:addCallbackAtFrame(17, function()
		local fadeIn = cc.FadeIn:create(0.3333333333333333)
		local moveTo = cc.MoveTo:create(0.3333333333333333, pos)

		self._enoughTip:runAction(cc.Spawn:create(fadeIn, moveTo))

		if self._isWin then
			self._winPanel:fadeIn({
				time = 0.2
			})
			self:initWinView()
		else
			self._losePanel:fadeIn({
				time = 0.2
			})
			self:initLoseView()
		end
	end)

	local battleStatist = self._data.report.statist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local mvpPoint = 0
	local model = IconFactory:getRoleModelByKey("HeroBase", teams[currentTeamId]:getHeroes()[1])

	if not playerBattleData.unitSummary then
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

			local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
			local heroMvpText = ""

			if roleId then
				heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
			end

			if heroMvpText then
				self._mvpAudioEffect = "Voice_" .. roleId .. "_" .. 31

				local text = self._wordPanel:getChildByName("text")

				text:setString(Strings:get(heroMvpText))

				local image1 = self._wordPanel:getChildByFullName("image1")
				local image2 = self._wordPanel:getChildByFullName("image2")
				local size = text:getContentSize()

				image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
			end
		end
	end
end

function ExploreBattleFinishMediator:initWinView()
	local rewardNode = self._winPanel:getChildByFullName("rewardNode")

	rewardNode:setScrollBarEnabled(false)
	rewardNode:removeAllItems()

	local i = 0

	local function showReward(rewards)
		if #rewards == 0 then
			return
		end

		local rewardData = table.remove(rewards, 1)

		i = i + 1

		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(78, 88))

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			swallowTouches = true,
			needDelay = true
		})
		icon:addTo(layout):center(layout:getContentSize())
		rewardNode:pushBackCustomItem(layout)
		icon:setScale(1)
		icon:setOpacity(0)

		local scale = cc.ScaleTo:create(0.2, 0.6)
		local fadeIn = cc.FadeIn:create(0.2)
		local spawn = cc.Spawn:create(scale, fadeIn)

		icon:runAction(spawn)
		performWithDelay(self:getView(), function()
			showReward(rewards)
		end, i * 0.05)
	end

	showReward(self._rewards)
end

function ExploreBattleFinishMediator:initLoseView()
	local anim1 = cc.MovieClip:create("anniu_fubenjiesuan")

	anim1:addTo(self._losePanel):posite(142, 66)
	anim1:addEndCallback(function()
		anim1:stop()
	end)

	local text1 = anim1:getChildByName("text")

	self._losePanel:getChildByName("masterBtn"):setPosition(cc.p(0, 0))
	self._losePanel:getChildByName("masterBtn"):changeParent(text1)

	local anim2 = cc.MovieClip:create("anniu_fubenjiesuan")

	anim2:addTo(self._losePanel):posite(290, 66)
	anim2:addEndCallback(function()
		anim2:stop()
	end)

	local text2 = anim2:getChildByName("text")

	self._losePanel:getChildByName("heroBtn"):setPosition(cc.p(0, 0))
	self._losePanel:getChildByName("heroBtn"):changeParent(text2)
end

function ExploreBattleFinishMediator:leaveWithData()
	self:onTouchMaskLayer()
end

function ExploreBattleFinishMediator:onTouchMaskLayer()
	if self._data.callBack then
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)

		if self._data.quickbattle then
			self:close()
		else
			BattleLoader:popBattleView(self)
		end

		self._data.callBack()
	end
end

function ExploreBattleFinishMediator:onClickMaster()
	local view = "MasterMainView"

	BattleLoader:popBattleView(self, {}, view, {})
end

function ExploreBattleFinishMediator:onClickHero()
	local view = "HeroShowListView"

	BattleLoader:popBattleView(self, {}, view, {})
end
