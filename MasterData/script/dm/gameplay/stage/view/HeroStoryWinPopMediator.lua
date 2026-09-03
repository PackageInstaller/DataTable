-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/HeroStoryWinPopMediator.lua

HeroStoryWinPopMediator = class("HeroStoryWinPopMediator", DmPopupViewMediator)

HeroStoryWinPopMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}

function HeroStoryWinPopMediator:initialize()
	super.initialize(self)
end

function HeroStoryWinPopMediator:dispose()
	if self._audioEffectId then
		AudioEngine:getInstance():stopEffect(self._audioEffectId)

		self._audioEffectId = nil
	end

	super.dispose(self)
end

function HeroStoryWinPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroStoryWinPopMediator:enterWithData(data)
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
	self:showExpPanel()
end

function HeroStoryWinPopMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._starPanel = self._main:getChildByFullName("Panel_star")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._wordPanel = self._main:getChildByName("word")
end

function HeroStoryWinPopMediator:showExpPanel()
	local heroId = self._data.MVPHeroId
	local heroBaseInfo = ConfigReader:getRecordById("HeroBase", heroId)
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = roleModel
	})

	mvpSprite:setScale(0.8)

	self._mvpSprite = mvpSprite

	local heroMvpText = heroBaseInfo.MVPText

	self._mvpAudioEffect = "Voice_" .. heroId .. "_" .. 31

	local text = self._wordPanel:getChildByName("text")

	text:setString(Strings:get(heroMvpText))

	local size = text:getContentSize()
	local posX, posY = text:getPosition()
	local img = self._wordPanel:getChildByName("Image_24")

	img:setPosition(cc.p(posX + size.width - 30, posY - size.height - 10))
	self._wordPanel:runAction(cc.FadeIn:create(0.6))

	local anim = cc.MovieClip:create("stageshengli_fubenjiesuan")

	anim:setPlaySpeed(1)

	local bgPanel = self._main:getChildByName("heroAndBgPanel")
	local mvpSpritePanel = anim:getChildByName("roleNode")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(-200, -200))
	anim:addCallbackAtFrame(45, function()
		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())
	anim:gotoAndPlay(1)

	local starPanel = self._starPanel
	local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
	local starCondition = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", self._data.pointId, "StarCondition")

	for i = 1, 3 do
		local star = starPanel:getChildByFullName("star" .. i)
		local labelText = star:getChildByFullName("text")

		labelText:setString(Strings:get(descs[starCondition[i].type], {
			value = starCondition[i].value
		}))
	end

	self:initRewardPanel()
end

function HeroStoryWinPopMediator:initRewardPanel()
	self._rewardPanel:setVisible(true)

	self._rewardList = {}

	local rewardTab = {}

	if self._data.firstPassrewards then
		for k, v in ipairs(self._data.firstPassrewards) do
			rewardTab[#rewardTab + 1] = v
		end
	end

	if self._data.rewards then
		for k, v in ipairs(self._data.rewards) do
			rewardTab[#rewardTab + 1] = v
		end
	end

	for k, v in ipairs(rewardTab) do
		self._rewardList[k] = IconFactory:createRewardIcon(v, {
			isWidget = true
		})

		IconFactory:bindTouchHander(self._rewardList[k], IconTouchHandler:new(self), v, {
			needDelay = true
		})
	end

	for k, v in ipairs(self._rewardList) do
		local size = cc.size(78, 88)
		local layout = ccui.Layout:create()

		layout:setContentSize(size)
		layout:addChild(self._rewardList[k])
		self._rewardList[k]:setPosition(cc.p(60, 74))
		layout:setScale(1)
		layout:setOpacity(0)

		local delay = cc.DelayTime:create(0.1 * k)
		local scale = cc.ScaleTo:create(0.2, 0.6)
		local fadeIn = cc.FadeIn:create(0.2)
		local spawn = cc.Spawn:create(scale, fadeIn)

		layout:runAction(cc.Sequence:create(delay, spawn))
		self._rewardListView:pushBackCustomItem(layout)
	end

	local _star1 = self._starPanel:getChildByFullName("star1")
	local posX1, posY1 = _star1:getPosition()
	local _star2 = self._starPanel:getChildByFullName("star2")
	local posX2, posY2 = _star2:getPosition()
	local _star3 = self._starPanel:getChildByFullName("star3")
	local posX3, posY3 = _star3:getPosition()

	_star1:setPositionX(posX1 + 650)
	_star2:setPositionX(posX2 + 650)
	_star3:setPositionX(posX3 + 650)

	local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX1, posY1)))

	easeBackOutAni:update(1)
	_star1:runAction(easeBackOutAni)

	easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX2, posY2)))

	easeBackOutAni:update(0.8)
	_star2:runAction(easeBackOutAni)

	easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX3, posY3)))

	easeBackOutAni:update(0.6)
	_star3:runAction(easeBackOutAni)
	performWithDelay(self:getView(), function()
		self:setPointStarCondition()
	end, 1)
end

function HeroStoryWinPopMediator:setPointStarCondition()
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

function HeroStoryWinPopMediator:leaveWithData()
	self:onTouchLayout()
end

function HeroStoryWinPopMediator:onTouchLayout(sender, eventType)
	self._stageSystem:setActivityHeroStoryId({
		pointId = self._data.pointId
	})
	BattleLoader:popBattleView(self, {
		viewName = "HeroStoryChapterView"
	})
end
