-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubRankMediator.lua

ClubRankMediator = class("ClubRankMediator", DmAreaViewMediator, _M)

ClubRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubRankMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubRankMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubRankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

local kBtnHandlers = {
	["main.myInfo.main.sharebtn"] = "onClickShare"
}
local kCellTag = 100
local lineAnimTag = 5999
local myInfoAnimTag = 6999
local cellAnimTag = 7999

function ClubRankMediator:initialize()
	super.initialize(self)
end

function ClubRankMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubRankMediator:disposeView()
	self._viewCache = nil
end

function ClubRankMediator:userInject()
	return
end

function ClubRankMediator:onRegister()
	self:mapButtonHandlersClick(kBtnHandlers)
	super.onRegister(self)
end

function ClubRankMediator:enterWithData()
	self:initNodes()
	self:createData()
	self:refreshData()
end

function ClubRankMediator:createData()
	self._player = self._developSystem:getPlayer()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._applyRecordListOj = self._clubSystem:getApplyRecordListOj()
end

function ClubRankMediator:refreshData()
	self._curIndex = 1
	self._rankModel = self._rankSystem:getRank()
	self._rankType = RankType.kClub
	self._rankList = self._rankSystem:getRankListByType(self._rankType)
end

function ClubRankMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._topNode = self._mainPanel:getChildByFullName("topnode")

	self._topNode:removeFromParent(false)

	self._lineAnim = self:bindCellAnim(self._mainPanel, self._topNode, {
		x = 255,
		y = 24
	})

	self._lineAnim:setTag(lineAnimTag)
	self._lineAnim:setPosition(430, 190)

	local combatLabel = self._topNode:getChildByName("combatlabel")

	GameStyle:setYellowTextEffect(combatLabel)
	combatLabel:offset(-4, 0)

	self._cellPanel = self._mainPanel:getChildByFullName("myInfo.main")

	local myInfoNode = self._mainPanel:getChildByName("myInfo")

	myInfoNode:offset(-14, 0)

	self._myInfoNode = self._mainPanel:getChildByName("myInfo")

	self._myInfoNode:removeFromParent(false)

	self._myInfoAnim = self:bindCellAnim(self._mainPanel, self._myInfoNode)

	self._myInfoAnim:setTag(myInfoAnimTag)
	self._myInfoAnim:setPosition(623, 255)
	self._myInfoAnim:setVisible(false)

	self._cell = self._mainPanel:getChildByName("cell")
end

function ClubRankMediator:refreshView()
	self:refreshData()
	self:createTableView()
	self:runAnim()
end

function ClubRankMediator:uptadeMyInfo()
	local rankCellClass = kRankConfig[RankType.kClubHall].RankCellClass
	local resFile = kRankConfig[RankType.kClubHall].resFile
	local rankCell = rankCellClass:new(resFile, self._myInfoNode)

	self:getInjector():injectInto(rankCell)
	rankCell:createView()

	local record = self._rankList:getSelfRecord()

	if record then
		rankCell:refreshView(record, {
			showMySelf = true
		})
	end
end

function ClubRankMediator:updateCell(cell, index, rankRecord)
	local imgRank = cell:getChildByName("img_rank")
	local textRank = cell:getChildByName("text_rank")
	local level = cell:getChildByName("level")
	local name = cell:getChildByName("name")
	local damage = cell:getChildByName("damage")

	name:setString(rankRecord:getNickName())
	level:setString("Lv." .. rankRecord:getLevel())

	local changeImg = cell:getChildByName("change")

	changeImg:setVisible(rankRecord:getChangeNum() ~= 0)

	if rankRecord:getChangeNum() ~= 0 then
		local changeText = changeImg:getChildByName("value")

		if rankRecord:getChangeNum() > 0 then
			changeImg:loadTexture("jjc_bg_ts.png", 1)
		else
			changeImg:loadTexture("jjc_bg_xj.png", 1)
		end

		changeText:setString(math.abs(rankRecord:getChangeNum()))
	end
end

function ClubRankMediator:refreshRankLabel(cell, rank)
	cell:setSwallowTouches(false)

	local bgImg = cell:getChildByFullName("img_bg")
	local rankImgDi = cell:getChildByName("Image_rankdi")
	local rankTextDi = cell:getChildByName("Image_Textrank")
	local rankImg = rankImgDi:getChildByName("Image_rank")
	local rankLabel = rankTextDi:getChildByName("Text_rank")

	rankImgDi:setVisible(false)
	rankTextDi:setVisible(false)

	local rankImgConfig = kRankImgConfig[rank]

	if rankImgConfig then
		rankImgDi:setVisible(true)
		bgImg:loadTexture("asset/ui/rank/" .. rankImgConfig.bg)
		rankImgDi:loadTexture(rankImgConfig.rankDi, 1)
		rankImg:loadTexture(rankImgConfig.rankImg, 1)
		rankImgDi:setPositionY(rankImgConfig.rankImgPosY)
	else
		rankTextDi:setVisible(true)
		bgImg:loadTexture("asset/ui/rank/bg_hui_normal.png")
		rankLabel:setString(rank)
	end

	if rank == -1 then
		rankLabel:setString("未上榜")
	end
end

function ClubRankMediator:createTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local size = self._cellPanel:getContentSize()

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height + 0
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local itemCell = self._cell:clone()

			itemCell:setVisible(true)
			itemCell:setTag(kCellTag)
			itemCell:setPosition(cc.p(6, -3))
			cell:setTag(idx + 1)
			cell:addChild(itemCell)
		end

		local rankRecord = self._rankSystem:getRankRecordByTypeAndIndex(self._rankType, idx + 1)

		dump(rankRecord, "rankRecord")
		self:updateCell(cell:getChildByTag(kCellTag), idx + 1, rankRecord)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._rankSystem:getRankCountByType(self._rankType)
	end

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local winSizeHieght = (winSize.height - 640) / 2
	local tableView = cc.TableView:create(cc.size(930, 380 + winSizeHieght))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(176, 26 - winSizeHieght)
	tableView:setDelegate()
	self._mainPanel:addChild(tableView, 100)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function ClubRankMediator:createCell(cell, idx)
	local rankRecord = self._rankList:getRecordByRank(idx)

	self:updateCell(cell, rankRecord)
	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)
	cell:addTouchEventListener(function(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end)
end

function ClubRankMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local sureRequest = false
	local offsetY = self._tableView:getContentOffset().y

	if kMinRefreshHeight < offsetY then
		local factor1 = viewHeight < self._tableView:getContentSize().height
		local factor2 = self._rankList:getRecordCount() < self._rankList:getMaxCount()

		if factor1 and factor2 then
			sureRequest = true
		end
	end

	if sureRequest then
		self._isAskingRank = true
		self._requestNextCount = self._rankList:getRecordCount()

		self:doRequestNextRank()
	end
end

function ClubRankMediator:doRequestNextRank()
	local kCellHeight = self._cellPanel:getContentSize().height
	local dataEnough = self._rankList:getDataEnough()

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self:refreshData()
			self._tableView:removeFromParent(true)
			self:createTableView()

			local kCellHeight = self._cellPanel:getContentSize().height

			if self._requestNextCount then
				local diffCount = self._rankList:getRecordCount() - self._requestNextCount
				local offsetY = -diffCount * kCellHeight + kCellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))

				self._requestNextCount = nil
				self._isAskingRank = false
			end
		end

		local rankStart = self._rankList:getRecordCount() + 1
		local rankEnd = rankStart + self._rankList:getRequestRankCountPerTime() - 1

		self._rankSystem:requestRankData(RankType.kClub, rankStart, rankEnd, onRequestRankDataSucc)
	end
end

function ClubRankMediator:getTableViewPosY()
	return self._tableView:getContentOffset().y
end

function ClubRankMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
		cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
	end
end

function ClubRankMediator:onCellClicked(sender, eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		local tableViewPosY = self:getTableViewPosY()
		local oldIndex = self._curIndex

		if math.abs(tableViewPosY - self._tableViewPosY) < 1 then
			self._curIndex = idx

			self._tableView:updateCellAtIndex(oldIndex - 1)
			self._tableView:updateCellAtIndex(self._curIndex - 1)

			local rankRecord = self._rankList:getRecordByRank(idx + 1)
			local delegate, outSelf = {}, self

			function delegate:willClose(popupMediator, data)
				outSelf._textFieldCanMove = true
			end

			local friendSystem = self:getInjector():getInstance(FriendSystem)

			friendSystem:showFriendPlayerInfoView(rankRecord:getRid(), rankRecord)
		end
	elseif eventType == ccui.TouchEventType.began then
		self._tableViewPosY = self:getTableViewPosY()
	end
end

function ClubRankMediator:onClickShare(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Item_PleaseWait")
		}))
	end
end

function ClubRankMediator:bindCellAnim(parent, node, offsetData)
	dump(idx, "idx_______")

	local anim = cc.MovieClip:create("cell_dapaihang")
	local animNode = anim:getChildByName("cell")

	node:addTo(animNode):center(animNode:getContentSize()):offset(-455, -54)

	if offsetData then
		node:offset(offsetData.x, offsetData.y)
	end

	anim:addTo(parent, 1):offset(450, -200)
	anim:addEndCallback(function(cid, mc)
		anim:stop()
	end)
	anim:gotoAndPlay(15)

	return anim
end

function ClubRankMediator:getCellCountByWinSize()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local winSizeHieght = self._tableView:getContentSize().height
	local size = self._cellPanel:getContentSize()

	return math.modf(winSizeHieght / size.height) + 2
end

function ClubRankMediator:runAnim()
	local cellTime = 0.13
	local cache = {}
	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, self:getCellCountByWinSize() do
		if allCells[i] then
			local cell = allCells[i]:getChildByTag(cellAnimTag)

			if cell then
				cell:setVisible(false)

				cache[i] = cell
			end
		end
	end

	self._lineAnim:setVisible(false)

	local function cakkFunc()
		local lineAnim = self._lineAnim

		lineAnim:setVisible(true)
		lineAnim:gotoAndPlay(0)
		lineAnim:addCallbackAtFrame(3, function(cid, mc)
			lineAnim:removeCallback(cid)
		end)
		lineAnim:addCallbackAtFrame(4, function(cid, mc)
			lineAnim:removeCallback(cid)

			local allCells = self._tableView:getContainer():getChildren()

			for i = 1, #cache do
				local cell = cache[i]

				cell:runAction(DelayAction:create(function()
					cell:setVisible(true)
					cell:gotoAndPlay(0)
				end, cellTime * i))
			end
		end)
	end

	local myInfoAnim = self._mainPanel:getChildByTag(myInfoAnimTag)

	if myInfoAnim then
		myInfoAnim:setVisible(true)
		myInfoAnim:gotoAndPlay(0)
		myInfoAnim:addCallbackAtFrame(3, function(cid, mc)
			myInfoAnim:removeCallback(cid)

			if cakkFunc then
				cakkFunc()
			end
		end)
	end
end
