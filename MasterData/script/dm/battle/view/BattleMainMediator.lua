-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleMainMediator.lua

require("dm.battle.view.BattleCamera")
require("dm.battle.view.BattleGroundLayer")
require("dm.battle.view.BattleScreenEffectLayer")
require("dm.battle.view.widget.BattleWidget")
require("dm.battle.view.widget.BattleCardWidget")
require("dm.battle.view.widget.BattleControllerButtons")
require("dm.battle.view.widget.BattleSkillCardRefreshButton")
require("dm.battle.view.widget.BattlePassiveSkillWidget")
require("dm.battle.view.widget.LeadStagePassiveSkillWidget")
require("dm.battle.view.widget.BattlePassiveSkillTip")
require("dm.battle.view.widget.BattleEnergyBar")
require("dm.battle.view.widget.BattleMasterWidget")
require("dm.battle.view.widget.BattleHeadWidget")
require("dm.battle.view.widget.BattleHeadHpWidget")
require("dm.battle.view.widget.BattleSkillTipWidget")
require("dm.battle.view.widget.BattleHeroTipWidget")
require("dm.battle.view.widget.BattleTimerWidget")
require("dm.battle.view.widget.CardArrayWidget")
require("dm.battle.view.widget.RoundInfoWidget")
require("dm.battle.view.widget.BattleLootWidget")
require("dm.battle.view.widget.BattleWaveWidget")
require("dm.battle.view.widget.BattleChangeWidget")
require("dm.battle.view.widget.BattleDeadCountWidget")
require("dm.battle.view.widget.BattlePvpSpeedUpWidget")
require("dm.battle.view.widget.BattleNoticeEnhanceWidget")
require("dm.battle.view.BattleUnitManager")
require("dm.battle.view.BattleRoleObject")
require("dm.battle.view.BattleRoleModel")
require("dm.battle.view.BattleViewContext")
require("dm.battle.view.interpreter.all")
require("dm.battle.view.BattleRoleSpineHandler")
require("dm.battle.view.BattleShowQueue")
require("dm.gameplay.petRace.view.component.PetRaceBattleHeadWidget")

BattleViewZOrder = {
	ScreeEffect = 4,
	UIEffect = 3,
	guide = 5,
	OpLayer = 2,
	Ground = 0,
	BgEffect = -2,
	Head = -1,
	Dev = 999,
	Background = -3,
	UnderOp = 1
}

function battleUpdateFunction(interval, stepFunc, target)
	local __actime__

	return function(task, dt)
		if __actime__ == nil then
			__actime__ = 0

			return
		end

		local actime = __actime__ + dt
		local frameInterval = interval

		while frameInterval <= actime do
			actime = actime - frameInterval

			stepFunc(target)
		end

		__actime__ = actime
	end
end

BattleMainMediator = class("BattleMainMediator", DmAreaViewMediator, _M)

BattleMainMediator:has("_delegate", {
	is = "r"
})
BattleMainMediator:has("_battleData", {
	is = "r"
})

function BattleMainMediator:initialize()
	super.initialize(self)

	self._customSpinePool = SpineResManager.pushReleasePool(100)
end

function BattleMainMediator:dispose()
	if self._updateTask then
		self._updateTask:stop()

		self._updateTask = nil
	end

	if self._simulatorUpdateTask then
		self._simulatorUpdateTask:stop()

		self._simulatorUpdateTask = nil
	end

	if self._finishTask then
		self._finishTask:stop()

		self._finishTask = nil
	end

	if self._unitPollingTask then
		self._unitPollingTask:stop()

		self._unitPollingTask = nil
	end

	if self._skeletonAnimGroup then
		self._skeletonAnimGroup:release()

		self._skeletonAnimGroup = nil
	end

	if self._unitManager then
		self._unitManager:dispose()

		self._unitManager = nil
	end

	SpineResManager.popReleasePool(self._customSpinePool)
	super.dispose(self)
end

function BattleMainMediator:onRegister()
	super.onRegister(self)

	local view = self:getView()
	local bgEffectLayer = cc.Node:create():addTo(view, BattleViewZOrder.BgEffect)
	local groundLayer = cc.Node:create():addTo(view, BattleViewZOrder.Ground)
	local underOpLayer = cc.Node:create():addTo(view, BattleViewZOrder.UnderOp)
	local uiEffectLayer = cc.Node:create():addTo(view, BattleViewZOrder.UIEffect)
	local screenEffectLayer = cc.Node:create():addTo(view, BattleViewZOrder.ScreeEffect)

	bgEffectLayer:setContentSize(CC_DESIGN_RESOLUTION)

	self._bgEffectLayer = bgEffectLayer
	self._uiEffectLayer = uiEffectLayer
	self.groundLayer = self:autoManageObject(BattleGroundLayer:new(groundLayer))
	self.screenEffectLayer = self:autoManageObject(BattleScreenEffectLayer:new(screenEffectLayer))
	self.underOpLayer = self:autoManageObject(BattleScreenEffectLayer:new(underOpLayer))

	local movieClipGroup = MCGroupManager:getTimelineGroup("BattleMCGroup")

	movieClipGroup:resume()

	self._movieClipGroup = movieClipGroup
	self._skeletonAnimGroup = sp.SkeletonAnimationGroup:create()

	self._skeletonAnimGroup:retain()
	self._skeletonAnimGroup:start()

	local spineHandler = BattleRoleSpineHandler:new()
	local injector = self:getInjector()
	local panelLayer = injector:getInstance("battleUILayer")

	view:addChild(panelLayer, BattleViewZOrder.OpLayer)

	self.battleUIMediator = self:getMediatorMap():retrieveMediator(panelLayer)

	local viewContext = BattleViewContext:new()

	viewContext:setInjector(injector)

	self._viewContext = self:autoManageObject(viewContext)

	viewContext:setValue("BattleMainMediator", self)
	viewContext:setValue("BattleGroundLayer", self.groundLayer)
	viewContext:setValue("SkeletonAnimGroup", self._skeletonAnimGroup)
	viewContext:setValue("SpineHandler", spineHandler)
	viewContext:setValue("BattleScreenEffectLayer", self.screenEffectLayer)
	viewContext:setValue("UnderOpLayer", self.underOpLayer)
	viewContext:setValue("BattleUIMediator", self.battleUIMediator)
	spineHandler:setViewContext(viewContext)
	self.battleUIMediator:setMainMediator(self)
	self.battleUIMediator:setBattleGround(self.groundLayer)
	self.groundLayer:setViewContext(self._viewContext)
	self.battleUIMediator:initWithContext(self._viewContext)
	self.screenEffectLayer:setupViewContext(viewContext)
	self.underOpLayer:setupViewContext(viewContext)
end

function BattleMainMediator:onRemove()
	if self._delegate ~= nil and self._delegate.willLeaveBattle ~= nil then
		self._delegate:willLeaveBattle(self)
	end

	super.onRemove(self)
end

function BattleMainMediator:adjustLayout(targetFrame)
	self:getView():setContentSize(targetFrame)

	targetFrame.width = targetFrame.width - 2 * AdjustUtils.getFixOffsetX()
	self.targetFrame = targetFrame

	self.screenEffectLayer:adjustLayout(targetFrame)
	self.underOpLayer:adjustLayout(targetFrame)
	self.groundLayer:adjustLayout(targetFrame)
	self.battleUIMediator:adjustLayout(targetFrame)
end

function BattleMainMediator:getTargetFrame()
	return self.targetFrame
end

function BattleMainMediator:setBackground(bgId)
	local bgConfig = ConfigReader:getRecordById("BackGroundPicture", bgId)

	if not bgConfig then
		return false
	end

	local align = cc.p(0.5, 0.5)
	local background = ccui.ImageView:create("asset/scene/" .. bgConfig.Picture .. ".jpg")

	if not background then
		return false
	end

	local frame = self:getView():getContentSize()

	background:setAnchorPoint(align)
	background:setName("BattleBackground")
	background:center(CC_DESIGN_RESOLUTION)

	if bgConfig.Flash1 and bgConfig.Flash1 ~= "" then
		local anim = cc.MovieClip:create(bgConfig.Flash1)

		anim:addTo(background):center(background:getContentSize())
		anim:setName("flash")
	end

	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return true
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			-- block empty
		end
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self:getView():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, background)
	self:getView():addChild(background, BattleViewZOrder.Background)

	return true
end

function BattleMainMediator:changeBackground(bgId)
	local bgConfig = ConfigReader:getRecordById("BackGroundPicture", bgId)

	if not bgConfig then
		return false
	end

	local background = self:getBackGround()

	background:loadTexture("asset/scene/" .. bgConfig.Picture .. ".jpg", ccui.TextureResType.localType)
	background:removeChildByName("flash")

	if bgConfig.Flash1 and bgConfig.Flash1 ~= "" then
		local anim = cc.MovieClip:create(bgConfig.Flash1)

		anim:addTo(background):center(background:getContentSize())
		anim:setName("flash")
	end
end

function BattleMainMediator:getBackGround()
	return self:getView():getChildByName("BattleBackground")
end

function BattleMainMediator:setCellState(isVisible)
	for k, v in pairs(self.groundLayer:getLeftGroundCells()) do
		v:getDisplayNode():setVisible(isVisible)
	end

	for k, v in pairs(self.groundLayer:getRightGroundCells()) do
		v:getDisplayNode():setVisible(isVisible)
	end
end

function BattleMainMediator:playGroundEffect(bgRes, align, animName, zoom, actId, extra, blackOpacity)
	local opacity = 160

	if extra and extra.opacity then
		opacity = extra.opacity
	end

	if blackOpacity and blackOpacity ~= "" then
		opacity = blackOpacity
	end

	self._bgEffectLayer:removeAllChildren()

	self._bgEffectLayer.bg = nil
	self._bgEffectLayer.act = actId

	local align = cc.p(align[1] or 0.5, align[2] or 0.5)
	local background

	if bgRes and bgRes ~= "" then
		background = cc.Sprite:create(bgRes)

		if not background then
			return false
		end
	else
		local winSize = cc.Director:getInstance():getVisibleSize()

		background = cc.LayerColor:create(cc.c4b(0, 0, 0, opacity), winSize.width + 1000, winSize.height + 500)
	end

	local frame = self:getView():getContentSize()

	background:setAnchorPoint(align)
	background:setName("BattleBackground")
	background:center(CC_DESIGN_RESOLUTION)
	self._bgEffectLayer:addChild(background)
	background:setOpacity(0)

	self._bgEffectLayer.bg = background

	if animName and animName ~= "" then
		local bgEffect = cc.MovieClip:create(animName, "BattleMCGroup")

		bgEffect:center(CC_DESIGN_RESOLUTION)
		bgEffect:addTo(self._bgEffectLayer)
		bgEffect:setScale(zoom)
		bgEffect:addEndCallback(function(cid, mc)
			mc:stop()

			if not extra or not extra.zorder or extra.zorder <= 0 then
				background:stopAllActions()
				background:runAction(cc.FadeTo:create(0.2, 0))

				self._bgEffectLayer.bg = nil

				mc:removeFromParent(true)
				self._bgEffectLayer:removeAllChildren()
			end
		end)
	end

	local function speceilFunc()
		self._bgEffectLayer.bg.isRetain = extra.duration ~= nil
		extra.duration = extra.duration or 20000

		local actions = cc.Sequence:create(cc.FadeTo:create(0.2, opacity), cc.DelayTime:create(extra.duration / 1000 or 2), cc.CallFunc:create(function()
			local members = self._unitManager:getMembers()

			for k, v in pairs(members) do
				local displayObj = v:getView()

				displayObj:setVisible(true)
			end

			self:setCellState(true)
			background:runAction(cc.Sequence:create(cc.FadeTo:create(0.2, 0), cc.CallFunc:create(function()
				self._bgEffectLayer.bg = nil

				self._bgEffectLayer:removeAllChildren()
			end)))
		end))

		background:runAction(actions)

		local members = self._unitManager:getMembers()

		for k, v in pairs(members) do
			local displayObj = v:getView()

			if extra.unit and extra.zorder > 1 and extra.unit:getId() ~= v:getId() then
				displayObj:setVisible(false)
			end
		end

		self:setCellState(false)

		if extra.Music and extra.Music ~= "" then
			AudioEngine:getInstance():playEffect(extra.Music)
		end
	end

	if extra and extra.zorder and extra.zorder > 0 then
		speceilFunc()
	else
		background:runAction(cc.FadeTo:create(0.2, opacity))
	end
end

function BattleMainMediator:clearGroundEffect(actId)
	if self._bgEffectLayer.act == actId and not clearGroundEffect then
		if self._bgEffectLayer.bg and not self._bgEffectLayer.bg.isRetain then
			self._bgEffectLayer.bg:runAction(cc.Sequence:create(cc.FadeTo:create(0.2, 0), cc.CallFunc:create(function()
				self._bgEffectLayer.bg = nil

				self._bgEffectLayer:removeAllChildren()
				self:setCellState(true)
			end)))
		elseif self._bgEffectLayer.bg and not self._bgEffectLayer.bg.isRetain then
			self._bgEffectLayer:removeAllChildren()
			self:setCellState(true)
		else
			self:setCellState(true)
		end
	end
end

function BattleMainMediator:playBGM(music)
	if music == nil or self._bgm == music then
		return
	end

	self._bgm = music

	if string.sub(music, 1, 6) == "Action" then
		AudioEngine:getInstance():playAction(music, true)
	else
		AudioEngine:getInstance():playBackgroundMusic(music)
	end
end

function BattleMainMediator:playDieEffect(sound)
	AudioEngine:getInstance():playEffect(sound)
end

function BattleMainMediator:getViewConfig()
	return self._battleData and self._battleData.viewConfig
end

function BattleMainMediator:getBattleConfig()
	return self._battleData and self._battleData.battleConfig
end

function BattleMainMediator:enterWithData(data)
	self._battleData = data

	local logicInfo = data.logicInfo
	local viewConfig = data.viewConfig
	local bgRes = viewConfig.background

	self:setBackground(bgRes)

	if viewConfig.bgm then
		local bgm = ConfigReader:getDataByNameIdAndKey("Sound", viewConfig.bgm[1], "Id")

		self:playBGM(viewConfig.bgm)

		self._bgm = viewConfig.bgm
		self._delegate = data.delegate

		assert(self._delegate ~= nil)

		local view = self:getView()
		local injector = self:getInjector()
		local targetFrame = self.targetFrame

		self._camera = BattleCamera:new(targetFrame.width, targetFrame.height)

		self._camera:workOnNodes({
			self.groundLayer:getView(),
			self:getBackGround(),
			self._bgEffectLayer
		})

		local viewContext = self._viewContext
		local battleGuide = logicInfo.battleGuide

		if battleGuide and battleGuide.setViewContext then
			battleGuide:setViewContext(viewContext)
		end

		viewContext:setValue("Camera", self._camera)
		viewContext:setValue("IsReplayMode", data.isReplay)
		viewContext:setValue("ShowHpMode", viewConfig.hpShow or BattleHp_ShowType.Show)
		viewContext:setValue("ShowSkillEffect", viewConfig.effectShow or BattleEffect_ShowType.All)
		viewContext:setValue("bulletTimeEnabled", viewConfig.bulletTimeEnabled or false)
		viewContext:setValue("battleSuppress", viewConfig.battleSuppress or {})
		viewContext:setValue("unlockMasterSkill", viewConfig.unlockMasterSkill)

		local battleShowQueue = BattleShowQueue:new()

		battleShowQueue:setViewContext(viewContext)
		viewContext:setValue("BattleShowQueue", battleShowQueue)

		if self._battleData.battleData then
			battleShowQueue:addMasterShow(self._battleData.battleData.playerData, self._battleData.battleData.enemyData)
		end

		if self._battleData.battleData then
			battleShowQueue:addBattleItemShow(self._battleData.battleData.playerData, self.battleUIMediator)
		end

		if self._delegate.onBattleStart then
			self._delegate:onBattleStart(self, viewContext:getEventDispatcher())
		end

		local timelines

		self._battleDirector = logicInfo.director

		assert(self._battleDirector ~= nil)

		self._unitManager = BattleUnitManager:new()

		viewContext:setValue("BattleUnitManager", self._unitManager)
		viewContext:setValue("MainPlayerId", logicInfo.mainPlayerId)

		if not logicInfo.teams then
			for _, teamInfo in ipairs(logicInfo.teams) do
				local ais = teamInfo.ais
				local playerController = self._battleDirector:createPlayerController()

				playerController:bindPlayers(teamInfo.players)

				if ais then
					for _, ai in ipairs(ais) do
						ai:setController(playerController)
					end
				end

				for index, player in ipairs(teamInfo.players) do
					if player == logicInfo.mainPlayerId[1] then
						viewContext:setValue("MainPlayerAI", ais and ais[index])
						viewContext:setValue("MainPlayerController", playerController)
					elseif ais and ais[index] then
						local test = ais[index]:setIgnoreWaiting(false)
					end
				end
			end

			self:setMainPlayerIsAuto(false)
			self.groundLayer:enterWithData(viewConfig)
			self.battleUIMediator:setupViewConfig(viewConfig, data.isReplay)

			if self.battleUIMediator.setBattleType then
				self.battleUIMediator:setBattleType(self._battleData.battleType)
			end

			local tlInterpFactory = self:createTLInterpFactory()
			local battleInterpreter = logicInfo.interpreter

			battleInterpreter:setTLInterpFactory(tlInterpFactory)
			battleInterpreter:setEndCallback(function()
				print("didFinishBattle")
				self:didFinishBattle()
			end)
			self._battleDirector:start()
			self:startMainLoop()

			if GameConfigs.openDevWin and not GameConfigs.debugHeroId then
				self:setupDevMode()
			end

			self.mapEventListener(self, self:getEventDispatcher(), "DEBUG_EVT_SAVE_BATTLE_DUMP", self, self.saveBattleDump)
			self.mapEventListener(self, self:getEventDispatcher(), "DEBUG_EVT_UPLOAD_ERROR_BATTLE_DUMP", self, self.uploadErrorBattleDumpByEvent)
			self.mapEventListener(self, self:getEventDispatcher(), "DEBUG_EVT_CHANGE_BATTLE_SPEED", self, self.debugChangeSpeed)
			self.mapEventListener(self, self:getEventDispatcher(), EVT_CHECK_IS_BATTLE_VIEW, self, function(_, event)
				local callback = event:getData()

				if type(callback) == "function" then
					callback(true)
				end
			end)
			self.mapEventListener(self, self:getEventDispatcher(), EVT_ENTER_BACKGROUND, self, function()
				local storyDirector = self:getInjector():getInstance(story.StoryDirector)
				local guideAgent = storyDirector:getGuideAgent()

				if not guideAgent:isGuiding() then
					local viewCfg = self._battleData.viewConfig

					if viewCfg.btnsShow then
						if not viewCfg.btnsShow.pause.visible then
							local isPauseVisible = false

							if isPauseVisible and not self._isPaused then
								self:onPause()
							end
						end
					end
				end
			end)
			self:getInjector():mapValue("Debug_BattleDump", nil)

			local battleSimulator = self._battleDirector:getBattleSimulator()

			if battleSimulator then
				local battleContext = battleSimulator:getBattleContext()

				self._unitManager:setBattleContext(battleContext)
			end

			local director = cc.Director:getInstance()

			director:setAnimationInterval(0.016666666666666666)
		end
	end
end

function BattleMainMediator:leaveWithData()
	self:onPause()
end

function BattleMainMediator:willStartEnterTransition(transition)
	self.battleUIMediator:willStartEnterTransition()
end

function BattleMainMediator:createTLInterpFactory()
	local tlInterpFactory = {
		_classMappings = {
			BattleMainLine = MainTLInterpreter,
			BattleGuideLine = GuideTLInterpreter,
			BattlePlayer = PlayerTLInterpreter,
			BattleUnit = UnitTLInterpreter,
			BattleField = BFieldTLInterpreter
		}
	}
	local outSelf = self

	function tlInterpFactory:createTLInterpreter(typeName)
		local tlclazz = self._classMappings[typeName]

		if tlclazz ~= nil then
			return tlclazz:new(outSelf._viewContext)
		else
			print("no interpreter for", typeName)
		end
	end

	return tlInterpFactory
end

function BattleMainMediator:getSkeletonAnimGroup()
	return self._skeletonAnimGroup
end

function BattleMainMediator:setTimeFactor(timeFactor)
	local timeScale = self._viewContext:getTimeScale()
	local bulletTime = self._viewContext:getValue("bulletTimeEnabled") and self._viewContext:getBulletTimeFactor() or 1

	self._viewContext:setTimeFactor(timeFactor)
	self._movieClipGroup:setSpeed((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))
	self._skeletonAnimGroup:setSpeedFactor((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))
end

function BattleMainMediator:setTimeScale(timeScale)
	local timeFactor = self._viewContext:getTimeFactor()
	local bulletTime = self._viewContext:getValue("bulletTimeEnabled") and self._viewContext:getBulletTimeFactor() or 1

	self._viewContext:setTimeScale(timeScale)
	self._movieClipGroup:setSpeed((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))
	self._skeletonAnimGroup:setSpeedFactor((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))

	if self._delegate.onTimeScaleChanged then
		self._delegate:onTimeScaleChanged(timeScale)
	end
end

function BattleMainMediator:resetTimeScaleAndTimeFactor()
	local timeFactor = self._viewContext:getTimeFactor()

	self._viewContext:setTimeScale(1)
	self._viewContext:setTimeFactor(1)
	self._viewContext:setBulletTimeFactor(1)
	self._movieClipGroup:setSpeed(1)
	self._skeletonAnimGroup:setSpeedFactor(1)
end

function BattleMainMediator:setBulletTime(bulletTime)
	if not self._viewContext:getValue("bulletTimeEnabled") then
		return
	end

	local timeScale = self._viewContext:getTimeScale()
	local timeFactor = self._viewContext:getTimeFactor()

	self._viewContext:setBulletTimeFactor(bulletTime)
	self._movieClipGroup:setSpeed((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))
	self._skeletonAnimGroup:setSpeedFactor((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime))
end

function BattleMainMediator:showHero(heroBaseId)
	if self._pauseBlock then
		return
	end

	local function pauseFunc()
		self:pause()
	end

	local function resumeCallback()
		self:onResume()

		local battleShowQueue = self._viewContext:getValue("BattleShowQueue")

		if battleShowQueue then
			battleShowQueue:show()
		end
	end

	if self._delegate.showHero then
		self._delegate:showHero(heroBaseId, pauseFunc, resumeCallback)
	else
		resumeCallback()
	end
end

function BattleMainMediator:showMaster(friend, enemy)
	if self._pauseBlock then
		return
	end

	local function pauseFunc()
		return
	end

	local function resumeCallback()
		self:onResume()

		local battleShowQueue = self._viewContext:getValue("BattleShowQueue")

		if battleShowQueue then
			battleShowQueue:show()
		end
	end

	if self._delegate.showMaster then
		self._delegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
	else
		resumeCallback()
	end
end

function BattleMainMediator:showBattleItem(paseSta)
	if self._pauseBlock then
		return
	end

	local function resumeCallback()
		if paseSta then
			self:onResume()
		end

		local battleShowQueue = self._viewContext:getValue("BattleShowQueue")

		if battleShowQueue then
			battleShowQueue:show()
		end
	end

	if self._delegate.showBattleItem then
		self._delegate:showBattleItem(pauseFunc, resumeCallback, paseSta)
	end
end

function BattleMainMediator:showBossCome(paseSta)
	if self._pauseBlock then
		return
	end

	local function pauseFunc()
		if paseSta then
			self:pause()
		end
	end

	local function resumeCallback()
		if paseSta then
			self:onResume()
		end

		local battleShowQueue = self._viewContext:getValue("BattleShowQueue")

		if battleShowQueue then
			battleShowQueue:show()
		end
	end

	if self._delegate.showBossCome then
		self._delegate:showBossCome(pauseFunc, resumeCallback, paseSta)
	end
end

function BattleMainMediator:pause(block)
	if self._pauseBlock then
		return
	end

	local scheduler = self._viewContext:getScheduler()

	scheduler:pause()
	self._battleDirector:pause()
	self._movieClipGroup:pause()
	self._skeletonAnimGroup:pause()

	self._pauseBlock = block
	self._isPaused = true
end

function BattleMainMediator:resume()
	local scheduler = self._viewContext:getScheduler()

	scheduler:resume()
	self._battleDirector:resume()
	self._movieClipGroup:resume()
	self._skeletonAnimGroup:resume()

	self._pauseBlock = nil
	self._isPaused = false
end

function BattleMainMediator:onPause()
	if self._pauseBlock then
		return
	end

	self:pause()

	local function continueCallback(hpShow, effectShow)
		if hpShow and self._viewContext:getValue("ShowHpMode") ~= hpShow then
			self._viewContext:setValue("ShowHpMode", hpShow)

			local members = self._unitManager:getMembers()

			if members then
				for k, v in pairs(members) do
					v:refreshHpBySetting()
				end
			end
		end

		if effectShow and self._viewContext:getValue("ShowSkillEffect") ~= effectShow then
			self._viewContext:setValue("ShowSkillEffect", effectShow)
		end

		self:onResume()
	end

	local function leaveCallback(isFinish)
		self:tryLeaving(isFinish)
	end

	if self._delegate.onPauseBattle then
		self._delegate:onPauseBattle(continueCallback, leaveCallback)
	end
end

function BattleMainMediator:onRestraint()
	if self._pauseBlock then
		return
	end

	local function continueCallback()
		if self._viewContext:getValue("bulletTimeEnabled") then
			self:onResume()
		end
	end

	if self._delegate.onShowRestraint then
		if self._viewContext:getValue("bulletTimeEnabled") then
			self:pause()
		end

		self._delegate:onShowRestraint(continueCallback)
	end
end

function BattleMainMediator:setMainPlayerIsAuto(isAuto)
	if isAuto == nil then
		return false
	end

	local mainPlayerAI = self._viewContext:getValue("MainPlayerAI")

	if not mainPlayerAI then
		return false
	end

	self._viewContext:setValue("IsAutoMode", isAuto)
	mainPlayerAI:setIsEnabled(isAuto)

	return true
end

function BattleMainMediator:changeMainPlayerAi()
	local mainPlayerAI = self._viewContext:getValue("MainPlayerAI")

	if not mainPlayerAI then
		return false
	end

	if mainPlayerAI.changeAi then
		mainPlayerAI:changeAi()
	end
end

function BattleMainMediator:onResume()
	self:resume()
end

function BattleMainMediator:onSkip()
	local context = self._viewContext

	if not context then
		return
	end

	local isReplay = context:getValue("IsReplayMode")

	if isReplay then
		self:stopScheduler()
		self._delegate:onSkipBattle(self)

		return
	end

	if self._resultData then
		return
	end

	local simulator = self._battleDirector:getBattleSimulator()

	if simulator and self:setMainPlayerIsAuto(true) then
		local frameInterval = self._battleDirector:getFrameInterval()

		while true do
			local result = simulator:tick(frameInterval)

			if result then
				break
			end
		end

		self:stopMainLoop()

		self._resultData = simulator:getBattleResult()

		self:saveBattleRecord()

		local isTeamAView = self._viewContext:getValue("IsTeamAView")

		if isTeamAView then
			if not self._resultData then
				local battleResult = self._resultData * -1

				self:playRoleWinAnim(battleResult)

				return
			end
		end
	end
end

function BattleMainMediator:onAMChanged(isAuto)
	self:flushTouchEnable()

	if self._delegate and self._delegate.onAMStateChanged then
		self._delegate:onAMStateChanged(self, isAuto)
	end
end

function BattleMainMediator:flushTouchEnable()
	local context = self._viewContext

	if not context then
		return
	end

	local isAuto = context:getValue("IsAutoMode")
	local isReplay = context:getValue("IsReplayMode")
	local touchEnable = not isReplay and not isAuto

	self.battleUIMediator:setTouchEnabled(touchEnable)
end

function BattleMainMediator:tryLeaving(isFinish)
	self._delegate:tryLeaving(function(leave)
		if leave then
			if isFinish then
				self:sendMessage("leave", {}, function(isOk, _)
					if isOk then
						self:tick(0.1)
						self:stopScheduler()
						self._delegate:onLeavingBattle()
					end
				end)
				self:onResume()
			else
				self:stopScheduler()
				self._delegate:onLeavingBattle()
			end
		else
			self:onResume()
		end
	end)
end

function BattleMainMediator:stopScheduler()
	local scheduler = self._viewContext:getScheduler()

	scheduler:stop()
	self:stopMainLoop()
	self._skeletonAnimGroup:stop()

	local director = cc.Director:getInstance()

	director:setAnimationInterval(1 / (GAME_MAX_FPS or 60))
end

function BattleMainMediator:sendMessage(msg, args, callback)
	local mainPlayerController = self._viewContext:getValue("MainPlayerController")

	assert(mainPlayerController ~= nil)

	local playerId = self._viewContext:getValue("CurMainPlayer")

	if not playerId then
		return
	end

	return mainPlayerController:sendOpCommandByPlayer(playerId, msg, args, function(isOk, reason)
		if not isOk and reason then
			local tipStr = Strings:get("Btips_" .. reason)
		end

		if callback then
			callback(isOk, reason)
		end
	end)
end

function BattleMainMediator:showFinalHitAnim(unit)
	local finalHitShow = self._battleData.viewConfig.finalHitShow

	unit:setRelPosition(unit:getHomePlace())
	self:releaseGuideLayer()

	if finalHitShow then
		self.battleUIMediator:fade()
		self:resetTimeScaleAndTimeFactor()

		local targetPos = self.groundLayer:convertRelPos2WorldSpace(unit:getHomePlace())
		local camera = self._viewContext:getValue("Camera")

		self._viewContext:setValue("CameraActId", "finalHit")

		local zhongjietexiao = cc.MovieClip:create("bao_zhongjietexiao")

		zhongjietexiao:setAnchorPoint(cc.p(0.5, 0.5))
		zhongjietexiao:addTo(unit:getView())
		zhongjietexiao:setPosition(cc.p(0, unit:getModelHeight() / 2))

		local addSpeedNum = -0.01
		local timeScale = 0.2

		camera:focusOn(targetPos.x, targetPos.y, 1.4, 0.05)
		self:setTimeFactor(timeScale)
		zhongjietexiao:addCallbackAtFrame(50, function()
			addSpeedNum = 0 - addSpeedNum

			camera:focusOn(display.cx, display.cy, 1, 0.2)
		end)

		local action = schedule(zhongjietexiao, function()
			timeScale = timeScale + addSpeedNum

			if timeScale > 1 then
				timeScale = 1
			end

			if timeScale < 0.05 then
				timeScale = 0.05
			end

			self:setTimeFactor(timeScale)
		end, 0)

		zhongjietexiao:addEndCallback(function()
			zhongjietexiao:stop()
			zhongjietexiao:removeFromParent(true)
			self:resetTimeScaleAndTimeFactor()
		end)

		return true
	end
end

function BattleMainMediator:showFinalDieAnim(unit)
	local finalHitShow = self._battleData.viewConfig.finalHitShow

	if finalHitShow then
		self:resetTimeScaleAndTimeFactor()

		local zhongjietexiao = cc.MovieClip:create("die_zhongjietexiao")

		zhongjietexiao:setAnchorPoint(cc.p(0.5, 0.5))
		zhongjietexiao:addTo(unit:getView())
		zhongjietexiao:setPosition(cc.p(0, unit:getModelHeight() / 2))
		zhongjietexiao:addEndCallback(function()
			if checkDependInstance(unit) then
				unit:finalHitDie()
				AudioEngine:getInstance():playEffect("Se_Effect_Die")
			end

			zhongjietexiao:stop()
			zhongjietexiao:removeFromParent(true)
		end)
		unit:finalHitLock()

		return true
	end

	return false
end

function BattleMainMediator:showFinalTaskFinish(unit)
	local finalTaskFinishShow = self._battleData.viewConfig.finalTaskFinishShow

	if finalTaskFinishShow then
		self:resetTimeScaleAndTimeFactor()
		AudioEngine:getInstance():playEffect("Se_Alert_Battle_Start", false)
		performWithDelay(self:getView(), function()
			local mc = cc.MovieClip:create("dhb_tongguan")

			mc:addTo(self:getView(), 999):center(CC_DESIGN_RESOLUTION)
			mc:gotoAndPlay(1)
			mc:addEndCallback(function(cid, mc)
				mc:stop()
				mc:removeFromParent(true)
			end)
		end, 0.7)

		return true
	end

	return false
end

function BattleMainMediator:didFinishBattle()
	self:saveIsAuto()
end

function BattleMainMediator:battleFinished(result)
	self:checkFinishState(result)
end

function BattleMainMediator:battleTimeup(result)
	self:checkFinishState(result)
end

function BattleMainMediator:checkFinishState(result)
	if self._unitPollingTask then
		return
	end

	self.battleUIMediator:hideHeroTip()
	self.battleUIMediator:stopBulletTime()
	self.battleUIMediator:setTouchEnabled(false)
	self.groundLayer:setTouchEnabled(false)
	self.battleUIMediator:disableCtrlButton()
	self:saveBattleRecord()

	local isTeamAView = self._viewContext:getValue("IsTeamAView")
	local battleResult = isTeamAView and result or result * -1

	self._resultData = result

	local maxDelay = 5
	local cumu = 0

	local function tick(task, dt)
		cumu = cumu + dt

		local canExit = true

		if cumu < maxDelay then
			local members = self._unitManager:getMembers()

			for _, unit in pairs(members) do
				if unit then
					canExit = unit:isIdleState()
				end

				if not canExit then
					break
				end
			end
		end

		if canExit then
			self._unitPollingTask:stop()

			self._unitPollingTask = nil

			self:playRoleWinAnim(battleResult)
		end
	end

	local scheduler = self._viewContext:getScheduler()

	self._unitPollingTask = scheduler:schedule(tick, 0, true)
end

function BattleMainMediator:playRoleWinAnim(result)
	if self._finishTask then
		return
	end

	local members = self._unitManager:getMembers()

	for _, unit in pairs(members) do
		unit:playWinOrLoseAnim(result)
	end

	local function tick(dt)
		self:stopScheduler()
		self._finishTask:stop()

		self._finishTask = nil

		self:battleWinOrLose(result)
	end

	local scheduler = self._viewContext:getScheduler()
	local waitTime = self:getViewConfig().finishWaitTime or 0.5

	self._finishTask = scheduler:schedule(tick, waitTime, false)
end

function BattleMainMediator:battleWinOrLose(result)
	self._delegate:onBattleFinish(result)
end

function BattleMainMediator:saveIsAuto()
	local viewConfig = self._battleData.viewConfig

	if viewConfig.battleSettingType then
		local battleSimulator = self._battleDirector:getBattleSimulator()

		if battleSimulator ~= nil then
			local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(viewConfig.battleSettingType)
			local unlock, tips = self:getInjector():getInstance("SystemKeeper"):isUnlock("AutoFight")
			local battleContext = battleSimulator:getBattleContext()

			if battleContext then
				battleContext:writeVar("battleIsAuto", {
					playerId = self._viewContext:getValue("MainPlayerId"),
					isAuto = (not unlock or nil) and false
				})
			end
		end
	end
end

function BattleMainMediator:startMainLoop()
	self._updateTask = self._viewContext:scalableSchedule(function(task, dt)
		self:tick(dt)
	end)
end

function BattleMainMediator:stopMainLoop()
	if self._updateTask then
		self._updateTask:stop()

		self._updateTask = nil
	end
end

function BattleMainMediator:tick(interval)
	if self._interpreterFinished ~= true then
		self._battleDirector:update(interval * 1000)

		if self.header then
			self:updateCountdown(interval)
		end
	end

	if self._camera then
		self._camera:update(interval)
	end
end

function BattleMainMediator:setupDevMode()
	local winBtn = ccui.Button:create()
	local winBtn = ccui.Text:create("PASS", TTF_FONT_FZYH_M, 40)

	winBtn:setTouchEnabled(true)
	winBtn:addClickEventListener(function()
		self:stopScheduler()
		self._delegate:onDevWin(self)
	end)

	local director = cc.Director:getInstance()
	local size = director:getVisibleSize()

	winBtn:setAnchorPoint(cc.p(1, 0.5))
	winBtn:setPosition(cc.p(size.width - 140, size.height * 0.2))
	winBtn:setScale(1.5)
	self:getView():addChild(winBtn, BattleViewZOrder.Dev)
end

function BattleMainMediator:saveBattleRecord()
	local battleInterpreter = self._battleDirector:getBattleInterpreter()
	local recordsProvider = battleInterpreter:getRecordsProvider()

	if recordsProvider and recordsProvider.dumpRecords ~= nil then
		local battleRecords = recordsProvider:dumpRecords()

		battleRecords.mainPlayerId = self._viewContext:getValue("MainPlayerId")

		self:getInjector():mapValue("Debug_BattleRecords", battleRecords)
		BattleLogger:info("battlerecord", "timelines:{}", battleRecords)
	end

	local result, battleDump = self:getBattleDump()

	if result then
		self:getInjector():mapValue("Debug_BattleDump", battleDump)
	end
end

function BattleMainMediator:getBattleDump()
	local simulator = self._battleDirector:getBattleSimulator()

	if simulator == nil then
		return false, "NoSimulator"
	else
		local var_93_0 = {
			battleType = self._battleData.battleType,
			battleData = self._battleData.battleData,
			battleConfig = self._battleData.battleConfig,
			viewConfig = self._battleData.viewConfig
		}

		var_93_0.opData = simulator:getInputManager():dumpInputHistory()
		var_93_0.mainPlayerId = self._viewContext:getValue("MainPlayerId")

		local battleDump = var_93_0
		local battleInterpreter = self._battleDirector:getBattleInterpreter()
		local recordsProvider = battleInterpreter:getRecordsProvider()

		if recordsProvider and recordsProvider.dumpRecords ~= nil then
			local battleRecords = recordsProvider:dumpRecords()

			battleRecords.mainPlayerId = self._viewContext:getValue("MainPlayerId")
			battleDump.records = battleRecords
		end

		return true, battleDump
	end
end

function BattleMainMediator:saveBattleDump(event)
	local callback = event:getData()
	local context = self._viewContext

	if not context then
		return
	end

	local isReplay = context:getValue("IsReplayMode")

	if isReplay then
		callback(false, "ReplayMode")
	else
		local result, battleDump = self:getBattleDump()

		callback(result, battleDump)
	end
end

function BattleMainMediator:uploadErrorBattleDumpByEvent(event)
	local info = event:getData()

	self:uploadErrorBattleDump(info)
end

function BattleMainMediator:uploadErrorBattleDump(info)
	local context = self._viewContext

	if not context then
		return
	end

	local isReplay = context:getValue("IsReplayMode")

	if not isReplay then
		local result, battleDump = self:getBattleDump()

		if result then
			StatisticSystem:uploadBattleDump(LogType.kBError, {
				info = info,
				battleDump = battleDump
			})
		end
	end
end

function BattleMainMediator:debugChangeSpeed(event)
	local speed = event:getData()

	self:setTimeScale(speed)
end

function BattleMainMediator:addEffectAnim(anim, pos, zOrder, loop, flipx, flipy)
	local zOrders = {
		Ground = 0,
		UnderUI = BattleViewZOrder.OpLayer,
		TopLayer = BattleViewZOrder.ScreeEffect
	}
	local movieClip = cc.MovieClip:create(anim, "BattleMCGroup")

	movieClip:setScaleX(flipx and -1 or 1)
	movieClip:setScaleY(flipy and -1 or 1)

	local worldPos = self:getView():convertToWorldSpace(cc.p(0, 0))

	movieClip:setPosition(cc.p(pos.x - worldPos.x, pos.y - worldPos.y))
	movieClip:addTo(self:getView(), zOrders[zOrder])
	movieClip:addEndCallback(function(cid, mc)
		loop = (loop or 1) - 1

		if loop == 0 then
			mc:stop()
			mc:removeFromParent(true)
		end
	end)

	if zOrder == "Ground" then
		local parent = self.groundLayer:getContentLayer()
		local worldPos = parent:convertToWorldSpace(cc.p(0, 0))

		movieClip:setPosition(cc.p(pos.x - worldPos.x, pos.y - worldPos.y))
		movieClip:changeParent(parent)
	end
end

function BattleMainMediator:setGuideLayerVisible(sta)
	if self._guideLayer then
		self._guideLayer:setVisible(sta)
	end
end

function BattleMainMediator:releaseGuideLayer()
	if self._guideLayer then
		self._guideLayer:removeFromParent()

		self._guideLayer = nil
	end
end

function BattleMainMediator:retainGuideLayer(_view)
	self:releaseGuideLayer()

	self._guideLayer = _view

	_view:addTo(self:getView():getParent())
end
