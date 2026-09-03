-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityOrientMapMediator.lua

require("dm.gameplay.activity.model.stageModel.ActivityStageCellNew")

ActivityOrientMapMediator = class("ActivityOrientMapMediator", DmAreaViewMediator, _M)

ActivityOrientMapMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityOrientMapMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ActivityOrientMapMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityOrientMapMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local BaseChapterPath = "asset/scene/"
local ShowPointNum = 4
local normalCellAnim = {
	{
		open = "bq5_huijiadeluzhuyefuben",
		close = "bqs5_huijiadeluzhuyefuben"
	},
	{
		open = "bq4_huijiadeluzhuyefuben",
		close = "bqs4_huijiadeluzhuyefuben"
	},
	{
		open = "bq1_huijiadeluzhuyefuben",
		close = "bqs1_huijiadeluzhuyefuben"
	}
}
local kBtnHandlers = {
	["main.actionNode.btn_emBattle"] = {
		func = "onClickEmBattle"
	},
	["main.actionNode.btn_stage"] = {
		func = "onClickChangeStage"
	},
	["main.actionNode.btn_story"] = {
		func = "onClickStory"
	},
	["main.stagePanel.btn_left"] = {
		func = "onClickLeft"
	},
	["main.stagePanel.btn_right"] = {
		func = "onClickRight"
	}
}

function ActivityOrientMapMediator:initialize()
	super.initialize(self)
end

function ActivityOrientMapMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshStoryColorEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COLOUR_EGG_REFRESH, self, self.refreshEggs)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GET_NEW_STORY, self, self.refreshStoryBtnRedPoint)
end

function ActivityOrientMapMediator:setupTopInfoWidget()
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

function ActivityOrientMapMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._blockActivityId = data.blockActivityId
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
		return
	end

	self._showUI = true
	self._data = data or {}
	self._stageIndex = data.enterBattlePointId and self._model:getMapIdexBySortId(data.enterBattlePointId) or self._data.stageIndex or 1
	self._mapId = self._model:getMapIdByStageIndex(self._stageIndex)
	self._pointCells = {}

	self:initWidget()
	self:setupTopInfoWidget()
	self:initStage()
	self:setChapterTitle()
	self:setAdditionHero()
	self:playBackGroundMusic()
	self:getColorEggs()
	self:refreshStoryBtnRedPoint()
end

function ActivityOrientMapMediator:doReset()
	self:getColorEggs()
end

function ActivityOrientMapMediator:refreshEggs(event)
	local data = event:getData()
	local eggIds = data.ids

	self:refreshColorEggs(eggIds)
	self:refreshStoryColorEggs()
end

function ActivityOrientMapMediator:getColorEggs()
	self._colorEggActivity = self._activity:getColourEggActivity()

	if self._colorEggActivity then
		self._activitySystem:colourEggGetAll(self._activityId, self._colorEggActivity:getId(), function()
			return
		end)
	end
end

function ActivityOrientMapMediator:resumeWithData(data)
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
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
	self:playBackGroundMusic()
end

function ActivityOrientMapMediator:playBackGroundMusic()
	local chapterInfo = self._model:getStageByStageIndex(self._stageIndex)
	local chapterConfig = chapterInfo:getConfig()

	AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
end

function ActivityOrientMapMediator:setAdditionHero()
	local btns = self._activity:getButtonConfig()

	if btns.blockParams and btns.blockParams.heroes then
		local length = #btns.blockParams.heroes

		for i = 1, length do
			local id = btns.blockParams.heroes[i]
			local icon = IconFactory:createHeroIconForReward({
				star = 0,
				id = id
			})

			icon:addTo(self._stageRewardsPanel):setScale(0.45)

			local x = (i - 1) * 65 + 5

			icon:setPositionX(x)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end

		self._stageAdditionPanel:setContentSize(cc.size(#btns.blockParams.heroes * 65 + 95, 70))
	end
end

function ActivityOrientMapMediator:setChapterTitle()
	local chapterInfo = self._model:getStageByStageIndex(self._stageIndex)
	local chapterConfig = chapterInfo:getConfig()
	local activityConfig = self._model:getActivityConfig()
	local mainBgPanel = self._main:getChildByName("bg")

	mainBgPanel:removeAllChildren()

	local path = activityConfig.BackgroundScene[self._stageIndex]

	if path then
		local background = cc.Sprite:create(BaseChapterPath .. path .. ".jpg")

		background:setAnchorPoint(cc.p(0.5, 0.5))
		background:addTo(mainBgPanel):center(mainBgPanel:getContentSize())
	end

	if chapterConfig then
		self._textContent:setString(Strings:get(chapterConfig.MapName))

		local bgNode = self._bgPanel:getChildByName("bg")

		bgNode:removeAllChildren()

		local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Picture")

		if backgroundId and backgroundId ~= "" then
			local background = ccui.ImageView:create(BaseChapterPath .. backgroundId .. ".jpg")

			background:setAnchorPoint(cc.p(0.5, 0.5))
			background:addTo(bgNode):center(bgNode:getContentSize()):offset(0, 2)
		end

		local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash1")

		if flashId and flashId ~= "" then
			local mc = cc.MovieClip:create(flashId)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgNode)
		end

		local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash2")

		if flashId2 and flashId2 ~= "" then
			local mc = cc.MovieClip:create(flashId2)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgNode)
		end

		local plistViewId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Extra")

		if plistViewId and plistViewId ~= "" then
			local plistView = cc.CSLoader:createNode("asset/ui/" .. plistViewId .. ".csb")

			plistView:addTo(bgNode):center(cc.size(1136, 640))
		end
	end

	local config = activityConfig.ChangeBtnImg[self._mapId]

	if not config.Image then
		local name = Strings:get(config.Part) or "NONE"

		self._stageBtnTxt:setString(Strings:get(name))
	end
end

function ActivityOrientMapMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._stagePanel = self:getView():getChildByFullName("main.stagePanel")

	self._stagePanel:setLocalZOrder(2)

	self._cloneCell = self._main:getChildByFullName("cell_clone")

	self._cloneCell:setVisible(false)

	self._textContent = self:getView():getChildByFullName("main.stagePanel.bg.titleContent")
	self._stageAdditionPanel = self:getView():getChildByFullName("main.stageAddition")
	self._emBattleBtn = self._main:getChildByFullName("actionNode.btn_emBattle")
	self._storyBtn = self._main:getChildByFullName("actionNode.btn_story")
	self._stageBtn = self._main:getChildByFullName("actionNode.btn_stage")
	self._choicePanel = self._main:getChildByFullName("actionNode.choicePanel")
	self._emBattleBtnX = self._emBattleBtn:getPositionX()
	self._stageBtnX = self._stageBtn:getPositionX()
	self._stageBtnTxt = self._stageBtn:getChildByName("Text_1")
	self._stageRewardsPanel = self:getView():getChildByFullName("main.stageAddition.stageRewards")
	self._leftBtn = self._stagePanel:getChildByName("btn_left")
	self._rightBtn = self._stagePanel:getChildByName("btn_right")
	self._bgPanel = self._stagePanel:getChildByFullName("bg")

	self._stageAdditionPanel:addClickEventListener(function()
		self:onClickAdditionButton()
	end)

	self._colorEggPointView = {}
end

function ActivityOrientMapMediator:switchMainScene()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
end

function ActivityOrientMapMediator:initStage()
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

	self:createStagePoint()
	self:showOpenAnim()
end

function ActivityOrientMapMediator:storySort(tab)
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

function ActivityOrientMapMediator:createStagePoint(showPageIndex)
	local activityConfig = self._model:getActivityConfig()
	local posArr = activityConfig["LevelPointLocationM0" .. self._stageIndex]

	if showPageIndex then
		self._showPageIndex = showPageIndex
	else
		local curPointIndex = table.indexof(self._pointList, self._selectPointId) or 1

		self._showPageIndex = math.ceil(curPointIndex / ShowPointNum)
	end

	local maxPageCount = math.ceil(#self._pointList / ShowPointNum)
	local startIndex = 1 + (self._showPageIndex - 1) * ShowPointNum

	for i = 1, ShowPointNum do
		local cell = self._pointCells[i]

		if not cell then
			cell = self._cloneCell:clone()

			cell:addTo(self._stagePanel):posite(posArr[i][1] + 47, posArr[i][2] + 47)

			self._pointCells[i] = cell
		end

		cell:setVisible(false)

		cell.pointId = nil

		local pointId = self._pointList[startIndex + i - 1]

		if pointId then
			cell:setVisible(true)

			cell.pointId = pointId

			self:setupPointCell(cell, pointId)

			local function callFunc()
				self:onClickPointCell(pointId)
			end

			mapButtonHandlerClick(nil, cell, {
				clickAudio = "Se_Click_Open_1",
				func = callFunc
			})
		end
	end

	self._leftBtn:setVisible(self._showPageIndex > 1)
	self._rightBtn:setVisible(maxPageCount > self._showPageIndex)
end

function ActivityOrientMapMediator:setupPointCell(cell, pointId)
	local pointInfo, pointType = self._model:getPointById(pointId)
	local isUnLock = pointInfo:isUnlock()
	local isPassed = pointInfo:isPass()
	local normalPanel = cell:getChildByName("normal")
	local storyPanel = cell:getChildByName("story")

	storyPanel:setVisible(false)
	normalPanel:setVisible(false)

	local nameText = cell.nameText

	if not nameText then
		nameText = cell:getChildByName("Text_name")
		cell.nameText = nameText
	end

	nameText:setString(pointInfo:getName())

	local redPoint = cell.redPoint

	if not redPoint then
		redPoint = cell:getChildByName("redPoint")
		cell.redPoint = redPoint
	end

	redPoint:setVisible(false)

	local anim = cell.anim

	if anim then
		nameText:changeParent(cell)
		redPoint:changeParent(cell)

		if cell.indexText then
			cell.indexText:changeParent(cell)
			cell.indexText:setVisible(false)
		end

		anim:removeFromParent()
	end

	local closeAnim = cell.closeAnim

	if closeAnim then
		closeAnim:removeFromParent()
	end

	if pointType == kStageTypeMap.StoryPoint then
		storyPanel:setVisible(true)

		anim = self:createAnim("bq3_huijiadeluzhuyefuben", storyPanel, cc.p(140, 23))
		closeAnim = self:createAnim("bqs3_huijiadeluzhuyefuben", storyPanel, cc.p(140, 23))
		cell.anim = anim
		cell.closeAnim = closeAnim

		anim:setGray(not isUnLock)
	elseif pointType == kStageTypeMap.point then
		local isPerfect = pointInfo:isPerfect()

		normalPanel:setVisible(true)

		local indexText = cell.indexText

		if not indexText then
			indexText = normalPanel:getChildByName("Text_index")
			cell.indexText = indexText
		end

		cell.indexText:setVisible(true)
		indexText:setString(pointInfo:getIndex())

		if isPerfect then
			anim = self:createAnim(normalCellAnim[3].open, normalPanel, cc.p(136, 35))
			closeAnim = self:createAnim(normalCellAnim[3].close, normalPanel, cc.p(136, 35))
		elseif isPassed then
			anim = self:createAnim(normalCellAnim[2].open, normalPanel, cc.p(140, 35))
			closeAnim = self:createAnim(normalCellAnim[2].close, normalPanel, cc.p(140, 35))

			anim:setGray(false)
		else
			anim = self:createAnim(normalCellAnim[1].open, normalPanel, cc.p(140, 35))
			closeAnim = self:createAnim(normalCellAnim[1].close, normalPanel, cc.p(140, 35))

			anim:setGray(not isUnLock)
		end

		cell.anim = anim
		cell.closeAnim = closeAnim

		local indexNode = cell.anim:getChildByName("index")

		indexText:changeParent(indexNode):center(indexNode:getContentSize()):offset(0, 0)

		local rid = self._developSystem:getPlayer():getRid()
		local value = cc.UserDefault:getInstance():getBoolForKey("activityStageRed" .. pointInfo:getId() .. rid, false)

		redPoint:setVisible(pointInfo:isUnlock() and pointInfo:isPass() and not pointInfo:isPerfect() and not value)
	end

	local nameNode = cell.anim:getChildByName("name")

	nameText:changeParent(nameNode):center(nameNode:getContentSize()):offset(-5, 1)
	redPoint:changeParent(nameNode):center(nameNode:getContentSize()):offset(73, 5)
	cell.closeAnim:setVisible(false)
	cell.anim:gotoAndStop(20)
end

function ActivityOrientMapMediator:createAnim(animName, parent, pos)
	local anim = cc.MovieClip:create(animName)

	anim:addTo(parent):setPosition(pos)
	anim:gotoAndStop(1)
	anim:addEndCallback(function()
		anim:stop()
	end)

	return anim
end

function ActivityOrientMapMediator:showOpenAnim()
	if not self._openAnim then
		local openAnim = cc.MovieClip:create("open_huijiadeluzhuyefuben")

		openAnim:addTo(self._stagePanel, -1):center(self._stagePanel:getContentSize()):offset(36, 67)

		local bgNode = openAnim:getChildByFullName("bg")
		local bg1 = self._bgPanel

		bg1:changeParent(bgNode):center(bgNode:getContentSize())
		openAnim:addEndCallback(function()
			openAnim:stop()
		end)

		self._openAnim = openAnim
	end

	self._openAnim:gotoAndPlay(1)
	self._openAnim:setVisible(true)

	for i, v in pairs(self._pointCells) do
		v:setVisible(false)
	end

	self._openAnim:addCallbackAtFrame(12, function()
		self:showPointCellAnim(1)
	end)
end

function ActivityOrientMapMediator:showPointCellAnim(index)
	local cell = self._pointCells[index]

	if cell and cell.pointId then
		cell:setVisible(true)

		local anim = cell.anim

		anim:gotoAndPlay(1)
		anim:addCallbackAtFrame(5, function()
			self:showPointCellAnim(index + 1)
		end)
	end
end

function ActivityOrientMapMediator:refreshColorEggs(eggIds)
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

				local bgPanel = self:getView():getChildByFullName("main.bg")

				node:addTo(bgPanel, 500):posite(bgPanel:getContentSize().width * 0.5 + pos[1], pos[2])
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

				local bgPanel = self:getView():getChildByFullName("main.bg")

				node:addTo(bgPanel, 500):posite(bgPanel:getContentSize().width * 0.5 + pos[1], pos[2])

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

function ActivityOrientMapMediator:refreshStoryColorEggs()
	if not self._model then
		return
	end

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

function ActivityOrientMapMediator:checkShowHiddenStory(pointId)
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

function ActivityOrientMapMediator:getMaxUnlockPointIndex()
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

function ActivityOrientMapMediator:onClickEmBattle()
	self._activitySystem:enterTeam(self._activityId, self._model)
end

function ActivityOrientMapMediator:onClickPointCell(pointId)
	local pointInfo, pointType = self._model:getPointById(pointId)

	if not pointInfo:isUnlock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("Lock2")
		}))

		return
	end

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

		self:enterCommonPoint(pointId)
	elseif pointType == kStageTypeMap.StoryPoint then
		self:onClickPlayStory(pointId)
	end
end

function ActivityOrientMapMediator:enterCommonPoint(pointId)
	self._selectPointId = pointId

	local delegate, outSelf = {}, self
	local data = {
		parent = self,
		pointId = pointId,
		activityId = self._activityId
	}

	function delegate:willClose(popupMediator, data)
		outSelf:createStagePoint()
	end

	local view = self:getInjector():getInstance("ActivityPointDetailNewView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
end

function ActivityOrientMapMediator:onClickPlayStory(pointId, isCheck)
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

		self:playBackGroundMusic()
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

function ActivityOrientMapMediator:refreshStoryPoint(pointId)
	self:storySort(self._storyPointList)
	self:initStage()
end

function ActivityOrientMapMediator:onClickAdditionButton()
	if not self._model then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._model:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityOrientMapMediator:onClickStory()
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
			self:refreshStoryBtnRedPoint()
		end
	}))
end

function ActivityOrientMapMediator:onClickColorEgg(sender, egg)
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

function ActivityOrientMapMediator:refreshStoryBtnRedPoint()
	if not self._storyBtnRedPoint then
		self._storyBtnRedPoint = RedPoint:createDefaultNode()

		self._storyBtnRedPoint:addTo(self._storyBtn):posite(80, 80)
		self._storyBtnRedPoint:setName("redPoint")
		self._storyBtnRedPoint:setScale(0.8)
	end

	local st = self._gallerySystem:getStoryPackRedPointByType(GalleryMemoryPackType.ACTIVI)

	self._storyBtnRedPoint:setVisible(st)
end

function ActivityOrientMapMediator:onClickChangeStage()
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

function ActivityOrientMapMediator:changeStagePart(stageIndex, tips, lockTip)
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
		self:showChangePartAnim(function()
			self._stageIndex = stageIndex
			self._mapId = self._model:getMapIdByStageIndex(stageIndex)

			self:initStage()
			self:setChapterTitle()
			self:getColorEggs()
			self:playBackGroundMusic()
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))
		end)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = lockTip
		}))
	end
end

function ActivityOrientMapMediator:onClickLeft()
	local showPageIndex = self._showPageIndex - 1

	self:createStagePoint(showPageIndex)
	self:showPointCellAnim(1)
end

function ActivityOrientMapMediator:onClickRight()
	local showPageIndex = self._showPageIndex + 1

	self:createStagePoint(showPageIndex)
	self:showPointCellAnim(1)
end

function ActivityOrientMapMediator:showChangePartAnim(callback)
	if self._closeAnim then
		return
	end

	self._openAnim:setVisible(false)

	local closeAnim = cc.MovieClip:create("close_huijiadeluzhuyefuben")

	closeAnim:addTo(self._stagePanel, -1):center(self._stagePanel:getContentSize()):offset(36, 67)

	self._closeAnim = closeAnim

	local bgNode = closeAnim:getChildByFullName("bg")
	local bg = self._bgPanel:clone()

	bg:addTo(bgNode):center(bgNode:getContentSize())
	closeAnim:addEndCallback(function()
		closeAnim:stop()
		closeAnim:removeFromParent()

		self._closeAnim = nil

		callback()
	end)
	closeAnim:gotoAndStop(1)

	for i, v in pairs(self._pointCells) do
		if v.anim then
			v.anim:setVisible(false)
		end

		if v.closeAnim then
			v.closeAnim:setVisible(true)
			v.closeAnim:gotoAndPlay(1)
			v.closeAnim:addCallbackAtFrame(10, function()
				if i == 1 then
					closeAnim:gotoAndPlay(1)
				end
			end)
			v.closeAnim:addEndCallback(function()
				v.closeAnim:setVisible(false)
				v.closeAnim:clearCallbacks()
			end)

			local nameNode = v.closeAnim:getChildByName("name")

			v.nameText:clone():addTo(nameNode):center(nameNode:getContentSize()):offset(-5, 1)

			local indexNode = v.closeAnim:getChildByName("index")

			if indexNode and v.indexText then
				v.indexText:clone():addTo(indexNode):center(indexNode:getContentSize())
			end
		end
	end
end
