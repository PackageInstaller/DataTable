-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeRankMediator.lua

StagePracticeRankMediator = class("StagePracticeRankMediator", DmPopupViewMediator, _M)

StagePracticeRankMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePracticeRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeRankMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")

function StagePracticeRankMediator:initialize()
	super.initialize(self)
end

function StagePracticeRankMediator:dispose()
	super.dispose(self)
end

function StagePracticeRankMediator:onRegister()
	super.onRegister(self)

	self._player = self._developSystem:getPlayer()
end

local rankEndCount = 20
local kCellWidth, kCellHeight = 490, 100

function StagePracticeRankMediator:enterWithData(data)
	self:initData(data)
	self:initNodes()
	self:createTabBtns()
	self:refreshTabBtns()
	self:requestRankByIndex()
	self:refreshChallageBtn()
end

function StagePracticeRankMediator:setupView(...)
	return
end

function StagePracticeRankMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._cellPanel = self:getView():getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._cellBtn = self._mainPanel:getChildByFullName("bgs.clonebtn")

	self._cellBtn:setVisible(false)

	self._rightNode = self._mainPanel:getChildByFullName("rightnode")
	self._challageBtn = self._mainPanel:getChildByFullName("rightnode.btn")
	self._tabNode = self._mainPanel:getChildByFullName("tabnode")
	self._scroll = self._mainPanel:getChildByFullName("bgs.scroll")
	self._btnClose = self:getView():getChildByFullName("Button_58")
	self._titlePos = cc.p(self._mainPanel:getChildByFullName("bgs.scroll.Image_38"):getPosition())

	self._scroll:setScrollBarEnabled(false)
	self._challageBtn:addTouchEventListener(function(sender, eventType)
		self:onClickChallage(sender, eventType)
	end)
	self._btnClose:addTouchEventListener(function(sender, eventType)
		self:onClickClose(sender, eventType)
	end)
end

function StagePracticeRankMediator:initData(data)
	self._data = data
	self._pointIndex = data.index
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
	self._curMapData = self._stagePractice:getMapById(self._data.mapId)
end

function StagePracticeRankMediator:refreshData()
	self._rankListOj = self._stagePracticeSystem:getRankListOj()
	self._rankList = self._rankListOj:getList()
end

function StagePracticeRankMediator:refreshTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
	end

	self:refreshData()
	self:createTableView()
end

function StagePracticeRankMediator:requestRankByIndex()
	self:refreshData()

	local pointId = self._pointList[self._pointIndex]:getId()

	self._rankListOj:cleanUp()
	self._stagePracticeSystem:requestRank(pointId, 1, rankEndCount, function()
		self:refreshTableView()
		self:refreshMyInfo()
		self:scrollTabPanel(self._pointIndex)
	end)
end

local changeHeight = 46

function StagePracticeRankMediator:createTabBtns()
	local arrowImg1 = self._tabNode:getChildByFullName("jiantou1")
	local arrowImg2 = self._tabNode:getChildByFullName("jiantou2")
	local pointList = self._curMapData:getPointArray()

	self._pointList = {}

	for i = 1, #pointList do
		local data = pointList[i]

		if not data:isLock() then
			self._pointList[#self._pointList + 1] = data
		end
	end

	local cellCount = #self._pointList
	local scrollHeight = self._scroll:getContentSize().height
	local allHeight = cellCount * (self._cellBtn:getContentSize().height + changeHeight)

	allHeight = math.max(allHeight, scrollHeight)

	arrowImg1:setVisible(allHeight ~= scrollHeight)
	arrowImg2:setVisible(allHeight ~= scrollHeight)
	self._scroll:setInnerContainerSize(cc.size(self._scroll:getContentSize().width, allHeight))

	self._tabBtns = {}

	for i = 1, cellCount do
		local data = self._pointList[i]
		local btn = self._cellBtn:clone()

		btn:setTouchEnabled(true)
		btn:addTouchEventListener(function(sender, eventType)
			self:onTabClicked(sender, eventType, i)
		end)
		btn:setVisible(true)

		local pos = cc.p(self._scroll:getPosition())

		btn:addTo(self._scroll):posite(self._titlePos.x, allHeight - (self._cellBtn:getContentSize().height + changeHeight) * i + 2)

		function btn:setTextStyle()
			local darkLabel = self:getChildByFullName("dark_1.namelabel")

			darkLabel:setString(data:getName())

			local lightLabel = self:getChildByFullName("light_1.namelabel")

			lightLabel:setString(data:getName())
		end

		function btn:setShowState(isLight)
			local darkNode = self:getChildByFullName("dark_1")

			darkNode:setVisible(not isLight)

			local lightNode = self:getChildByFullName("light_1")

			lightNode:setVisible(isLight)
		end

		btn:setTextStyle()

		self._tabBtns[i] = btn
	end
end

function StagePracticeRankMediator:scrollTabPanel(tag)
	local innerHeight = self._scroll:getInnerContainer():getContentSize().height
	local sizeHeight = self._scroll:getContentSize().height
	local posY = -innerHeight + sizeHeight

	posY = posY + (tag - 1) * (self._cellBtn:getContentSize().height + changeHeight)

	if posY > 0 then
		posY = 0
	end

	self._scroll:getInnerContainer():setPositionY(posY)
end

function StagePracticeRankMediator:refreshTabBtns()
	for i = 1, #self._tabBtns do
		self:refreshTabBtnByIndex(i)
	end
end

function StagePracticeRankMediator:refreshTabBtnByIndex(index)
	local btn = self._tabBtns[index]

	btn:setShowState(self._pointIndex == index)
end

function StagePracticeRankMediator:refreshMyInfo()
	local data = self._rankListOj:getSelfRecord()
	local rankLabel = self._rightNode:getChildByFullName("ranklabel")
	local label4 = self._rightNode:getChildByFullName("label4")
	local label5 = self._rightNode:getChildByFullName("label5")
	local timeLabel = self._rightNode:getChildByFullName("timelabel")
	local str = string.format("%0.2f", data:getTime() / 1000) .. "秒"

	rankLabel:setString(data:getRank())
	timeLabel:setString(str)
	timeLabel:setVisible(true)
	label5:setVisible(true)
	label4:setVisible(true)
	rankLabel:setVisible(true)

	if data:getRank() == -1 then
		rankLabel:setString(Strings:get("StagePractice_Text19"))
		rankLabel:setFontSize(21)
	end

	if data:getTime() == 0 then
		timeLabel:setVisible(false)
		label5:setVisible(false)
		label4:setVisible(false)
		rankLabel:setVisible(false)
	end
end

function StagePracticeRankMediator:refreshChallageBtn()
	local button = self._challageBtn
	local curPointData = self._pointList[self._pointIndex]

	button:setVisible(not curPointData:isLock())
end

function StagePracticeRankMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(610, 370))

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return kCellWidth, kCellHeight
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(10, -10))
			sprite:setSwallowTouches(false)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setVisible(true)
			cell:addChild(sprite, 11, 123)
			self:createCell(sprite, idx + 1)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._rankListOj:getRecordCount()
	end

	tableView:setTag(1234)

	self._tableView = tableView

	self._tableView:setAnchorPoint(0.5, 0.5)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(0, 0)
	self._mainPanel:getChildByFullName("bg_small"):addChild(tableView, 900)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function StagePracticeRankMediator:createCell(cell, tag)
	local data = self._rankList[tag]

	if not data then
		return
	end

	local oldHeadImg = cell:getChildByTag(123)

	if oldHeadImg then
		oldHeadImg:removeFromParent(false)
	end

	local levelLabel = cell:getChildByFullName("levellabel")

	levelLabel:setString("Lv." .. data:getLevel())

	local nameLabel = cell:getChildByFullName("namelabel")

	nameLabel:setString(data:getPlayerName())

	local timeLabel = cell:getChildByFullName("timelabel")
	local str = string.format("%0.2f", data:getTime() / 1000) .. "秒"

	timeLabel:setString(str)
	self:createRankImg(cell, tag)

	if not cell.vipNodeWidget then
		cell.vipNodeWidget = PlayerVipWidget:new(PlayerVipWidget:createWidgetNode())

		cell.vipNodeWidget:getView():addTo(cell, 99)
		cell.vipNodeWidget:getView():setScale(1.1)
	end

	cell.vipNodeWidget:getView():posite(180 + nameLabel:getContentSize().width, 30)
	cell.vipNodeWidget:getView():setScale(0.8)
	cell.vipNodeWidget:updateView(data:getVip())
end

function StagePracticeRankMediator:createRankImg(cell, tag)
	local oldRankImg = cell:getChildByTag(234)
	local oldrangtext = cell:getChildByTag(677)
	local oldrangbg = cell:getChildByTag(688)

	if oldRankImg then
		oldRankImg:removeFromParent(false)
	end

	if oldrangbg then
		oldrangbg:removeFromParent(false)
	end

	local posX = 60

	if tag <= 3 then
		local path = "pic_mingci_ph" .. tag .. ".png"
		local img = cc.Sprite:createWithSpriteFrameName(path)

		img:addTo(cell, 1, 234):posite(posX, 50)

		if cell:getChildByTag(677) then
			cell:getChildByTag(677):removeFromParent(false)
		end

		local pathbg = "pic_bg_phb" .. tag .. ".png"

		cell:getChildByName("backimg"):loadTexture(pathbg, 1)
	else
		if oldrangtext then
			oldrangtext:removeFromParent(false)
		end

		local textrank = cell:getChildByFullName("text_rank"):clone()

		textrank:setVisible(true)
		textrank:setTag(677)
		textrank:setString(tag)
		textrank:addTo(cell, 3, 677):posite(posX, 50)
	end
end

function StagePracticeRankMediator:touchForTableview()
	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and self._rankListOj:getRecordCount() < self._rankListOj:getMaxCount() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = self._rankListOj:getRecordCount()

		self:doRequestNextRank()
	end
end

function StagePracticeRankMediator:doRequestNextRank()
	local dataEnough = self._rankListOj:getDataEnough()

	if dataEnough == true then
		local rankStart = self._rankListOj:getRecordCount() + 1
		local rankEnd = rankStart + self._rankListOj:getRequestRankCountPerTime() - 1
		local pointId = self._pointList[self._pointIndex]:getId()

		self._stagePracticeSystem:requestRank(pointId, rankStart, rankEnd, function()
			self:refreshTableViewByServer()
		end)
	end
end

function StagePracticeRankMediator:refreshTableViewByServer()
	self:refreshTableView()

	if self._requestNextCount then
		local diffCount = self._rankListOj:getRecordCount() - self._requestNextCount
		local offsetY = -diffCount * kCellHeight + kCellHeight

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end
end

function StagePracticeRankMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function StagePracticeRankMediator:onTabClicked(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended then
		local oldIndex = self._pointIndex

		self._pointIndex = index

		self:refreshTabBtnByIndex(oldIndex)
		self:refreshTabBtnByIndex(index)
		self._rankListOj:cleanUp()
		self:requestRankByIndex()
		self._tableView:stopScroll()
		self:refreshChallageBtn()
	end
end

function StagePracticeRankMediator:onClickChallage(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local pointData = self._pointList[self._pointIndex]

		self:close({
			enterTeam = true,
			pointId = pointData:getId()
		})
	end
end
