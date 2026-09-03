-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeWinMediator.lua

StagePracticeWinMediator = class("StagePracticeWinMediator", DmPopupViewMediator, _M)

StagePracticeWinMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePracticeWinMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeWinMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
StagePracticeWinMediator:has("_stagePracticeMeditor", {
	is = "r"
}):injectWith("StagePracticeMediator")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}

function StagePracticeWinMediator:initialize()
	super.initialize(self)
end

function StagePracticeWinMediator:dispose()
	super.dispose(self)
end

function StagePracticeWinMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._player = self._developSystem:getPlayer()
end

function StagePracticeWinMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._data = data
	self._mapId = self._data.mapId
	self._pointId = self._data.pointId

	local config = ConfigReader:getRecordById("StagePracticePoint", tostring(self._pointId))

	config = config or ConfigReader:getRecordById("BlockPracticePoint", tostring(self._pointId))
	self._pointName = Strings:get(config.Name)
	self._time = data.time
	self._winWorld = config.WinWord or ""
	self._canTouch = false

	self:setupView()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("enter_StagePracticeFightMediator")
end

function StagePracticeWinMediator:showWinAni()
	local anim = cc.MovieClip:create("shenglixunlianben_zhandoujiesuan")
	local mvpSpritePanel = anim:getChildByName("heroSprites")
	local battleStatist = self._data.statist
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist.players[player:getRid()]
	local team = developSystem:getTeamByType(StageTeamType.PRACTICE)
	local mvpPoint = 0
	local model

	for k, v in pairs(playerBattleData.unitSummary) do
		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Model")

		if roleId then
			local checkIsHero = ConfigReader:getRecordById("HeroBase", roleId)

			if checkIsHero then
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

	model = IconFactory:getSpMvpBattleEndMid(model)
	self._mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")
	local heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")

	if heroMvpText then
		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 18, posY - size.height))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
		self._wordPanel:setLocalZOrder(12)
	end

	local titleText = anim:getChildByName("titleTexts")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(-360, -200))
	anim:addCallbackAtFrame(19, function()
		self._title:changeParent(titleText)
		self._title:setLocalZOrder(-1)
		self._title:setPosition(cc.p(0, 0))
	end)
	anim:addCallbackAtFrame(45, function()
		self:showText(true)
		anim:stop()
		self._mTouchLayer:setTouchEnabled(true)
	end)
	anim:addTo(self._aniPanel):center(self._aniPanel:getContentSize())
end

function StagePracticeWinMediator:showText(show)
	self._pN:setVisible(show)
	self._tN:setVisible(show)
	self._pointNameNode:setVisible(show)
	self._pointTimeNode:setVisible(show)
end

function StagePracticeWinMediator:setupView()
	self._pN = self:getView():getChildByFullName("mainpanel.pointname_0")
	self._tN = self:getView():getChildByFullName("mainpanel.pointname_0_0")
	self._pointNameNode = self:getView():getChildByFullName("mainpanel.pointname")
	self._pointTimeNode = self:getView():getChildByFullName("mainpanel.pointtime")
	self._rewardNode = self:getView():getChildByFullName("mainpanel.reward")
	self._title = self:getView():getChildByFullName("mainpanel.title")
	self._backimg = self:getView():getChildByFullName("mainpanel.backimg2")
	self._mTouchLayer = self:getView():getChildByFullName("mTouchLayout")
	self._wordPanel = self:getView():getChildByFullName("mainpanel.word")

	AdjustUtils.ignorSafeAreaRectForNode(self._backimg, AdjustUtils.kAdjustType.Right)
	self._pointNameNode:setString(self._pointName)
	self._pointTimeNode:setString(self._time / 1000 .. Strings:get("TimeUtil_Sec"))

	local conditions = self._data.starCondition
	local condCount = 0

	if conditions then
		condCount = #conditions
	end

	self:showText(false)

	self._mainPanel = self:getView():getChildByName("mainpanel")
	self._aniPanel = self:getView():getChildByFullName("mainpanel.anipanel")

	self._mainPanel:setTouchEnabled(false)
	self._mainPanel:setLocalZOrder(10)
	self._mTouchLayer:setLocalZOrder(11)
	self._mTouchLayer:setTouchEnabled(false)
	self:showWinAni()

	local rewards = {}

	if self._data.stagePassReward then
		local winRewards = self._data.stagePassReward

		for i = 1, #winRewards do
			local data = winRewards[i]

			data.viewType = "stagePassReward"
			rewards[#rewards + 1] = data
		end
	end

	if self._data.stageStarReward then
		local starRewards = self._data.stageStarReward

		for i = 1, #starRewards do
			local data = starRewards[i]

			data.viewType = "stageStarReward"
			rewards[#rewards + 1] = data
		end
	end

	local rewardCount = 0

	for i, value in pairs(rewards) do
		rewardCount = rewardCount + 1
	end

	local conditionDes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_StarConditionDesc", "content")
	local totalStars = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StagePractice_PointMaxStars", "content")

	if self._mapId and self._stagePracticeSystem:getPointById(self._mapId, self._pointId)._firstPassState == 1 then
		-- block empty
	else
		self._rewardNode:setVisible(false)
	end
end

function StagePracticeWinMediator:switchMainScene()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, {
		viewName = "StagePracticeView",
		isBackEntrance = true,
		mapId = self._data.mapId,
		pointId = self._data.pointId
	}))
end

function StagePracticeWinMediator:onTouchMaskLayer(sender, eventType)
	if not self._canTouch then
		return
	end

	self:switchMainScene()
end

function StagePracticeWinMediator:showReward(pointid)
	local rewards = self._stagePracticeSystem:getPointRewardConfig(pointid)
	local rewardAnim = cc.MovieClip:create("zhanlipinxunlianben_zhandoujiesuan")

	for k, v in pairs(rewards) do
		local nodep = self._rewardNode:getChildByFullName("reward_" .. k)

		nodep:removeAllChildren()

		local info = {
			code = v.code,
			amount = v.amount,
			type = v.type
		}
		local reward = IconFactory:createRewardIcon(info, {
			showAmount = true,
			isWidget = true
		})

		IconFactory:bindTouchHander(reward, IconTouchHandler:new(self), v, {
			needDelay = true
		})
		nodep:setVisible(true)
		nodep:addChild(reward)
		nodep:setScale(0.6)

		local rewardCellAnim = cc.MovieClip:create("zhanlipintubiao_zhandoujiesuan")
	end
end

function StagePracticeWinMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:switchMainScene()
	end
end

function StagePracticeWinMediator:leaveWithData()
	self:onTouchLayout(nil, ccui.TouchEventType.ended)
end

function StagePracticeWinMediator:onTouchLayout(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local stageSystem = self._stageSystem
		local rewards = self._data.rewards
		local data = {}

		data.pointId = self._data.pointId
		data.chapterId = self._data.mapId
		data.isInit = false

		if self._data.mapId then
			BattleLoader:popBattleView(self, {
				viewName = "StagePracticeMainView",
				userdata = data
			})
		else
			BattleLoader:popBattleView(self, {
				viewName = "CommonStageChapterView"
			})
		end

		if rewards and #rewards > 0 then
			local view = stageSystem:getInjector():getInstance("getRewardView")

			stageSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end
	end
end
