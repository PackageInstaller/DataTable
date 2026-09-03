-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/HomeMediator.lua

HomeMediator = class("HomeMediator", DmAreaViewMediator, _M)

HomeMediator:has("_homeSystem", {
	is = "r"
}):injectWith("HomeSystem")
HomeMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")
HomeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HomeMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
HomeMediator:has("_mailSystem", {
	is = "r"
}):injectWith("MailSystem")
HomeMediator:has("_clubSystem", {
	is = "rw"
}):injectWith("ClubSystem")
HomeMediator:has("_shopSystem", {
	is = "rw"
}):injectWith("ShopSystem")
HomeMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
HomeMediator:has("_activitySystem", {
	is = "rw"
}):injectWith("ActivitySystem")
HomeMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
HomeMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")
HomeMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
HomeMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
HomeMediator:has("_cooperateSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
HomeMediator:has("_planeWarSystem", {
	is = "r"
}):injectWith("PlaneWarSystem")

local kBtnHandlers = {
	unfoldMenuBtn = {
		clickAudio = "Se_Click_Home_1",
		func = "onMenuStateChange"
	},
	["unfoldMenuBtn.fastGetResourceBtn"] = {
		ignoreClickAudio = true,
		func = "fastGetRes"
	},
	["unfoldMenuBtn.fastGetResourceExBtn"] = {
		ignoreClickAudio = true,
		func = "fastGetRes"
	}
}
local spineTouchEventTag = false
local firstChargePackId = "PackageShop_1"
local PREPARESTATE = "Prepare_State"
local ResidentSoundID
local spineTouchEventName = "touch2"
local buildingResourceTimeState = {
	0,
	60,
	900,
	1800,
	3600,
	10800,
	21600
}
local buildingResourceTimeAnim = {
	"jieduan2_jiayuanshouqu",
	"jieduan3_jiayuanshouqu",
	"jieduan4_jiayuanshouqu",
	"jieduan5_jiayuanshouqu",
	"jieduan6_jiayuanshouqu",
	"jieduan7_jiayuanshouqu"
}
local buildingResourceTimeAnimPos = {
	cc.p(160, 52),
	cc.p(160, 63),
	cc.p(160, 63),
	cc.p(171, 70),
	cc.p(180, 73),
	cc.p(190, 83)
}
local buildingGetResourceExBtnSize = {
	cc.p(0, 0),
	cc.p(0, 0),
	cc.p(10, 40),
	cc.p(50, 50),
	cc.p(75, 55),
	cc.p(80, 63)
}

local function formatUnorderTable(unorderTable, compFunc)
	local _tab = {}

	for k, v in pairs(unorderTable) do
		_tab[#_tab + 1] = k
	end

	if compFunc then
		table.sort(_tab, compFunc)
	end

	return _tab
end

local function convertNodeToWorldSpaceWithPos(node, pos)
	local parent = node:getParent()
	local rowPosX, rowPosY = node:getPosition()
	local offsetPos = parent:convertToWorldSpace(cc.p(rowPosX, rowPosY))
	local offX = pos.x - offsetPos.x
	local offY = pos.y - offsetPos.y

	node:setPosition(cc.p(rowPosX + offX, rowPosY + offY))
end

local HomeViewConfig = require("dm.gameplay.home.model.HomeViewConfig")

function HomeMediator:initialize()
	super.initialize(self)
end

function HomeMediator:dispose()
	if self._bannerTimer then
		self._bannerTimer:stop()

		self._bannerTimer = nil
	end

	if self._checkGetResTimer then
		self._checkGetResTimer:stop()

		self._checkGetResTimer = nil
	end

	if self._webPayTimer then
		self._webPayTimer:stop()

		self._webPayTimer = nil
	end

	if self._timeLimitShopTimer then
		self._timeLimitShopTimer:stop()

		self._timeLimitShopTimer = nil
	end

	if self._currencyInfoWidget then
		self._currencyInfoWidget:dispose()

		self._currencyInfoWidget = nil
	end

	if self._playInfoWidget then
		self._playInfoWidget:dispose()

		self._playInfoWidget = nil
	end

	if self._chatFlowWidget then
		self._chatFlowWidget:dispose()

		self._chatFlowWidget = nil
	end

	if self._motion then
		self._motion:stop()

		self._motion = nil
	end

	if self._coopInviteTimer then
		self._coopInviteTimer:stop()

		self._coopInviteTimer = nil
	end

	if self._packagetimer then
		self._packagetimer:stop()

		self._packagetimer = nil
	end

	super.dispose(self)
end

function HomeMediator:resumeWithData(data)
	self:refreshDownloadStatus()
	self:refreshRedPoint()
	self:setComplexActivityEntry()
	self:setActivityCalendar()
	self:setNewArenaBtn()
	self:randomBoardRoleAndBg()
	self:showCoopTips()

	if self._motion and not self._motion:isRunning() then
		self:enableAccelerator()
	end

	if not self._checkGetResTimer then
		self:enableBuildingResourceTimer()
	end

	if not self._webPayTimer then
		self:enableWebPayListTimer()
	end

	if not self._timeLimitShopTimer then
		self:enableTimeLimitShopTimer()
	end

	if self._dreamActivityTips then
		self._dreamActivityTips:setVisible(false)
		self._dreamActivityTips:stopAllActions()
	end

	if self._cooperateTip then
		self._cooperateTip:setVisible(false)
		self._cooperateTip:stopAllActions()
	end

	self._touchTimes = 0

	local resumeTime = TimeUtil:timeByLocalDate()

	if not self._lastResumeTime or resumeTime - self._lastResumeTime > 900 then
		self:setBoardHeroEffectState(true)

		self._lastResumeTime = resumeTime
	end

	self:registerHomeViewEvent()
	self:setupClickEnvs(true)
	self:playClimate2Audio()
	self:checkNewSystemUnlock()

	local isActivity = self._activitySystem:hasRedPointForActivity(DailyGift)
	local giftImg = self._homePanel:getChildByName("giftImg")

	giftImg:setVisible(false)

	if isActivity then
		giftImg:setVisible(true)
	end

	self:refreshPushPackageView()
end

function HomeMediator:leaveWithData(data)
	local data = {
		noClose = true,
		title = Strings:get("UPDATE_UI7"),
		content = Strings:get("UI_TEXT_EXIT_GAME"),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			performWithDelay(outSelf:getView(), function()
				cc.Director:getInstance():endToLua()
			end, 0.1)
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		isAreaIndependent = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function HomeMediator:playClimate2Audio()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local level = developSystem:getPlayer():getLevel()

	if self._climateEffect then
		AudioEngine:getInstance():stopEffect(self._climateEffect)

		self._climateEffect = nil
	end

	if (GameConfigs.closeGuide or not guideAgent:isGuiding() and level > 1) and Climate2AudioEffect[self._climateDay] and self._climateMc ~= nil then
		self._climateEffect = AudioEngine:getInstance():playEffect(Climate2AudioEffect[self._climateDay], false)
	end
end

function HomeMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()

	self:initButtons(HomeViewConfig)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:createMapListener()
end

function HomeMediator:onRemove()
	super.onRemove(self)
end

function HomeMediator:willStartResumeTransition()
	self._mc:setPlaySpeed(2)
	self._mc:gotoAndStop(0)

	local mainStageNode = self._rightFuncLayout:getChildByFullName("mExploreNode")

	mainStageNode:getChildByName("mRedSprite"):setOpacity(0)

	for i = 1, #self._actNodes do
		self._actNodes[i].movieClip:gotoAndStop(0)

		local redPoint = self._actNodes[i]:getChildByName("mRedSprite")

		redPoint:setOpacity(0)
	end

	local leftRowPosX, leftRowPosY = self._leftFuncLayout:getPosition()
	local topRowPosX, topRowPosY = self._topFuncLayout:getPosition()

	self._leftFuncLayout:setPositionX(leftRowPosX + 25)
	self._topFuncLayout:setPositionX(topRowPosX + 25)
	self._leftFuncLayout:setOpacity(0)
	self._topFuncLayout:setOpacity(0)

	local playerNode = self:getView():getChildByName("playerNode")
	local currencyInfoNode = self:getView():getChildByFullName("currencyinfo_node")
	local line = self:getView():getChildByFullName("Image_35")

	self._rightFuncLayout:getChildByFullName("extraActBtn"):setOpacity(0)
	playerNode:setOpacity(0)
	line:setOpacity(0)
	currencyInfoNode:setOpacity(0)
	self._menuStateBtn:setOpacity(0)

	local wonderfulAct = self._rightFuncLayout:getChildByName("wonderfulAct")
	local wonderfulActPosX, wonderfulActPosY = wonderfulAct:getPosition()

	wonderfulAct:setOpacity(0)
	wonderfulAct:setPositionY(wonderfulActPosY + 42.2)

	local newarenaBtn = self._rightFuncLayout:getChildByName("newarenaBtn")
	local newarenaBtnPosX, newarenaBtnPosY = newarenaBtn:getPosition()

	newarenaBtn:setOpacity(0)
	newarenaBtn:setPositionY(newarenaBtnPosY + 42.2)
end

function HomeMediator:didFinishResumeTransition()
	local activityBtn = self._urlFuncLayout:getChildByFullName("activityBtn")
	local unlock, tips = self._systemKeeper:isUnlock("ActivityCalendar")

	activityBtn:setVisible(unlock)

	local winSize = cc.Director:getInstance():getWinSize()

	if unlock then
		local var_13_0 = self._urlFuncLayoutNode1:getPositionX()

		if not var_13_0 then
			var_13_0 = self._urlFuncLayoutNode2:getPositionX()

			local targetX = var_13_0

			self._urlFuncLayout:setOpacity(0)
			self._urlFuncLayout:setPositionX(winSize.width)

			local fadeIn = cc.FadeIn:create(0.15)
			local moveTo1 = cc.MoveTo:create(0.15, cc.p(targetX - 50, self._urlFuncLayout:getPositionY()))
			local moveTo2 = cc.MoveTo:create(0.05, cc.p(targetX, self._urlFuncLayout:getPositionY()))
			local action = cc.Sequence:create(cc.Spawn:create(fadeIn, moveTo1), moveTo2)

			self._urlFuncLayout:runAction(action)
			self._menuStateBtn:runAction(cc.FadeIn:create(0.6))
			self._mc:gotoAndPlay(1)
		end
	end
end

function HomeMediator:didFinishCoverTransition()
	super.didFinishCoverTransition(self)
	self:getView():stopAllActions()

	if self._climateEffect then
		AudioEngine:getInstance():stopEffect(self._climateEffect)

		self._climateEffect = nil
	end

	if ResidentSoundID then
		AudioEngine:getInstance():stopEffect(ResidentSoundID)

		ResidentSoundID = nil
	end

	if self._motion then
		self._motion:stop()
	end

	self:setBoardHeroEffectState(false)
	self._playInfoWidget:unregisterTimerEvent()
end

function HomeMediator:enterWithData(data)
	local content = {
		point = "login_enter_home_view",
		type = "loginflow"
	}

	StatisticSystem:send(content)
	self:initWidget()
	self:onFunSwitchSet()
	self:setupCurrencyInfoWidget()
	self:setupPlayerInfoWidget()
	self:initHomeView()
	self:initAnim()
	self:setBoardHeroEffectState(true, true)
	self:enableAccelerator()
	self:setupClickEnvs(true)
	self:playClimate2Audio()
	self:checkNewSystemUnlock()
	self:refreshDownloadStatus()

	local payOffSystem = self:getInjector():getInstance(PayOffSystem)

	payOffSystem:createPayIncomplete()
	self:reshMCFPower()
	self:refreshPushPackageView()
end

function HomeMediator:reshMCFPower()
	self._shopSystem:refreshMCFRedPoint()
end

function HomeMediator:onFunSwitchSet()
	local taskNode = self._leftBtns.mTaskNode

	if taskNode then
		taskNode:setVisible(CommonUtils.GetSwitch("fn_task"))
	end

	local shopNode = self._leftBtns.mShopNode

	if shopNode then
		shopNode:setVisible(CommonUtils.GetSwitch("fn_shop_recharge"))
	end

	local guildNode = self._rightBtns.mGuildNode

	if guildNode then
		guildNode:setVisible(CommonUtils.GetSwitch("fn_guild"))
	end

	local activityNode = self._rightBtns.mActivity2Node

	if activityNode then
		activityNode:setVisible(CommonUtils.GetSwitch("fn_activity"))
	end
end

function HomeMediator:createMapListener()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOMEVIEW_REDPOINT_REF, self, self.passiveRefreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOME_SET_SHOWHERO, self, self.setShowHero)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHARGETASK_FIN, self, self.reloadView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOME_SET_VIEWBG, self, self.changeHomeViewBg)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.reloadView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOME_SET_CLIMATE, self, self.setClimateScene)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_RECEIVEINVITATION, self, self.onReceiveFriendPvpInviteCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_SELECT_SUCC, self, self.setBoardHeroSprite)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.setBoardHeroSprite)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.reloadPageView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_REWARDS_SUCC, self, self.showDownloadReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_PORTRAIT_OVER, self, self.refreshDownloadStatus)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_SOUNDCV_OVER, self, self.refreshDownloadStatus)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_PORTRAIT, self, self.refreshDownloadPorLabel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_SOUNDCV, self, self.refreshDownloadSoundLabel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROES_SYNC_SHOW, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RETURN_ACTIVITY_REFRESH, self, self.onBackFlowActivityRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MAIL_NEW, self, self.refreshActivityCalendarRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_OFFLINE_REPORT, self, self.setNewArenaBtn)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOMEVIEW_SETBORAD_MOVE, self, self.setShowHeroMoveViewVis)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_INVITE, self, self.showCoopTips)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BLOCKLEVEL_CHANGE, self, self.reloadView)
end

function HomeMediator:onBackFlowActivityRefresh(event)
	self._rightFuncLayout:getChildByName("mBackFlowNode"):setVisible(self._activitySystem:isReturnActivityShow())
end

function HomeMediator:showDownloadReward(event)
	self:refreshDownloadStatus()

	local data = event:getData()

	if data.rewards and #data.rewards > 0 then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = data.rewards
		}))
	end
end

function HomeMediator:refreshDownloadStatus()
	self._downloadBtn:setVisible(self._settingSystem:canDownloadPortrait() or self._settingSystem:canDownloadSoundCV())

	local btn = self._downloadBtn:getChildByFullName("mBtn")
	local mTempName = self._downloadBtn:getChildByFullName("mTempName")
	local normalPath = "main_xz_1.png"
	local pressedPath = "main_xz_1.png"
	local tip = Strings:get("Home_UI_Download")

	if self._settingSystem:canDownloadPortrait() then
		local isPortraitDownloadOver = self._settingSystem:isPortraitDownloadOver()

		if isPortraitDownloadOver then
			normalPath = "main_xz_3.png"
			pressedPath = "main_xz_3.png"
			tip = Strings:get("Home_UI_Download_Received")
		else
			normalPath = "main_xz_2.png"
			pressedPath = "main_xz_2.png"

			local portraitProgress = self._settingSystem:getPortraitProgress()

			portraitProgress = math.modf(portraitProgress)
			tip = portraitProgress == 100 and Strings:get("Home_UI_Download_Received") or portraitProgress .. "%"
		end
	elseif self._settingSystem:canDownloadSoundCV() then
		local isSoundCVDownloadOver = self._settingSystem:isSoundCVDownloadOver()

		if isSoundCVDownloadOver then
			normalPath = "main_xz_3.png"
			pressedPath = "main_xz_3.png"
			tip = Strings:get("Home_UI_Download_Received")
		else
			normalPath = "main_xz_2.png"
			pressedPath = "main_xz_2.png"

			local soundcvProgress = self._settingSystem:getSoundCVProgress()

			soundcvProgress = math.modf(soundcvProgress)
			tip = soundcvProgress == 100 and Strings:get("Home_UI_Download_Received") or soundcvProgress .. "%"
		end
	end

	btn:loadTextureNormal(normalPath, ccui.TextureResType.userDataType)
	btn:loadTexturePressed(pressedPath, ccui.TextureResType.userDataType)
	mTempName:setString(tip)

	if self._navigation._initDone then
		self._navigation:updataTopNode()

		local isOpen = self._navigation:isTopOpen()

		if isOpen then
			self._navigation:openAction()
		else
			self._navigation:closeAction()
		end
	end
end

function HomeMediator:refreshDownloadPorLabel(event)
	local data = event:getData()
	local percent = math.modf(data.progress)
	local tip = percent .. "%"
	local mTempName = self._downloadBtn:getChildByFullName("mTempName")

	if percent == 100 then
		mTempName:setString(Strings:get("Home_UI_Download_Received"))
	else
		mTempName:setString(tip)
	end
end

function HomeMediator:refreshDownloadSoundLabel(event)
	if self._settingSystem:canDownloadPortrait() then
		return
	end

	local data = event:getData()
	local percent = math.modf(data.progress)
	local tip = percent .. "%"
	local mTempName = self._downloadBtn:getChildByFullName("mTempName")

	if percent == 100 then
		mTempName:setString(Strings:get("Home_UI_Download_Received"))
	else
		mTempName:setString(tip)
	end
end

function HomeMediator:reloadView()
	self:reloadPageView()
	self:checkClubRedPoint()
	self:checkExtraRedPoint()
	self:setComplexActivityEntry()
	self:setActivityCalendar()
	self:setNewArenaBtn()
end

function HomeMediator:initHomeView()
	self._homePanel:setVisible(true)

	local afkBtn = self._homePanel:getChildByName("afkBtn")

	afkBtn:setLocalZOrder(5556)

	local function callFunc()
		local view = self:getInjector():getInstance("BuildingAfkGiftView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			canSetBoardHero = true,
			type = 4,
			id = self._showHeroId
		}))
	end

	mapButtonHandlerClick(nil, afkBtn, {
		ignoreClickAudio = true,
		func = callFunc
	})

	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

	self._showHeroId = customDataSystem:getValue(PrefixType.kGlobal, "BoardHeroId", -1)

	if self._showHeroId == -1 then
		self._showHeroId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Default_Model_Board", "content")

		customDataSystem:setValue(PrefixType.kGlobal, "BoardHeroId", self._showHeroId)
	end

	self._homeViewBgId = self._settingSystem:getHomeBgId()

	self:randomBoardRoleAndBg()
	self:registerHomeViewEvent()
	self:initActivityBanner()
	self:checkClubRedPoint()
	self:checkExtraRedPoint()
	self:enableBuildingResourceTimer()
	self:enableWebPayListTimer()
	self:enableTimeLimitShopTimer()
	self:setComplexActivityEntry()
	self:setActivityCalendar()
	self:setNewArenaBtn()
end

function HomeMediator:enableBuildingResourceTimer()
	local unlock, tips = self._systemKeeper:isUnlock("Village_Building")

	if unlock then
		if self._checkGetResTimer then
			self._checkGetResTimer:stop()

			self._checkGetResTimer = nil
		end

		local function updata()
			local lastGetResTime = self._buildingSystem:getBuildLastGetResTime()
			local tag = 0

			for i = #buildingResourceTimeState, 1, -1 do
				if lastGetResTime > buildingResourceTimeState[i] then
					tag = i

					break
				end
			end

			local animName = buildingResourceTimeAnim[tag - 1]
			local animPos = buildingResourceTimeAnimPos[tag - 1]
			local curAnim = self._menuStateBtn:getChildByTag(10025)

			if tag == 0 or tag == 1 then
				if curAnim then
					self._menuStateBtn:removeChildByTag(10025)
				end

				self._menuStateBtn:getChildByTag(10026):stop()
			elseif not curAnim or curAnim:getName() ~= animName then
				self._menuStateBtn:getChildByTag(10026):play()

				if curAnim then
					self._menuStateBtn:removeChildByTag(10025)
				end

				local mc = cc.MovieClip:create(animName)

				mc:addCallbackAtFrame(65, function()
					mc:stop()
				end)
				mc:addTo(self._menuStateBtn, 1, 10025):setName(animName)
				mc:setPosition(animPos)

				local btnSize = {}

				btnSize.width = buildingGetResourceExBtnSize[tag - 1].x
				btnSize.height = buildingGetResourceExBtnSize[tag - 1].y

				self._fastGetResourceExBtn:ignoreContentAdaptWithSize(false)
				self._fastGetResourceExBtn:setContentSize(btnSize)
			end
		end

		self._checkGetResTimer = LuaScheduler:getInstance():schedule(updata, 2, false)
	end
end

function HomeMediator:enableWebPayListTimer()
	if self._webPayTimer then
		self._webPayTimer:stop()

		self._webPayTimer = nil
	end

	local function updata()
		local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
		local topViewName = scene:getTopViewName()

		if topViewName == "homeView" then
			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:showWebReward()
		end
	end

	self._webPayTimer = LuaScheduler:getInstance():schedule(updata, 1, false)
end

function HomeMediator:enableTimeLimitShopTimer()
	local isShow = self._activitySystem:checkTimeLimitShopShow()

	if not isShow then
		return
	end

	if self._timeLimitShopTimer then
		self._timeLimitShopTimer:stop()

		self._timeLimitShopTimer = nil
	end

	local deadline = self._homePanel:getChildByFullName("timeShop.deadline")
	local timeShop = self._homePanel:getChildByName("timeShop")

	timeShop:getChildByName("redPoint"):setVisible(self._activitySystem:checkTimeLimitShopRedpointShow())

	local timeShopTitle = self._homePanel:getChildByFullName("timeShop.title")

	timeShopTitle:setString(Strings:get(self._activitySystem:getFestivalPackageTitle()))

	local function updata()
		local leaveTime = self._activitySystem:getTimeLimitShopLeaveTime()
		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, leaveTime)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.day = tonumber(parts[1])
		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.s = tonumber(parts[4])

		deadline:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.s .. Strings:get("TimeUtil_Sec") or timeTab.s .. Strings:get("TimeUtil_Sec"))
	end

	self._timeLimitShopTimer = LuaScheduler:getInstance():schedule(updata, 1, false)

	updata()
end

function HomeMediator:fastGetRes()
	local unlock, tips = self._systemKeeper:isUnlock("Village_Building")

	if unlock then
		local lastGetResTime = self._buildingSystem:getBuildLastGetResTime()
		local tag = 0

		for i = #buildingResourceTimeState, 1, -1 do
			if lastGetResTime > buildingResourceTimeState[i] then
				tag = i

				break
			end
		end

		if tag == 0 then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Build_ResourceBuilding_Unlock")
			}))
		else
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local mc = self._menuStateBtn:getChildByTag(10026)

			mc:stop()

			local goldIcon = self._menuStateBtn:getChildByTag(10025)

			if goldIcon then
				goldIcon:setVisible(false)
			end

			local delegate = __associated_delegate__(self)({
				willClose = function(self, popUpMediator, data)
					local mc = self._menuStateBtn:getChildByTag(10026)

					mc:gotoAndStop(1)
					self._menuStateBtn:removeChildByTag(10025)
				end
			})
			local view = self:getInjector():getInstance("BuildingOneKeyGetResView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil, delegate))
		end
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function HomeMediator:enableAccelerator()
	if device.platform == "mac" or device.platform == "windows" then
		return
	end

	if self._motion then
		self._motion:stop()

		self._motion = nil
	end

	local posX, posY = 568, 320

	self._motion = app.getDevice():getMotion()

	function self._motion.onMotion(data)
		local acceleration = data.userAcceleration
		local acX = acceleration.x
		local acY = acceleration.y
		local acZ = acceleration.z

		if math.abs(acX) > 2 or math.abs(acY) > 2 or math.abs(acZ) > 2 then
			if not spineTouchEventTag and self._sharedSpine and self._sharedSpine:hasAnimation(spineTouchEventName) then
				spineTouchEventTag = true

				self._sharedSpine:playAnimation(0, spineTouchEventName, true)
			end

			return
		end

		local gravity = data.gravity
		local offX = -gravity.y * 80
		local offY = gravity.x * 60
		local ccp = cc.p(posX + offX, posY + offY)

		self._homeBgPanel:setPosition(ccp)
	end

	self._motion:setInterval(0.03333333333333333)
	self._motion:start()
end

function HomeMediator:initAnim()
	local iconView = cc.MovieClip:create("baoshi_lingxingbaoshi")

	iconView:setPosition(cc.p(0, 0))

	local mainStageNode = self._rightFuncLayout:getChildByFullName("mExploreNode")
	local mainStageNodeMc = mainStageNode.movieClip

	mainStageNode.iconMovieClip = iconView

	mainStageNodeMc:getChildByName("Icon"):addChild(iconView)
	mainStageNode:getChildByName("mRedSprite"):setOpacity(0)

	local nodes = {}

	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mGuildNode")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mRecruitEquipNode")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mChallengeNode")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mCardsGroupNode")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mArena1Node")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mActivity2Node")
	nodes[#nodes + 1] = self._rightFuncLayout:getChildByName("mBackFlowNode")

	for i = 1, #nodes do
		local redPoint = nodes[i]:getChildByName("mRedSprite")

		redPoint:setOpacity(0)
	end

	self._actNodes = nodes

	local mainMovieClip = cc.MovieClip:create("dh_xinzhujiemian")

	self._mc = mainMovieClip

	mainMovieClip:stop()
	mainMovieClip:addCallbackAtFrame(1, function()
		mainStageNodeMc:gotoAndPlay(0)
	end)
	mainMovieClip:addCallbackAtFrame(11, function()
		local mc = nodes[1].movieClip

		mc:gotoAndPlay(0)
		mainStageNode:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
		nodes[1]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
	end)

	local dreamActivity = nodes[3]:getChildByFullName("dreamActivity")

	if dreamActivity then
		dreamActivity:setVisible(false)
	end

	local function nodeSparkle(node, delay1, delay2)
		node:stopAllActions()
		node:setOpacity(255)

		local delay1 = cc.DelayTime:create(delay1)
		local fadeOut = cc.FadeOut:create(0.2)
		local delay2 = cc.DelayTime:create(delay2)
		local fadeIn = cc.FadeIn:create(0.2)
		local action = cc.RepeatForever:create(cc.Sequence:create(delay1, fadeOut, delay2, fadeIn))

		node:runAction(action)
	end

	mainMovieClip:addCallbackAtFrame(12, function()
		local mc1 = nodes[2].movieClip

		mc1:gotoAndPlay(0)
		nodes[2]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))

		local mc2 = nodes[3].movieClip

		mc2:gotoAndPlay(0)
		nodes[3]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
		delayCallByTime(300, function()
			if self._dreamSystem:checkActivityDreamChallengeOpen() then
				local dreamActivity = nodes[3]:getChildByFullName("dreamActivity")

				if self._dreamActivityTips then
					dreamActivity:setVisible(true)
					dreamActivity:setOpacity(0)
					self._dreamActivityTips:runAction(cc.FadeIn:create(0.3))
				else
					local icon = cc.Sprite:createWithSpriteFrameName("zjm_tfsjrk_bg.png")
					local label = cc.Label:createWithTTF(Strings:get("DreamChallenge_Entry_Tip01"), TTF_FONT_FZYH_R, 16)

					label:setOverflow(cc.LabelOverflow.SHRINK)
					label:setDimensions(120, 90)
					label:enableOutline(cc.c4b(3, 1, 4, 255), 1)
					label:setTextColor(cc.c3b(255, 242, 155))
					label:addTo(icon):center(icon:getContentSize())
					label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
					label:setOverflow(cc.LabelOverflow.SHRINK)
					icon:setName("dreamActivity")
					icon:setPositionY(46)
					icon:addTo(nodes[3])

					self._dreamActivityTips = icon
				end

				local delay1 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamChallenge_EntryBubble_Stay", "content")
				local delay2 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamChallenge_EntryBubble_Gone", "content")

				nodeSparkle(self._dreamActivityTips, delay1, delay2)
			end
		end)

		local mc3 = nodes[4].movieClip

		mc3:gotoAndPlay(0)
		nodes[4]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))

		local mc4 = nodes[6].movieClip

		mc4:gotoAndPlay(0)
		nodes[6]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
		delayCallByTime(300, function()
			if self._cooperateSystem:getcooperateBossState() == kCooperateBossState.kStart then
				local cooperateTip = nodes[5]:getChildByFullName("cooperateTip")

				if self._cooperateTip then
					cooperateTip:setVisible(true)
					cooperateTip:setOpacity(0)
					self._cooperateTip:runAction(cc.FadeIn:create(0.3))
				else
					local icon = cc.Sprite:createWithSpriteFrameName("zjm_tfsjrk_bg.png")
					local label = cc.Label:createWithTTF(Strings:get("CooperateBoss_EntryTip"), TTF_FONT_FZYH_R, 16)

					label:enableOutline(cc.c4b(3, 1, 4, 255), 1)
					label:setTextColor(cc.c3b(255, 242, 155))
					label:setDimensions(120, 90)
					label:addTo(icon):center(icon:getContentSize())
					label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
					label:setOverflow(cc.LabelOverflow.SHRINK)
					icon:setName("cooperateTip")
					icon:setPosition(cc.p(15, 25))
					icon:addTo(nodes[5])

					self._cooperateTip = icon
				end

				local delay1 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_EntryBubble_Stay", "content")
				local delay2 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_EntryBubble_Gone", "content")

				nodeSparkle(self._cooperateTip, delay1, delay2)
			end
		end)
	end)
	mainMovieClip:addCallbackAtFrame(13, function()
		local mc = nodes[5].movieClip

		mc:gotoAndPlay(0)
		nodes[5]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))

		local mc1 = nodes[7].movieClip

		mc1:gotoAndPlay(0)
		nodes[7]:getChildByName("mRedSprite"):runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
		nodes[7]:setVisible(self._activitySystem:isReturnActivityShow())
	end)
	mainMovieClip:addCallbackAtFrame(30, function()
		mainMovieClip:stop()
	end)

	local mcNode = self:getView():getChildByFullName("mainMcNode")

	mainMovieClip:setAnchorPoint(cc.p(0, 0))
	mainMovieClip:setPosition(cc.p(0, 0))
	mainMovieClip:addTo(mcNode)

	local mainBgPanel = mainMovieClip:getChildByName("mainBgPanel")

	self._homeBgPanel:changeParent(mainBgPanel)

	local heroPanel = mainMovieClip:getChildByName("heroPanel")

	self._homePanel:changeParent(heroPanel)
	self._homePanel:setPosition(cc.p(800, 520))

	local baseFadePanel = mainMovieClip:getChildByName("baseFadePanel")
	local leftRowPosX, leftRowPosY = self._leftFuncLayout:getPosition()
	local topRowPosX, topRowPosY = self._topFuncLayout:getPosition()

	self._leftFuncLayout:setPositionX(leftRowPosX + 25)
	self._topFuncLayout:setPositionX(topRowPosX + 25)
	self._leftFuncLayout:setOpacity(0)
	self._topFuncLayout:setOpacity(0)

	local newarenaBtn = self._rightFuncLayout:getChildByName("newarenaBtn")

	newarenaBtn:setOpacity(0)

	local newarenaBtnPosX, newarenaBtnPosY = newarenaBtn:getPosition()
	local wonderfulAct = self._rightFuncLayout:getChildByName("wonderfulAct")

	wonderfulAct:setOpacity(0)

	local wonderfulActPosX, wonderfulActPosY = wonderfulAct:getPosition()

	mainMovieClip:addCallbackAtFrame(20, function()
		self._leftFuncLayout:runAction(cc.Spawn:create(cc.FadeIn:create(0.21), cc.MoveBy:create(0.21, cc.p(-25, 0))))
		self._topFuncLayout:runAction(cc.Spawn:create(cc.FadeIn:create(0.21), cc.MoveBy:create(0.21, cc.p(-25, 0))))

		local nowWonderfulActPosY = wonderfulAct:getPositionY()

		wonderfulAct:runAction(cc.Spawn:create(cc.FadeIn:create(0.21), cc.MoveBy:create(0.21, cc.p(0, wonderfulActPosY - nowWonderfulActPosY))))
		newarenaBtn:runAction(cc.Spawn:create(cc.FadeIn:create(0.21), cc.MoveTo:create(0.21, cc.p(newarenaBtnPosX, newarenaBtnPosY))))
	end)

	local playerNode = self:getView():getChildByName("playerNode")
	local currencyInfoNode = self:getView():getChildByFullName("currencyinfo_node")
	local line = self:getView():getChildByFullName("Image_35")

	playerNode:setOpacity(0)
	currencyInfoNode:setOpacity(0)
	line:setOpacity(0)
	self._rightFuncLayout:getChildByFullName("extraActBtn"):setOpacity(0)
	mainMovieClip:addCallbackAtFrame(17, function()
		playerNode:runAction(cc.FadeIn:create(0.21))
		currencyInfoNode:runAction(cc.FadeIn:create(0.21))
		line:runAction(cc.FadeIn:create(0.21))
		self._rightFuncLayout:getChildByFullName("extraActBtn"):runAction(cc.FadeIn:create(0.21))
	end)
	self._menuStateBtn:setOpacity(0)
	self._menuStateBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.6)))

	local activityBtn = self._urlFuncLayout:getChildByFullName("activityBtn")
	local unlock, tips = self._systemKeeper:isUnlock("ActivityCalendar")

	performWithDelay(self:getView(), function()
		activityBtn:setVisible(unlock)

		local winSize = cc.Director:getInstance():getWinSize()

		self._urlFuncLayout:setPositionX(winSize.width)

		if unlock then
			local var_49_0 = self._urlFuncLayoutNode1:getPositionX()

			if not var_49_0 then
				var_49_0 = self._urlFuncLayoutNode2:getPositionX()

				local targetX = var_49_0

				self._urlFuncLayout:setOpacity(0)
				self._urlFuncLayout:setPositionX(winSize.width)

				local fadeIn = cc.FadeIn:create(0.15)
				local moveTo1 = cc.MoveTo:create(0.15, cc.p(targetX - 50, self._urlFuncLayout:getPositionY()))
				local moveTo2 = cc.MoveTo:create(0.05, cc.p(targetX, self._urlFuncLayout:getPositionY()))
				local action = cc.Sequence:create(cc.Spawn:create(fadeIn, moveTo1), moveTo2)

				self._urlFuncLayout:runAction(action)
			end
		end
	end, 0.1)
	mainMovieClip:gotoAndPlay(0)
	self:showCoopTips(nodes[5])
end

function HomeMediator:checkNewSystemUnlock()
	local blockCoroutine

	blockCoroutine = coroutine.create(function()
		local function resumeCoroutine()
			local status, str = coroutine.resume(blockCoroutine)

			str = str or ""

			assert(status, "系统解锁出错，错误信息为" .. str)
		end

		local delegate = {}

		function delegate:willClose()
			resumeCoroutine()
		end

		if self._developSystem:getLevelupBackup() then
			local dataLv = {}

			function dataLv.callBack()
				resumeCoroutine()
			end

			self._developSystem:popPlayerLvlUpView(dataLv)
			coroutine.yield()
		end

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local level = developSystem:getPlayer():getLevel()

		if not guideAgent:isGuiding() then
			local systems = self._systemKeeper:getUnlockSystemsByType(UnlockAnimView.kHome)

			if systems then
				if self:getView():isVisible() then
					for i = 1, #systems do
						dump(systems[i], "解锁的系统==")

						local targetNode = self:getNewSyatemTarget(systems[i])
						local targetPos = cc.p(0, 0)
						local view = self:getInjector():getInstance("NewSystemView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							targetPos = (targetNode or nil) and targetNode:getParent():convertToWorldSpace(cc.p(targetNode:getPosition())),
							systemData = systems[i],
							type = UnlockAnimView.kHome
						}, delegate))
						coroutine.yield(systems[i].Id)
					end
				end
			end
		end

		if GameConfigs.closeGuide or not guideAgent:isGuiding() and level > 1 then
			if CommonUtils.GetSwitch("fn_announce_check_in") and self._loginSystem:getLoginUrl() and self._loginSystem:getIsShowAnnounce() then
				local delegate = {}

				function delegate:willClose(popupMediator, data)
					if popupMediator.resetData then
						popupMediator:resetData()
					end

					resumeCoroutine()
				end

				local view = self:getInjector():getInstance("serverAnnounceViewNew")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					isDeductTime = 1
				}, delegate))
				coroutine.yield()
			end

			if self._activitySystem:isReturnActivityShow() and not self._activitySystem:isReturnLetterDraw() then
				self._activitySystem:tryEnterActivityLetter(delegate)
				coroutine.yield()
			end

			if CommonUtils.GetSwitch("fn_check_in") then
				local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

				if not monthSignInSystem:isTodaySign() then
					monthSignInSystem:showSignView(delegate)
					coroutine.yield()
				end
			end

			local activity = self._activitySystem:getActivityByComplexUI(ActivityType_UI.KActivityBlockHoliday)

			if activity then
				local supportActivityId = activity:getActivityConfig().ActivitySupport
				local supportActivity = self._activitySystem:getActivityById(supportActivityId)

				if supportActivity then
					local status = supportActivity:getPeriodStatus()

					if status == ActivitySupportStatus.Starting then
						local playerId = self:getDevelopSystem():getPlayer():getRid()
						local lastTime = cc.UserDefault:getInstance():getStringForKey(playerId .. supportActivity:getId(), 0)
						local curTime = self._gameServerAgent:remoteTimeMillis()
						local isSameDay = TimeUtil:isSameDay(lastTime / 1000, curTime / 1000, {
							sec = 0,
							min = 0,
							hour = 5
						})

						if not isSameDay then
							local view = self:getInjector():getInstance("ActivitySupportPailianHolidayView")

							self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
								transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
							}, {
								activityId = supportActivity:getId()
							}, delegate))
							cc.UserDefault:getInstance():setStringForKey(playerId .. supportActivity:getId(), curTime)
							coroutine.yield()
						end
					end
				end
			end
		end
	end)

	local status, str = coroutine.resume(blockCoroutine)

	str = str or ""

	assert(status, "主角升级弹窗出错,错误信息为" .. str)
end

function HomeMediator:setupCurrencyInfoWidget()
	local currencyInfoNode = self:getView():getChildByFullName("currencyinfo_node")
	local config = {
		CurrencyIdKind.kDiamond,
		CurrencyIdKind.kPower,
		CurrencyIdKind.kCrystal,
		CurrencyIdKind.kGold
	}
	local injector = self:getInjector()

	self._currencyInfoWidget = injector:injectInto(CurrencyInfoWidget:new(currencyInfoNode))

	self._currencyInfoWidget:mapEvent()
	self._currencyInfoWidget:updateCurrencyInfo(config)
end

function HomeMediator:initWidget()
	self._leftFuncLayout = self:getView():getChildByFullName("mLeftFuncLayout")
	self._rightFuncLayout = self:getView():getChildByFullName("mRightFuncLayout")
	self._bottomFuncLayout = self:getView():getChildByFullName("mBottomFuncLayout")
	self._topFuncLayout = self:getView():getChildByFullName("mTopFuncLayout")
	self._homePanel = self:getView():getChildByName("mHomePanel")
	self._showHeroPanel = self._homePanel:getChildByName("heroPanel")
	self._menuStateBtn = self:getView():getChildByName("unfoldMenuBtn")

	self._menuStateBtn:getChildByName("redPoint"):setLocalZOrder(100)

	self._fastGetResourceExBtn = self._menuStateBtn:getChildByName("fastGetResourceExBtn")
	self._urlFuncLayout = self:getView():getChildByFullName("URLAdjustNode.URLLayout")
	self._urlFuncLayoutNode1 = self:getView():getChildByFullName("URLAdjustNode.Node1")
	self._urlFuncLayoutNode2 = self:getView():getChildByFullName("URLAdjustNode.Node2")
	self._homeBgPanel = self:getView():getChildByFullName("homeBgPanel")

	local wonderfulAct = self._rightFuncLayout:getChildByFullName("wonderfulAct")

	AdjustUtils.adjustLayoutByType(wonderfulAct, AdjustUtils.kAdjustType.Right)

	local onArena1Btn = self._rightFuncLayout:getChildByFullName("mArena1Node")

	wonderfulAct:setPosition(cc.p(onArena1Btn:getPositionX() - 150, onArena1Btn:getPositionY() - 20))

	local newarenaBtn = self._rightFuncLayout:getChildByFullName("newarenaBtn")

	AdjustUtils.adjustLayoutByType(newarenaBtn, AdjustUtils.kAdjustType.Right)

	local onArena1Btn = self._rightFuncLayout:getChildByFullName("mArena1Node")

	newarenaBtn:setPosition(cc.p(onArena1Btn:getPositionX() - 270, onArena1Btn:getPositionY()))

	local extraActBtn = self._rightFuncLayout:getChildByFullName("extraActBtn")

	AdjustUtils.adjustLayoutByType(extraActBtn, AdjustUtils.kAdjustType.Right)

	local mChallengeNode = self._rightFuncLayout:getChildByFullName("mChallengeNode")

	extraActBtn:setPosition(cc.p(mChallengeNode:getPositionX() - 95, mChallengeNode:getPositionY() - 85))

	self._safeTouchLayout = self:getView():getChildByName("touchPanel")
	self._panelHeroLayout = self:getView():getChildByName("Panel_hero")
	self._setBoardNode = self:getView():getChildByName("Node_setBoard")
	self._boardHeroLayOut = self:getView():getChildByName("Node_setBoard")

	if not self._setBoardNode:getChildByFullName("boardNode") then
		local boardNode = cc.CSLoader:createNode("asset/ui/SetBoardMove.csb")

		boardNode:addTo(self._setBoardNode)
		boardNode:setName("boardNode")
	end

	self:hideShowHeroMove()

	local iconMc = cc.MovieClip:create("baoxiang_jiayuanshouqu")

	iconMc:addTo(self._menuStateBtn, 2, 10026)
	iconMc:setPlaySpeed(0.5)
	iconMc:gotoAndStop(1)
	iconMc:setPosition(cc.p(170, 66))

	local talkPanel = self._homePanel:getChildByName("talkPanel")

	talkPanel:setLocalZOrder(5555)

	local text = talkPanel:getChildByFullName("clipNode.text")

	text:setLineSpacing(4)
	text:getVirtualRenderer():setMaxLineWidth(330)

	local bubbleBg = talkPanel:getChildByName("talkBg")

	self._primeTextPosX = text:getPositionX()
	self._primeTextPosY = text:getPositionY()

	bubbleBg:ignoreContentAdaptWithSize(true)

	local giftPanel = self._homePanel:getChildByName("giftImg")

	giftPanel:setLocalZOrder(5558)

	local function giftPanelFunc()
		giftPanel:setVisible(false)

		local activity = self._activitySystem:getActivityById("FreeStamina")
		local curList = activity:getActivityConfig().FreeStamina
		local timeFragmentIndex = 0

		for i = 1, #curList do
			local status = self._activitySystem:isCanGetStamina(curList[i].Time, curList[i].Order)

			if status == StaminaRewardTimeStatus.kNow then
				timeFragmentIndex = i
			end
		end

		local param = {
			doActivityType = 101,
			index = timeFragmentIndex
		}

		self._activitySystem:requestDoActivity(DailyGift, param, function(response)
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ShowTipEvent({
				tip = Strings:get("Daily_Gift_Get")
			}))
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				needClick = true,
				rewards = response.data.reward
			}))
		end)
	end

	mapButtonHandlerClick(nil, giftPanel, {
		ignoreClickAudio = true,
		func = giftPanelFunc
	})

	local timeShop = self._homePanel:getChildByName("timeShop")

	timeShop:getChildByName("redPoint"):setVisible(self._activitySystem:checkTimeLimitShopRedpointShow())
	timeShop:setLocalZOrder(5557)

	local function timeShopFunc()
		timeShop:getChildByName("redPoint"):setVisible(false)
		self._activitySystem:tryEnterTimeLimitSHop()
	end

	mapButtonHandlerClick(nil, timeShop, {
		ignoreClickAudio = true,
		func = timeShopFunc
	})

	local timeShopTitle = self._homePanel:getChildByFullName("timeShop.title")

	timeShopTitle:getVirtualRenderer():setLineSpacing(-5)
	timeShopTitle:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
	timeShopTitle:getVirtualRenderer():setDimensions(120, 36)

	local lineGradiantVec2 = {
		{
			ratio = 0.75,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.99,
			color = cc.c4b(0, 0, 0, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	timeShopTitle:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	timeShopTitle:setString(Strings:get(self._activitySystem:getFestivalPackageTitle()))
	AdjustUtils.adjustLayoutByType(timeShop, AdjustUtils.kAdjustType.Right)

	local topFoldBtn = self._topFuncLayout:getChildByName("mFoldBtn")
	local mc = cc.MovieClip:create("yincang_xinzhujiemian")

	mc:addTo(topFoldBtn, -1)
	mc:setPosition(25, 15)
	mc:addCallbackAtFrame(16, function()
		topFoldBtn:setTouchEnabled(true)
		mc:stop()
	end)
	mc:addCallbackAtFrame(45, function()
		topFoldBtn:setTouchEnabled(true)
		mc:stop()
	end)
	mc:gotoAndStop(1)

	topFoldBtn.mc = mc

	local function callFunc(sender)
		topFoldBtn:setTouchEnabled(false)

		local mc = sender.mc
		local isOpen = self._navigation:isTopOpen()

		if isOpen then
			mc:gotoAndPlay(30)
			self._navigation:closeTop()
		else
			mc:gotoAndPlay(1)
			self._navigation:openTop()
		end

		local isVisible = self._navigation:checkTopRedPoint()

		sender:getChildByFullName("redPoint"):setVisible(isVisible)

		local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			local bagNode = self._navigation._topLayout:getChildByFullName("mBagNode")
			local bagWorldPos = bagNode:convertToWorldSpace(cc.p(0, 0))

			self._buildingSystem:setBagWorldPos(bagWorldPos)
		end))

		self:getView():runAction(sequence)
	end

	mapButtonHandlerClick(nil, topFoldBtn, {
		ignoreClickAudio = true,
		func = callFunc
	})

	self._navigation = Navigation:new(self._bottomFuncLayout, self._rightFuncLayout, self._leftFuncLayout, self._topFuncLayout, self._urlFuncLayout, self:getInjector())

	callFunc(topFoldBtn)
	performWithDelay(self:getView(), function()
		self._navigation._initDone = true
	end, 0.1)

	if self._dreamActivityTips then
		self._dreamActivityTips:setVisible(false)
		self._dreamActivityTips:stopAllActions()
	end

	if self._cooperateTip then
		self._cooperateTip:setVisible(false)
		self._cooperateTip:stopAllActions()
	end
end

function HomeMediator:setTextAnim()
	local talkPanel = self._homePanel:getChildByName("talkPanel")
	local clipNode = talkPanel:getChildByName("clipNode")
	local text = clipNode:getChildByName("text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function HomeMediator:checkSoundUnlock(heroId, soundId)
	local hero = self._heroSystem:getHeroById(heroId)
	local sound = {}

	sound.config = ConfigReader:getRecordById("Sound", soundId)

	function sound:setUnlock(unlock)
		return
	end

	function sound:getUnlockDesc()
		return self.config.UnlockDesc
	end

	function sound:getUnlockCondition()
		if not self.config.Unlock then
			return self.config.Unlock
		end
	end

	return self._heroSystem:getSoundUnlock(hero, sound)
end

function HomeMediator:setBoardHeroEffectState(isEnable, isEnterHome)
	local talkPanel = self._homePanel:getChildByName("talkPanel")
	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._showHeroId)

	if isEnable and not isHide then
		if not self._boardHeroEffect then
			self._boardHeroEffect = PREPARESTATE

			performWithDelay(talkPanel, function()
				local soundId = isEnterHome and AudioTimerSystem:getLoginAndEnterHomeSound(self._showHeroId) or AudioTimerSystem:getResumeHomeSound(self._showHeroId, self._climateDay)
				local text = talkPanel:getChildByFullName("clipNode.text")

				talkPanel:setVisible(true)
				text:stopAllActions()
				text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

				local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc"))

				text:setString(str)
				self:setTextAnim()

				self._boardHeroEffect = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
					self._boardHeroEffect = nil

					if checkDependInstance(self) then
						talkPanel:setVisible(false)
					end
				end)
			end, 1)
		end
	else
		if self._boardHeroEffect then
			if self._boardHeroEffect == PREPARESTATE then
				talkPanel:stopAllActions()
			else
				AudioEngine:getInstance():stopEffect(self._boardHeroEffect)
			end

			self._boardHeroEffect = nil
		end

		talkPanel:setVisible(false)
	end
end

function HomeMediator:changeHomeViewBg()
	local isRandom = self._settingSystem:getSettingModel():getRoleAndBgRandom()

	if isRandom then
		return
	end

	self._homeViewBgId = self._settingSystem:getHomeBgId()

	self:loadBgImageTab()
end

function HomeMediator:loadBgImageTab()
	local bgImageId = self._homeViewBgId
	local timeTable = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "Loop")

	self._switchBgTab = formatUnorderTable(timeTable, function(a, b)
		local aParts = string.split(a, ":", nil, true)
		local bParts = string.split(b, ":", nil, true)
		local aStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = aParts[1],
			min = aParts[2],
			sec = aParts[3]
		})
		local bStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = bParts[1],
			min = bParts[2],
			sec = bParts[3]
		})

		return aStamp < bStamp
	end)
	self._switchBgTag = -999

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local pointId = "S01S01"
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)

	local point = stageSystem:getPointById(pointId)
	local level = developSystem:getPlayer():getLevel()
	local complexNum = storyAgent:getGuideComplexNum()

	if level == 1 and point and not point:isPass() and complexNum == kGuideComplexityList.none then
		-- block empty
	else
		local BGM = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "BGM")

		AudioEngine:getInstance():playBackgroundMusic(BGM)
		self._settingModel:setBGMusicId(BGM)
	end
end

function HomeMediator:loadBgImage()
	local curTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local switchBgTag = #self._switchBgTab

	local function comp(switchTime, realTime)
		local parts = string.split(switchTime, ":", nil, true)
		local switchTimeStemp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = parts[1],
			min = parts[2],
			sec = parts[3]
		})

		return switchTimeStemp <= realTime
	end

	for k, v in ipairs(self._switchBgTab) do
		if not comp(self._switchBgTab[k], curTimeStamp) then
			switchBgTag = k - 1

			break
		end
	end

	if switchBgTag < 1 then
		switchBgTag = #self._switchBgTab
	end

	if switchBgTag == self._switchBgTag then
		return
	end

	local bgImage = self._homeBgPanel:getChildByName("bgImage")
	local flashPanel = self._homeBgPanel:getChildByName("bgFlashPanel")

	flashPanel:removeAllChildren()

	self._climateMc = nil

	bgImage:setVisible(false)

	self._switchBgTag = switchBgTag

	local timeTable = ConfigReader:getDataByNameIdAndKey("HomeBackground", self._homeViewBgId, "Loop")
	local tabValue = timeTable[self._switchBgTab[self._switchBgTag]]
	local BGBackgroundId = tabValue.BG
	local imageInfo = ConfigReader:getRecordById("BackGroundPicture", BGBackgroundId)
	local winSize = cc.Director:getInstance():getWinSize()

	if imageInfo.Picture and imageInfo.Picture ~= "" then
		bgImage:setVisible(true)
		bgImage:ignoreContentAdaptWithSize(true)
		bgImage:loadTexture("asset/scene/" .. imageInfo.Picture .. ".jpg")

		if winSize.height < 641 then
			bgImage:setScale(winSize.width / 1386 * 1.2)
		end
	end

	local flashId = imageInfo.Flash1

	if flashId and flashId ~= "" then
		local mc = cc.MovieClip:create(flashId)

		mc:addTo(flashPanel):center(flashPanel:getContentSize())

		self._mainBgMc = mc

		self:setClimateScene()

		if winSize.height < 641 then
			mc:setScale(winSize.width / 1386 * 1.2)
		end

		local extFlashId = imageInfo.Flash2

		if extFlashId and extFlashId ~= "" then
			local extMc = cc.MovieClip:create(extFlashId)

			if extMc then
				extMc:addTo(flashPanel):center(flashPanel:getContentSize())
				extMc:setScale(winSize.width / 1386 * 1.2)
			end
		end
	end

	if imageInfo.Extra and imageInfo.Extra ~= "" then
		local extraView = cc.CSLoader:createNode("asset/ui/" .. imageInfo.Extra .. ".csb")

		extraView:addTo(flashPanel):center(flashPanel:getContentSize())

		if winSize.height < 641 then
			extraView:setScale(winSize.width / 1386 * 1.2)
		end
	end
end

function HomeMediator:setClimateScene()
	if self._climateMc then
		self._climateMc:removeFromParent()

		self._climateMc = nil
	end

	if self._homeViewBgId == "HomeBackground_4" then
		self._climateDay = self._climateDay == ClimateType.Snow and ClimateType.SnowS or ClimateType.Snow
	else
		local weathData = self._settingModel:getWeatherData()

		self._climateDay = GameStyle:getClimateById(weathData.conditionIdDay)
	end

	dump(self._climateDay, "今日天气为：")

	if Climate2LayerName[self._climateDay] and self._mainBgMc then
		local layer = self._mainBgMc:getChildByName(Climate2LayerName[self._climateDay])

		if layer then
			local climateMc = cc.MovieClip:create(Climate2MCName[self._climateDay])

			climateMc:addTo(layer)

			self._climateMc = climateMc
		end
	end
end

function HomeMediator:setBoardHeroSprite()
	self._touchTimes = 0

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._showHeroId)
	local hero = self._heroSystem:getHeroById(self._showHeroId)
	local surfaceId

	if hero then
		roleModel = hero:getModel()
		surfaceId = hero:getSurfaceId()
	end

	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel,
		useAnim = self._settingModel:getRoleDynamic()
	})

	if spineani then
		spineani:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)

		self._sharedSpine = spineani
	else
		self._sharedSpine = nil
	end

	self._showHeroPanel:removeChildByTag(690)
	heroSprite:addTo(self._showHeroPanel):setTag(690)
	heroSprite:setPosition(cc.p(160, -70))
	heroSprite:setTouchEnabled(false)

	self._heroSprite = heroSprite
	self._moveHeroSp = self._heroSprite:getChildByFullName("hero")

	if surfaceId then
		local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
		local num = #surfaceData

		for i = 1, num do
			local _info = surfaceData[i]
			local touchPanel = ccui.Layout:create()

			touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

			local point = _info.point
			local size = heroSprite:getContentSize()

			if point[1] == "all" then
				touchPanel:setContentSize(cc.size(size.width, size.height))
				touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
			else
				touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
				touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + size.width / 2, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
			end

			if GameConfigs.HERO_TOUCHVIEW_DEBUG then
				touchPanel:setBackGroundColorType(1)
				touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
				touchPanel:setBackGroundColorOpacity(180)
			end

			touchPanel:setTouchEnabled(true)
			touchPanel:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					if self._sharedSpine and self._sharedSpine:hasAnimation(_info.action) then
						self._sharedSpine:playAnimation(0, _info.action, true)
					end

					self._touchTimes = self._touchTimes + 1

					if self._touchTimes >= 1 then
						self:openBoardHeroButton(self._touchTimes)
					end

					if self._boardHeroEffect then
						return
					end

					local soundId = AudioTimerSystem:getHeroTouchSoundByPart(self._showHeroId, _info.part, self._touchTimes)
					local isExistStr = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "CueName"))
					local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
					local isHide = table.indexof(HideVoice, self._showHeroId)

					if isExistStr and isExistStr ~= "Voice_Default" and not isHide then
						local talkPanel = self._homePanel:getChildByName("talkPanel")
						local text = talkPanel:getChildByFullName("clipNode.text")

						talkPanel:setVisible(true)
						text:stopAllActions()
						text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

						local trueSoundId

						self._boardHeroEffect, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
							self._boardHeroEffect = nil

							if checkDependInstance(self) then
								talkPanel:setVisible(false)
							end
						end)

						local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc"))

						text:setString(str)
						self:setTextAnim()

						self._lastClickSound = soundId
					end
				end
			end)
			touchPanel:addTo(heroSprite, num + 1 - i)
		end
	end

	self:setShowHeroMoveView()
end

function HomeMediator:openBoardHeroButton(times)
	local afkBtn = self._homePanel:getChildByName("afkBtn")

	afkBtn:stopAllActions()
	afkBtn:setVisible(true)
	performWithDelay(afkBtn, function()
		afkBtn:setVisible(false)
	end, 5)

	if times == 1 then
		self._showHeroPanel:stopAllActions()
		performWithDelay(self._showHeroPanel, function()
			self._touchTimes = 0
		end, 600)
	end
end

function HomeMediator:spineAnimEvent(event)
	if event.type == "complete" and event.animation ~= "animation" and self._sharedSpine then
		if event.animation == spineTouchEventName then
			spineTouchEventTag = false
		end

		self._sharedSpine:playAnimation(0, "animation", true)
	end
end

function HomeMediator:initActivityBanner()
	local view = self._urlFuncLayout:getChildByName("pageView")

	self._animName = {}

	local delegate, outself = {}, self

	function delegate:getPageNum()
		return #outself._animName
	end

	function delegate:getPageByIndex(index)
		return outself:getPageByIndex(index)
	end

	function delegate:pageTouchedAtIndex(index)
		outself:viewTouchEvent(index)
	end

	local data = {
		view = view,
		delegate = delegate
	}

	self:setPageViewIndicator()

	self._flipView = PageViewUtil:new(data)

	self._flipView:reloadData()
	self:enableBannerTimer()
end

function HomeMediator:enableBannerTimer()
	if self._bannerTimer then
		self._bannerTimer:stop()

		self._bannerTimer = nil
	end

	if #self._animName > 1 then
		local function bannerTimer()
			self._flipView:scrollToDirection(1, 1)
		end

		self._bannerTimer = LuaScheduler:getInstance():schedule(bannerTimer, 5, false)
	end
end

function HomeMediator:setPageViewIndicator()
	self._animName = self._homeSystem:getBannerAct()

	local pageTipPanel = self._urlFuncLayout:getChildByName("pageTipPanel")
	local Image_1 = self._urlFuncLayout:getChildByName("Image_1")
	local pageView = self._urlFuncLayout:getChildByName("pageView")

	pageTipPanel:removeAllChildren()

	local width = 0

	for i = 1, #self._animName do
		local img = ccui.ImageView:create("miam_qh_2.png", 1)

		img:setAnchorPoint(cc.p(0.5, 0.5))
		img:setTag(i)
		img:addTo(pageTipPanel)
		img:setPosition(cc.p((img:getContentSize().width + 8) * (i - 1), pageTipPanel:getContentSize().height / 2))

		width = img:getContentSize().width * i
	end

	pageTipPanel:setContentSize(cc.size(width, 50))
	pageTipPanel:setVisible(#self._animName ~= 0)
	Image_1:setVisible(#self._animName ~= 0)
	pageView:setVisible(#self._animName ~= 0)
end

function HomeMediator:reloadPageView()
	self:setPageViewIndicator()
	self._flipView:reloadData()
	self:enableBannerTimer()
	self:refreshPushPackageView()
end

function HomeMediator:getPageByIndex(index)
	local animData = self._animName[index]
	local pageView = self._urlFuncLayout:getChildByName("pageView")
	local layout = ccui.Layout:create()

	layout:setName("mainLayout")
	layout:setAnchorPoint(cc.p(0, 0))
	layout:setPosition(cc.p(0, 0))
	layout:setContentSize(pageView:getContentSize())

	if not animData then
		return layout
	end

	local image = animData.bannerInfo.Img
	local pageTipPanel = self._urlFuncLayout:getChildByName("pageTipPanel")
	local image = ccui.ImageView:create("asset/ui/mainScene/" .. image, ccui.TextureResType.localType)

	image:setScale(0.8)
	image:addTo(layout):center(layout:getContentSize())

	for i = 1, #self._animName do
		local image = i == index and "miam_qh_1.png" or "miam_qh_2.png"

		pageTipPanel:getChildByTag(i):loadTexture(image, ccui.TextureResType.plistType)
	end

	return layout
end

function HomeMediator:viewTouchEvent(index)
	local animData = self._animName[index]
	local bannerInfo = animData.bannerInfo
	local bannerType = bannerInfo.Type

	if bannerType == ActivityBannerType.kPackageShop then
		local model = animData.model
		local view = self:getInjector():getInstance("ShopView")
		local shopId = "Shop_Timelimitedmall"
		local data = {
			shopId = shopId
		}

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))

		local view = self:getInjector():getInstance("ShopPackageView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopId = shopId,
			item = model
		}))
	elseif bannerType == ActivityBannerType.kActivity then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local url = bannerInfo.Link
		local param = {}

		self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
			url = url,
			extParams = param
		}))
	elseif bannerType == ActivityBannerType.kCooperateBoss then
		self._cooperateSystem:enterCooperateBoss()
	end
end

function HomeMediator:setupPlayerInfoWidget()
	local playInfoNode = self:getView():getChildByFullName("playerNode")

	self._playInfoWidget = self:getInjector():injectInto(PlayerInfoWidget:new(playInfoNode))

	self._playInfoWidget:initSubviews()
	self._playInfoWidget:setupView()
end

function HomeMediator:registerHomeViewEvent()
	self:loadBgImage()

	local function callFunc()
		local isActivity = self._activitySystem:hasRedPointForActivity(DailyGift)
		local giftImg = self._homePanel:getChildByName("giftImg")

		if isActivity then
			giftImg:setVisible(true)

			if not self._refreshGiftRed then
				self:refreshRedPoint()

				self._refreshGiftRed = true
			end
		else
			giftImg:setVisible(false)

			self._refreshGiftRed = false
		end

		local isShow = self._activitySystem:checkTimeLimitShopShow()
		local timeShop = self._homePanel:getChildByName("timeShop")
		local timeShopAnimNode = timeShop:getChildByName("anim")

		timeShopAnimNode:removeAllChildren()

		if isShow then
			self:enableTimeLimitShopTimer()
			timeShop:setVisible(true)

			local timeShop = self._homePanel:getChildByName("timeShop")

			timeShop:getChildByName("redPoint"):setVisible(self._activitySystem:checkTimeLimitShopRedpointShow())

			local timeShopTitle = self._homePanel:getChildByFullName("timeShop.title")

			timeShopTitle:setString(Strings:get(self._activitySystem:getFestivalPackageTitle()))

			local mc = cc.MovieClip:create("eff_zong_xianshilibaorukoueff")

			mc:addTo(timeShopAnimNode)
		else
			timeShop:setVisible(false)
		end

		self:loadBgImage()
	end

	self._playInfoWidget:registerTimerEvent(callFunc)
	schedule(self:getView(), function()
		local soundId = AudioTimerSystem:getSixtySecendSoundId(self._showHeroId)
		local talkPanel = self._homePanel:getChildByName("talkPanel")

		talkPanel:setVisible(true)

		local text = talkPanel:getChildByFullName("clipNode.text")

		text:stopAllActions()
		text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))

		local str = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc"))

		text:setString(str)

		ResidentSoundID = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			if checkDependInstance(self) then
				talkPanel:setVisible(false)
			end

			ResidentSoundID = nil
		end)
	end, 600)
	performWithDelay(self:getView(), function()
		self:setBoardHeroEffectState(true)
	end, 900)
end

function HomeMediator:onMenuStateChange(sender, eventType)
	self._buildingSystem:tryEnter()
end

function HomeMediator:onClickComplexBtn(ui)
	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._activitySystem:tryEnterComplexMainView(ui)
end

function HomeMediator:onChatBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	local data = {}
	local view = self:getInjector():getInstance("chatMainView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function HomeMediator:onFriendBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local friendSystem = self:getInjector():getInstance(FriendSystem)

	friendSystem:tryEnter({})
end

function HomeMediator:onRankBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local rankSystem = self:getInjector():getInstance(RankSystem)

	rankSystem:tryEnter()
end

function HomeMediator:onDownloadBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	if self._settingSystem:canDownloadPortrait() then
		self._settingSystem:downloadPortrait()
	elseif self._settingSystem:canDownloadSoundCV() then
		self._settingSystem:downloadSoundCV()
	end
end

function HomeMediator:onMailBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local function getDataSucc()
		local view = self:getInjector():getInstance("MailView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}, nil)

		self:dispatch(event)
	end

	self._mailSystem:requestGetMailList(true, getDataSucc)
end

function HomeMediator:onPassBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	self._passSystem:showMainPassView()
end

function HomeMediator:onYxqBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	if SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:openYxq()
	end
end

function HomeMediator:onClickGameAnnounce(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	if CommonUtils.GetSwitch("fn_announce_check_in") then
		local view = self:getInjector():getInstance("serverAnnounceViewNew")
		local delegate = {}

		function delegate:willClose(popupMediator, data)
			popupMediator:resetData()
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			isDeductTime = 0
		}, delegate))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroStory_Team_UI1")
		}))
	end
end

function HomeMediator:onRechargeBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Fold_1", false)

	local rechargeView = self:getInjector():getInstance("rechargeMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, rechargeView, nil, {
		tabType = 1
	}))
end

function HomeMediator:onGalleryBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		local gallerySystem = self:getInjector():getInstance("GallerySystem")

		gallerySystem:tryEnter()
	end
end

function HomeMediator:onShopBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	local unlock, unlockTips = self._systemKeeper:isUnlock("Shop_Unlock")

	if unlock then
		self._shopSystem:tryEnter({
			shopId = ShopSpecialId.kShopRecommend
		})
	else
		self:dispatch(ShowTipEvent({
			tip = unlockTips
		}))
	end
end

function HomeMediator:onRewardBtn(sender, type, model)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	local view = self:getInjector():getInstance("ShopView")
	local shopId = "Shop_Timelimitedmall"
	local data = {
		shopId = shopId
	}

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))

	local view = self:getInjector():getInstance("ShopPackageView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		shopId = shopId,
		item = model
	}))
end

function HomeMediator:onActivity1Btn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Fold_1", false)

		local view = self:getInjector():getInstance("eightDayLoginView")
		local params = {}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, params, nil, nil))
	end
end

function HomeMediator:onActivity2Btn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

	local unlock, unlockTips = self._systemKeeper:isUnlock("Activity")

	if unlock then
		self._activitySystem:tryEnter()
	else
		self:dispatch(ShowTipEvent({
			tip = unlockTips
		}))
	end
end

function HomeMediator:onExploreBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		sender:setTouchEnabled(false)
		AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)

		local node = self._rightBtns.mExploreNode
		local mainMc = node.iconMovieClip
		local mc = cc.MovieClip:create("dh_jinruzhuxian")

		mc:addTo(self:getView())
		mc:setPosition(cc.p(1000, 260))

		local mainPanel = mc:getChildByName("main")

		mainMc:changeParent(mainPanel)
		mc:gotoAndStop(0)

		local transition = {}

		function transition:runTransitionAnimation(topNode, coverNode, endCallFunc)
			if not coverNode then
				endCallFunc()

				return
			end

			topNode:setVisible(false)

			local pushViewNode

			for k, v in pairs(topNode:getChildren()) do
				pushViewNode = v

				break
			end

			pushViewNode:setOpacity(0)

			local layerColor = ccui.Layout:create()

			layerColor:setContentSize(cc.size(1386, 852))
			layerColor:setBackGroundColorType(1)
			layerColor:setBackGroundColor(cc.c3b(0, 0, 0))
			layerColor:setBackGroundColorOpacity(255)
			layerColor:setTouchEnabled(true)
			layerColor:addTo(topNode)

			local bgColor = ccui.Layout:create()

			bgColor:setContentSize(cc.size(1386, 852))
			bgColor:setBackGroundColorType(1)
			bgColor:setBackGroundColor(cc.c3b(0, 0, 0))
			bgColor:setBackGroundColorOpacity(255)
			bgColor:addTo(topNode, -1)
			mc:addCallbackAtFrame(45, function()
				topNode:setVisible(true)

				local posX, posY = pushViewNode:getPosition()

				pushViewNode:setPosition(posX + 100, posY)
				pushViewNode:runAction(cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(posX, posY)), cc.FadeIn:create(0.3)))
				layerColor:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function()
					layerColor:setBackGroundColorOpacity(0)
					bgColor:removeFromParent(true)
				end)))
			end)
			mc:addCallbackAtFrame(57, function()
				mc:stop()
				mc:removeFromParent(true)
				layerColor:removeFromParent(true)

				local fixedMc = node.movieClip

				fixedMc:gotoAndStop(0)

				local iconView = cc.MovieClip:create("baoshi_lingxingbaoshi")

				iconView:setPosition(cc.p(0, 0))

				node.iconMovieClip = iconView

				fixedMc:getChildByName("Icon"):addChild(iconView)
				sender:setTouchEnabled(true)
				endCallFunc()
			end)
			mc:gotoAndPlay(24)
		end

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, self:getInjector():getInstance("CommonStageMainView"), {
			transition = transition
		}, {}))
	end
end

function HomeMediator:onArena1Btn(sender, type)
	if type == ccui.TouchEventType.ended then
		local unlock, tips = self._systemKeeper:isUnlock("Arena_All")

		if not unlock then
			self:dispatch(ShowTipEvent({
				tip = tips
			}))

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local view = self:getInjector():getInstance("FunctionEntranceView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			style = 1,
			title = Strings:get("FUNCTION_ENTRANCE_TITLE2")
		})

		self:dispatch(event)
	end
end

function HomeMediator:onChallengeBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		local unlock, tips = self._systemKeeper:isUnlock("BlockSp_All")

		if not unlock then
			self:dispatch(ShowTipEvent({
				tip = tips
			}))

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local view = self:getInjector():getInstance("EntranceGodhandView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil)

		self:dispatch(event)
	end
end

function HomeMediator:onOpenWorldBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local exploreSystem = self:getInjector():getInstance(ExploreSystem)

		exploreSystem:tryEnter()
	end
end

function HomeMediator:onGuildBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	local unlock, unlockTips = self._systemKeeper:isUnlock("Club_System")

	if unlock then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local clubSystem = self:getInjector():getInstance(ClubSystem)

		clubSystem:tryEnter()
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = unlockTips
		}))
	end
end

function HomeMediator:onBackFlowBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		self._activitySystem:tryEnterActivityReturn()
	end
end

function HomeMediator:onRecruitHeroBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		local recruitSystem = self:getInjector():getInstance("RecruitSystem")

		recruitSystem:tryEnter()

		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local pointFirstPassCheck1 = customDataSystem:getValue(PrefixType.kGlobal, "M02S01_FirstPassState", "false")
		local pointFirstPassCheck2 = customDataSystem:getValue(PrefixType.kGlobal, "M03S04_FirstPassState", "false")

		if pointFirstPassCheck1 == "true" then
			customDataSystem:setValue(PrefixType.kGlobal, "M02S01_FirstPassState", "false")
		end

		if pointFirstPassCheck2 == "true" then
			customDataSystem:setValue(PrefixType.kGlobal, "M03S04_FirstPassState", "false")
		end
	end
end

function HomeMediator:onPackageBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		dump("onPackageBtn >>>>>>>>>")
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local bagView = self:getInjector():getInstance("BagView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, bagView, nil))
	end
end

function HomeMediator:onCardsGroupBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local unlock, tips = self._systemKeeper:isUnlock("Hero_Group")

		if not unlock then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))

			return
		end

		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

		customDataSystem:setValue(PrefixType.kGlobal, "StageTeamRed", "0")

		local view = self:getInjector():getInstance("StageTeamView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	end
end

function HomeMediator:onDigimonBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local view = self:getInjector():getInstance("HeroShowListView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))

		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local pointFirstPassCheck1 = customDataSystem:getValue(PrefixType.kGlobal, "S02S02_FirstPassState", "false")
		local pointFirstPassCheck2 = customDataSystem:getValue(PrefixType.kGlobal, "M03S02_FirstPassState", "false")

		if pointFirstPassCheck1 == "true" then
			customDataSystem:setValue(PrefixType.kGlobal, "S02S02_FirstPassState", "false")
		end

		if pointFirstPassCheck2 == "true" then
			customDataSystem:setValue(PrefixType.kGlobal, "M03S02_FirstPassState", "false")
		end
	end
end

function HomeMediator:onLeadBtn(sender, type)
	if type ~= ccui.TouchEventType.ended then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local masterSystem = self._developSystem:getMasterSystem()

	masterSystem:tryEnter()
end

function HomeMediator:onTaskBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local taskSystem = self:getInjector():getInstance("TaskSystem")

		taskSystem:tryEnter()
	end
end

function HomeMediator:onMazeBtn(sender, type)
	if type == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local mazeSystem = self:getInjector():getInstance("MazeSystem")

		mazeSystem:tryEnter()
	end
end

function HomeMediator:initButtons(config)
	self._leftBtns = {}
	self._bottomBtns = {}
	self._topBtns = {}
	self._rightBtns = {}

	local language = getCurrentLanguage()

	for layout, nodes in pairs(config) do
		for node, controls in pairs(nodes) do
			local btn = self:getView():getChildByFullName(layout .. "." .. node)

			if layout == "mLeftFuncLayout" then
				self._leftBtns[node] = btn
			elseif layout == "mTopFuncLayout" then
				self._topBtns[node] = btn
			elseif layout == "mBottomFuncLayout" then
				self._bottomBtns[node] = btn
			elseif layout == "mRightFuncLayout" then
				self._rightBtns[node] = btn
			end

			if node == "mDownNode" then
				self._downloadBtn = btn
			end

			if node == "mYxqNode" then
				self._yxqBtn = btn
			end

			for name, infos in pairs(controls) do
				local fullName = layout .. "." .. node .. "." .. name

				if name == "mBtn" then
					if node == "mYxqNode" then
						local ccsbutton = self:getView():getChildByFullName(fullName)

						if SDKHelper and SDKHelper:isEnableSdk() and SDKHelper:readCacheValue("showYxq") then
							local url = SDKHelper:readCacheValue("yxqIcon")

							if url then
								local function onImageLoaded(ccsbutton, image, infos, success, texture)
									if success and texture and ccsbutton and not tolua.isnull(ccsbutton) then
										local texturePath = texture:getPath()

										if texturePath then
											ccsbutton:loadTextureNormal(texturePath, ccui.TextureResType.localType)
											ccsbutton:loadTexturePressed(texturePath, ccui.TextureResType.localType)
										else
											ccsbutton:loadTextureNormal(texture, ccui.TextureResType.userDataType)
											ccsbutton:loadTexturePressed(texture, ccui.TextureResType.userDataType)
										end

										local normal = ccui.ImageView:create(infos.normal, ccui.TextureResType.userDataType)

										ccsbutton:setContentSize(normal:getContentSize())
										ccsbutton:setScale(0.6)
									else
										ccsbutton:loadTextureNormal(infos.normal, ccui.TextureResType.userDataType)
										ccsbutton:loadTexturePressed(infos.press, ccui.TextureResType.userDataType)

										local normal = ccui.ImageView:create(infos.normal, ccui.TextureResType.userDataType)

										ccsbutton:setContentSize(normal:getContentSize())
										ccsbutton:setScale(0.6)
										print("Failed to load image from URL:", url)
									end
								end

								local function loadImageToButton(ccsbutton, image, infos, url)
									if string.find(url, "http://") == 1 or string.find(url, "https://") == 1 then
										local xhr = cc.XMLHttpRequest:new()

										xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
										xhr.timeout = 10

										xhr:open("GET", url)

										local function onReadyStateChange()
											if xhr.readyState == 4 then
												if xhr.status >= 200 and xhr.status < 207 then
													local filePath = cc.FileUtils:getInstance():getWritablePath() .. "temp_yxq_icon_" .. tostring(math.random(10000)) .. ".png"
													local file = io.open(filePath, "wb")

													if file then
														file:write(xhr.response)
														file:close()
														cc.Director:getInstance():getTextureCache():addImageAsync(filePath, function(texture)
															local loadSuccess = texture ~= nil

															onImageLoaded(ccsbutton, image, infos, loadSuccess, texture)
															os.remove(filePath)
														end)
													else
														print("Failed to open file for writing.")
														onImageLoaded(ccsbutton, image, infos, false, nil)
													end
												else
													print("HTTP request failed with status code: " .. xhr.status)
													onImageLoaded(ccsbutton, image, infos, false, nil)
												end
											end
										end

										xhr:registerScriptHandler(onReadyStateChange)
										xhr:send()
									else
										local texture = cc.Director:getInstance():getTextureCache():addImage(url)

										onImageLoaded(ccsbutton, image, infos, texture ~= nil, texture)
									end
								end

								loadImageToButton(ccsbutton, image, infos, url)
							else
								ccsbutton:loadTextureNormal(infos.normal, ccui.TextureResType.userDataType)
								ccsbutton:loadTexturePressed(infos.press, ccui.TextureResType.userDataType)
								ccsbutton:setContentSize(image:getContentSize())
								ccsbutton:setScale(0.6)
							end
						else
							ccsbutton:loadTextureNormal(infos.normal, ccui.TextureResType.userDataType)
							ccsbutton:loadTexturePressed(infos.press, ccui.TextureResType.userDataType)

							local normal = ccui.ImageView:create(infos.normal, ccui.TextureResType.userDataType)

							ccsbutton:setContentSize(normal:getContentSize())
							ccsbutton:setScale(0.6)
						end
					else
						local ccsbutton = self:getView():getChildByFullName(fullName)
						local image = ccui.ImageView:create(infos.normal, ccui.TextureResType.userDataType)

						ccsbutton:loadTextureNormal(infos.normal, ccui.TextureResType.userDataType)
						ccsbutton:loadTexturePressed(infos.press, ccui.TextureResType.userDataType)
						ccsbutton:setContentSize(image:getContentSize())

						if layout == "mTopFuncLayout" then
							ccsbutton:setScale(0.5)
						end
					end
				elseif name == "mFunc" then
					local func = self[infos]
					local touchLayer = self:getView():getChildByFullName(layout .. "." .. node .. ".mTouchLayer")

					if touchLayer then
						touchLayer:addTouchEventListener(function(sender, eventType)
							func(self, sender, eventType)
						end)
					else
						local btn = self:getView():getChildByFullName(layout .. "." .. node .. ".mBtn")

						btn:addTouchEventListener(function(sender, eventType)
							func(self, sender, eventType)
						end)
					end
				elseif name == "redPointFunc" then
					local func = self._homeSystem[infos]
					local redPointNode = btn:getChildByName("mRedSprite")

					btn.redPoint = RedPoint:new(redPointNode, nil, function()
						return func(self._homeSystem)
					end)
				elseif name == "redPointPos" then
					local redPointNode = btn:getChildByName("mRedSprite")

					redPointNode:setPosition(infos)
				elseif name == "mMovieClip" then
					local movieClipNode = self:getView():getChildByFullName(fullName)
					local movieClip = cc.MovieClip:create(infos.name)

					movieClip:addCallbackAtFrame(30, function()
						movieClip:stop()
					end)
					movieClip:stop()
					movieClip:addTo(movieClipNode):center(movieClipNode:getContentSize()):setName(infos.name)

					local node = self:getView():getChildByFullName(layout .. "." .. node)

					node.movieClip = movieClip

					if infos.pos then
						convertNodeToWorldSpaceWithPos(node, infos.pos)
					end

					AdjustUtils.adjustLayoutByType(node, AdjustUtils.kAdjustType.Right)
				elseif name == "mLabel" then
					local mLabel = self:getView():getChildByFullName(fullName)
					local mLabelName = mLabel:getChildByName("mLabelName")

					mLabelName:setString(Strings:get(infos.mLabelNames))
					mLabelName:setFontSize(infos.fontSize)

					local mTempName = mLabel:getChildByName("mTempName")

					mTempName:setString(Strings:get(infos.mTempName))

					local image = mLabel:getChildByName("autoImage")
					local size = image:getContentSize()

					if infos.autoImageW then
						if not infos.autoImageW then
							local setWidth = size.width

							if infos.autoImageH then
								if not infos.autoImageH then
									local setHeight = size.height

									image:setContentSize(cc.size(setWidth, setHeight))

									if language ~= GameLanguageType.CN then
										if infos.mLabelNames == "Home_Adventure" then
											mLabelName:setContentSize(cc.size(97, 64))
											mLabelName:setFontSize(infos.fontSize - 12)
										else
											mLabelName:setContentSize(cc.size(97, 32))
											mLabelName:setFontSize(infos.fontSize - 4)
										end

										mLabelName:setPositionY(30)
									end

									local parentMc = self:getView():getChildByFullName(layout .. "." .. node).movieClip

									if parentMc then
										local mcPanel = parentMc:getChildByName("mBtnName")

										mLabel:changeParent(mcPanel):posite(mcPanel:getContentSize().width / 2 + ((language ~= GameLanguageType.CN or nil) and 10), mcPanel:getContentSize().height / 2)
									end
								end
							end
						end
					end
				elseif name == "mTempName" then
					local tempNameText = self:getView():getChildByFullName(fullName)

					assert(tempNameText ~= nil, "error:templName=" .. fullName .. " not found")
					tempNameText:setString(Strings:get(infos))

					if language ~= GameLanguageType.CN then
						tempNameText:setFontSize(12)
					end
				elseif name == "mLabelName" then
					local nameLabel = self:getView():getChildByFullName(fullName)

					nameLabel:setString(Strings:get(infos))
					nameLabel:enableOutline(cc.c4b(53, 37, 69, 191.25), 1)

					if language ~= GameLanguageType.CN then
						nameLabel:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
					end
				elseif name == "mLabelNames" then
					local nameLabel = self:getView():getChildByFullName(fullName)

					nameLabel:setString(Strings:get(infos))
				elseif name == "mLabelNames_2" then
					local nameLabel = self:getView():getChildByFullName(fullName)

					nameLabel:setString(Strings:get(infos))
				elseif name == "mLangDesc" then
					local mLangDesc = self:getView():getChildByFullName(fullName)

					mLangDesc:setString(infos)
				elseif name == "drawNodePos" then
					local touchLayer = self:getView():getChildByFullName(layout .. "." .. node .. ".mTouchLayer")

					if touchLayer and next(infos) then
						local shape = ccui.HittingPolygon:create(infos)

						touchLayer:setHittingShape(shape)
					end
				end
			end
		end
	end
end

function HomeMediator:getNewSyatemTarget(data)
	local var_147_0 = {
		Friend_Entrance = self._topBtns.mFriendNode,
		BlockSp_Entrance = self._rightBtns.mChallengeNode,
		BlockSp_Gold = self._rightBtns.mChallengeNode,
		BlockSp_Crystal = self._rightBtns.mChallengeNode,
		BlockSp_Exp = self._rightBtns.mChallengeNode,
		Arena_System = self._rightBtns.mArena1Node,
		KOF = self._rightBtns.mArena1Node,
		Stage_Practice = self._rightBtns.mChallengeNode,
		Elite_Block = self._rightBtns.mExploreNode,
		Draw_Hero = self._rightBtns.mRecruitEquipNode,
		Draw_Equip = self._rightBtns.mRecruitEquipNode,
		Club_System = self._rightBtns.mGuildNode,
		Hero_Gallery = self._leftBtns.mPhotoNode,
		Hero_Quality = self._leftBtns.mServantNode,
		Hero_Skill = self._leftBtns.mServantNode,
		Hero_StarUp = self._leftBtns.mServantNode,
		Hero_Soul = self._bottomBtns.mServantNode,
		Hero_LevelUp = self._leftBtns.mServantNode,
		Equip_LevelUp = self._leftBtns.mServantNode,
		Task_System = self._leftBtns.mTaskNode,
		Task_Achievement = self._leftBtns.mTaskNode,
		MainTask = self._leftBtns.mTaskNode,
		GrowTask = self._leftBtns.mTaskNode,
		DailyQuest = self._leftBtns.mTaskNode,
		Shop_Mystery = self._leftBtns.mShopNode,
		Shop_Groceries = self._leftBtns.mShopNode,
		Master_Auras = self._leftBtns.mLeadNode,
		Master_Equip = self._leftBtns.mLeadNode,
		Master_Core = self._leftBtns.mLeadNode,
		Master_StarUp = self._leftBtns.mLeadNode,
		Master_Skill = self._leftBtns.mLeadNode,
		Hero_Gift = self._leftBtns.mPhotoNode,
		Hero_Sound = self._leftBtns.mServantNode,
		Hero_Group = self._rightBtns.mCardsGroupNode,
		Equip_StarUp = self._leftBtns.mServantNode,
		Map_Explore = self._rightBtns.mChallengeNode,
		Unlock_Tower_1 = self._rightBtns.mChallengeNode,
		Crusade = self._rightBtns.mChallengeNode
	}

	var_147_0.Village_Building = self:getView():getChildByFullName("unfoldMenuBtn.Image_156")

	local config = var_147_0

	return config[data.Id]
end

function HomeMediator:setupClickEnvs(sta)
	if GameConfigs.closeGuide then
		return
	end

	if sta or self._setupClickEnvs then
		self._setupClickEnvs = true
	else
		return
	end

	if self._activitySystem:isReturnActivityShow() and not self._activitySystem:isReturnLetterDraw() then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local targetNode_4 = self._rightBtns.mCardsGroupNode

	storyDirector:setClickEnv("home.cardsGroup_btn", targetNode_4, function(sender, eventType)
		self:onCardsGroupBtn(sender, eventType)
	end)

	local sequence = cc.Sequence:create(cc.DelayTime:create(1.2), cc.CallFunc:create(function()
		local targetNode_1 = self._leftBtns.mTaskNode

		storyDirector:setClickEnv("home.task_btn", targetNode_1, function(sender, eventType)
			self:onTaskBtn(sender, eventType)
		end)

		local targetNode_2 = self._rightBtns.mExploreNode

		storyDirector:setClickEnv("home.explore_btn", targetNode_2, function(sender, eventType)
			self:onExploreBtn(sender, eventType)
		end)

		local targetNode_3 = self._rightBtns.mRecruitEquipNode

		storyDirector:setClickEnv("home.recruitEquip_btn", targetNode_3, function(sender, eventType)
			self:onRecruitHeroBtn(sender, eventType)
		end)

		local targetNode_5 = self._leftBtns.mServantNode

		storyDirector:setClickEnv("home.servant_btn", targetNode_5, function(sender, eventType)
			self:onDigimonBtn(sender, eventType)
		end)

		local targetNode_6 = self._rightBtns.mChallengeNode

		storyDirector:setClickEnv("home.challenge_btn", targetNode_6, function(sender, eventType)
			self:onChallengeBtn(sender, eventType)
		end)

		local targetNode_7 = self._leftBtns.mLeadNode

		storyDirector:setClickEnv("home.master_btn", targetNode_7, function(sender, eventType)
			self:onLeadBtn(sender, eventType)
		end)

		local targetNode_8 = self._leftBtns.mPhotoNode

		storyDirector:setClickEnv("home.photo_btn", targetNode_8, function(sender, eventType)
			self:onGalleryBtn(sender, eventType)
		end)

		local targetNode_9 = self._rightBtns.mArena1Node

		storyDirector:setClickEnv("home.arena_btn", targetNode_9, function(sender, eventType)
			self:onArena1Btn(sender, eventType)
		end)

		local targetNode_10 = self._rightBtns.mGuildNode

		storyDirector:setClickEnv("home.guild_btn", targetNode_10, function(sender, eventType)
			self:onGuildBtn(sender, eventType)
		end)

		local targetNode_11 = self._rightBtns.mOpenWorld

		storyDirector:setClickEnv("home.openWorld_btn", targetNode_11, function(sender, eventType)
			self:onOpenWorldBtn(sender, eventType)
		end)

		local targetNode_12 = self._rightBtns.mLabyrinth

		storyDirector:setClickEnv("home.mLabyrinth_btn", targetNode_12, function(sender, eventType)
			self:onLabyrinthBtn(sender, eventType)
		end)

		local targetNode_13 = self:getView():getChildByFullName("unfoldMenuBtn")

		storyDirector:setClickEnv("home.village_btn", targetNode_13, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Home_1", false)
			self:onMenuStateChange(sender, eventType)
		end)

		local targetNode_14 = self._rightFuncLayout:getChildByFullName("mActivity2Node")

		storyDirector:setClickEnv("home.activity", targetNode_14, function(sender, eventType)
			local activitySystem = self:getInjector():getInstance(ActivitySystem)

			activitySystem:tryEnter({
				id = "__DaySign__"
			})
		end)

		local targetNode_15 = self._navigation._topLayout:getChildByFullName("mMailNode")

		storyDirector:setClickEnv("home.mail", targetNode_15, function(sender, eventType)
			self:onMailBtn(sender, eventType)
		end)
		storyDirector:notifyWaiting("enter_home_view")
	end))

	self:getView():runAction(sequence)
	self._homeSystem:triggerNewerGuide()
	self:setupGuideAnim()
	self:getView():runAction(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_home_view_init")
	end))
end

function HomeMediator:setupGuideAnim()
	if GameConfigs.closeGuide then
		if self._circleAnim then
			self._circleAnim:removeFromParent(true)

			self._circleAnim = nil
		end

		return
	end

	local stageSystem = self:getInjector():getInstance(StageSystem)
	local targetNode = self._rightBtns.mExploreNode
	local pointId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_EndBlockPoint", "content") or "M03S06"
	local point = stageSystem:getPointById(pointId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	local ownHeroList = self._heroSystem:getOwnHeroIds()
	local tscriptNames = "guide_ToTeamOption"
	local guideSaved = guideAgent:isSaved(tscriptNames)

	if not guideAgent:isGuiding() and not guideSaved and #ownHeroList > 3 and maxTeamPetNum > 3 then
		guideAgent:trigger(tscriptNames, nil, nil)
	end

	if self._circleAnim then
		if point:isPass() then
			self._circleAnim:removeFromParent(true)

			self._circleAnim = nil
		elseif guideAgent:isGuiding() then
			self._circleAnim:setVisible(false)
		elseif not guideAgent:isGuiding() then
			self._circleAnim:setVisible(true)
		end
	elseif not guideAgent:isGuiding() and targetNode and point and not point:isPass() then
		local animNode = cc.Node:create()

		animNode:addTo(targetNode):center(targetNode:getContentSize()):offset(0, 0)

		local circleAnim = cc.MovieClip:create("anim_xinyindaoguangquan")

		circleAnim:addTo(animNode):center(animNode:getContentSize()):offset(0, 0)

		local handAnim = cc.MovieClip:create("xiaoshou_xinshouyindao")

		handAnim:addTo(animNode):center(animNode:getContentSize()):offset(5, -5)

		local handNode = handAnim:getChildByName("handNode")

		if handNode then
			local image = ccui.ImageView:create("xsyd_shou.png", ccui.TextureResType.plistType)

			image:addTo(handNode)
		end

		self._circleAnim = animNode
	end
end

function HomeMediator:refreshRedPoint()
	for _, v in pairs(self._leftBtns) do
		local _redPointNode = v.redPoint

		if _redPointNode then
			_redPointNode:refresh()
		end
	end

	for _, v in pairs(self._topBtns) do
		local _redPointNode = v.redPoint

		if _redPointNode then
			_redPointNode:refresh()
		end
	end

	for _, v in pairs(self._bottomBtns) do
		local _redPointNode = v.redPoint

		if _redPointNode then
			_redPointNode:refresh()
		end
	end

	for _, v in pairs(self._rightBtns) do
		local _redPointNode = v.redPoint

		if _redPointNode then
			_redPointNode:refresh()
		end
	end

	self:checkExtraRedPoint()

	for _, v in pairs(self._btns) do
		local _redPointNode = v.redPoint1

		if _redPointNode then
			_redPointNode:refresh()
		end
	end
end

function HomeMediator:passiveRefreshRedPoint(event)
	local data = event:getData().type

	if data and data == 1 then
		local btn = self._topBtns.mMailNode

		btn.redPoint:refresh()
	elseif data and data == 2 then
		local btn = self._topBtns.mFriendNode
		local redPointState = event:getData().showRedPoint

		if redPointState and redPointState == 1 then
			local redPointNode = btn:getChildByName("mRedSprite")

			redPointNode:setVisible(true)
		else
			btn.redPoint:refresh()
		end
	elseif data and data == 3 then
		local btn = self._rightBtns.mArena1Node

		btn.redPoint:refresh()
	elseif data and data == 4 then
		local btn = self._rightBtns.mGuildNode
		local redPointState = event:getData().showRedPoint

		if redPointState == 1 then
			btn:getChildByName("mRedSprite"):setVisible(true)
		elseif redPointState == -1 then
			btn:getChildByName("mRedSprite"):setVisible(false)
		end

		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local playerClubId = self._clubSystem:getClubId()

		customDataSystem:setValue(PrefixType.kGlobal, "clubId", playerClubId, false)
	elseif data and data == 5 then
		local btn = self._topBtns.mRankNode

		if btn and btn.redPoint then
			btn.redPoint:refresh()
		end
	end

	local topFoldBtn = self._topFuncLayout:getChildByName("mFoldBtn")
	local isVisible = self._navigation:checkTopRedPoint()

	topFoldBtn:getChildByFullName("redPoint"):setVisible(isVisible)
end

function HomeMediator:setShowHero(event)
	local data = event:getData()
	local setHeroId = data.heroId
	local isRandom = self._settingSystem:getSettingModel():getRoleAndBgRandom()

	if isRandom then
		return
	end

	self._showHeroId = setHeroId

	self:setBoardHeroSprite()
end

function HomeMediator:setShowHeroMoveViewVis()
	self._setBoardNode:setVisible(true)
	self._safeTouchLayout:setVisible(true)
	self._panelHeroLayout:setVisible(true)
	self._safeTouchLayout:setSwallowTouches(true)
end

function HomeMediator:setShowHeroMoveView()
	self._scaleRange = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroBoard_ScaleRange", "content")

	local node = self._setBoardNode:getChildByFullName("boardNode")

	self._slider = node:getChildByFullName("Slider_1")

	local function callback(sender, eventType)
		self._localPos = {
			0,
			0
		}
		self._localScale = 1

		self:updateShowHeroMoveView()
	end

	mapButtonHandlerClick(nil, node:getChildByFullName("Button_huanyuan"), {
		func = callback
	})

	local function callback(sender, eventType)
		local targetPos = cc.p(self._moveHeroSp:getPositionX() - self._originPos[1], self._moveHeroSp:getPositionY() - self._originPos[2])

		self._homeSystem:setBordHeroPos(self._showHeroId, targetPos.x, targetPos.y, self._nowScale)
		self:hideShowHeroMove()
	end

	mapButtonHandlerClick(nil, node:getChildByFullName("Button_OK"), {
		func = callback
	})

	local function callback(sender, eventType)
		local info = self._homeSystem:getBordHeroPos(self._showHeroId)

		self._localScale = info[3]
		self._localPos = {
			info[1],
			info[2]
		}

		self:updateShowHeroMoveView()
		self:hideShowHeroMove()
	end

	mapButtonHandlerClick(nil, node:getChildByFullName("Button_Cancel"), {
		func = callback
	})
	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)
	self._panelHeroLayout:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._isOnOwn = false
			self._touchBeganPos = sender:getTouchBeganPosition()
		elseif eventType == ccui.TouchEventType.moved then
			local beganPos = sender:getTouchBeganPosition()
			local movedPos = sender:getTouchMovePosition()

			self._isDrag = self._isDrag or self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				self:changeMovingPos(movedPos)
			end
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			if self._isDrag then
				self._targetPos = cc.p(self._panelHeroLayout:getPosition())
			end

			self._isDrag = false
		end
	end)
	self._moveHeroSp:setAnchorPoint(cc.p(0.5, 0.5))

	local s = self._moveHeroSp:getScale()
	local size = self._moveHeroSp:getContentSize()

	self._moveHeroSp:setPosition(cc.p(self._moveHeroSp:getPositionX() + size.width * s / 2, self._moveHeroSp:getPositionY() + size.height * s / 2))

	self._originScale = self._moveHeroSp:getScale()
	self._originPos = {
		self._moveHeroSp:getPositionX(),
		self._moveHeroSp:getPositionY()
	}

	self._moveHeroSp:setAnchorPoint(cc.p(0.5, 0.5))
	self._panelHeroLayout:setAnchorPoint(cc.p(0.5, 0.5))

	local info = self._homeSystem:getBordHeroPos(self._showHeroId)

	self._localScale = info[3]
	self._localPos = {
		info[1],
		info[2]
	}

	self._moveHeroSp:setPosition(cc.p(self._originPos[1] + self._localPos[1], self._originPos[2] + self._localPos[2]))
	self._moveHeroSp:setScale(self._originScale * self._localScale)

	local size = self._moveHeroSp:getContentSize()

	size.width = size.width * self._originScale
	size.height = size.height * self._originScale

	self._panelHeroLayout:setContentSize(size)
	self._panelHeroLayout:setScale(self._localScale)

	local targetPos = self._moveHeroSp:getParent():convertToWorldSpace(cc.p(self._moveHeroSp:getPosition()))

	self._targetPos = self._panelHeroLayout:getParent():convertToNodeSpace(targetPos)

	self._panelHeroLayout:setPosition(cc.p(self._targetPos))

	local minScale = self._scaleRange[1]
	local maxScale = self._scaleRange[2]
	local total = maxScale - minScale

	self._slider:setPercent((self._localScale - minScale) / total * 100)
	self:onSliderChanged()
end

function HomeMediator:onSliderChanged(event)
	local per = self._slider:getPercent() / 100
	local minScale = self._scaleRange[1]
	local maxScale = self._scaleRange[2]
	local total = maxScale - minScale
	local nowScale = per * total + minScale

	self._nowScale = nowScale

	self._panelHeroLayout:setScale(nowScale)
	self._moveHeroSp:setScale(self._originScale * nowScale)
	self:updateShowHeroMoveViewText()
end

function HomeMediator:updateShowHeroMoveView()
	local node = self._setBoardNode:getChildByFullName("boardNode")
	local posText = node:getChildByFullName("Text_2")
	local scaleText = node:getChildByFullName("Text_2_0")

	self._moveHeroSp:setPosition(cc.p(self._originPos[1] + self._localPos[1], self._originPos[2] + self._localPos[2]))

	local targetPos = self._moveHeroSp:getParent():convertToWorldSpace(cc.p(self._moveHeroSp:getPosition()))

	self._targetPos = self._panelHeroLayout:getParent():convertToNodeSpace(targetPos)

	self._panelHeroLayout:setPosition(cc.p(self._targetPos))

	local minScale = self._scaleRange[1]
	local maxScale = self._scaleRange[2]
	local total = maxScale - minScale

	self._slider:setPercent((self._localScale - minScale) / total * 100)
	self:onSliderChanged()
end

function HomeMediator:updateShowHeroMoveViewText()
	local node = self._setBoardNode:getChildByFullName("boardNode")
	local posText = node:getChildByFullName("Text_2")
	local scaleText = node:getChildByFullName("Text_2_0")
	local x = self._moveHeroSp:getPositionX() - self._originPos[1]
	local y = self._moveHeroSp:getPositionY() - self._originPos[2]

	posText:setString(Strings:get("Hero_setBoard_UI3", {
		Num = math.floor(x) .. "," .. math.floor(y)
	}))
	scaleText:setString(Strings:get("Hero_setBoard_UI4", {
		Num = self._nowScale * 100 .. "%"
	}))
end

function HomeMediator:changeMovingPos(pos)
	local xOffset = pos.x - self._touchBeganPos.x
	local yOffset = pos.y - self._touchBeganPos.y
	local xTar = self._targetPos.x + xOffset
	local yTar = self._targetPos.y + yOffset
	local tarPos = cc.p(xTar, yTar)

	self._panelHeroLayout:setPosition(tarPos)

	local targetPos = self._panelHeroLayout:getParent():convertToWorldSpace(cc.p(self._panelHeroLayout:getPosition()))
	local targetPos = self._moveHeroSp:getParent():convertToNodeSpace(targetPos)

	self._moveHeroSp:setPosition(cc.p(targetPos))
	self:updateShowHeroMoveViewText()
end

function HomeMediator:hideShowHeroMove()
	self._setBoardNode:setVisible(false)
	self._safeTouchLayout:setVisible(false)
	self._panelHeroLayout:setVisible(false)

	self._localScale = self._panelHeroLayout:getScale()
end

function HomeMediator:checkTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg1 = math.deg((math.atan(yOffset / xOffset)))
		local dragDeg2 = math.deg((math.atan(xOffset / yOffset)))

		if dragDeg1 > 30 or dragDeg2 > 30 then
			return true
		end
	end

	return false
end

function HomeMediator:mailRedPoint()
	local mailSystem = self:getInjector():getInstance(MailSystem)

	return mailSystem:queryRedPointState()
end

function HomeMediator:rankRedPoint()
	local rankSystem = self:getInjector():getInstance(RankSystem)

	return rankSystem:getRewardRedPoint()
end

function HomeMediator:friendRedPoint()
	local friendSystem = self:getInjector():getInstance(FriendSystem)

	return friendSystem:queryRedPointState()
end

function HomeMediator:activityRedPoint()
	local st = self._activitySystem:getHomeRedPointSta()
	local movieClipNode = self:getView():getChildByFullName("mRightFuncLayout.mActivity2Node.mMovieClip.huodong_xinzhujiemian")

	movieClipNode:addCallbackAtFrame(10, function()
		movieClipNode:getChildByName("guang"):setVisible(st)
	end)

	return st
end

function HomeMediator:firstRechargeRedPoint()
	local player = self:getDevelopSystem():getPlayer()
	local rechargeState = player:getFirstRecharge()

	if rechargeState == 1 then
		return true
	else
		return false
	end
end

function HomeMediator:arenaRedPoint()
	local unlock = self._systemKeeper:isUnlock("Arena_All")

	if not unlock then
		return false
	end

	local arenaSystem = self:getInjector():getInstance(ArenaSystem)
	local petRaceSystem = self:getInjector():getInstance(PetRaceSystem)
	local coopBoss = self:getInjector():getInstance(CooperateBossSystem)
	local leadStageArena = self:getInjector():getInstance(LeadStageArenaSystem)

	return arenaSystem:checkAwardRed() or petRaceSystem:redPointShow() or coopBoss:redPointShow() or leadStageArena:checkShowRed()
end

function HomeMediator:exploreRedPoint()
	local exploreSystem = self:getInjector():getInstance(ExploreSystem)

	return exploreSystem:checkIsShowRedPoint()
end

function HomeMediator:heroRedPoint()
	local heroSystem = self._developSystem:getHeroSystem()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local pointFirstPassCheck1 = customDataSystem:getValue(PrefixType.kGlobal, "S02S02_FirstPassState", "false")
	local pointFirstPassCheck2 = customDataSystem:getValue(PrefixType.kGlobal, "M03S02_FirstPassState", "false")

	return pointFirstPassCheck1 == "true" or pointFirstPassCheck2 == "true" or heroSystem:checkIsShowRedPoint()
end

function HomeMediator:teamRedPoint()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Group")

	if not unlock then
		return false
	end

	local stageSystem = self:getInjector():getInstance(StageSystem)

	return stageSystem:checkIsShowRedPoint()
end

function HomeMediator:recruitRedPoint()
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local pointFirstPassCheck1 = customDataSystem:getValue(PrefixType.kGlobal, "M02S01_FirstPassState", "false")
	local pointFirstPassCheck2 = customDataSystem:getValue(PrefixType.kGlobal, "M03S04_FirstPassState", "false")

	return pointFirstPassCheck1 == "true" or pointFirstPassCheck2 == "true" or recruitSystem:checkIsShowRedPoint()
end

function HomeMediator:taskRedPoint()
	local taskSystem = self:getInjector():getInstance(TaskSystem)

	return taskSystem:checkIsShowRedPoint()
end

function HomeMediator:galleryRedPoint()
	local gallerySystem = self:getInjector():getInstance(GallerySystem)

	return gallerySystem:checkIsShowRedPoint()
end

function HomeMediator:shopRedPoint()
	return self._shopSystem:getRedPoint()
end

function HomeMediator:bagRedPoint()
	local bagSystem = self:getInjector():getInstance(BagSystem)

	return bagSystem:isBagRedPointShow()
end

function HomeMediator:challengeRedPoint()
	local spStageSystem = self:getInjector():getInstance(SpStageSystem)
	local stagePracticeSystem = self:getInjector():getInstance(StagePracticeSystem)
	local crusadeSystem = self:getInjector():getInstance(CrusadeSystem)
	local dreamSystem = self:getInjector():getInstance(DreamChallengeSystem)

	return spStageSystem:checkIsShowRedPoint() or stagePracticeSystem:checkAwardRed() or crusadeSystem:canCrusadeSweep() or dreamSystem:checkIsShowRedPoint()
end

function HomeMediator:onMainChapterRedPoint()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	return stageSystem:hasHomeRedPoint()
end

function HomeMediator:masterRedPoint()
	local masterSystem = self._developSystem:getMasterSystem()

	return masterSystem:checkIsShowRedPoint()
end

function HomeMediator:onClubRedPoint()
	local clubSystem = self:getInjector():getInstance(ClubSystem)

	return clubSystem:hasHomeRedPoint() or clubSystem:hasHomeActivityRedPoint()
end

function HomeMediator:checkClubRedPoint()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local clubSystem = self._clubSystem
	local clubIdInfo = customDataSystem:getValue(PrefixType.kGlobal, "clubId")
	local playerClubId = clubSystem:getClubId()

	if clubIdInfo ~= playerClubId then
		customDataSystem:setValue(PrefixType.kGlobal, "clubId", playerClubId)

		local clubRedPoint = self._rightBtns.mGuildNode

		clubRedPoint:getChildByName("mRedSprite"):setVisible(true)
	end

	local unlock, unlockTips = self._systemKeeper:isUnlock("Club_System")

	if not unlock then
		local clubRedPoint = self._rightBtns.mGuildNode

		clubRedPoint:getChildByName("mRedSprite"):setVisible(false)
	end

	if self._homeSystem:onClubRedPoint() then
		local clubRedPoint = self._rightBtns.mGuildNode

		clubRedPoint:getChildByName("mRedSprite"):setVisible(true)
	end
end

function HomeMediator:checkExtraRedPoint()
	local buildingRedPoint = self._menuStateBtn:getChildByName("redPoint")
	local hasList = self._buildingSystem:getBuildingQueueNum()
	local isVisible

	if hasList < 1 then
		isVisible = self._buildingSystem:getBuildLvOrBuildSta()

		if isVisible then
			buildingRedPoint:getChildByName("Text_1"):setString(Strings:get("Build_List_Build"))
		end
	elseif self._buildingSystem:getBuildLvOrBuildSta() then
		isVisible = true

		buildingRedPoint:getChildByName("Text_1"):setString(Strings:get("Build_List_Idle"))
	end

	buildingRedPoint:setOpacity(0)

	if isVisible then
		performWithDelay(self:getView(), function()
			buildingRedPoint:runAction(cc.FadeIn:create(0.5))
		end, 0.5)
	end

	local chargeBtn = self:getView():getChildByFullName("URLAdjustNode.URLLayout.btn_2")

	chargeBtn:setVisible(CommonUtils.GetSwitch("fn_first_pay"))

	local unlock, unlockTips = self._systemKeeper:isUnlock("Shop_Unlock")

	if unlock then
		local shopList = self._shopSystem:getPackageList()
		local canBuyPackage = false
		local model

		for _, v in ipairs(shopList) do
			if v._id == firstChargePackId and v._leftCount > 0 then
				canBuyPackage = true
				model = v

				break
			end
		end

		if canBuyPackage then
			local function callFunc()
				local view = self:getInjector():getInstance("ShopView")
				local shopId = "Shop_Timelimitedmall"
				local data = {
					subid = "Shop_Package",
					shopId = shopId
				}

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))

				view = self:getInjector():getInstance("ShopBuyPackageView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					shopId = ShopSpecialId.KShopTimelimitedmall,
					item = model
				}))
			end

			mapButtonHandlerClick(nil, chargeBtn, {
				clickAudio = "Se_Click_Open_1",
				func = callFunc
			})
		else
			chargeBtn:setVisible(false)
		end
	else
		chargeBtn:setVisible(false)
	end

	local extActBtn = self:getView():getChildByFullName("URLAdjustNode.URLLayout.extActivityBtn")

	extActBtn:setVisible(false)

	local activity = self._activitySystem:getActivityByComplexUI(ActivityType_UI.KActivityReZhan)

	if activity and not self._activitySystem:isActivityOver(activity:getId()) then
		extActBtn:setVisible(true)
		mapButtonHandlerClick(nil, extActBtn, {
			func = function(sender, eventType)
				self:onClickComplexBtn(ActivityType_UI.KActivityReZhan)
			end
		})

		local redPoint = extActBtn:getChildByName("redPoint")

		redPoint:setVisible(activity:hasRedPoint())
	end

	extActBtn:setPositionX(chargeBtn:getPositionX())

	if chargeBtn:isVisible() then
		extActBtn:setPositionX(chargeBtn:getPositionX() - 120)
	end
end

function HomeMediator:onReceiveFriendPvpInviteCallback(event)
	local unlock, tips = self._systemKeeper:isUnlock("Friend_PK")

	if not unlock then
		return
	end

	local friendPvpSystem = self:getInjector():getInstance(FriendPvpSystem)
	local data = event:getData()

	if not friendPvpSystem._forbidFriendInvitePop then
		local canPop = friendPvpSystem:checkInvitePop(data)

		if canPop then
			local inviteListPanel = self:getView():getChildByName("friendPvpInvitePanel")

			inviteListPanel:setVisible(true)

			local inviteList = inviteListPanel:getChildByName("inviteList")

			local function closeDelegate()
				local inviteMap = friendPvpSystem:getReceiveInviteMap()

				if table.nums(inviteMap) == 0 then
					inviteList:removeAllItems()
					inviteListPanel:setVisible(false)
				else
					inviteList:doLayout()
				end
			end

			local invitePop = self:getInjector():injectInto(FriendPvpInvitePopWidget:new(closeDelegate))

			invitePop:initView(data)
			inviteList:pushBackCustomItem(invitePop:getView())
		end
	end
end

function HomeMediator:playVedioSprite(showStr)
	self:setBoardHeroEffectState(false)

	local videoSize = cc.size(2436, 1124)
	local offset = -728.84
	local winSize = cc.Director:getInstance():getWinSize()
	local videoSprite = VideoSprite.create("video/welcome.usm", function(instance, eventName, index)
		if eventName == "complete" then
			instance:removeFromParent()

			local disposePanel = self:getView():getChildByName("disposePanel")

			disposePanel:removeFromParent()

			local storyDirector = self:getInjector():getInstance(story.StoryDirector)

			storyDirector:notifyWaiting("exit_home_playVedioSprite")
			self:getView():runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				storyDirector:notifyWaiting("enter_home_view")
			end)))
		elseif eventName == "textShow" then
			local text = ccui.Text:create(showStr, TTF_FONT_FZYH_M, 20)

			text:setTextColor(cc.c3b(101, 78, 118))
			text:addTo(instance):center(videoSize)
			text:setScale(videoSize.height / winSize.height)
			text:offset(0, offset * winSize.height / videoSize.height)
			text:setOpacity(0)
			text:runAction(cc.FadeIn:create(0.5))
		end
	end)
	local bgPanel = ccui.Layout:create()

	bgPanel:setTouchEnabled(true)
	bgPanel:setContentSize(winSize)
	bgPanel:setAnchorPoint(cc.p(0.5, 0.5))
	bgPanel:setPosition(cc.p(568, 320))
	bgPanel:addTo(self:getView())
	bgPanel:setName("disposePanel")
	bgPanel:setBackGroundColorType(1)
	bgPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	videoSprite:addTo(self:getView())
	videoSprite:setContentSize(videoSize)
	videoSprite:addFrameEvent("textShow", 57)
	videoSprite:setScale(winSize.height / videoSize.height)
	videoSprite:setPosition(cc.p(568, 320))
	videoSprite:setLocalZOrder(9999)
end

function HomeMediator:refreshRemainTime(remainTime)
	local str = self._clubSystem:getRemainTime(remainTime)
	local ClubResourcesBattleData = self._clubSystem:getClub():getClubResourcesBattleInfo()

	if ClubResourcesBattleData:getStatus() == "NOTOPEN" or ClubResourcesBattleData:getStatus() == "MATCHING" then
		local timeStr = Strings:get("Club_ResourceBattle_8")

		self._clubResourcesBattleTimeText:setString(timeStr)
	end

	if ClubResourcesBattleData:getStatus() == "OPEN" then
		self._clubResourcesBattleTimeText:setString((remainTime < 0 or nil) and Strings:get("Club_ResourceBattle_14"))
	end

	if ClubResourcesBattleData:getStatus() == "END" then
		local timeStr = Strings:get("Club_ResourceBattle_14")

		self._clubResourcesBattleTimeText:setString(timeStr)
	end
end

function HomeMediator:randomBoardRoleAndBg()
	local isRandom = self._settingSystem:getSettingModel():getRoleAndBgRandom()

	if isRandom then
		local showHeroId, showBGId = self._settingSystem:getRandomShowRoleAndBg()

		self._showHeroId = showHeroId

		self:setBoardHeroSprite()

		self._homeViewBgId = showBGId

		self:loadBgImageTab()
	else
		self:setBoardHeroSprite()
		self:loadBgImageTab()
	end
end

local detectiveBtnName = {
	{
		text = "ActivityBlock_Detective_Name_1",
		fontsize = 20,
		pos = {
			40,
			30
		},
		color = cc.c4b(255, 255, 255, 255)
	},
	{
		text = "ActivityBlock_Detective_Name_2",
		fontsize = 20,
		pos = {
			30,
			10
		},
		color = cc.c4b(255, 255, 255, 255)
	},
	{
		text = "ActivityBlock_Detective_Name_3",
		fontsize = 24,
		pos = {
			65,
			10
		},
		lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 253, 90, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(255, 239, 184, 255)
			}
		}
	}
}

function HomeMediator:setComplexActivityEntry()
	local complexActivityEntryAnim = {
		[ActivityType_UI.kActivityBlockWsj] = {
			anim = "rukou_wanshengjierukou",
			aimpos = cc.p(48, 40),
			redPointFuncx = self._activitySystem.hasRedPointForActivityWsj
		},
		[ActivityType_UI.kActivityBlockSummer] = {
			anim = "rukou_xiarihuodong",
			aimpos = cc.p(40, 40),
			redPointFuncx = self._activitySystem.hasRedPointForActivitySummer
		},
		[ActivityType_UI.kActivityWxh] = {
			anim = "wuxiurukou_wuxiurukou",
			aimpos = cc.p(-34, 125)
		},
		[ActivityType_UI.kActivityBlockZuoHe] = {
			anim = "anniu_rukouyemian",
			aimpos = cc.p(51, 40)
		},
		[ActivityType_UI.kActivityBlock] = {
			img = "hd_rk_fhj.png",
			imgpos = cc.p(50, 43)
		},
		[ActivityType_UI.KActivityBlockSnowflake] = {
			anim = "xuehua-CX_yongbuxiaorongrukou",
			aimpos = cc.p(50, 43)
		},
		[ActivityType_UI.KActivityBlockHoliday] = {
			anim = "rukou_newyearshop",
			aimpos = cc.p(50, 43)
		},
		[ActivityType_UI.KActivityBlockDetetive] = {
			anim = "biao_timeeff",
			aimpos = cc.p(50, 43),
			detectiveBtnName = detectiveBtnName
		},
		[ActivityType_UI.KActivityBlockMusic] = {
			img = "musicfestival_btn_zjm_rukou.png",
			anim = "rukou-CX_yinyuejierukou",
			aimpos = cc.p(55, 43),
			imgpos = cc.p(58, 43)
		},
		[ActivityType_UI.KActivityBlockBaking] = {
			animZorder = 1,
			img = "baking_btn_zjm_rukou.png",
			anim = "hongpeirukou_hongbeidazuozhanrukou",
			imgZorder = 2,
			aimpos = cc.p(55, 43),
			imgpos = cc.p(55, 13)
		},
		[ActivityType_UI.KActivityCollapsed] = {
			animZorder = 1,
			img = "collapsed_btn_zjm_rukou.png",
			anim = "rukou_xigerukou",
			imgZorder = 2,
			aimpos = cc.p(39, 39),
			imgpos = cc.p(56, 22)
		},
		[ActivityType_UI.KActivityKnight] = {
			animZorder = 2,
			img = "knight_btn_zjm_rukou.png",
			anim = "weiguang_qishiweiguang",
			imgZorder = 1,
			aimpos = cc.p(39, 39),
			imgpos = cc.p(46, 35)
		},
		[ActivityType_UI.KActivitySunflower] = {
			animZorder = 1,
			img = "sunflower_btn_zjm_rukou.png",
			anim = "eff_zong_21kedexinfengeff",
			imgZorder = 2,
			aimpos = cc.p(49, 42),
			imgpos = cc.p(53, 10)
		},
		[ActivityType_UI.KActivityFire] = {
			animZorder = 2,
			img = "fire_btn_zjm_rukou.png",
			anim = "eff_rukou_Fire_yewangrukoueff",
			imgZorder = 1,
			aimpos = cc.p(50, 60),
			imgpos = cc.p(40, 60)
		},
		[ActivityType_UI.kActivityZero] = {
			animZorder = 2,
			img = "knight_btn_zjm_rukou.png",
			anim = "weiguang_qishiweiguang",
			imgZorder = 1,
			aimpos = cc.p(39, 39),
			imgpos = cc.p(46, 35)
		},
		[ActivityType_UI.KActivityFemale] = {
			animZorder = 1,
			img = "female_btn_zjm_rukou.png",
			anim = "zhu_biannvshengrukou",
			imgZorder = 2,
			aimpos = cc.p(39, 39),
			imgpos = cc.p(46, 35)
		},
		[ActivityType_UI.KActivityStoryBook] = {
			animZorder = 1,
			img = "storybook_btn_zjm_rukou.png",
			anim = "zhu_beimouzhujiemianrukou",
			imgZorder = 2,
			aimpos = cc.p(39, 39),
			imgpos = cc.p(46, 35)
		},
		[ActivityType_UI.kActivityReZero] = {
			animZorder = 1,
			img = "rezero_btn_zjm_rukou.png",
			anim = "fukou_tubiao_clkaishieff",
			imgZorder = 2,
			aimpos = cc.p(45, 35),
			imgpos = cc.p(46, 35)
		},
		[ActivityType_UI.KActivityDeepSea] = {
			animZorder = 1,
			img = "deepsea_btn_zjm_rukou.png",
			anim = "rukou_shenhaihuodongrukou",
			imgZorder = 2,
			aimpos = cc.p(-90, 125),
			imgpos = cc.p(60, 33)
		},
		[ActivityType_UI.KActivitySummerRe] = {
			anim = "rukou_xiarihuodong",
			aimpos = cc.p(40, 40)
		},
		[ActivityType_UI.KActivityFireWorks] = {
			animZorder = 1,
			img = "fireworks_btn_zjm_rukou.png",
			anim = "eff_Z_zjm_huohuadahuirukou",
			imgZorder = 2,
			aimpos = cc.p(-125, 160),
			imgpos = cc.p(55, 38)
		},
		[ActivityType_UI.KActivityTerror] = {
			animZorder = 1,
			img = "terror_btn_zjm_rukou.png",
			anim = "eff_rukoutexiao_kongbubenrukou",
			imgZorder = 2,
			aimpos = cc.p(-90, 125),
			imgpos = cc.p(58, 7)
		},
		[ActivityType_UI.KActivityRiddle] = {
			img = "riddle_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "rukouZ__zhentanduijuerukouzhuye",
			imgZorder = 2,
			aimpos = cc.p(-80, 135),
			imgpos = cc.p(55, 9),
			redpos = cc.p(123, 47)
		},
		[ActivityType_UI.KActivityAnimal] = {
			img = "animal_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "rukou_xinyuanyimiaochangjing",
			imgZorder = 2,
			aimpos = cc.p(-90, 145),
			imgpos = cc.p(60, 20),
			redpos = cc.p(115, 51)
		},
		[ActivityType_UI.KActivityDusk] = {
			img = "dusk_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "ZSrukou_TX_zhushenhuanghunfuben",
			imgZorder = 2,
			aimpos = cc.p(60, 60),
			imgpos = cc.p(65, 25),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivitySilentNight] = {
			img = "silentnight_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "rukou_shengdanzhuyefubenrukou",
			imgZorder = 2,
			aimpos = cc.p(60, 58),
			imgpos = cc.p(65, 50),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivityDrama] = {
			img = "drama_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "rukou_gudianxijufuben",
			imgZorder = 2,
			aimpos = cc.p(60, 60),
			imgpos = cc.p(65, 25),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivityFamily] = {
			img = "family_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "rukou_huijiadeluzhuyefuben",
			imgZorder = 2,
			aimpos = cc.p(60, 55),
			imgpos = cc.p(65, 55),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivityMagic] = {
			animZorder = 1,
			commonAnim = "main_zhujiemiantongyonganniu",
			anim = "main_wuzuizhiyuanniu",
			imgZorder = 2,
			img = "magic_btn_zjm_rukou.png",
			aimpos = cc.p(60, 60),
			imgpos = cc.p(65, 45),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivitySamurai] = {
			img = "samurai_btn_zjm_rukou.png",
			animZorder = 1,
			anim = "main_wujinxia",
			imgZorder = 2,
			aimpos = cc.p(60, 60),
			imgpos = cc.p(65, 45),
			redpos = cc.p(115, 56)
		},
		[ActivityType_UI.KActivitySpring] = {
			img = "spring_btn_zjm_rukou.png",
			animZorder = 3,
			anim = "xuehua_newyearshop",
			imgZorder = 2,
			aimpos = cc.p(60, 60),
			imgpos = cc.p(65, 60),
			redpos = cc.p(115, 60)
		},
		[ActivityType_UI.KActivityEaster] = {
			img = "hd_rk_fhj.png",
			imgpos = cc.p(50, 43)
		}
	}
	local extraActBtn = self._rightFuncLayout:getChildByFullName("extraActBtn")

	extraActBtn:setVisible(false)

	local blockBtn = extraActBtn:getChildByFullName("btn_block")

	blockBtn:setVisible(false)

	local redPoint = blockBtn:getChildByName("redPoint")

	redPoint:setLocalZOrder(999)
	redPoint:setVisible(false)

	local bs = blockBtn:getContentSize()
	local count = 0

	self._btns = self._btns or {}

	local function del()
		for k, v in pairs(self._btns) do
			v:removeFromParent()
		end

		self._btns = {}
	end

	local function create(ui, cfg)
		self._btns[ui] = blockBtn:clone()

		self._btns[ui]:setVisible(true)
		self._btns[ui]:setTouchEnabled(true)
		self._btns[ui]:setSwallowTouches(true)
		self._btns[ui]:addTo(extraActBtn):center(bs)
		mapButtonHandlerClick(nil, self._btns[ui], {
			func = function(sender, eventType)
				self:onClickComplexBtn(ui)
			end
		})

		if cfg.img then
			local img = ccui.ImageView:create(cfg.img, ccui.TextureResType.plistType)

			img:setPosition(cfg.imgpos)
			img:addTo(self._btns[ui])
			img:setLocalZOrder(cfg.imgZorder or 1)
		end

		if cfg.anim then
			local anim = cc.MovieClip:create(cfg.anim)

			anim:gotoAndPlay(1)
			anim:setPosition(cfg.aimpos)
			anim:addTo(self._btns[ui])
			anim:setLocalZOrder(cfg.animZorder or 2)
		end

		if cfg.commonAnim then
			local anim = cc.MovieClip:create(cfg.commonAnim)

			anim:gotoAndPlay(1)
			anim:setPosition(cfg.aimpos)
			anim:addTo(self._btns[ui])
			anim:setLocalZOrder(cfg.animZorder or 2)
		end

		if cfg.detectiveBtnName then
			for i, v in ipairs(cfg.detectiveBtnName) do
				local label = cc.Label:createWithTTF(Strings:get(v.text), TTF_FONT_FZYH_M, v.fontsize)

				label:enableOutline(cc.c4b(0, 0, 0, 255), 1)

				if v.color then
					label:setColor(v.color)
				elseif v.lineGradiantVec2 then
					label:enablePattern(cc.LinearGradientPattern:create(v.lineGradiantVec2, {
						x = 0,
						y = -1
					}))
				end

				label:setPosition(cc.p(v.pos[1], v.pos[2]))
				self._btns[ui]:addChild(label, 3)
			end
		end
	end

	local test = false

	if test then
		del()
	end

	for ui, cfg in pairs(complexActivityEntryAnim) do
		local activity = self._activitySystem:getActivityByComplexUI(ui)

		if activity and not self._activitySystem:isActivityOver(activity:getId()) then
			if not self._btns[ui] then
				create(ui, cfg)
			end

			local activityId = activity:getId()

			self._btns[ui]:setVisible(self._activitySystem:checkConditionWithId(activityId))

			if self._btns[ui]:isVisible() then
				if not cfg.redPointFuncx then
					local redFunc = self._activitySystem.hasRedPointForActivity

					extraActBtn:setVisible(true)

					local function redPointCal()
						return redFunc(self._activitySystem, activityId)
					end

					if not self._btns[ui].redPoint1 then
						local node = RedPoint:createDefaultNode()

						self._btns[ui].redPoint1 = RedPoint:new(node, self._btns[ui], redPointCal)

						node:setPosition(cfg.redpos or cc.p(79, 83)):setScale(0.8)
						node:setLocalZOrder(999)
					end
				end
			end

			self._btns[ui]:setPositionX(blockBtn:getPositionX() - count * (bs.width + 20))

			count = count + 1
		elseif self._btns[ui] then
			self._btns[ui]:removeFromParent()

			self._btns[ui] = nil
		end
	end
end

function HomeMediator:setActivityCalendar()
	local activityDate, actBubbleData = self._homeSystem:getWonderfulActData()
	local wonderfulAct = self._rightFuncLayout:getChildByName("wonderfulAct")
	local activityTalk = self._urlFuncLayout:getChildByFullName("activityBtn.talkBg")
	local activityBtnBunle = self._urlFuncLayout:getChildByFullName("activityBtn.talkBg.talk")

	if activityDate == nil then
		wonderfulAct:setVisible(false)
		activityTalk:setVisible(false)
	else
		wonderfulAct:setVisible(true)
		activityTalk:setVisible(true)
		wonderfulAct:loadTextureNormal(activityDate.Icon .. ".png", ccui.TextureResType.plistType)
		wonderfulAct:loadTexturePressed(activityDate.Icon .. ".png", ccui.TextureResType.plistType)
		wonderfulAct:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local url = activityDate.Link

				self._homeSystem:urlEnter(url)
			end
		end)

		local redPoint = wonderfulAct:getChildByFullName("redPoint")

		if activityDate.Type == "Activity" then
			redPoint:setVisible(self._homeSystem:wonderfulActRedPointShow(activityDate))
		else
			redPoint:setVisible(false)
		end

		self:refreshActivityCalendarRedPoint()
	end

	if not actBubbleData then
		activityTalk:setVisible(false)
	else
		activityTalk:setVisible(true)
	end

	local activityBtn = self._urlFuncLayout:getChildByFullName("activityBtn")
	local unlock, tips = self._systemKeeper:isUnlock("ActivityCalendar")

	if unlock then
		activityBtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local url = "view://ActivityListiew"

				self._homeSystem:urlEnter(url)
			end
		end)

		if actBubbleData and actBubbleData.Bubble and #actBubbleData.Bubble > 0 then
			activityBtnBunle:setString(Strings:get(actBubbleData.Bubble[math.random(1, #actBubbleData.Bubble)]))
		end

		local function nodeSparkle(node, delay1, delay2)
			node:stopAllActions()

			local delay1 = cc.DelayTime:create(delay1)
			local fadeOut = cc.FadeOut:create(0.2)
			local delay2 = cc.DelayTime:create(delay2)
			local fadeIn = cc.FadeIn:create(0.2)
			local changeText = cc.CallFunc:create(function()
				if actBubbleData and actBubbleData.Bubble then
					self._urlFuncLayout:getChildByFullName("activityBtn.talkBg.talk"):setString(Strings:get(self._homeSystem:getActivityCalenderBubble(activityDate.Bubble)))
				end
			end)
			local action = cc.RepeatForever:create(cc.Sequence:create(delay1, fadeOut, changeText, delay2, fadeIn))

			node:runAction(action)
		end

		local delay = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MainPage_BubbleTime", "content")

		nodeSparkle(activityTalk, delay[1], delay[2])
	end
end

function HomeMediator:refreshActivityCalendarRedPoint()
	if not self._activityBtnRedPoint then
		local redPoint = RedPoint:createDefaultNode()

		redPoint:setName("redPoint")
		redPoint:setScale(0.8)
		redPoint:addTo(self._urlFuncLayout:getChildByFullName("activityBtn")):posite(173, 120)
		redPoint:setLocalZOrder(99900)

		self._activityBtnRedPoint = redPoint
	end

	self._activityBtnRedPoint:setVisible(self._activitySystem:isActivityCalendarRedpointShowAll())
end

function HomeMediator:setNewArenaBtn()
	local newarenaBtn = self._rightFuncLayout:getChildByName("newarenaBtn")
	local state = self._homeSystem:getNewArenaRecordVis()

	if state > 0 then
		if not newarenaBtn then
			return
		end

		newarenaBtn:setVisible(true)
		newarenaBtn:removeAllChildren()

		local movieClip = cc.MovieClip:create("eff_rukou_mengjingjichangrukou")

		movieClip:addTo(newarenaBtn):center(newarenaBtn:getContentSize())

		local text = ccui.Text:create(Strings:get("ClassArena_UI38"), TTF_FONT_FZYH_M, 16)

		text:getVirtualRenderer():setMaxLineWidth(380)
		text:addTo(newarenaBtn)
		text:setAnchorPoint(cc.p(0.5, 0.5))
		text:setPosition(43, 22)
		newarenaBtn:addClickEventListener(function()
			self._homeSystem:enterNewArenaRecord(state)
			newarenaBtn:setVisible(false)
		end)
	else
		newarenaBtn:setVisible(false)
	end
end

function HomeMediator:showCoopTips(baseview)
	if not self._coopInviteTip then
		local cooperateTip = baseview:getChildByFullName("coopInviteTip")
		local icon = cc.Sprite:createWithSpriteFrameName("main_img_qipao.png")
		local mengyan = cc.Sprite:create("asset/emotion/mengyan_01.png")

		mengyan:addTo(icon):center(icon:getContentSize()):offset(-22, 10)
		mengyan:setScale(0.24)

		local label = cc.Label:createWithTTF(Strings:get("CooperateBoss_InviteTip"), TTF_FONT_FZYH_R, 18)

		label:setTextColor(cc.c3b(31, 37, 32))
		label:addTo(icon):center(icon:getContentSize()):offset(20, 5)
		label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
		label:setOverflow(cc.LabelOverflow.NONE)
		icon:setName("coopInviteTip")
		icon:setPosition(cc.p(95, 35))
		icon:addTo(baseview)

		self._coopInviteTip = icon
	end

	self._coopInviteTip:stopAllActions()
	self._coopInviteTip:setVisible(false)

	if self._cooperateSystem:getcooperateBossState() == kCooperateBossState.kStart then
		local times = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperationBossBumbleTip", "content") or 30

		local function callback(data)
			if DisposableObject:isDisposed(self) then
				return
			end

			local maps = data.invitedBossIdMap

			if #maps > 0 then
				self._coopInviteTip:stopAllActions()
				self._coopInviteTip:setVisible(true)

				local delayTimeAct = cc.DelayTime:create(times)
				local callFuncAct = cc.CallFunc:create(function()
					self._coopInviteTip:setVisible(false)
				end)
				local action = cc.Sequence:create(delayTimeAct, callFuncAct)

				self._coopInviteTip:runAction(action)

				if not self._coopInviteTimer then
					local bossData = maps[1]
					local bossConfig = ConfigReader:getRecordById("CooperateBossMain", bossData.confId)
					local endTime = bossData.bossCreateTime + bossConfig.Time

					local function checkTimeFunc()
						local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
						local remainTime = endTime - remoteTimestamp

						if remainTime <= 0 then
							if self._coopInviteTimer then
								self._coopInviteTimer:stop()

								self._coopInviteTimer = nil
							end

							self:showCoopTips()
						end
					end

					self._coopInviteTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

					checkTimeFunc()
				end
			end

			self:dispatch(Event:new(EVT_COOPERATE_BOSS_SELF_REFRESH))
		end

		self._cooperateSystem:requestCooperateBossMain(callback)
	end
end

function HomeMediator:refreshPushPackageView()
	local node = self:getView():getChildByFullName("mgiftNode")
	local remainText = node:getChildByFullName("mTempName")
	local touchLayer = node:getChildByFullName("mTouchLayer")

	touchLayer:addClickEventListener(function()
		self._developSystem:showPushPackageView()
	end)

	if self._packagetimer then
		self._packagetimer:stop()

		self._packagetimer = nil
	end

	local function getMinLimit()
		local packageData = self._developSystem:getPushPackageData()
		local curTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
		local pushPackageTimeList = self._developSystem:getPushGiftTimeList()
		local minLimittime, curPackageData

		for k, package in pairs(packageData) do
			local limitTime = pushPackageTimeList[package:getId()]

			if curTimeStamp < limitTime then
				if minLimittime == nil then
					minLimittime = limitTime
					curPackageData = package
				end

				if limitTime < minLimittime then
					minLimittime = limitTime
					curPackageData = package
				end
			end
		end

		return minLimittime, curPackageData
	end

	local minLimit, curPackageData = getMinLimit()

	if minLimit then
		node:setVisible(true)

		if curPackageData then
			touchLayer:removeAllChildren()

			local Price_Box = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Price_Box", "content")
			local kind = Price_Box[tostring(curPackageData:getPrice())]
			local animName = KPushPackageAnimName[kind]
			local anim = RoleFactory:createRoleAnimation(animName)

			anim:setScale(0.4)
			anim:addTo(touchLayer):posite(40, 0)
		end

		local function update()
			local curTime = self._gameServerAgent:remoteTimestamp()
			local remainTime = math.max(minLimit - curTime, 0)
			local fmtStr = "${d}:${HH}:${M}:${SS}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = parts[1]
			timeTab.hour = parts[2]
			timeTab.min = parts[3]
			timeTab.sec = parts[4]

			local str = ""

			str = tonumber(timeTab.day) > 0 and timeTab.day .. ":" .. timeTab.hour or tonumber(timeTab.hour) > 0 and timeTab.hour .. ":" .. timeTab.min .. ":" .. timeTab.sec or tonumber(timeTab.min) > 0 and "00:" .. timeTab.min .. ":" .. timeTab.sec or "00:" .. "00:" .. timeTab.sec

			if remainTime == 0 then
				self:refreshPushPackageView()
			else
				remainText:setString(str)
			end
		end

		self._packagetimer = LuaScheduler:getInstance():schedule(update, 1, false)

		update()
	else
		node:setVisible(false)
	end
end
