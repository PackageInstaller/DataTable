-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMemoryListMediator.lua

GalleryMemoryListMediator = class("GalleryMemoryListMediator", DmAreaViewMediator, _M)

GalleryMemoryListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMemoryListMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {}
local InfoImage = {
	[GalleryMemoryType.STORY] = "album_img_jqsx.png",
	[GalleryMemoryType.HERO] = "album_img_hbxz.png",
	[GalleryMemoryType.ACTIVI] = "album_img_gthy.png"
}
local MemoryTitle = {
	[GalleryMemoryType.STORY] = Strings:get("GALLERY_UI15"),
	[GalleryMemoryType.HERO] = Strings:get("GALLERY_UI16"),
	[GalleryMemoryType.ACTIVI] = Strings:get("GALLERY_UI17")
}
local ShowLineNum = 4

function GalleryMemoryListMediator:initialize()
	super.initialize(self)
end

function GalleryMemoryListMediator:dispose()
	super.dispose(self)
end

function GalleryMemoryListMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function GalleryMemoryListMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initView()
	self:initInfoView()
	self._gallerySystem:setLastViewTimeOfMemory(self._storyId or self._memoryType)
end

function GalleryMemoryListMediator:resumeWithData(data)
	self:refreshAllRedPoint()
end

function GalleryMemoryListMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._infoNode = self._main:getChildByFullName("infoNode")
	self._cellClone = self._main:getChildByFullName("clonePanel")

	self._cellClone:setVisible(false)

	self._nodeClone = self._main:getChildByFullName("nodeClone")

	self._nodeClone:setVisible(false)

	self._lockPanel = self._main:getChildByFullName("lockPanel")

	self._lockPanel:setVisible(false)

	self._maskPanel = self:getView():getChildByName("maskPanel")

	self._maskPanel:setVisible(false)
	self:ignoreSafeArea()

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._tableViewPanel:setContentSize(cc.size(self._tableViewPanel:getContentSize().width, winSize.height))

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._infoNode:getChildByName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	self._infoNode:getChildByName("num"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	self._infoNode:getChildByName("loadingBar"):setScale9Enabled(true)
	self._infoNode:getChildByName("loadingBar"):setCapInsets(cc.rect(10, 1, 1, 1))

	local locationX = 300 + AdjustUtils.getAdjustX()

	self._infoNode:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(0.3 * locationX / 200, cc.p(-locationX, 395))))
end

function GalleryMemoryListMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryMemoryListMediator:ignoreSafeArea()
	local titleImage = self._main:getChildByFullName("titleImage")

	AdjustUtils.ignorSafeAreaRectForNode(titleImage, AdjustUtils.kAdjustType.Left)
end

function GalleryMemoryListMediator:initData(data)
	self._memoryType = data.type
	self._title = data.title

	if self._memoryType == GalleryMemoryType.STORY and data.storyType and data.storyId then
		self._storyType = data.storyType
		self._storyId = data.storyId
		self._showList, self._eliteShowList = self._gallerySystem:getMemorieStorysById(data.storyType, data.storyId)
	else
		self._storyType = nil
		self._storyId = nil
		self._showList = self._gallerySystem:getMemoriesByType(self._memoryType)
		self._eliteShowList = {}
	end

	self._tableViewCell = {}
end

function GalleryMemoryListMediator:initInfoView()
	if self._memoryType == GalleryMemoryType.STORY then
		self._infoNode:setVisible(false)

		return
	end

	local text = self._infoNode:getChildByName("text")
	local image = self._infoNode:getChildByName("image")
	local num = self._infoNode:getChildByName("num")
	local loadingBar = self._infoNode:getChildByName("loadingBar")

	image:loadTexture(InfoImage[self._memoryType], 1)
	text:setString(MemoryTitle[self._memoryType])

	if self._memoryType == GalleryMemoryType.ACTIVI then
		num:setVisible(false)
		loadingBar:setVisible(false)
		self._infoNode:getChildByName("Image_30"):setVisible(false)
	else
		local data = self._gallerySystem:getMemoryValueByType(self._memoryType)

		num:setString(data[1] .. "/" .. data[2])
		loadingBar:setPercent(data[1] / data[2] * 100)
	end
end

function GalleryMemoryListMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if idx + 1 == math.ceil(#self._showList / ShowLineNum) then
			return self._cellClone:getContentSize().width, self._cellClone:getContentSize().height
		end

		return self._cellClone:getContentSize().width, self._cellClone:getContentSize().height
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._showList / ShowLineNum) + math.ceil(#self._eliteShowList / ShowLineNum)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
	self:setScrollOffset()
end

function GalleryMemoryListMediator:createTeamCell(cell, index)
	cell:removeAllChildren()
	cell:setLocalZOrder(99 - index)

	local cellPanel = self._cellClone:clone()

	cellPanel:setVisible(true)
	cellPanel:addTo(cell):setName("cellPanel")
	cellPanel:setPosition(cc.p(self:getCellPosition(index), 0))
	cellPanel:setTag(12138)

	local image = cellPanel:getChildByFullName("image")

	image:setRotation(self:getCellRotation(index))

	self._tableViewCell[index] = cell

	cell:setVisible(false)
	cell:setName("cell_" .. index)
	self:runStartAnim(cell)

	if (index - 1) * ShowLineNum < #self._showList then
		for i = 1, ShowLineNum do
			local data = self._showList[ShowLineNum * (index - 1) + i]

			if data then
				local panel = cellPanel:getChildByFullName("image"):getChildByFullName("panel_" .. i)

				panel:setTouchEnabled(true)
				panel:setSwallowTouches(false)
				panel:addTouchEventListener(function(sender, eventType)
					self:onClickMemory(sender, eventType, data, ShowLineNum * (index - 1) + i, "NORMAL")
				end)

				local node = self._nodeClone:clone()

				node:setVisible(true)
				node:setPosition(cc.p(0, 3))
				node:addTo(panel)
				node:getChildByName("image"):loadTexture(data:getIcon())
				node:getChildByName("image"):ignoreContentAdaptWithSize(true)
				node:getChildByName("text"):setString(data:getTitle())

				if not data:getUnlock() then
					local lockTip = data:getLockTip()

					if lockTip == "" then
						local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
						local str = conditionkeeper:getConditionDesc(data:getCondition()[1])

						data:setLockTip(str)

						lockTip = str
					end

					node:getChildByName("text"):setString(lockTip)
					node:getChildByName("image"):setColor(cc.c3b(125, 125, 125))
				else
					self:refreshRedPoint(panel, data)
				end
			end
		end
	elseif #self._eliteShowList > 0 then
		local index2 = index - math.ceil(#self._showList / ShowLineNum)

		for i = 1, ShowLineNum do
			local data = self._eliteShowList[ShowLineNum * (index2 - 1) + i]

			if data then
				local panel = cellPanel:getChildByFullName("image"):getChildByFullName("panel_" .. i)

				panel:setTouchEnabled(true)
				panel:setSwallowTouches(false)
				panel:addTouchEventListener(function(sender, eventType)
					self:onClickMemory(sender, eventType, data, ShowLineNum * (index2 - 1) + i, "ELITE")
				end)

				local node = self._nodeClone:clone()

				node:setVisible(true)
				node:setPosition(cc.p(0, 3))
				node:addTo(panel)
				node:getChildByName("image"):loadTexture(data:getIcon())
				node:getChildByName("image"):ignoreContentAdaptWithSize(true)
				node:getChildByName("text"):setString(data:getTitle())

				if not data:getUnlock() then
					local lockTip = data:getLockTip()

					if lockTip == "" then
						local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
						local str = conditionkeeper:getConditionDesc(data:getCondition()[1])

						data:setLockTip(str)

						lockTip = str
					end

					node:getChildByName("text"):setString(lockTip)
					node:getChildByName("image"):setColor(cc.c3b(125, 125, 125))
				else
					self:refreshRedPoint(panel, data)
				end
			end
		end
	end
end

function GalleryMemoryListMediator:onClickMemory(sender, eventType, data, index, stageType)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true

		if data:getUnlock() then
			local scale1 = cc.ScaleTo:create(0.1, 0.9)

			sender:runAction(scale1)
		end
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if not data:getUnlock() then
				local lockTip = data:getLockTip()

				if lockTip == "" then
					local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
					local str = conditionkeeper:getConditionDesc(data:getCondition()[1])

					data:setLockTip(str)

					lockTip = str
				end

				self:dispatch(ShowTipEvent({
					tip = lockTip
				}))

				return
			end

			self._maskPanel:setVisible(true)

			local scale3 = cc.ScaleTo:create(0.12, 1)
			local callfunc = cc.CallFunc:create(function()
				local maskImage = self:getView():getChildByName("maskImage")
				local fade = cc.FadeIn:create(0.2)
				local func = cc.CallFunc:create(function()
					self:onClickCallback(sender, data, index, stageType)

					self._isReturn = true

					maskImage:setOpacity(0)
					self._maskPanel:setVisible(false)
				end)
				local seq = cc.Sequence:create(fade, func)

				maskImage:runAction(seq)
			end)
			local seq = cc.Sequence:create(scale3, callfunc)

			sender:runAction(seq)
		else
			sender:stopAllActions()
		end

		sender:setScale(1)
	elseif eventType == ccui.TouchEventType.canceled then
		sender:stopAllActions()
		sender:setScale(1)
	end
end

function GalleryMemoryListMediator:onClickCallback(sender, data, inde, stageType)
	if data:getType() == GalleryMemoryType.STORY then
		local storyLink = data:getStoryLink()

		if storyLink ~= "" then
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(true)

			local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()

			storyAgent:trigger(storyLink, function()
				return
			end, function()
				self._gallerySystem:setActivityStorySaveStatus(data:getId(), false)
				self:refreshRedPoint(sender, data, false)

				local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
				local statisticsData = storyAgent:getStoryStatisticsData(storyLink)
				local var_24_0 = {
					type = "plot_end",
					id_first = 0,
					point = "plot_end",
					op_type = self._storyType == "ACTIVILIST" and "plot_activity" or "plot_stage"
				}

				if self._storyType == "ACTIVILIST" then
					var_24_0.activityid = self._title or nil
				end

				if self._storyType == "STORYLIST" then
					var_24_0.stagetype = stageType or nil
				end

				var_24_0.plot_id = storyLink
				var_24_0.plot_name = data:getTitle()
				var_24_0.totaltime = endTs - startTs
				var_24_0.detail = statisticsData.detail
				var_24_0.amount = statisticsData.amount
				var_24_0.misc = statisticsData.misc

				StatisticSystem:send(var_24_0)
			end)
		end
	else
		local view = self:getInjector():getInstance("GalleryMemoryInfoView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			data = data,
			listData = self._showList
		}, nil))
		self:refreshRedPoint(sender, data, false)
	end
end

function GalleryMemoryListMediator:onClickBack()
	if self._memoryType == GalleryMemoryType.STORY then
		for index, data in ipairs(self._showList) do
			self._gallerySystem:setActivityStorySaveStatus(data:getId(), false)
		end

		for index, data in ipairs(self._eliteShowList) do
			self._gallerySystem:setActivityStorySaveStatus(data:getId(), false)
		end
	end

	self:dismiss()
end

function GalleryMemoryListMediator:runStartAnim(cell)
	if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(cell) then
		return
	end

	local speed = 0.9

	local function runActionFun1(node)
		node:setRotation(-5)
		node:setOpacity(200)
		node:fadeIn({
			time = 0.1 * speed
		})
		node:setScale(1.2)

		local rotate1 = cc.RotateTo:create(0.1 * speed, 1.5)
		local resize1 = cc.ScaleTo:create(0.1 * speed, 0.8)
		local spawn1 = cc.Spawn:create(rotate1, resize1)
		local rotate2 = cc.RotateTo:create(0.1 * speed, 0.6)
		local resize2 = cc.ScaleTo:create(0.1 * speed, 1)
		local spawn2 = cc.Spawn:create(rotate2, resize2)
		local seq = cc.Sequence:create(spawn1, spawn2)

		node:runAction(seq)
	end

	local function runActionFun2(node)
		node:setRotation(10)
		node:setOpacity(200)
		node:setScale(1.2)
		node:setVisible(false)

		local delay = cc.DelayTime:create(0.3 * speed)
		local callfunc = cc.CallFunc:create(function()
			node:setVisible(true)
		end)
		local fadein = cc.FadeIn:create(0.06)
		local rotate1 = cc.RotateTo:create(0.1 * speed, 0)
		local resize1 = cc.ScaleTo:create(0.1 * speed, 0.8)
		local spawn1 = cc.Spawn:create(fadein, rotate1, resize1)
		local resize2 = cc.ScaleTo:create(0.1 * speed, 1)
		local seq = cc.Sequence:create(delay, callfunc, spawn1, resize2)

		node:runAction(seq)
	end

	local function runActionFun3(node)
		node:setRotation(10)
		node:setOpacity(200)
		node:setVisible(false)
		node:setScale(1.2)

		local delay = cc.DelayTime:create(0.6 * speed)
		local callfunc1 = cc.CallFunc:create(function()
			node:setVisible(true)
		end)
		local fadein = cc.FadeIn:create(0.06)
		local rotate1 = cc.RotateTo:create(0.1 * speed, 1.3)
		local resize1 = cc.ScaleTo:create(0.1 * speed, 0.8)
		local spawn1 = cc.Spawn:create(fadein, rotate1, resize1)
		local resize2 = cc.ScaleTo:create(0.1 * speed, 1)
		local seq = cc.Sequence:create(delay, callfunc1, spawn1, resize2)

		node:runAction(seq)
	end

	local function runActionFun()
		cell:setVisible(true)

		local panel = cell:getChildByTag(12138)

		if panel:getChildByFullName("image") then
			local node = panel:getChildByFullName("image")
			local index = string.split(cell:getName(), "_")[2]

			if self["run_" .. index] then
				return
			end

			if index == "1" then
				runActionFun1(node)
			elseif index == "2" then
				runActionFun2(node)
			elseif index == "3" then
				runActionFun3(node)
			end

			self["run_" .. index] = true
		end
	end

	runActionFun()
end

function GalleryMemoryListMediator:getCellRotation(index)
	local rotation = 0
	local mod = math.fmod(index, 3)

	if mod == 0 then
		rotation = 1.3
	elseif mod == 1 then
		rotation = 0.6
	end

	return rotation
end

function GalleryMemoryListMediator:getCellPosition(index)
	local position = 0
	local mod = math.fmod(index, 3)

	if mod == 2 then
		position = 15
	elseif mod == 0 then
		position = -5
	end

	return position
end

function GalleryMemoryListMediator:setScrollOffset()
	if not self._memoryType or self._memoryType == GalleryMemoryType.STORY and self._storyType == GalleryMemoryPackType.STORY then
		return
	end

	local index = self._gallerySystem:getFirstNewMemoryByType(self._memoryType, self._storyId)

	if not index then
		return
	end

	index = table.indexof(self._showList, index)

	if index and index > 0 then
		if index <= ShowLineNum then
			return
		end

		index = math.ceil(index / ShowLineNum) - 2
	else
		return
	end

	if self._heroView then
		local offset = self._heroView:getContentOffset()

		offset.y = offset.y + index * self._cellClone:getContentSize().height

		if offset.y >= 0 then
			offset.y = 0
		end

		self._heroView:setContentOffset(cc.p(0, offset.y))
	end
end

function GalleryMemoryListMediator:refreshRedPoint(panel, data, value)
	if not panel then
		return
	end

	local redPoint = panel:getChildByName("redPoint")

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(250, 120)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint")
		redPoint:setScale(0.7)
	end

	if value ~= nil or not data then
		redPoint:setVisible(value)
	else
		redPoint:setVisible(self._gallerySystem:isNewMemory(data))
	end
end

function GalleryMemoryListMediator:refreshAllRedPoint()
	if not self._heroView or DisposableObject:isDisposed(self._heroView) then
		return
	end

	local offset = self._heroView:getContentOffset()

	self._heroView:reloadData()
	self._heroView:setContentOffset(cc.p(offset.x, offset.y))
end
