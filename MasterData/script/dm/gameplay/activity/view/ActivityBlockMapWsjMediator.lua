-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockMapWsjMediator.lua

require("dm.gameplay.activity.model.ActivityColorEgg")
require("dm.gameplay.stage.view.component.StoryStageCommonCell")

ActivityBlockMapWsjMediator = class("ActivityBlockMapWsjMediator", DmAreaViewMediator, _M)

ActivityBlockMapWsjMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockMapWsjMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockMapWsjMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local BaseChapterPath = "asset/scene/"
local kBtnHandlers = {
	["main.btn_left"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickLeft"
	},
	["main.btn_right"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickRight"
	},
	["main.actionNode.btn_emBattle"] = {
		func = "onClickEmBattle"
	}
}
local actUiConfig = {
	ACTIVITYBLOCKMAPHoliday = {
		boss = {
			bg = "shuangdan_img_gkrk_boss2.png"
		},
		story = {
			lockBg = "shuangdan_img_gkrk_sheying.png",
			unlockBg = "shuangdan_img_gkrk_jqkq.png",
			lockIcon = "shuangdan_img_gkrk_sheying.png",
			unlockBgSize = cc.size(208, 48)
		},
		normal = {
			bg = "shuangdan_img_gkrk_zx2.png"
		}
	}
}

function ActivityBlockMapWsjMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshStoryColorEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COLOUR_EGG_REFRESH, self, self.refreshEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._bagSystem = self._developSystem:getBagSystem()
end

function ActivityBlockMapWsjMediator:initWidget()
	local view = self:getView()

	self._main = view:getChildByName("main")
	self._stagePanel = view:getChildByFullName("main.stagePanel")

	self._stagePanel:setLocalZOrder(2)
	self._stagePanel:setAnchorPoint(0.5, 0.5)

	self._cloneCell = view:getChildByName("clone_cell")
	self._storyCell = view:getChildByFullName("storyPoint_cell")
	self._textContent = view:getChildByFullName("main.titleContent")
	self._starBoxPanel = view:getChildByName("star_panel")
	self._stageAdditionPanel = view:getChildByFullName("main.stageAddition")
	self._Image_2 = view:getChildByFullName("main.Image_2")

	if self._Image_2 then
		self._Image_2:setVisible(false)
	end

	self._stageRewardsPanel = self:getView():getChildByFullName("main.stageAddition.stageRewards")

	self._stageAdditionPanel:addClickEventListener(function()
		self:onClickAditionButton()
	end)

	self._normalPointCell = view:getChildByFullName("normalPoint_cell")
	self._bossPointCell = view:getChildByFullName("bossPoint_cell")
	self._storyPointCell = view:getChildByFullName("storyPoint_cell")

	self._normalPointCell:getChildByFullName("Lock"):setVisible(false)
	self._bossPointCell:getChildByFullName("Lock"):setVisible(false)
	self._normalPointCell:setVisible(false)
	self._bossPointCell:setVisible(false)
	self._storyPointCell:setVisible(false)

	self._colorEggPointView = {}

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local text2 = view:getChildByFullName("main.actionNode.btn_emBattle.Text_2")
		local text3 = view:getChildByFullName("main.actionNode.btn_emBattle.Text_3")
		local text4 = view:getChildByFullName("main.actionNode.btn_emBattle.Text_4")

		text3:setVisible(false)
		text4:setVisible(false)
		text2:setPosition(cc.p(58, 44))
	end
end

function ActivityBlockMapWsjMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)

	local config = {
		style = 1,
		currencyInfo = self._model:getActivityConfig().ResourcesBanner,
		title = Strings:get(self._model:getTitle()),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.dismiss, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityBlockMapWsjMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._uiId = self._activity:getUI()
	self._model = self._activity:getBlockMapActivity()

	if not self._model then
		self:dismiss()

		return
	end

	self:setupTopInfoWidget()
	self:initData(data)
	self:initWidget()
	self:refreshView()
end

function ActivityBlockMapWsjMediator:resumeWithData(data)
	self:initData(data)
	self:refreshView(true)
end

function ActivityBlockMapWsjMediator:refreshView(all)
	if all then
		self._stagePanel:removeAllChildren()

		for k, view in pairs(self._colorEggPointView) do
			if view then
				local parent = view:getParent()

				if parent ~= nil then
					view:removeFromParent()
				end
			end
		end

		self._colorEggPointView = {}
	end

	self:setChapterTitle()
	self:getColorEggs()
	self:initStage()
	self:initRewardBox()
	self:setAdditionHero()
	self:refreshStarBoxPanel()
	self:refreshChooseBtnState()
	self:playBackGroundMusic()
end

function ActivityBlockMapWsjMediator:initData(data)
	if not data and self._data then
		return
	end

	self._data = data or {}
	self._stageType = self._data.stageType or StageType.kNormal
	self._mapId = self._data and self._data.enterBattlePointId and self._model:getMapIdByPointId(self._data.enterBattlePointId) or self._data.mapId or self._model:getMapIdByStageType(self._stageType)
	self._mapSort = self._model:getActivityConfig().MapSort or {
		[self._mapId] = 1
	}
	self._mapIndex = nil

	for id, index in pairs(self._mapSort) do
		if id == self._mapId then
			self._mapIndex = index
		end
	end

	self._mapIndex = self._mapIndex or 1
end

function ActivityBlockMapWsjMediator:doReset()
	self:getColorEggs()
end

function ActivityBlockMapWsjMediator:refreshEggs(event)
	local data = event:getData()
	local eggIds = data.ids

	self:refreshColorEggs(eggIds)
	self:refreshStoryColorEggs()
end

function ActivityBlockMapWsjMediator:getColorEggs()
	self._colorEggActivity = self._activity:getColourEggActivity()

	if self._colorEggActivity then
		self._activitySystem:colourEggGetAll(self._activityId, self._colorEggActivity:getId(), function()
			return
		end)
	end
end

function ActivityBlockMapWsjMediator:playBackGroundMusic()
	local chapterInfo = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local chapterConfig = chapterInfo:getConfig()

	AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
end

function ActivityBlockMapWsjMediator:setAdditionHero()
	local btns = self._activity:getButtonConfig()

	if btns.blockParams and btns.blockParams.heroes then
		local length = #btns.blockParams.heroes

		for i = 1, length do
			local id = btns.blockParams.heroes[i]
			local icon = IconFactory:createHeroIconForReward({
				star = 0,
				id = id
			})

			icon:addTo(self._stageRewardsPanel):setScale(0.5)

			local x = 30 * (3 - length) + 68 * (i - 1)

			icon:setPositionX(x)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end
	end

	self._stageAdditionPanel:setContentSize(cc.size(#btns.blockParams.heroes * 75 + 45, 70))
end

function ActivityBlockMapWsjMediator:setChapterTitle()
	local chapterInfo = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local chapterConfig = chapterInfo:getConfig()

	if chapterConfig then
		self._textContent:setString(Strings:get(chapterConfig.MapName))

		local bgPanel = self:getView():getChildByFullName("main.bg")

		bgPanel:removeAllChildren()

		local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Picture")

		if backgroundId and backgroundId ~= "" then
			local background = cc.Sprite:create(BaseChapterPath .. backgroundId .. ".jpg")

			background:setAnchorPoint(cc.p(0.5, 0.5))
			background:setPosition(cc.p(568, 320))
			background:addTo(bgPanel)

			self._bgSize = background:getContentSize()
		else
			self._bgSize = self._main:getContentSize()
		end

		local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash1")

		if flashId and flashId ~= "" then
			local mc = cc.MovieClip:create(flashId)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgPanel):setName(flashId)

			self._flashId = flashId
		end

		local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash2")

		if flashId2 and flashId2 ~= "" then
			local mc = cc.MovieClip:create(flashId2)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgPanel)
		end

		self._bgScale = 1

		local winSize = cc.Director:getInstance():getWinSize()

		if winSize.height < 641 then
			bgPanel:setScale(winSize.width / 1386)

			if winSize.width then
				self._bgScale = 1386 / winSize.width or 1
			end
		end

		self._stagePanel:setContentSize(self._bgSize)
		self._stagePanel:setScale(1 / self._bgScale)

		local plistViewId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Extra")

		if plistViewId and plistViewId ~= "" then
			local plistView = cc.CSLoader:createNode("asset/ui/" .. plistViewId .. ".csb")

			plistView:addTo(bgPanel):center(cc.size(1136, 640))
		end

		local imageViewNode = self:getView():getChildByFullName("main.titleBg")
		local titleSize = self._textContent:getContentSize().width + 45

		imageViewNode:setContentSize(cc.size(titleSize, imageViewNode:getContentSize().height))
	end
end

function ActivityBlockMapWsjMediator:switchMainScene()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
end

function ActivityBlockMapWsjMediator:refreshColorEggs(eggIds)
	self._eggList = {}

	local disableEggList = self._colorEggActivity:getDisableList()
	local bgPanel = self:getView():getChildByFullName("main.bg")
	local eggList = self._colorEggActivity:getActivityConfig().Egg

	if eggList and next(eggList) then
		for eggId, v in pairs(eggList) do
			local colorEgg = ActivityColorEgg:new(eggId)

			if colorEgg:getMap() == self._mapId and self._colorEggPointView[eggId] == nil then
				local icon = colorEgg:getIcon()
				local pos = colorEgg:getLocation()
				local node = ccui.Widget:create()

				node:setContentSize(cc.size(100, 100))

				local anim = cc.MovieClip:create(icon)

				assert(anim, "anim not find name = " .. icon)
				anim:setLocalZOrder(999)
				anim:setTag(486)
				anim:addTo(node):center(node:getContentSize())
				anim:stop()
				node:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
				node:setScale(self._bgScale)
				node:setLocalZOrder(5)

				self._colorEggPointView[eggId] = node
			end
		end
	end

	for i = 1, #eggIds do
		local eggId = eggIds[i]
		local colorEgg = ActivityColorEgg:new(eggId)

		self._eggList[i] = colorEgg

		if colorEgg:getMap() == self._mapId then
			if self._colorEggPointView[eggId] == nil then
				local icon = colorEgg:getIcon()
				local pos = colorEgg:getLocation()
				local node = ccui.Widget:create()

				node:setContentSize(cc.size(100, 100))

				local anim = cc.MovieClip:create(icon)

				assert(anim, "anim not find name = " .. icon)
				anim:setLocalZOrder(999)
				anim:setTag(486)
				anim:addTo(node):center(node:getContentSize())
				anim:stop()
				node:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
				node:setScale(self._bgScale)

				self._colorEggPointView[eggId] = node
			end

			local view = self._colorEggPointView[eggId]

			if not table.find(disableEggList, eggId) then
				view:getChildByTag(486):play()

				local function callFunc(sender, eventType)
					self:onClickColorEgg(sender, self._eggList[i])
				end

				mapButtonHandlerClick(self, view, {
					func = callFunc
				}, nil, true)
				view:getChildByName("true"):setSwallowTouches(true)
			end
		end
	end
end

function ActivityBlockMapWsjMediator:refreshStoryColorEggs()
	local map = self._model:getActivityMapById(self._mapId)
	local storyEggs = map._colorEggsMap

	for eggId, egg in pairs(storyEggs) do
		if self._colorEggPointView[eggId] == nil then
			local view = self._storyPointCell:clone()

			view:getChildByFullName("content"):setString(Strings:get(egg:getName()))

			local pos = egg:getLocation()

			view:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
			view:setScale(self._bgScale)
			view:setLocalZOrder(8)

			self._colorEggPointView[eggId] = view
		end

		local view = self._colorEggPointView[eggId]
		local callFunc
		local progress = self._model:getActivityConfig().StaminaStack
		local itemId, amount = egg:getUnlockCondition()
		local progressPanel = view:getChildByFullName("progressPanel")
		local lockPanel = view:getChildByFullName("lockPanel")
		local unlockPanel = view:getChildByFullName("unLockPanel")

		if progress == itemId then
			local num = self._bagSystem:getItemCount(itemId)
			local unlock = amount <= num

			progressPanel:setVisible(not unlock)
			lockPanel:setVisible(not unlock)
			unlockPanel:setVisible(unlock)

			local iconNode = progressPanel:getChildByFullName("icon_node")
			local textNode = progressPanel:getChildByFullName("text_bg.text")
			local strNode = progressPanel:getChildByFullName("text_bg.str")
			local icon = IconFactory:createItemPic({
				scaleRatio = 0.3,
				id = itemId
			})

			icon:addTo(iconNode):center(iconNode:getContentSize())
			textNode:setString(num)
			textNode:setColor(cc.c3b(220, 20, 60))
			strNode:setString("/" .. amount)
			textNode:setPositionX(15)
			strNode:setPositionX(20 + textNode:getContentSize().width)

			callFunc = unlock and function(sender, eventType)
				local storyId = egg:getStoryId()

				self:onClickStoryEgg(egg, storyId)
			end or function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("ACTIVITY_Halloween_NOT_ENOUGH_3")
				}))
			end
		else
			progressPanel:setVisible(false)

			function callFunc(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("ACTIVITY_Halloween_NOT_ENOUGH_3")
				}))
			end
		end

		view:setVisible(true)

		local touchPanel = view:getChildByName("true")

		if touchPanel then
			touchPanel:removeFromParent()
		end

		mapButtonHandlerClick(self, view, {
			ignoreClickAudio = true,
			func = callFunc
		}, nil, true)
		view:getChildByName("true"):setSwallowTouches(true)
	end
end

function ActivityBlockMapWsjMediator:initStage()
	local map = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local mapConfig = map:getConfig()
	local storyPoints = map:getStoryPoints()

	self._normalPointView = {}
	self._storyPointView = {}
	self._bossPointView = {}

	local i = 1
	local j = 1

	for _, point in ipairs(map._index2Points) do
		if not point:isBoss() then
			self:createNormalPointNode(i, point)

			i = i + 1
		else
			self:createBossPointNode(j, point)

			j = j + 1
		end
	end

	self._storyPointList = storyPoints

	self:storySort(self._storyPointList)

	for k, storyPoint in ipairs(self._storyPointList) do
		self:createStoryPointNode(k, storyPoint:getId())
	end
end

function ActivityBlockMapWsjMediator:storySort(tab)
	table.sort(tab, function(a, b)
		local storyPointA = a:isPass() and 1 or 0
		local storyPointB = b:isPass() and 1 or 0
		local storyPointConfigA = ConfigReader:getRecordById("ActivityStoryPoint", a:getId())
		local storyPointConfigB = ConfigReader:getRecordById("ActivityStoryPoint", b:getId())

		if storyPointA == storyPointB then
			if self._stageType == StageType.kNormal then
				return storyPointConfigA.Location[2] < storyPointConfigB.Location[2]
			else
				return storyPointConfigA.Location[2] > storyPointConfigB.Location[2]
			end
		end

		return storyPointB < storyPointA
	end)
end

function ActivityBlockMapWsjMediator:createNormalPointNode(index, pointData)
	local point = pointData
	local pointId = point:getId()

	if self._normalPointView[pointId] == nil then
		local view = self._normalPointCell:clone()

		view:setVisible(true)
		view:getChildByFullName("name"):setString(Strings:get(point:getIndex()))
		view:getChildByFullName("content"):setString(Strings:get(point:getName()))

		local pos = point:getLocation()

		view:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
		view:setScale(self._bgScale)
		view:setLocalZOrder(10)

		local function callFunc(sender, eventType)
			self:enterCommonPoint(pointId)
		end

		mapButtonHandlerClick(self, view, {
			ignoreClickAudio = true,
			func = callFunc
		}, nil, true)
		view:getChildByName("true"):setSwallowTouches(true)

		local uiConfig = actUiConfig[self._model:getUI()]

		if uiConfig and uiConfig.normal and uiConfig.normal.bg then
			view:getChildByName("bg"):loadTexture(uiConfig.normal.bg, ccui.TextureResType.plistType)
		end

		self._normalPointView[pointId] = view
	end

	local view = self._normalPointView[pointId]

	view:setVisible(point:isUnlock())

	local stars = view:getChildByName("stars")

	if not point._starState then
		local starState = {
			false,
			false,
			false
		}

		for i = 1, 3 do
			local _star = stars:getChildByName("star" .. i)

			if starState[i] then
				_star:loadTexture("asset/common/yinghun_xingxing.png", ccui.TextureResType.localType)
				_star:setScale(0.3)
			else
				_star:loadTexture("icon_zuanshi.png", ccui.TextureResType.plistType)
				_star:setScale(0.25)
			end
		end
	end
end

function ActivityBlockMapWsjMediator:createBossPointNode(index, pointData)
	local point = pointData
	local pointId = point:getId()

	if self._bossPointView[pointId] == nil then
		local view = self._bossPointCell:clone()

		view:setVisible(true)
		view:getChildByFullName("content"):setString(Strings:get(point:getName()))

		local pos = point:getLocation()

		view:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
		view:setScale(self._bgScale)
		view:setLocalZOrder(20)

		local function callFunc(sender, eventType)
			self:enterCommonPoint(pointId)
		end

		mapButtonHandlerClick(self, view, {
			ignoreClickAudio = true,
			func = callFunc
		}, nil, true)
		view:getChildByName("true"):setSwallowTouches(true)

		local uiConfig = actUiConfig[self._model:getUI()]

		if uiConfig and uiConfig.boss and uiConfig.boss.bg then
			view:getChildByName("bg"):loadTexture(uiConfig.boss.bg, ccui.TextureResType.plistType)
		end

		self._bossPointView[pointId] = view
	end

	local view = self._bossPointView[pointId]

	view:setVisible(point:isUnlock())

	local hpRate = pointData:getHpRate()

	view:getChildByFullName("progressBg.exBar"):setPercent(hpRate * 100)
end

function ActivityBlockMapWsjMediator:createStoryPointNode(index, pointId)
	local map = self._model:getActivityMapById(self._mapId)
	local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", pointId)
	local storyPoint = map:getStoryPointById(pointId)

	if self._storyPointView[pointId] == nil then
		local pos = storyPoint:getLocation()
		local view = self._storyPointCell:clone()

		view:setVisible(true)
		view:getChildByFullName("content"):setString(Strings:get(storyPoint:getName()))
		view:addTo(self._stagePanel):center(self._bgSize):setPosition(cc.p(pos[1] + self._bgSize.width * 0.5, pos[2] + self._bgSize.height * 0.5))
		view:setScale(self._bgScale)
		view:setLocalZOrder(20)

		view.point = storyPoint

		local function callFunc(sender, eventType)
			self:onClickPlayStory(pointId)
		end

		mapButtonHandlerClick(self, view, {
			ignoreClickAudio = true,
			func = callFunc
		}, nil, true)
		view:getChildByName("true"):setSwallowTouches(true)
		view:getChildByFullName("unLockPanel"):setVisible(storyPoint:isUnlock())
		view:getChildByFullName("lockPanel"):setVisible(not storyPoint:isUnlock())
		view:getChildByFullName("progressPanel"):setVisible(false)

		self._storyPointView[pointId] = view

		local uiConfig = actUiConfig[self._model:getUI()]

		if uiConfig and uiConfig.story then
			if uiConfig.story.unlockBg then
				view:getChildByName("unLockPanel"):loadTexture(uiConfig.story.unlockBg, ccui.TextureResType.plistType)
			end

			if uiConfig.story.unlockBgSize then
				view:getChildByName("unLockPanel"):setContentSize(uiConfig.story.unlockBgSize)
			end
		end

		self._storyPointView[pointId]:setVisible(storyPoint:isUnlock())
	else
		self._storyPointView[pointId]:setVisible(storyPoint:isUnlock())
	end
end

function ActivityBlockMapWsjMediator:checkShowHiddenStory(pointId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local pointInfo, pointType = self._model:getPointById(pointId)
	local map = self._model:getActivityMapById(self._mapId)

	if pointType == kStageTypeMap.point then
		local hiddenStory = pointInfo:getHiddenStory()

		for link, v in pairs(hiddenStory) do
			local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", link)
			local storyPoint = map:getStoryPointById(link)

			return storyPoint:isPass()
		end
	end

	return true
end

function ActivityBlockMapWsjMediator:initRewardBox()
	for i = 1, 3 do
		local imgBox = self._starBoxPanel:getChildByFullName("bar_schedule.box_panel_" .. i .. ".img_box")

		imgBox:setTag(i)
		imgBox:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				self:onClickRewardBox(sender)
			end
		end)
	end
end

function ActivityBlockMapWsjMediator:refreshStarBoxPanel()
	local function setBoxStar(boxPanel, star)
		local textStar = boxPanel:getChildByName("text_star_num")

		textStar:setString(star)
	end

	local function setBoxState(boxPanel, index, state, showRed)
		local imgBox = boxPanel:getChildByName("img_box")

		imgBox:ignoreContentAdaptWithSize(true)

		local mcBox = boxPanel:getChildByName("mc_box")
		local imgRedPoint = boxPanel:getChildByName("red_point")

		imgRedPoint:setVisible(showRed)
	end

	local function setBoxPosition(boxPanel, starNum, totalStarNum)
		local totalWidth = 360
		local offset = 18
		local posX = starNum / totalStarNum * totalWidth - offset

		boxPanel:setPositionX(posX)
	end

	local chapterInfo = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local chapterConfig = chapterInfo:getConfig()
	local boxPanel = {}
	local starBar = self._starBoxPanel:getChildByName("bar_schedule")

	for i = 1, 3 do
		boxPanel[i] = starBar:getChildByName("box_panel_" .. i)
	end

	if chapterConfig then
		local boxRewardList = self:boxReardToTable(chapterConfig.StarBoxReward)
		local totalStarNum = tonumber(boxRewardList[#boxRewardList].starNum)
		local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0
		local boxNum = #boxRewardList

		boxPanel[1]:setVisible(boxNum >= 3)
		boxPanel[2]:setVisible(boxNum >= 2)

		for index, reward in pairs(boxRewardList) do
			local boxIndex = 3 - boxNum + index

			setBoxStar(boxPanel[boxIndex], reward.starNum)
			setBoxPosition(boxPanel[boxIndex], reward.starNum, totalStarNum)

			local isOpen, showRed

			if curStarNum >= reward.starNum then
				if chapterInfo and chapterInfo:getMapBoxState(reward.starNum) ~= StageBoxState.kCanReceive then
					isOpen = true
					showRed = false
				else
					isOpen = false
					showRed = true
				end
			else
				isOpen = false
				showRed = false
			end

			setBoxState(boxPanel[boxIndex], boxIndex, isOpen, showRed)
		end

		starBar:setPercent(curStarNum / totalStarNum * 100)
	end
end

function ActivityBlockMapWsjMediator:boxReardToTable(boxReward)
	local tab = {}

	if not boxReward then
		return tab
	end

	for k, v in pairs(boxReward) do
		local item = {}

		item.starNum = tonumber(k)
		item.rewardId = v

		table.insert(tab, item)
	end

	table.sort(tab, function(t1, t2)
		if t1.starNum <= t2.starNum then
			return true
		else
			return false
		end
	end)

	return tab
end

function ActivityBlockMapWsjMediator:onGotoHeroSystem()
	local view = self:getInjector():getInstance("HeroShowListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))
end

function ActivityBlockMapWsjMediator:refreshChooseBtnState()
	local chapterInfo = self._model:getMapByIndex(self._mapIndex - 1, self._stageType)
	local unlock = chapterInfo and chapterInfo:isUnlock()
	local leftTouchPanel = self:getView():getChildByFullName("main.btn_left")

	leftTouchPanel:setVisible(unlock)

	local chapterInfo = self._model:getMapByIndex(self._mapIndex + 1, self._stageType)
	local chapterInfoCur = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local unlock = chapterInfo and chapterInfoCur:isPass()
	local rightTouchPanel = self:getView():getChildByFullName("main.btn_right")

	rightTouchPanel:setVisible(unlock)
end

function ActivityBlockMapWsjMediator:onClickLeft()
	if self._mapIndex == 1 then
		return
	end

	local chapterInfo = self._model:getMapByIndex(self._mapIndex - 1, self._stageType)
	local unlock, tips = chapterInfo:isUnlock()

	if unlock then
		self._mapId = chapterInfo._mapId
		self._mapIndex = self._mapIndex - 1

		self:refreshView(true)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function ActivityBlockMapWsjMediator:onClickRight()
	if self._mapIndex == #self._mapSort then
		return
	end

	local chapterInfo = self._model:getMapByIndex(self._mapIndex + 1, self._stageType)
	local unlock, tips = chapterInfo:isUnlock()

	if unlock then
		self._mapId = chapterInfo._mapId
		self._mapIndex = self._mapIndex + 1

		self:refreshView(true)
	else
		if tips == Strings:get("Lock1") then
			tips = Strings:get("Lock4")
		end

		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function ActivityBlockMapWsjMediator:onClickEmBattle()
	self._activitySystem:enterTeam(self._activityId, self._model)
end

function ActivityBlockMapWsjMediator:onClickAditionButton()
	if not self._model then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._model:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockMapWsjMediator:onClickRewardBox(sender)
	local chapterInfo = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local chapterConfig = chapterInfo:getConfig()
	local boxRewardList = self:boxReardToTable(chapterConfig.StarBoxReward)
	local index = sender:getTag()
	local boxNum = #boxRewardList
	local boxIndex = index - (3 - boxNum)
	local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0

	local function receiveAward()
		local function requestRewardSuc(data)
			if checkDependInstance(self) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data.reward
				}))
			end
		end

		self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), {
			doActivityType = 105,
			type = litTypeMap[self._stageType],
			mapId = self._mapId,
			star = boxRewardList[boxIndex].starNum
		}, function(data)
			sender:getParent():getChildByName("red_point"):setVisible(false)

			local map = self._model:getActivityMapById(self._mapId)
			local rsData = data.data

			map:setMapBoxReceived(rsData.star)
			requestRewardSuc(rsData)
		end)
	end

	local data = {
		type = StageRewardType.kStarBox,
		rewardId = boxRewardList[boxIndex].rewardId,
		extra = {}
	}

	if curStarNum >= boxRewardList[boxIndex].starNum then
		if chapterInfo and chapterInfo:getMapBoxState(boxRewardList[boxIndex].starNum) ~= StageBoxState.kCanReceive then
			data.state = StageBoxState.kHasReceived
		else
			data.state = StageBoxState.kCanReceive
			data.callback = receiveAward
		end
	else
		data.state = StageBoxState.kCannotReceive
	end

	data.extra[1] = curStarNum
	data.extra[2] = boxRewardList[boxIndex].starNum

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageShowRewardView"), {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, self))
end

function ActivityBlockMapWsjMediator:onClickPlayStory(pointId, isCheck)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local chapterInfo = self._model:getMapByIndex(self._mapIndex, self._stageType)
	local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
	local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "StoryLink")
	local storyAgent = storyDirector:getStoryAgent()

	local function endCallBack()
		local storyPoint = chapterInfo:getStoryPointById(pointId)
		local isFirst = 0

		if not storyPoint:isPass() then
			isFirst = 1

			self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), {
				doActivityType = 106,
				pointId = pointId
			}, function(response)
				local function refreshStory()
					storyDirector:notifyWaiting("story_play_end")
					self:initStage()
				end

				local delegate, outSelf = {}, self

				function delegate:willClose(popupMediator, data)
					refreshStory()
				end

				local reward = response.data.reward

				if reward then
					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = reward
					}, delegate))
				else
					refreshStory()
				end
			end)
		end

		local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
		local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

		StatisticSystem:send({
			type = "plot_end",
			op_type = "plot_activity",
			point = "plot_end",
			activityid = self._activity:getTitle(),
			plot_id = storyLink,
			plot_name = storyPoint:getName(),
			id_first = isFirst,
			totaltime = endTs - startTs,
			detail = statisticsData.detail,
			amount = statisticsData.amount,
			misc = statisticsData.misc
		})
	end

	storyAgent:setSkipCheckSave(not isCheck)
	storyAgent:trigger(storyLink, nil, endCallBack)
end

function ActivityBlockMapWsjMediator:enterCommonPoint(pointId)
	local pointInfo = self._model:getPointById(pointId)

	if not pointInfo:isUnlock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("Lock2")
		}))

		return
	end

	local openTime = pointInfo:getConfig().PointTime
	local curTime = self._gameServerAgent:remoteTimestamp()

	if openTime and openTime.start then
		local startTime = TimeUtil:formatStrToRemoteTImestamp(openTime.start)

		if curTime < startTime then
			local date = TimeUtil:localDate("%Y-%m-%d", startTime)

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Newyear_ActivityStage_OpenTimeTip", {
					time = date
				})
			}))

			return
		end
	end

	local data = {
		parent = self,
		pointId = pointId,
		activityId = self._activityId
	}
	local view = self:getInjector():getInstance("ActivityPointDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function ActivityBlockMapWsjMediator:onClickStoryEgg(egg, storyId, isCheck)
	local function endCallBack()
		self:refreshView()
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(not isCheck)
	storyAgent:trigger(storyId, nil, endCallBack)
end

function ActivityBlockMapWsjMediator:onClickColorEgg(sender, egg)
	if sender._onlick then
		return
	end

	sender._onlick = true

	self._activitySystem:colourEggGetTarget(self._activityId, self._colorEggActivity:getId(), egg._eggId, function(data)
		local anim = sender:getChildByTag(486)

		if anim then
			anim:stop()
		end

		sender:removeChildByName("true")

		sender._onlick = false

		local modelConfig = egg:getModelConfig()

		local function func()
			local data = data.rewards

			if data and next(data) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data
				}))
			end
		end

		if modelConfig and next(modelConfig) then
			local view = self:getInjector():getInstance("ActivityColorEggView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				model = modelConfig,
				tips = egg:getDesc(),
				callback = func
			}))
		else
			func()
		end
	end)
end
