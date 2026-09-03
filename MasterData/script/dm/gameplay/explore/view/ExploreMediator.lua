-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMediator.lua

ExploreMediator = class("ExploreMediator", DmAreaViewMediator)

ExploreMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ExploreMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
ExploreMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
ExploreMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	tipBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTip"
	},
	["Panel_base.bottomNode.rankBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRank"
	}
}
local kCellInfo = {
	Lock = {
		anim = "lockIcon_shamoyibian",
		size = cc.size(150, 150)
	},
	UnLock = {
		anim = "unlockIcon_shamoyibian",
		size = cc.size(250, 250)
	}
}

function ExploreMediator:initialize()
	super.initialize(self)
end

function ExploreMediator:dispose()
	self:getView():stopAllActions()
	super.dispose(self)
end

function ExploreMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._bagSystem = self._developSystem:getBagSystem()
end

function ExploreMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_RESET_MAPCOUNT, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_RESET, self, self.resumeWithData)
end

function ExploreMediator:enterWithData(data)
	self:initView()
	self:initData()
	self:updateView()
	self:setupTopInfoWidget()
	self:runStartAction()
	self:checkShowStage(data)
	self:setupClickEnvs()
end

function ExploreMediator:checkShowStage(data)
	if data and data.curGroupId then
		self:getView():stopAllActions()

		local view = self:getInjector():getInstance("ExploreStageView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			mapTypeId = data.curGroupId
		}))
	end
end

function ExploreMediator:resumeWithData()
	self:updateData()
	self:updateView()
	self:updateDailyRewardTimes()
	self:runStartAction()
end

function ExploreMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kPower
		},
		title = Strings:get("EXPLORE_TITLE"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self:updateDailyRewardTimes()

	local tipBtn = self:getView():getChildByFullName("tipBtn")

	tipBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function ExploreMediator:updateDailyRewardTimes()
	local dailyRewardPanel = self:getView():getChildByFullName("dailyRewardPanel")
	local times = self._exploreSystem:getDailyRecommendTimes()
	local mapDailyRewardTime = self._exploreSystem:getMapDailyRewardTime()
	local textLabel = dailyRewardPanel:getChildByFullName("text")
	local timeLabel = dailyRewardPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. mapDailyRewardTime)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)
	textLabel:disableEffect(1)
	timeLabel:disableEffect(1)

	if times <= 0 then
		textLabel:setTextColor(cc.c3b(255, 255, 255))
		timeLabel:setTextColor(cc.c3b(255, 255, 255))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	else
		textLabel:setTextColor(cc.c3b(186, 238, 22))
		timeLabel:setTextColor(cc.c3b(186, 238, 22))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
	end

	local exploreTimesPanel = self:getView():getChildByFullName("exploreTimesPanel")
	local times = self._exploreSystem:getEnterTimes()
	local enterTotalTimes = self._exploreSystem:getEnterTotalTimes()
	local textLabel = exploreTimesPanel:getChildByFullName("text")
	local timeLabel = exploreTimesPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. enterTotalTimes)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		exploreTimesPanel:setPositionX(600)
	end
end

function ExploreMediator:initView()
	self._main = self:getView():getChildByFullName("Panel_base")
	self._mapPanel = self._main:getChildByFullName("mapPanel")

	self._mapPanel:setScrollBarEnabled(false)

	self._rankPanel = self._main:getChildByFullName("bottomNode.rankPanel")
	self._dpLabel = self._rankPanel:getChildByFullName("dpLabel")

	self:setEffect()

	local bgAnim = self._main:getChildByName("bgAnim")

	bgAnim:removeAllChildren()

	local anim = cc.MovieClip:create("stageAnim_shamoyibian")

	anim:addTo(bgAnim)

	self._lineAnim = cc.MovieClip:create("zhixian_shamoyibian")

	self._lineAnim:addTo(bgAnim):posite(0, -28)
	self._lineAnim:addEndCallback(function()
		self._lineAnim:stop()
	end)
	self._lineAnim:setPlaySpeed(1.3)
end

function ExploreMediator:setEffect()
	GameStyle:setCommonOutlineEffect(self._rankPanel:getChildByFullName("text1"), 204)
	self:getView():getChildByFullName("dailyRewardPanel.text"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self:getView():getChildByFullName("dailyRewardPanel.times"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self:getView():getChildByFullName("exploreTimesPanel.text"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	self:getView():getChildByFullName("exploreTimesPanel.times"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
end

function ExploreMediator:initData()
	self._mapIds = self._exploreSystem:getMapPointIds()
	self._pointMap = self._exploreSystem:getPointMap()
	self._mapTypes = self._exploreSystem:getMapTypesOpen()
	self._mapPanels = {}
end

function ExploreMediator:setupView(ignoreAnim)
	self._lineAnim:gotoAndPlay(0)

	local language = getCurrentLanguage()
	local maxPosX = 976
	local hasUnlock = false
	local hasChangePosY = false
	local posX = 0
	local addPosX = 0
	local addPosX1 = 0

	for i = 1, #self._mapTypes do
		local data = self._mapTypes[i]
		local panel = ccui.Widget:create()

		panel:setAnchorPoint(cc.p(0.5, 0.5))
		panel:setSwallowTouches(false)
		panel:setTouchEnabled(true)
		panel:addClickEventListener(function()
			self:onClickBuild(data)
		end)
		panel:addTo(self._mapPanel)

		hasUnlock = not data:getLock()

		if data:getLock() then
			local info = kCellInfo.Lock

			panel:setContentSize(info.size)

			local animNode = cc.MovieClip:create(info.anim)

			animNode:addTo(panel)
			animNode:setPosition(cc.p(info.size.width / 2, info.size.height / 2))
			animNode:addEndCallback(function()
				animNode:gotoAndPlay(28)
			end)
			animNode:setName("AnimNode")
			animNode:setPlaySpeed(1.5)

			local name = cc.Label:createWithTTF(data:getName(), TTF_FONT_FZYH_M, 22)

			name:enableOutline(cc.c4b(35, 15, 5, 255), 1)
			name:setAnchorPoint(cc.p(0, 0.5))
			name:addTo(animNode:getChildByName("name")):posite(-65, 0)

			local lockDesc = cc.Label:createWithTTF(data:getLockTip(), TTF_FONT_FZYH_M, 18)

			lockDesc:enableOutline(cc.c4b(35, 15, 5, 255), 1)
			lockDesc:setAnchorPoint(cc.p(0, 0.5))
			lockDesc:setColor(cc.c3b(191, 191, 191))
			lockDesc:addTo(animNode:getChildByName("lockDesc")):posite(-40, 0)

			local lockImage = ccui.ImageView:create("xlg_bg_suo.png", 1)

			lockImage:addTo(animNode:getChildByName("lockImage")):posite(1, 5)
			name:setOverflow(cc.LabelOverflow.SHRINK)
			name:setDimensions(160, 60)
			name:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
			lockDesc:setOverflow(cc.LabelOverflow.SHRINK)
			lockDesc:setDimensions(200, 30)
			lockDesc:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

			if language ~= GameLanguageType.CN then
				name:setLineSpacing(-8)
			end
		else
			local info = kCellInfo.UnLock

			panel:setContentSize(info.size)

			local animNode = cc.MovieClip:create(info.anim)

			animNode:addTo(panel)
			animNode:setPosition(cc.p(info.size.width / 2, info.size.height / 2))
			animNode:addEndCallback(function()
				animNode:stop()
			end)
			animNode:setName("AnimNode")
			animNode:setPlaySpeed(1.5)

			local buildImg = ccui.ImageView:create(data:getImg())

			buildImg:addTo(animNode:getChildByName("buildImg"))
			buildImg:setPosition(cc.p(0, 0))

			if i == 2 then
				buildImg:setPosition(cc.p(18, 4))
			end

			local name_1 = animNode:getChildByName("name_1")
			local name_2 = animNode:getChildByName("name_2")
			local nameLabel1 = ""
			local nameLabel2 = ""
			local nameLabel3 = ""
			local length = utf8.len(data:getName())

			if language == "en" then
				local charLength = length
				local strs = string.split(data:getName(), " ")
				local length = #strs

				for j = 1, length do
					local num = strs[j]

					if j > 1 and j == length then
						nameLabel2 = nameLabel2 .. num

						if j == length then
							nameLabel3 = utf8.sub(data:getName(), charLength, charLength)
						end
					else
						nameLabel1 = nameLabel1 .. " " .. num
					end
				end

				nameLabel1 = string.trim(nameLabel1)
			else
				for j = 1, length do
					local num = utf8.sub(data:getName(), j, j)

					if j == length - 1 or j == length then
						nameLabel2 = nameLabel2 .. num

						if j == length then
							nameLabel3 = num
						end
					else
						nameLabel1 = nameLabel1 .. num
					end
				end
			end

			local name1 = cc.Label:createWithTTF(nameLabel1, CUSTOM_TTF_FONT_1, 60)

			name1:enableOutline(cc.c4b(35, 15, 5, 255), 1)
			name1:setAnchorPoint(cc.p(0, 0))
			name1:addTo(name_1):posite(-(string.len(nameLabel1) * 10), -30)

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(127, 127, 127, 255)
				}
			}

			name1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))

			local name2 = cc.Label:createWithTTF(nameLabel2, CUSTOM_TTF_FONT_1, 78)

			name2:enableOutline(cc.c4b(35, 15, 5, 255), 1)
			name2:setAnchorPoint(cc.p(0, 0.5))
			name2:addTo(name_2):posite(-50, -6)
			name2:setAdditionalKerning(-15)

			local name3 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 78)

			name3:setAnchorPoint(cc.p(0, 0.5))
			name3:addTo(name_2):posite(40, -6)
			name3:setOpacity(90)

			local name4 = cc.Label:createWithTTF(nameLabel3, CUSTOM_TTF_FONT_1, 78)

			name4:setAnchorPoint(cc.p(0, 0.5))
			name4:addTo(name_2):posite(60, -6)
			name4:setOpacity(50)
			name1:setOverflow(cc.LabelOverflow.SHRINK)
			name1:setDimensions(250, 90)
			name2:setOverflow(cc.LabelOverflow.SHRINK)
			name2:setDimensions(200, 160)
			name3:setOverflow(cc.LabelOverflow.SHRINK)
			name3:setDimensions(200, 160)
			name4:setOverflow(cc.LabelOverflow.SHRINK)
			name4:setDimensions(200, 160)

			if language == GameLanguageType.FR or language == GameLanguageType.TH or language == GameLanguageType.ES or language == GameLanguageType.DE then
				name1:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
				name1:setAnchorPoint(cc.p(0.5, 0))
				name1:posite(50, -6)
				name2:setLineSpacing(-30)
				name2:setAdditionalKerning(-10)
			elseif language ~= GameLanguageType.CN then
				name2:setLineSpacing(-30)
				name2:setAdditionalKerning(-10)

				if i == 2 then
					name3:posite(#nameLabel2 * 28, -6)
					name4:posite(#nameLabel2 * 28 + 10, -6)
				else
					name3:posite(#nameLabel2 * 23, -6)
					name4:posite(#nameLabel2 * 23 + 10, -6)
				end
			end
		end

		panel:getChildByName("AnimNode"):gotoAndStop(0)

		if hasUnlock then
			if addPosX1 == 0 then
				addPosX1 = -80
				posX = posX + -80
			end

			posX = posX + 300

			panel:setPosition(cc.p(posX, 297))
		else
			if addPosX == 0 then
				addPosX = 100
				posX = posX + 100
			end

			hasChangePosY = not hasChangePosY
			posX = posX + 147

			local posY = hasChangePosY and 368 or 217

			panel:setPosition(cc.p(posX, posY))
		end

		self._mapPanels[#self._mapPanels + 1] = panel
		maxPosX = math.max(maxPosX, posX)
	end

	self._mapPanel:setInnerContainerSize(cc.size(maxPosX + 260, 640))
end

function ExploreMediator:updateData()
	self._mapIds = self._exploreSystem:getMapPointIds()
	self._pointMap = self._exploreSystem:getPointMap()
	self._mapTypes = self._exploreSystem:getMapTypesOpen()
end

function ExploreMediator:updateView()
	self._mapPanel:removeAllChildren()
	self:setupView()

	local totalDp = self._developSystem:getPlayer():getExplore():getTotalDp()

	self._dpLabel:setString(totalDp)
end

function ExploreMediator:enterMapByKey(key)
	self._exploreSystem:enterMapById(function(data)
		local view = self:getInjector():getInstance("ExploreMapView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			pointId = data.data.id
		})

		self:dispatch(event)
	end, {
		pointId = key
	}, true)
end

function ExploreMediator:onClickBuild(data)
	if data:getLock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = data:getLockTip()
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Charpter", false)

	local view = self:getInjector():getInstance("ExploreStageView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		mapTypeId = data:getId()
	}))
end

function ExploreMediator:onClickRank()
	local rankSystem = self:getInjector():getInstance(RankSystem)

	rankSystem:tryEnterRank({
		index = RankType.kMap
	})
end

function ExploreMediator:onClickTip()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageSp_Map_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ExploreMediator:onClickBack(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function ExploreMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local firstPanel = self._mapPanels[1]
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if firstPanel then
			storyDirector:setClickEnv("ExploreMediator.firstPanel", firstPanel, function(sender, eventType)
				local data = self._mapTypes[1]

				self:onClickBuild(data)
			end)
		end

		storyDirector:notifyWaiting("enter_ExploreMediator")
	end))

	self:getView():runAction(sequence)
end

function ExploreMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/Layer_explore.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 33, false)
	action:setTimeSpeed(1.2)

	local children = self._mapPanel:getChildren()
	local length = #children

	for i = 1, length do
		local child = children[i]

		child:setOpacity(0)
	end

	self:getView():stopAllActions()

	local delayTime = 0.1

	for i = 1, length do
		local child = children[i]
		local animNode = child:getChildByName("AnimNode")

		if child and animNode then
			local delayAction = cc.DelayTime:create(i * delayTime)
			local callfunc = cc.CallFunc:create(function()
				child:setOpacity(255)
				animNode:gotoAndPlay(0)
			end)
			local seq = cc.Sequence:create(delayAction, callfunc)

			self:getView():runAction(seq)
		end
	end
end
