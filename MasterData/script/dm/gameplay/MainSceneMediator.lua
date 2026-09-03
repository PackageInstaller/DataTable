-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/MainSceneMediator.lua

MainSceneMediator = class("MainSceneMediator", DmSceneMediator, _M)

MainSceneMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local muiscCfg = {
	battlePlayer = {
		noAutoPlay = true
	},
	CommonStageMainView = {
		id = "Mus_Chapter_Common"
	},
	BuildingView = {
		id = "Mus_Main_House"
	},
	ActivityBlockView = {
		noAutoPlay = true
	},
	ActivitySagaSupportStageView = {
		id = "Mus_Zuohe_1"
	},
	ActivitySagaSupportScheduleView = {
		id = "Mus_Zuohe_1"
	},
	ActivityBlockSupportView = {
		id = "Mus_Zuohe_1"
	},
	ActivityBlockEggView = {
		noAutoPlay = true
	},
	ActivityBlockSummerView = {
		noAutoPlay = true
	},
	ActivityBlockWsjView = {
		noAutoPlay = true
	},
	ActivityBlockMapWsjView = {
		noAutoPlay = true
	},
	ActivityBlockMonsterShopView = {
		noAutoPlay = true
	},
	ActivityBlockMusicView = {
		noAutoPlay = true
	},
	ActivityBakingMainView = {
		noAutoPlay = true
	},
	ActivitySunflowerMainView = {
		noAutoPlay = true
	},
	ActivityCollapsedMainView = {
		noAutoPlay = true
	},
	ActivityKnightMainView = {
		noAutoPlay = true
	},
	ActivityFemaleMainView = {
		noAutoPlay = true
	},
	ActivityReZeroMainView = {
		noAutoPlay = true
	},
	ActivityStoryBookMainView = {
		noAutoPlay = true
	},
	ActivitySummerReMainView = {
		noAutoPlay = true
	},
	ActivityBlockDetectiveView = {
		noAutoPlay = true
	},
	ActivityBlockTaskView = {
		noAutoPlay = true
	},
	ActivityBlockTeamView = {
		noAutoPlay = true
	},
	ActivityBlockSummerExchangeView = {
		noAutoPlay = true
	},
	ActivitySagaSupportMapView = {
		noAutoPlay = true
	},
	CommonStageChapterView = {
		noAutoPlay = true
	},
	StagePointDetailView = {
		noAutoPlay = true
	},
	rechargeMainView = {
		noAutoPlay = true
	},
	StageTeamView = {
		noAutoPlay = true
	},
	ExploreMapView = {
		noAutoPlay = true
	},
	loadingView = {
		noAutoPlay = true
	},
	MasterCultivateView = {
		noAutoPlay = true
	},
	HeroShowListView = {
		noAutoPlay = true
	},
	HeroShowMainView = {
		noAutoPlay = true
	},
	HeroEquipDressedView = {
		noAutoPlay = true
	},
	enterLoadingView = {
		noAutoPlay = true
	},
	BuildingAfkGiftView = {
		noAutoPlay = true
	},
	HeroInteractionView = {
		noAutoPlay = true
	},
	GalleryDateView = {
		noAutoPlay = true
	},
	DailyGiftView = {
		noAutoPlay = true
	},
	DreamBattleView = {
		noAutoPlay = true
	},
	ClubBossBattleView = {
		noAutoPlay = true
	},
	ClubView = {
		noAutoPlay = true
	},
	ClubNewHallView = {
		noAutoPlay = true
	},
	ClubNewTechnologyView = {
		noAutoPlay = true
	},
	ClubResourcesBattleView = {
		noAutoPlay = true
	},
	ClubBossView = {
		noAutoPlay = true
	},
	RecruitView = {
		noAutoPlay = true
	},
	DartsView = {
		noAutoPlay = true
	},
	ActivityBlockHolidayView = {
		id = "Mus_Story_NewYear"
	},
	ActivitySupportHolidayView = {
		id = "Mus_Redwhite"
	},
	RTPKMainView = {
		id = "Mus_Story_Danger_2"
	},
	RTPKMatchView = {
		noAutoPlay = true
	},
	rtpvpBattle = {
		noAutoPlay = true
	},
	rtpvpRobotBattle = {
		noAutoPlay = true
	},
	ActivityFireMainView = {
		noAutoPlay = true
	},
	MasterLeadStageDetailView = {
		noAutoPlay = true
	},
	MasterMainView = {
		noAutoPlay = true
	},
	LeadStageArenaMainView = {
		id = "Mus_Redwhite"
	},
	LeadStageArenaRivalView = {
		noAutoPlay = true
	},
	LeadStageArenaTeamListView = {
		noAutoPlay = true
	},
	LeadStageArenaTeamView = {
		noAutoPlay = true
	},
	LeadStageArenaReportView = {
		noAutoPlay = true
	},
	ShopCoopExchangeView = {
		noAutoPlay = true
	},
	ActivityDeepSeaMainView = {
		noAutoPlay = true
	},
	ActivityMapNewView = {
		noAutoPlay = true
	},
	ActivityFireWorksMainView = {
		noAutoPlay = true
	},
	ActivityTerrorMainView = {
		noAutoPlay = true
	},
	ActivityRiddleMainView = {
		noAutoPlay = true
	},
	ActivityAnimalMainView = {
		noAutoPlay = true
	},
	ActivityDuskMainView = {
		noAutoPlay = true
	},
	ActivitySilentNightMainView = {
		noAutoPlay = true
	},
	JumpView = {
		noAutoPlay = true
	},
	ActivityDramaMainView = {
		noAutoPlay = true
	},
	ActivityFamilyMainView = {
		noAutoPlay = true
	},
	ActivityOrientMapView = {
		noAutoPlay = true
	},
	ActivityMagicMainView = {
		noAutoPlay = true
	},
	ActivitySamuraiMainView = {
		noAutoPlay = true
	},
	ActivityBentoView = {
		noAutoPlay = true
	},
	WorldBossMainView = {
		noAutoPlay = true
	},
	ActivitySpringMainView = {
		noAutoPlay = true
	},
	ActivityBlockSupportNewView = {
		noAutoPlay = true
	},
	ActivitySagaSupportStageWxhView = {
		noAutoPlay = true
	},
	ActivitySagaSupportScheduleWxhView = {
		noAutoPlay = true
	}
}
local UINavigateHistory = {}

function MainSceneMediator:initialize()
	super.initialize(self)

	UINavigateHistory = {}
end

function MainSceneMediator:createHistory()
	for i = 1, #self._areaViewStack do
		local areaInfo = self._areaViewStack[i]
		local temp = {}

		temp.viewName = areaInfo.view:getViewName()
		temp.data = areaInfo.view.__enterData
		temp.options = areaInfo.view.__options
		temp.popupView = {}

		if areaInfo.popupGroup then
			for j = 1, #(areaInfo.popupGroup._popupViewStack or {}) do
				local popupInfo = areaInfo.popupGroup._popupViewStack[j]
				local popupTemp = {}

				popupTemp.viewName = popupInfo.view:getViewName()
				popupTemp.data = popupInfo.view.__enterData
				popupTemp.options = popupInfo.view.__options
				popupTemp.delegate = popupInfo.view.__delegate

				table.insert(temp.popupView, popupTemp)
			end
		end

		table.insert(UINavigateHistory, temp)
	end
end

function MainSceneMediator:dispose()
	if (DEBUG ~= 0 or app.pkgConfig.showDebugBox == 1) and self._debugBox then
		self._debugBox:clearTime()
	end

	super.dispose(self)
end

function MainSceneMediator:onRegister()
	super.onRegister(self)

	if DEBUG ~= 0 or app.pkgConfig.showDebugBox == 1 then
		local injector = self:getInjector()

		require("dm.debug.debugBox.init")
		injector:mapSingleton("DebugBox")

		local debugBox = self:getInjector():getInstance("DebugBox")

		debugBox:initInjectorAndMapClass(injector)
		debugBox:initEventDispatcher(self:getEventDispatcher())

		local debugBoxLayer = cc.Node:create()

		if not self._rootNode then
			local rootView = self:getView()

			self._rootNode:addChild(debugBoxLayer, 21)

			local winFrame = self:getAreaFrame()

			debugBoxLayer:setPosition(0, 0)
			debugBoxLayer:setContentSize(cc.size(winFrame.width, winFrame.height))
			debugBox:setupView(debugBoxLayer)

			self._debugBox = debugBox
		end
	end

	local function onKeyReleased(keyCode, event)
		if keyCode == cc.KeyCode.KEY_BACK then
			self:popTopView()
		end
	end

	local listener = cc.EventListenerKeyboard:create()

	listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self:getView())
	self:mapEventListeners()
end

function MainSceneMediator:onRemove()
	super.onRemove(self)
end

function MainSceneMediator:viewWillShow(name)
	if not name then
		return
	end

	local musicInfo = muiscCfg[name]

	if musicInfo and musicInfo.noAutoPlay then
		return
	end

	local settingSystem = self:getInjector():getInstance(SettingSystem)
	local mainBgMuisId = settingSystem:getCurBGMusicId()

	if musicInfo and musicInfo.id then
		mainBgMuisId = musicInfo.id
	end

	if mainBgMuisId and mainBgMuisId ~= "" then
		AudioEngine:getInstance():playBackgroundMusic(mainBgMuisId)
	end
end

function MainSceneMediator:enterWithData(data)
	local data = data or {}
	local injector = self:getInjector()

	if UNIT_TESTING then
		local view = injector:getInstance("TestView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view)

		self:dispatch(event)

		return
	end

	local viewName = "homeView"
	local view = injector:getInstance(viewName)

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function MainSceneMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RELEASE_VIEW_MEMORY, self, self.tryToReleaseViewMemory)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ENTER_BACKGROUND, self, self.appDidEnterBackground)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ENTER_FOREGROUND, self, self.appWillEnterForeground)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECEIVE_MEMORY_WARNING, self, self.didReceiveMemoryWarning)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_POINT_FIRSTPASS, self, self.firstPointPassEvent)
end

function MainSceneMediator:firstPointPassEvent(event)
	local passPoint = event:getData().pointId
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

	customDataSystem:setValue(PrefixType.kGlobal, passPoint .. "_FirstPassState", "true")
end

function MainSceneMediator:tryToReleaseViewMemory(event)
	local data = event:getData() or {}
	local isRemoveAll = not data.keepOnlyOne

	self:releaseViewMemory(isRemoveAll)
end

function MainSceneMediator:didReceiveMemoryWarning()
	sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
	print("收到内存警告")
	DataReader:cleanCache()

	if MemCacheUtils then
		MemCacheUtils:releaseAllCaches()
	end

	collectgarbage("collect")
end

function MainSceneMediator:appDidEnterBackground()
	self._developSystem:enterType({
		type = 1
	})
	sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
	app.clearCurrentPool()
	display.removeUnusedSpriteFrames()

	if DEBUG == 2 then
		-- block empty
	end

	DataReader:cleanCache()
	collectgarbage("collect")
	StatisticSystem:uploadLogs(LogType.kClient)
end

function MainSceneMediator:appWillEnterForeground()
	self._developSystem:enterType({
		type = 0
	})

	if not self:getTopView() then
		if device.platform == "android" then
			performWithDelay(self:getView(), function()
				self:resumeViwFromHistory(nil)
			end, 0.001)
		else
			self:resumeViwFromHistory(nil)
		end

		print("回到游戏")
	end
end

function MainSceneMediator:releaseViewMemory(isRemoveAll)
	if #self._areaViewStack == 0 then
		return
	end

	local isFighting = false

	self:dispatch(Event:new(EVT_CHECK_IS_BATTLE_VIEW, function()
		isFighting = true
	end))
	self:createHistory()

	if isRemoveAll and not isFighting then
		self:popToIndexView(0)
	else
		table.remove(UINavigateHistory)
	end

	local num = #self._areaViewStack - 1

	for i = 1, num do
		self:removeViewAtIndex(1)
	end

	if not isFighting then
		sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
	end

	app.clearCurrentPool()
	display.removeUnusedSpriteFrames()

	if DEBUG == 2 then
		-- block empty
	end

	print("释放内存")
end

function MainSceneMediator:createViewByInfo(viewInfo)
	local injector = self:getInjector()
	local view = injector:getInstance(viewInfo.viewName)

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, viewInfo.options, viewInfo.data))

	for j = 1, #viewInfo.popupView do
		local popupViewInfo = viewInfo.popupView[j]
		local pupupView = injector:getInstance(popupViewInfo.viewName)
		local event = ViewEvent:new(EVT_SHOW_POPUP, pupupView, popupViewInfo.options, popupViewInfo.data, popupViewInfo.delegate)

		self:dispatch(event)
	end

	return view
end

function MainSceneMediator:resumeViwFromHistory(data)
	local viewInfo = table.remove(UINavigateHistory)

	if viewInfo then
		viewInfo.data = viewInfo.data or {}
		viewInfo.data.resumeName = "History"

		self:createViewByInfo(viewInfo)
	else
		local view = self:getInjector():getInstance("homeView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
	end
end

function MainSceneMediator:popView(popView, options, data)
	super.popView(self, popView, options, data)

	if data and data.notReCreate then
		return
	end

	if not self:getTopView() then
		self:resumeViwFromHistory(data)
	end
end

function MainSceneMediator:popTopView()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local storyAgent = storyDirector:getStoryAgent()

	if guideAgent:isGuiding() then
		guideAgent:showExitGameTips()

		return
	end

	if storyAgent:isGuiding() then
		storyAgent:skip()

		return
	end

	if self:getPopupViewCount() > 0 then
		local popupView = self:getTopPopupView()

		if popupView and popupView.mediator then
			popupView.mediator:leaveWithData()

			return
		end
	end

	local view = self:getTopView()

	if view and view.mediator then
		view.mediator:leaveWithData()
	end
end

function MainSceneMediator:removeHistoryByName(name)
	for i = #UINavigateHistory, 1, -1 do
		local viewInfo = UINavigateHistory[i]

		if name == viewInfo.viewName then
			table.remove(UINavigateHistory, i)
		end
	end
end

function MainSceneMediator:pushView(areaView, options, data)
	self:removeHistoryByName(areaView:getViewName())

	local rets = {
		super.pushView(self, areaView, options, data)
	}

	return unpack(rets)
end

function MainSceneMediator:switchView(areaView, options, data)
	if #UINavigateHistory > 0 then
		local keepCognominalView = options.keepCognominalView

		if not keepCognominalView and options.replaceIndex == nil then
			local targetIndex = self:getViewIndexFromHistoryByName(areaView:getViewName())

			if targetIndex then
				for i = #UINavigateHistory, 1, -1 do
					table.remove(UINavigateHistory, i)

					if i == targetIndex then
						break
					end
				end

				options.replaceIndex = 1
			end
		elseif options.replaceViewName and options.replaceIndex and options.isHistoryReplaceIndex then
			for i = #UINavigateHistory, 1, -1 do
				table.remove(UINavigateHistory, i)

				if i == options.replaceIndex then
					break
				end
			end

			options.replaceIndex = 1
		end
	end

	local rets = {
		super.switchView(self, areaView, options, data)
	}

	return unpack(rets)
end

function MainSceneMediator:getViewIndexFromHistoryByName(name)
	for i = #UINavigateHistory, 1, -1 do
		local viewInfo = UINavigateHistory[i]

		if name == viewInfo.viewName then
			return i
		end
	end
end

function MainSceneMediator:popToIndexViewFromHistory(targetIndex, data)
	if targetIndex > #UINavigateHistory or targetIndex < 0 then
		return
	end

	for i = #UINavigateHistory, 1, -1 do
		if i == targetIndex then
			break
		end

		table.remove(UINavigateHistory, i)
	end

	self:popToIndexView(0, data)

	local viewInfo = table.remove(UINavigateHistory)

	self:createViewByInfo(viewInfo)
end
