-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMemoryPackMediator.lua

GalleryMemoryPackMediator = class("GalleryMemoryPackMediator", DmAreaViewMediator, _M)

GalleryMemoryPackMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMemoryPackMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {}
local Titles = {
	Strings:get("Gallery_Memory_title_1"),
	(Strings:get("Gallery_Memory_title_2"))
}
local TitlesType = {
	GalleryMemoryPackType.STORY,
	GalleryMemoryPackType.ACTIVI
}
local ShowLineNum = 4
local infoImage = "album_img_jqsx.png"
local memoryTitle = Strings:get("GALLERY_UI15")

function GalleryMemoryPackMediator:initialize()
	super.initialize(self)
end

function GalleryMemoryPackMediator:dispose()
	if self._delegateCallback then
		self._delegateCallback()
	end

	super.dispose(self)
end

function GalleryMemoryPackMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function GalleryMemoryPackMediator:mapEventListeners()
	return
end

function GalleryMemoryPackMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initLeftView()
	self:initView()
	self:initInfoView()
	self:changePageView()
	self:runStartAnim()
end

function GalleryMemoryPackMediator:resumeWithData()
	self:refreshRedPoint(self._sender, self._senderData)
	self:refreshTitlePanelRedPoint()
end

function GalleryMemoryPackMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._infoNode = self._main:getChildByFullName("infoNode")
	self._leftPanel = self._main:getChildByFullName("leftPanel")
	self._leftTitleNode = self._leftPanel:getChildByFullName("leftTitleNode")
	self._cellClone = self._main:getChildByFullName("clonePanel")

	self._cellClone:setVisible(false)

	self._titleCellClone = self._main:getChildByFullName("cloneTitlePanel")

	self._titleCellClone:setVisible(false)

	self._leftTitleClone = self._main:getChildByFullName("leftTitleClone")

	self._leftTitleClone:setVisible(false)

	self._nodeClone = self._main:getChildByFullName("nodeClone")

	self._nodeClone:setVisible(false)

	self._lockNodeClone = self._main:getChildByFullName("lockPanel")

	self._lockNodeClone:setVisible(false)

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

function GalleryMemoryPackMediator:setupTopInfoWidget()
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

function GalleryMemoryPackMediator:ignoreSafeArea()
	local titleImage = self._main:getChildByFullName("titleImage")

	AdjustUtils.ignorSafeAreaRectForNode(titleImage, AdjustUtils.kAdjustType.Left)
end

function GalleryMemoryPackMediator:initData(data)
	self._memoryType = data.type
	self._showList = {}
	self._showList[1] = self._gallerySystem:getMemoriePacksByType(GalleryMemoryPackType.STORY)
	self._showList[2] = self._gallerySystem:getMemoriePacksByType(GalleryMemoryPackType.ACTIVI)
	self._showList[3] = self._gallerySystem:getMemoriePacksByType(GalleryMemoryPackType.HERO)
	self._tableViewTitleIdx = {}
	self._tableViewTitleIdx[1] = 1
	self._tableViewTitleIdx[2] = self._tableViewTitleIdx[1] + math.ceil(#self._showList[1] / ShowLineNum)
	self._tableViewTitleIdx[3] = self._tableViewTitleIdx[2] + 1
	self._tableViewTitleIdx[4] = self._tableViewTitleIdx[3] + math.ceil(#self._showList[2] / ShowLineNum)
	self._tableViewCell = {}
	self._delegateCallback = data.callback
	self._isScroll = true
end

function GalleryMemoryPackMediator:initInfoView()
	local text = self._infoNode:getChildByName("text")
	local image = self._infoNode:getChildByName("image")
	local num = self._infoNode:getChildByName("num")
	local loadingBar = self._infoNode:getChildByName("loadingBar")

	image:loadTexture(infoImage, 1)
	text:setString(memoryTitle)

	local data = self._gallerySystem:getMemoryValueByType(GalleryMemoryType.STORY)

	num:setString(data[1] .. "/" .. data[2])
	loadingBar:setPercent(data[1] / data[2] * 100)
end

function GalleryMemoryPackMediator:initLeftView()
	if not Titles or #Titles <= 0 then
		return
	end

	local kLeftTitleDisY = 45
	local positionY = self._leftTitleNode:getPositionY()

	for i = 1, #Titles do
		local titlePanel = self._leftTitleClone:clone():setName("titlePanel_" .. i)

		titlePanel:setVisible(true)
		titlePanel:getChildByFullName("image"):setVisible(false)
		titlePanel:getChildByFullName("title"):setString(Titles[i])
		titlePanel:addTo(self._leftPanel)
		titlePanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				self._isScroll = false
				self._curSelectTitleIndex = i

				self:changePageView(true)
			elseif eventType == ccui.TouchEventType.ended then
				self._isScroll = true
			elseif eventType == ccui.TouchEventType.canceled then
				self._isScroll = true
			end
		end)
		titlePanel:setPosition(cc.p(0, positionY - kLeftTitleDisY * (i - 1)))

		local node = RedPoint:createDefaultNode()

		node:setScale(0.8)
		RedPoint:new(node, titlePanel, function()
			return self._gallerySystem:getStoryPackRedPointByType(TitlesType[i])
		end)

		self["titlePanelRedPoint" .. i] = node
	end

	self._curSelectTitleIndex = 1
end

function GalleryMemoryPackMediator:refreshTitlePanelRedPoint()
	for i = 1, #Titles do
		self["titlePanelRedPoint" .. i]:setVisible(self._gallerySystem:getStoryPackRedPointByType(TitlesType[i]))
	end
end

function GalleryMemoryPackMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false

		if self._tableViewTitlePos and #self._tableViewTitlePos > 1 then
			local offy = view:getContentOffset().y
			local idx = 0

			for i = #Titles, 1, -1 do
				if offy > self._tableViewTitlePos[i].y then
					idx = i

					break
				end
			end

			idx = idx == 0 and 1 or idx
			idx = offy == 0 and #Titles or idx

			if idx ~= self._curSelectTitleIndex and self._isScroll then
				self._curSelectTitleIndex = idx

				self:changePageView()
			end
		end
	end

	local function cellSizeForTable(table, idx)
		for i = 1, #self._tableViewTitleIdx - 1, 2 do
			if idx + 1 == self._tableViewTitleIdx[i] then
				return self._titleCellClone:getContentSize().width, self._titleCellClone:getContentSize().height
			end
		end

		return self._cellClone:getContentSize().width, self._cellClone:getContentSize().height
	end

	local function numberOfCellsInTableView(table)
		return self._tableViewTitleIdx[#self._tableViewTitleIdx]
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

	self._tableView = tableView

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

function GalleryMemoryPackMediator:createTeamCell(cell, index)
	cell:removeAllChildren()
	cell:setLocalZOrder(99 - index)

	for i = 1, #Titles do
		if index == self._tableViewTitleIdx[i * 2 - 1] then
			local titlePanel = self._titleCellClone:clone()

			titlePanel:setVisible(true)
			titlePanel:addTo(cell)
			titlePanel:setPosition(cc.p(0, 0))
			titlePanel:setTag(12138)

			local text = titlePanel:getChildByFullName("title")

			text:setString(Titles[i])

			break
		end

		if i >= #Titles then
			local listIndex = 1
			local index2

			for i = 1, #Titles do
				if index <= self._tableViewTitleIdx[i * 2] then
					listIndex = i
					index2 = index - self._tableViewTitleIdx[i * 2 - 1]

					break
				end

				if i >= #Titles then
					print("GalleryMemoryPackMediator..........out of line................")
				end
			end

			local cellPanel = self._cellClone:clone()

			cellPanel:setVisible(true)
			cellPanel:addTo(cell)
			cellPanel:setPosition(cc.p(0, 0))
			cellPanel:setTag(12138)

			for i = 1, ShowLineNum do
				local data = self._showList[listIndex][ShowLineNum * (index2 - 1) + i]

				if data then
					local panel = cellPanel:getChildByFullName("panel_" .. i)

					panel:setTouchEnabled(true)
					panel:setSwallowTouches(false)
					panel:addTouchEventListener(function(sender, eventType)
						self:onClickMemoryPack(sender, eventType, data, ShowLineNum * (index - 1) + i)
					end)

					if not data:getUnlock() then
						local node = self._lockNodeClone:clone()

						node:setVisible(true)
						node:setPosition(cc.p(0, 3))
						node:addTo(panel)
						node:getChildByName("image"):loadTexture(data:getIcon())

						local lockTip = data:getLockTip()

						if lockTip == "" then
							local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
							local str = conditionkeeper:getConditionDesc(data:getCondition()[1])

							data:setLockTip(str)

							lockTip = str
						end

						node:getChildByName("tip"):setString(lockTip)
						node:getChildByName("image"):setColor(cc.c3b(125, 125, 125))
					else
						local node = self._nodeClone:clone()

						node:setVisible(true)
						node:setPosition(cc.p(0, 3))
						node:addTo(panel)
						node:getChildByName("image"):loadTexture(data:getIcon())
						node:getChildByName("name"):setString(data:getTitle())

						local number = self._gallerySystem:getMemoryStoryValueByData(data)
						local currentNum = node:getChildByName("currentNum")
						local limitNum = node:getChildByName("limitNum")

						if data:getType() == GalleryMemoryPackType.STORY then
							currentNum:setString(number[1])
							limitNum:setString("/" .. number[2])
							currentNum:setPositionX(limitNum:getPositionX() - limitNum:getContentSize().width)
						else
							currentNum:setString(number[1])
							limitNum:setString("")
							currentNum:setPositionX(limitNum:getPositionX() - limitNum:getContentSize().width)
						end

						if data:getType() ~= GalleryMemoryPackType.STORY then
							self:refreshRedPoint(panel, data)
						end
					end
				end
			end
		end
	end

	self._tableViewCell[index] = cell

	cell:setVisible(false)
	cell:setName("cell_" .. index)
	self:runCellStartAnim(cell)
end

function GalleryMemoryPackMediator:onClickMemoryPack(sender, eventType, data, index)
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
					self:onClickCallback(data, index)

					self._isReturn = true

					maskImage:setOpacity(0)
					self._maskPanel:setVisible(false)
				end)
				local seq = cc.Sequence:create(fade, func)

				maskImage:runAction(seq)
			end)

			self._sender = sender
			self._senderData = data

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

function GalleryMemoryPackMediator:onClickCallback(data, index)
	local value = {}

	value.type = GalleryMemoryType.STORY
	value.storyType = data:getType()
	value.storyId = data:getId()
	value.title = data:getTitle()

	local view = self:getInjector():getInstance("GalleryMemoryListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, value, nil))
end

function GalleryMemoryPackMediator:onClickBack()
	self:dismiss()
end

function GalleryMemoryPackMediator:runStartAnim()
	return
end

function GalleryMemoryPackMediator:runCellStartAnim(cell)
	if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(cell) then
		return
	end

	local function runActionFun()
		cell:setVisible(true)

		local panel = cell:getChildByTag(12138)
	end

	runActionFun()
end

function GalleryMemoryPackMediator:changePageView(needScroll)
	for i = 1, #Titles do
		local titlePanel = self._leftPanel:getChildByName("titlePanel_" .. i)

		titlePanel:getChildByFullName("image"):setVisible(self._curSelectTitleIndex == i)
	end

	if needScroll then
		self:setScrollOffset(self._tableViewTitleIdx[self._curSelectTitleIndex])
	end
end

function GalleryMemoryPackMediator:setScrollOffset(lineIndex)
	if not self._tableViewTitlePos then
		self._tableViewTitlePos = {}

		for i = 1, #Titles do
			self._tableViewTitlePos[i] = self:getTableLinePos(self._tableViewTitleIdx[(i - 1) * 2 + 1])
		end
	end

	if not lineIndex then
		local data = self._gallerySystem:getFirstNewMemoryPackByType(self._memoryType, self._storyId)
		local index = 0

		if data then
			if data:getType() == GalleryMemoryPackType.STORY then
				index = self._tableViewTitleIdx[1] + math.ceil(table.indexof(self._showList[1], data) / ShowLineNum)
			elseif data:getType() == GalleryMemoryPackType.ACTIVI then
				index = self._tableViewTitleIdx[3] + math.ceil(table.indexof(self._showList[2], data) / ShowLineNum)
			elseif data:getType() == GalleryMemoryPackType.HERO then
				index = self._tableViewTitleIdx[5] + math.ceil(table.indexof(self._showList[3], data) / ShowLineNum)
			end
		else
			return
		end

		lineIndex = index
	end

	local offset = self:getTableLinePos(lineIndex)

	if offset.y >= 0 then
		offset.y = 0
	end

	self._tableView:setContentOffset(cc.p(0, offset.y))
end

function GalleryMemoryPackMediator:getTableLinePos(lineIndex)
	if not self._tableView then
		return
	end

	local offset = self._tableView:getContentOffset()
	local viewSize = self._tableView:getViewSize()
	local size = self._tableView:getContentSize()

	offset.y = viewSize.height - size.height

	local needAdd = true

	for idx = 1, lineIndex - 1 do
		needAdd = true

		for i = 1, #self._tableViewTitleIdx - 1, 2 do
			if idx + 1 == self._tableViewTitleIdx[i] then
				offset.y = offset.y + self._titleCellClone:getContentSize().height
				needAdd = false

				break
			end
		end

		if needAdd then
			offset.y = offset.y + self._cellClone:getContentSize().height
		end
	end

	return offset
end

function GalleryMemoryPackMediator:refreshRedPoint(panel, data, value)
	if not panel then
		return
	end

	if data:getType() == GalleryMemoryPackType.ACTIVI then
		local redPoint = panel:getChildByName("redPoint")

		if not redPoint then
			redPoint = RedPoint:createDefaultNode()

			redPoint:addTo(panel):posite(200, 145)
			redPoint:setLocalZOrder(99901)
			redPoint:setName("redPoint")
			redPoint:setScale(0.7)
		end

		redPoint:setVisible(self._gallerySystem:getActivityStoryPackRedPoint(data:getType(), data:getId()))
	end
end
