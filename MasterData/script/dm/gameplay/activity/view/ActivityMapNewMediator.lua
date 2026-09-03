-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityMapNewMediator.lua

require("dm.gameplay.activity.model.stageModel.ActivityStageCellNew")

ActivityMapNewMediator = class("ActivityMapNewMediator", DmAreaViewMediator, _M)

ActivityMapNewMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityMapNewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ActivityMapNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityMapNewMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local commonCellWidth = 420
local unSelectCellHeight = 69
local selectedCellHeight = 155
local onScrollState = false
local BaseChapterPath = "asset/scene/"
local kBtnHandlers = {
	["main.actionNode.btn_heroSystem"] = {
		func = "onGotoHeroSystem"
	},
	["main.actionNode.btn_emBattle"] = {
		func = "onClickEmBattle"
	},
	["main.actionNode.btn_stage"] = {
		func = "onClickChangeStageStype"
	},
	["main.actionNode.btn_stage_parttwo"] = {
		func = "onClickChangeStagePartTwo"
	},
	["main.actionNode.btn_story"] = {
		func = "onClickStory"
	},
	["main.btn_hideui"] = {
		func = "onClickHideUI"
	}
}
local terrorBmg = {
	bmg_1 = {
		role = "ico_roleshadow_1",
		img = "scene_main_terror_1",
		rolePosition = cc.p(415, 204),
		anim = {
			name = "PT_ZONG_juyuanfenwei",
			position = cc.p(568, 320)
		}
	},
	bmg_2 = {
		img = "scene_main_terror_1",
		saturation = -50,
		role = "ico_roleshadow_2",
		rolePosition = cc.p(498, 193),
		anim = {
			name = "PT_ZONG_juyuanfenwei",
			position = cc.p(568, 320)
		}
	},
	bmg_3 = {
		img = "scene_main_terror_1",
		saturation = -80,
		role = "ico_roleshadow_3",
		rolePosition = cc.p(588, 130),
		anim = {
			name = "PT_ZONG_juyuanfenwei",
			position = cc.p(568, 320)
		}
	},
	bmg_4 = {
		img = "scene_main_terror_3",
		anim = {
			name = "zHJzong1_juyuanfenwei",
			position = cc.p(568, 320),
			runAction = function(node)
				node:addCallbackAtFrame(95, function()
					node:stop()
				end)
			end
		}
	}
}

function ActivityMapNewMediator:initialize()
	super.initialize(self)
end

function ActivityMapNewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshStoryColorEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COLOUR_EGG_REFRESH, self, self.refreshEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GET_NEW_STORY, self, self.refreshStoryBtnRedPoint)
end

function ActivityMapNewMediator:setupTopInfoWidget()
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

function ActivityMapNewMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._blockActivityId = data.blockActivityId
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
		self:tryEnterSupport()

		return
	end

	self._showUI = true
	self._data = data or {}
	self._stageIndex = data.enterBattlePointId and self._model:getMapIdexBySortId(data.enterBattlePointId) or self._data.stageIndex or 1
	self._mapId = self._model:getMapIdByStageIndex(self._stageIndex)

	self:initWidget()
	self:setupTopInfoWidget()
	self:initStage()
	self:setChapterTitle()
	self:createTableView()
	self:setScrollPoint()
	self:setAdditionHero()
	self:playBackGroundMusic()
	self:getColorEggs()
	self:refreshStoryBtnRedPoint()
end

function ActivityMapNewMediator:doReset()
	self:getColorEggs()
end

function ActivityMapNewMediator:refreshEggs(event)
	local data = event:getData()
	local eggIds = data.ids

	self:refreshColorEggs(eggIds)
	self:refreshStoryColorEggs()
end

function ActivityMapNewMediator:getColorEggs()
	self._colorEggActivity = self._activity:getColourEggActivity()

	if self._colorEggActivity then
		self._activitySystem:colourEggGetAll(self._activityId, self._colorEggActivity:getId(), function()
			return
		end)
	end
end

function ActivityMapNewMediator:tryEnterSupport()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Activity_Saga_UI_2")
	}))
	self:dismiss()
end

function ActivityMapNewMediator:resumeWithData(data)
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
		self:tryEnterSupport()

		return
	end

	local pointIndex = table.indexof(self._pointList, self._selectPointId)

	if pointIndex then
		local map = self._model:getStageByStageIndex(self._stageIndex)
		local enterBattlePoint = map:getPointById(self._selectPointId)
		local nextPointId = self._pointList[pointIndex + 1]
		local nextPoint = map:getPointById(nextPointId)

		if enterBattlePoint:isPass() and nextPoint and nextPoint:isUnlock() and not nextPoint:isPass() then
			self._selectPointId = nextPointId
		end
	end

	self:initStage()
	self._tableView:reloadData()
	self:setScrollPoint()
	self:playBackGroundMusic()
end

function ActivityMapNewMediator:playBackGroundMusic()
	local chapterInfo = self._model:getStageByStageIndex(self._stageIndex)
	local chapterConfig = chapterInfo:getConfig()

	AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
end

function ActivityMapNewMediator:setAdditionHero()
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

			local x = (i - 1) * 65 + 5

			icon:setPositionX(x)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end

		self._stageAdditionPanel:setContentSize(cc.size(#btns.blockParams.heroes * 65 + 65, 70))
	end
end

function ActivityMapNewMediator:setChapterTitle()
	local chapterInfo = self._model:getStageByStageIndex(self._stageIndex)
	local chapterConfig = chapterInfo:getConfig()
	local activityConfig = self._model:getActivityConfig()

	if chapterConfig then
		self._textContent:setString(Strings:get(chapterConfig.MapName))

		local bgPanel = self:getView():getChildByFullName("main.bg")

		bgPanel:removeAllChildren()
		self._bgList:setTouchEnabled(false)

		if activityConfig.LongBmg then
			bgPanel:setVisible(false)

			self._bgCanMove = true

			local listSize = self._bgList:getContentSize()
			local height = 0
			local longBg = activityConfig.LongBmg

			for i, v in pairs(longBg) do
				local bg = ccui.ImageView:create(BaseChapterPath .. longBg[#longBg - i + 1] .. ".jpg")

				bg:setAnchorPoint(cc.p(0, 0))

				local size = bg:getContentSize()

				bg:addTo(self._bgList):posite(0, size.height * (i - 1))

				height = height + size.height
			end

			self._hideUIBtn:setVisible(self._bgCanMove and chapterInfo:isPass())
			self._bgList:setInnerContainerSize(cc.size(listSize.width, height))

			local anim = cc.MovieClip:create("shenhaichangjingTX_shenhaichangjing")

			anim:addTo(self._bgList):posite(listSize.width * 0.5, height * 0.5 - 3)

			local mcNode = anim:getChildByFullName("guai.img.img")
			local img = ccui.ImageView:create("asset/ui/activity/guaishouzhanyu_shenhaichangjingimage.png")

			img:addTo(mcNode):center(mcNode:getContentSize())

			local mcNode = anim:getChildByFullName("bgan.img")
			local img = ccui.ImageView:create("asset/ui/activity/bgguaishou_shenhaichangjingimage.png")

			img:addTo(mcNode):center(mcNode:getContentSize())

			for i = 1, 2 do
				local mcNode = anim:getChildByFullName("haicao.img" .. i)
				local img = ccui.ImageView:create("asset/ui/activity/chushou05_shenhaichangjingimage.png")

				img:addTo(mcNode):center(mcNode:getContentSize())
			end

			self._bgList:onScroll(function(event)
				self:refreshBgScroll()
			end)
		elseif activityConfig.ExchangeBmg then
			self:showExchangeBmg()
		else
			local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Picture")

			if backgroundId and backgroundId ~= "" then
				local background = cc.Sprite:create(BaseChapterPath .. backgroundId .. ".jpg")

				background:setAnchorPoint(cc.p(0.5, 0.5))
				background:setPosition(cc.p(568, 320))
				background:addTo(bgPanel)
			end

			local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash1")

			if flashId and flashId ~= "" then
				local mc = cc.MovieClip:create(flashId)

				mc:setPosition(cc.p(568, 320))
				mc:addTo(bgPanel)
			end

			local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash2")

			if flashId2 and flashId2 ~= "" then
				local mc = cc.MovieClip:create(flashId2)

				mc:setPosition(cc.p(568, 320))
				mc:addTo(bgPanel)
			end

			local winSize = cc.Director:getInstance():getWinSize()

			if winSize.height < 641 then
				bgPanel:setScale(winSize.width / 1386)
			end

			local plistViewId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Extra")

			if plistViewId and plistViewId ~= "" then
				local plistView = cc.CSLoader:createNode("asset/ui/" .. plistViewId .. ".csb")

				plistView:addTo(bgPanel):center(cc.size(1136, 640))
			end

			local imageViewNode = self:getView():getChildByFullName("main.titleBg")
			local titleSize = self._textContent:getContentSize().width + self._stageTypeView:getContentSize().width + 45

			imageViewNode:setContentSize(cc.size(titleSize, imageViewNode:getContentSize().height))
		end
	end
end

function ActivityMapNewMediator:showExchangeBmg()
	local activityConfig = self._model:getActivityConfig()

	if not activityConfig.ExchangeBmg then
		return
	end

	local lastPointId = self._pointList[#self._pointList]
	local map = self._model:getStageByStageIndex(self._stageIndex)
	local lastPoint = map:getPointById(lastPointId)
	local pointId = self._selectPointId

	if not pointId and lastPoint:isPass() then
		pointId = lastPointId
	end

	local bgImg = activityConfig.ExchangeBmg[pointId]

	if not bgImg then
		return
	end

	local bgPanel = self:getView():getChildByFullName("main.bg")

	bgPanel:removeChildByName("add_background")
	bgPanel:removeChildByName("add_role")
	bgPanel:setVisible(true)

	local bgImgCfg = terrorBmg[bgImg]
	local background = cc.Sprite:create(BaseChapterPath .. bgImgCfg.img .. ".jpg")

	background:setAnchorPoint(cc.p(0.5, 0.5))
	background:setPosition(cc.p(568, 320))
	background:addTo(bgPanel)
	background:setName("add_background")
	background:setLocalZOrder(11)

	if bgImgCfg.saturation then
		background:setSaturation(bgImgCfg.saturation)
	end

	if bgImgCfg.role then
		local role = ccui.ImageView:create(bgImgCfg.role .. ".png", ccui.TextureResType.plistType)

		role:setAnchorPoint(cc.p(0.5, 0.5))
		role:setPosition(bgImgCfg.rolePosition)
		role:addTo(bgPanel)
		role:setName("add_role")
		role:setLocalZOrder(22)
	end

	if bgImgCfg.anim and self.bgAnimName ~= bgImgCfg.anim.name then
		if self._bgAnim then
			self._bgAnim:removeFromParent()
		end

		self._bgAnim = cc.MovieClip:create(bgImgCfg.anim.name)

		self._bgAnim:setPosition(bgImgCfg.anim.position)
		self._bgAnim:addTo(bgPanel)
		self._bgAnim:setLocalZOrder(99)

		if bgImgCfg.anim.runAction then
			bgImgCfg.anim.runAction(self._bgAnim)
		end

		self.bgAnimName = bgImgCfg.anim.name
	end
end

function ActivityMapNewMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._stagePanel = self:getView():getChildByFullName("main.stagePanel")

	self._stagePanel:setLocalZOrder(2)

	self._cloneCell = self:getView():getChildByName("clone_cell")

	self._cloneCell:setVisible(false)

	self._textContent = self:getView():getChildByFullName("main.titleContent")
	self._stageTypeView = self:getView():getChildByFullName("main.stageType")
	self._stageAdditionPanel = self:getView():getChildByFullName("main.stageAddition")
	self._starAdditionPanel = self:getView():getChildByFullName("main.starAddPanel")
	self._Image_2 = self:getView():getChildByFullName("main.Image_2")

	if self._Image_2 then
		self._Image_2:setVisible(false)
	end

	self._heroSystemBtn = self._main:getChildByFullName("actionNode.btn_heroSystem")
	self._emBattleBtn = self._main:getChildByFullName("actionNode.btn_emBattle")
	self._stageTypeBtn = self._main:getChildByFullName("actionNode.btn_stage")
	self._storyBtn = self._main:getChildByFullName("actionNode.btn_story")
	self._parttwoBtn = self._main:getChildByFullName("actionNode.btn_stage_parttwo")
	self._choicePanel = self._main:getChildByFullName("actionNode.choicePanel")
	self._heroSystemBtnX = self._heroSystemBtn:getPositionX()
	self._emBattleBtnX = self._emBattleBtn:getPositionX()
	self._stageTypeBtnX = self._stageTypeBtn:getPositionX()
	self._parttwoBtnX = self._parttwoBtn:getPositionX()
	self._parttwoBtnTxt = self._parttwoBtn:getChildByName("Text_1")
	self._stageRewardsPanel = self:getView():getChildByFullName("main.stageAddition.stageRewards")
	self._bgList = self:getView():getChildByName("ScrollView_bg")

	self._bgList:setContentSize(cc.Director:getInstance():getWinSize())
	self._bgList:setScrollBarEnabled(false)

	self._hideUIBtn = self._main:getChildByName("btn_hideui")

	self._hideUIBtn:setVisible(false)

	for i = 1, 3 do
		self._stageTypeBtn:getChildByName("Text" .. i):enableOutline(cc.c4b(0, 0, 0, 204), 1)
	end

	self._pointSlider = self._main:getChildByName("Slider")

	self._pointSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)
	self._stageAdditionPanel:addClickEventListener(function()
		self:onClickAditionButton()
	end)
	self._starAdditionPanel:addClickEventListener(function()
		self:onClickAditionButton()
	end)

	self._colorEggPointView = {}
end

function ActivityMapNewMediator:updataStageBtnImg()
	if self._activity then
		local imgName

		if self._model:getActivityConfig().ChangeBtnImg then
			imgName = self._model:getActivityConfig().ChangeBtnImg[self._stageType]
		end

		if imgName then
			self._stageTypeBtn:loadTextures(imgName, imgName, imgName, ccui.TextureResType.plistType)
		end
	end

	local mapIds = self._activity:getBlockMapIds()

	self._stageTypeBtn:setVisible(table.nums(mapIds) > 1)
	self._heroSystemBtn:setPositionX((self._stageTypeBtn:isVisible() or nil) and (self._heroSystemBtnX or self._heroSystemBtnX - 100))
	self._emBattleBtn:setPositionX((self._stageTypeBtn:isVisible() or nil) and (self._emBattleBtnX or self._emBattleBtnX - 100))
	self._storyBtn:setPositionX(self._emBattleBtn:getPositionX() + 120)

	if not self._stageTypeBtn:isVisible() then
		local list = self._model:getMapList()

		self._parttwoBtn:setVisible(table.nums(list) > 1)
		self._heroSystemBtn:setPositionX((self._parttwoBtn:isVisible() or nil) and (self._heroSystemBtnX or self._heroSystemBtnX - 100))
		self._emBattleBtn:setPositionX((self._parttwoBtn:isVisible() or nil) and (self._emBattleBtnX or self._emBattleBtnX - 100))
		self._storyBtn:setPositionX(self._emBattleBtn:getPositionX() + 120)

		if self._parttwoBtn:isVisible() and self._model:getActivityConfig().ChangeBtnImg then
			local config = self._model:getActivityConfig().ChangeBtnImg[self._mapId]

			if not config.Image then
				local name = Strings:get(config.Part) or "NONE"

				self._parttwoBtn:loadTextures(config.Image, config.Image, config.Image, ccui.TextureResType.plistType)
				self._parttwoBtnTxt:setString(Strings:get(name))
			end
		end
	end
end

function ActivityMapNewMediator:switchMainScene()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
end

function ActivityMapNewMediator:onSliderChanged()
	local percent = self._pointSlider:getPercent()
	local maxOffset = self._tableView:minContainerOffset().y

	onScrollState = true

	self._tableView:setContentOffset(cc.p(0, maxOffset * (1 - percent * 0.01)), false)

	onScrollState = false

	self:changeBGMove()
end

function ActivityMapNewMediator:changeBGMove()
	if self._bgList:isTouchEnabled() then
		return
	end

	local maxOffset = self._tableView:minContainerOffset().y
	local offY = self._tableView:getContentOffset().y
	local percent = math.abs(offY / maxOffset)
	local maxUnlockIndex = math.min(self:getMaxUnlockPointIndex() + 1, #self._pointList)
	local maxPercent1 = maxUnlockIndex / #self._pointList

	if self._bgCanMove then
		local bgPercent = 100 - percent * 100

		self._bgList:jumpToPercentVertical(math.min(100, bgPercent * maxPercent1))
	end
end

function ActivityMapNewMediator:refreshColorEggs(eggIds)
	self._eggList = {}

	local disableEggList = self._colorEggActivity:getDisableList()
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

				if self._bgCanMove then
					local size = self._bgList:getInnerContainerSize()

					node:addTo(self._bgList, 500):posite(size.width * 0.5 + pos[1], pos[2])
				else
					local bgPanel = self:getView():getChildByFullName("main.bg")

					node:addTo(bgPanel, 500):posite(bgPanel:getContentSize().width * 0.5 + pos[1], pos[2])
				end

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

				if self._bgCanMove then
					local size = self._bgList:getInnerContainerSize()

					node:addTo(self._bgList, 500):posite(size.width * 0.5 + pos[1], pos[2])
				else
					local bgPanel = self:getView():getChildByFullName("main.bg")

					node:addTo(bgPanel, 500):posite(bgPanel:getContentSize().width * 0.5 + pos[1], pos[2])
				end

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

function ActivityMapNewMediator:refreshStoryColorEggs()
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

function ActivityMapNewMediator:initStage()
	local map = self._model:getActivityMapById(self._mapId)
	local storyPoints = map:getStoryPoints()

	self._pointList = {}

	for _, point in ipairs(map._index2Points) do
		self._pointList[#self._pointList + 1] = point:getId()
	end

	self._storyPointList = storyPoints

	self:storySort(self._storyPointList)

	for k, storyPoint in ipairs(self._storyPointList) do
		local pointId = storyPoint:getId()
		local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", pointId)

		if not storyPoint:getIsHidden() and not storyPoint:isPass() and storyPointConfig.IsHide ~= 1 then
			local preOpenPointIds = storyPoint:getPrevBPointId()
			local _pointId = preOpenPointIds[1]

			if _pointId then
				for k, v in ipairs(self._pointList) do
					if v == _pointId then
						table.insert(self._pointList, k + 1, pointId)

						break
					end
				end
			else
				table.insert(self._pointList, 1, pointId)
			end
		end
	end

	local enterBattlePointId = self._data.enterBattlePointId

	if enterBattlePointId then
		local pointIndex = table.indexof(self._pointList, enterBattlePointId)

		if pointIndex then
			local enterBattlePoint = map:getPointById(enterBattlePointId)
			local nextPointId = self._pointList[pointIndex + 1]
			local nextPoint = map:getPointById(nextPointId)

			self._selectPointId = enterBattlePoint:isPass() and nextPoint and nextPoint:isUnlock() and not nextPoint:isPass() and nextPointId or enterBattlePointId
		else
			self._selectPointId = enterBattlePointId
		end

		self._data.enterBattlePointId = nil
	else
		for _, _pointId in ipairs(self._pointList) do
			local _point = map:getPointById(_pointId)

			if _point:isUnlock() and not _point:isPass() then
				self._selectPointId = _pointId
			end
		end
	end

	self._showPointList = {}

	for index, _pointId in ipairs(self._pointList) do
		local _point = map:getPointById(_pointId)

		if _point:isPass() then
			self._showPointList[#self._showPointList + 1] = _point
		end

		if _point:isUnlock() and not _point:isPass() then
			self._showPointList[#self._showPointList + 1] = _point
			self._showPointList[#self._showPointList + 1] = self._pointList[index + 1]
		end
	end

	local minNum = self._model:getActivityConfig().BlockNum

	if minNum > #self._showPointList then
		for index, _pointId in ipairs(self._pointList) do
			local _point = map:getPointById(_pointId)

			if index > #self._showPointList and index <= minNum then
				self._showPointList[#self._showPointList + 1] = _point
			end
		end
	end

	self:updataStageBtnImg()
	self._starAdditionPanel:setVisible(false)
	self._hideUIBtn:setVisible(self._bgCanMove and map:isPass())

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local back_btn = self:getView():getChildByFullName("topinfo_node.back_btn")

	storyDirector:setClickEnv("activityblock.back_btn", back_btn, function(sender, eventType)
		self:dismiss()
	end)
	self:dispatch(Event:new(EVT_BLOCKLEVEL_CHANGE))
	delayCallByTime(500, function()
		storyDirector:notifyWaiting("enter_activity_blcok_view")
	end)
end

function ActivityMapNewMediator:storySort(tab)
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

local tempPos = {
	NORMAL = {
		cc.p(218, 320),
		cc.p(218, 370)
	},
	ELITE = {
		cc.p(190, 500),
		cc.p(470, 500)
	}
}

function ActivityMapNewMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(402, 419))

	local function numberOfCells(view)
		return #self._showPointList
	end

	local function cellTouched(table, cell)
		local index = cell:getIdx() + 1

		self:onClickNextAction(index)
	end

	local function cellSize(table, idx)
		local pointId = self._pointList[idx + 1]

		if pointId == self._selectPointId then
			return commonCellWidth, selectedCellHeight
		else
			return commonCellWidth, unSelectCellHeight
		end
	end

	local function onScroll(table)
		self:refreshStagePoint()
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell
		local pointId = self._pointList[index]

		cell = pointId == self._selectPointId and table:dequeueCellByTag(843) or table:dequeueCellByTag(348)

		if not cell then
			cell = cc.TableViewCell:new()

			local cellView = self._cloneCell:clone()

			cellView:setVisible(true)
			cellView:setAnchorPoint(cc.p(0.5, 1))
			cellView:setName("cellView")

			if pointId == self._selectPointId then
				cell:setTag(843)
				cellView:setPosition(cc.p(210, 145))
				cellView:addTo(cell)
			else
				cell:setTag(348)
				cellView:setPosition(cc.p(210, 78))
				cellView:addTo(cell)
			end

			cell.mediator = ActivityStageCellNew:new(cellView, {
				model = self._model,
				parentMediator = self
			})
		end

		cell.mediator:refreshData(self._selectPointId, pointId)
		cell.mediator:setCellState(self._selectPointId, pointId)
		cell.mediator:setHiddenStory(self:checkShowHiddenStory(pointId))

		return cell
	end

	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(70, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._stagePanel)
	tableView:reloadData()
	tableView:setBounceable(false)
	tableView:setClippingToBounds(false)

	self._tableView = tableView
end

function ActivityMapNewMediator:checkShowHiddenStory(pointId)
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

function ActivityMapNewMediator:getMaxUnlockPointIndex()
	local map = self._model:getActivityMapById(self._mapId)
	local index = 1

	for i, _pointId in ipairs(self._pointList) do
		local _point = map:getPointById(_pointId)

		if _point:isUnlock() and not _point:isPass() then
			index = i
		elseif _point:isUnlock() and _point:isPass() then
			index = i
		end
	end

	return index
end

function ActivityMapNewMediator:refreshStagePoint()
	if not self._tableView or onScrollState then
		return
	end

	local offY = self._tableView:getContentOffset().y
	local maxOffset = self._tableView:minContainerOffset().y
	local percent = math.abs(offY / maxOffset)

	self._pointSlider:setPercent(100 - percent * 100)
	self:changeBGMove()
end

function ActivityMapNewMediator:onGotoHeroSystem()
	local view = self:getInjector():getInstance("HeroShowListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))
end

function ActivityMapNewMediator:onClickEmBattle()
	self._activitySystem:enterTeam(self._activityId, self._model)
end

function ActivityMapNewMediator:setScrollPoint(offY)
	if #self._pointList < 5 then
		self._pointSlider:setVisible(false)

		return
	else
		self._pointSlider:setVisible(true)

		local curPointIndex = table.indexof(self._pointList, self._selectPointId) or 1

		if curPointIndex > 5 then
			if offY then
				self._tableView:setContentOffset(cc.p(0, offY), false)
			else
				local offset = unSelectCellHeight * (curPointIndex - 1)
				local minOffset = self._tableView:minContainerOffset().y

				self._tableView:setContentOffset(cc.p(0, offset + minOffset), false)
			end
		end
	end
end

function ActivityMapNewMediator:onClickNextAction(index)
	local tag = index
	local pointId = self._pointList[tag]
	local pointInfo, pointType = self._model:getPointById(pointId)

	if not pointInfo:isUnlock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("Lock2")
		}))

		return
	end

	if self._selectPointId ~= pointId then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._selectPointId = pointId

		local offY = self._tableView:getContentOffset().y

		self._tableView:reloadData()
		self:setScrollPoint(offY)
	else
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if pointType == kStageTypeMap.point then
			local condition = pointInfo:getConfig().UnlockCondition
			local curTime = self._gameServerAgent:remoteTimestamp()

			if condition and condition.start then
				local startTime = TimeUtil:formatStrToRemoteTImestamp(condition.start)

				if curTime < startTime then
					local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", startTime)

					self:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get("Newyear_ActivityStage_OpenTimeTip", {
							time = date
						})
					}))

					return
				end
			end

			self:enterCommonPoint(pointId, index)
		elseif pointType == kStageTypeMap.StoryPoint then
			self:onClickPlayStory(pointId)
		end
	end

	self:showExchangeBmg()
end

function ActivityMapNewMediator:enterCommonPoint(pointId, index)
	local delegate, outSelf = {}, self
	local data = {
		parent = self,
		pointId = pointId,
		activityId = self._activityId
	}

	function delegate:willClose(popupMediator, data)
		local offset = outSelf._tableView:getContentOffset()

		outSelf._tableView:reloadData()
		outSelf._tableView:setContentOffset(offset)
	end

	local view = self:getInjector():getInstance("ActivityPointDetailNewView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
end

function ActivityMapNewMediator:onClickPlayStory(pointId, isCheck)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local chapterInfo = self._model:getStageByStageIndex(self._stageIndex)
	local chapterConfig = chapterInfo:getConfig()
	local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "StoryLink")
	local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
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
				local delegate, outSelf = {}, self

				function delegate:willClose(popupMediator, data)
					storyDirector:notifyWaiting("story_play_end")
					outSelf:refreshStoryPoint(pointId)
					outSelf._activity:checkVote()
				end

				local view = self:getInjector():getInstance("getRewardView")

				if not response.data.reward then
					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = response.data.reward
					}, delegate))
				end
			end)
		end

		AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
		self._gallerySystem:setActivityStorySaveStatus(self._gallerySystem:getStoryIdByStoryLink(storyLink, pointId), true)

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
	storyAgent:trigger(storyLink, function()
		AudioEngine:getInstance():stopBackgroundMusic()
	end, endCallBack)
end

function ActivityMapNewMediator:refreshStoryPoint(pointId)
	self:storySort(self._storyPointList)
	self:initStage()
	self._tableView:reloadData()
	self:setScrollPoint()
end

function ActivityMapNewMediator:onClickChangeStageStype()
	local toStageType, tips

	if self._stageType == StageType.kNormal then
		toStageType = StageType.kElite
		tips = Strings:get("Change_Crazy_Tips")
	else
		toStageType = StageType.kNormal
		tips = Strings:get("Change_Normal_Tips")
	end

	local lockTip = Strings:get("Activity_Stage_Type_Switch_Tips")

	self:changeStagetype(toStageType, tips, lockTip)
end

function ActivityMapNewMediator:changeStagetype(toStageType, tips, lockTip)
	local map = self._model:getStageByStageIndex(toStageType)
	local mapPoints = map._index2Points
	local firstPoint = mapPoints[1]
	local startTime = firstPoint:getConfig().PointTime

	if startTime and startTime.start then
		local timeStr = startTime.start
		local timeStrTab = string.split(timeStr, " ")
		local _tab1 = TimeUtil:parseDate(nil, timeStrTab[1])
		local _tab2 = TimeUtil:parseTime(nil, timeStrTab[2])

		for k, v in pairs(_tab2) do
			_tab1[k] = v
		end

		local timeStemp = TimeUtil:getTimeByDateForTargetTime(_tab1)
		local curTimeStemp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

		if curTimeStemp < timeStemp then
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(startTime.start)
			local localDate = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", remoteTime)
			local tip = Strings:get("EMap_TimeLimit_Tips", {
				time = localDate
			})

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = (toStageType == StageType.kHard or nil) and Strings:get("HMap_TimeLimit_Tips", {
					time = localDate
				})
			}))

			return
		end
	end

	if map:isUnlock() then
		self._mapId = map:getMapId()
		self._stageType = toStageType
		self._selectPointId = nil

		self:setChapterTitle()
		self:initStage()
		self._tableView:reloadData()
		self:setScrollPoint()
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = lockTip
		}))
	end
end

function ActivityMapNewMediator:onClickAditionButton()
	if not self._model then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._model:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityMapNewMediator:onClickStory()
	local unlock, tips = self._gallerySystem:checkEnabled()

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("GalleryMemoryPackView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		type = GalleryMemoryType.STORY,
		callback = function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshStoryBtnRedPoint()
		end
	}))
end

function ActivityMapNewMediator:onClickColorEgg(sender, egg)
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

function ActivityMapNewMediator:onClickHideUI()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	self._showUI = not self._showUI

	local actionNode = self._main:getChildByName("actionNode")
	local imageViewNode = self:getView():getChildByFullName("main.titleBg")

	actionNode:setVisible(self._showUI)
	imageViewNode:setVisible(self._showUI)
	self._textContent:setVisible(self._showUI)
	self._stageAdditionPanel:setVisible(self._showUI)
	self._pointSlider:setVisible(self._showUI)
	self._stagePanel:setVisible(self._showUI)
	self._bgList:setTouchEnabled(not self._showUI)
	self._hideUIBtn:setOpacity(self._showUI and 255 or 127.5)
end

function ActivityMapNewMediator:refreshBgScroll()
	if not self._bgList:isTouchEnabled() then
		return
	end

	local size = self._bgList:getInnerContainerSize()
	local pos = self._bgList:getInnerContainerPosition()
	local percent = 1 - -pos.y / (size.height - 852)
	local maxOffset = self._tableView:minContainerOffset().y

	self._tableView:setContentOffset(cc.p(0, maxOffset * (1 - percent)))
	self._pointSlider:setPercent(percent * 100)
end

function ActivityMapNewMediator:refreshStoryBtnRedPoint()
	if not self._storyBtnRedPoint then
		self._storyBtnRedPoint = RedPoint:createDefaultNode()

		self._storyBtnRedPoint:addTo(self._storyBtn):posite(80, 80)
		self._storyBtnRedPoint:setName("redPoint")
		self._storyBtnRedPoint:setScale(0.8)
	end

	local st = self._gallerySystem:getStoryPackRedPointByType(GalleryMemoryPackType.ACTIVI)

	self._storyBtnRedPoint:setVisible(st)
end

function ActivityMapNewMediator:onClickChangeStagePartTwo()
	local list = self._model:getMapList()
	local stageIndex = self._stageIndex

	stageIndex = stageIndex >= #list and 1 or stageIndex + 1

	local mapId = self._model:getMapIdByStageIndex(stageIndex)
	local config = self._model:getActivityConfig().ChangeBtnImg[mapId]
	local tips = Strings:get("SubActivity_FireWorks_AB_6st", {
		part = Strings:get(config.Part)
	})
	local mapId = self._model:getMapIdByStageIndex(self._stageIndex)
	local config = self._model:getActivityConfig().ChangeBtnImg[mapId]
	local lockTip = Strings:get("SubActivity_FireWorks_AB_3st", {
		title = Strings:get(config.Part)
	})

	self:changeStagePart(stageIndex, tips, lockTip)
end

function ActivityMapNewMediator:changeStagePart(stageIndex, tips, lockTip)
	local map = self._model:getStageByStageIndex(stageIndex)
	local mapId = self._model:getMapIdByStageIndex(stageIndex)
	local config = self._model:getActivityConfig().ChangeBtnImg[mapId]
	local mapPoints = map._index2Points
	local firstPoint = mapPoints[1]
	local startTime = firstPoint:getConfig().UnlockCondition

	if startTime and startTime.start then
		local timeStr = startTime.start
		local timeStrTab = string.split(timeStr, " ")
		local _tab1 = TimeUtil:parseDate(nil, timeStrTab[1])
		local _tab2 = TimeUtil:parseTime(nil, timeStrTab[2])

		for k, v in pairs(_tab2) do
			_tab1[k] = v
		end

		local timeStemp = TimeUtil:getTimeByDateForTargetTime(_tab1)
		local curTimeStemp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

		if curTimeStemp < timeStemp then
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(startTime.start)
			local localDate = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", remoteTime)
			local tip = Strings:get("SubActivity_FireWorks_AB_2st", {
				title = Strings:get(config.Part),
				time = localDate
			})

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tip
			}))

			return
		end
	end

	local curMap = self._model:getStageByStageIndex(self._stageIndex)

	if map:isUnlock() and (self._stageIndex < #self._model:getMapList() or nil) and self._model:getStageByStageIndex(self._stageIndex):isPass() then
		self._stageIndex = stageIndex
		self._mapId = self._model:getMapIdByStageIndex(stageIndex)

		self:initStage()
		self:setChapterTitle()
		self:getColorEggs()
		self._tableView:reloadData()
		self:setScrollPoint()
		self:playBackGroundMusic()
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = lockTip
		}))
	end
end
