-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageRankMediator.lua

SpStageRankMediator = class("SpStageRankMediator", DmPopupViewMediator, _M)

SpStageRankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
SpStageRankMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")

local kBtnHandlers = {
	["main.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}
local kImgRank = {
	"pic_mingci_ph1.png",
	"pic_mingci_ph2.png",
	"pic_mingci_ph3.png"
}
local kCellTag = 100
local kTabTitle = {
	nil,
	nil,
	nil,
	nil,
	"SPECIAL_STAGE_TITLE_1",
	"SPECIAL_STAGE_TITLE_2",
	"SPECIAL_STAGE_TITLE_3"
}
local kRankBg = {
	"pic_bg_phb1.png",
	"pic_bg_phb2.png",
	"pic_bg_phb3.png",
	"pic_bg_phb4.png"
}

function SpStageRankMediator:initialize()
	super.initialize(self)
end

function SpStageRankMediator:dispose()
	super.dispose(self)
end

function SpStageRankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function SpStageRankMediator:enterWithData(data)
	self._selectIndex = -1
	self._title = data.title
	self._stageType = data.stageType
	self._rankModel = self._rankSystem:getRank()
	self._rankType = data.rankType
	self._rankList = self._rankSystem:getRankListByType(self._rankType)
	self._isAskingRank = false

	self:initWidgetInfo()
	self:createTableView()
end

function SpStageRankMediator:initWidgetInfo()
	self._bg = self:getView():getChildByName("main")

	self._bg:getChildByName("title"):setString(Strings:get(kTabTitle[self._rankType]))

	self._viewPanel = self._bg:getChildByName("tableView")
	self._cell = self._bg:getChildByName("cell")

	self._cell:setVisible(false)

	local titlePanel = self._bg:getChildByName("titlePanel")

	titlePanel:setVisible(true)

	local myRankText = self._bg:getChildByName("rank_my")

	myRankText:setVisible(true)

	local emptyNotice = self._bg:getChildByName("empty_notice")

	emptyNotice:setVisible(false)

	if self._rankSystem:getRankCountByType(self._rankType) == 0 then
		emptyNotice:setVisible(true)
		myRankText:setVisible(false)
		titlePanel:setVisible(false)
	end

	local myRecord = self._rankSystem:getMyselfDataByType(self._rankType)
	local rank = myRecord:getRank()

	myRankText:setString(Strings:get("SPECIAL_STAGE_TEXT_17", {
		rank = rank
	}))

	if rank == -1 then
		myRankText:setString(Strings:get("SPECIAL_STAGE_TEXT_17", {
			rank = Strings:get("Petrace_Text_3")
		}))
	end
end

function SpStageRankMediator:createTableView()
	local cellSizeNum = self._cell:getContentSize()
	local cellWidth = cellSizeNum.width
	local cellHeight = cellSizeNum.height

	self._cellHeight = cellHeight + 3

	local function numberOfCells(view)
		return self._rankSystem:getRankCountByType(self._rankType)
	end

	local function cellTouched(table, cell)
		self:onClickCell(cell)
	end

	local function cellSize(table, idx)
		return cellWidth, cellHeight + 3
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local itemCell = self._cell:clone()

			itemCell:setVisible(true)
			itemCell:setTag(kCellTag)
			itemCell:setPosition(cc.p(6, -3))
			cell:setTag(idx + 1)
			cell:addChild(itemCell)
		end

		local rankRecord = self._rankSystem:getRankRecordByTypeAndIndex(self._rankType, idx + 1)

		self:updateCell(cell:getChildByTag(kCellTag), idx + 1, rankRecord)

		return cell
	end

	local function onScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	self._viewPanel:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	self._tableView = tableView
end

function SpStageRankMediator:updateCell(cell, index, rankRecord)
	local imgRank = cell:getChildByName("img_rank")
	local textRank = cell:getChildByName("text_rank")

	cell:getChildByName("bg_normal"):loadTexture(kRankBg[#kRankBg], 1)

	local rank = rankRecord:getRank()

	if rank > 0 and rank < 4 then
		imgRank:loadTexture(kImgRank[rank], 1)
		imgRank:setVisible(true)
		textRank:setVisible(false)
		cell:getChildByName("bg_normal"):loadTexture(kRankBg[rank], 1)
	else
		textRank:setString(rank)
		imgRank:setVisible(false)
		textRank:setVisible(true)
	end

	local level = cell:getChildByName("level")
	local name = cell:getChildByName("name")
	local damage = cell:getChildByName("damage")

	name:setString(rankRecord:getNickName())
	level:setString("Lv." .. rankRecord:getLevel())
	damage:setString(rankRecord:getDamage())

	local changeImg = cell:getChildByName("change")

	changeImg:setVisible(rankRecord:getChangeNum() ~= 0)

	if rankRecord:getChangeNum() ~= 0 then
		local changeText = changeImg:getChildByName("value")

		if rankRecord:getChangeNum() > 0 then
			changeImg:loadTexture("zyfb_bg_ts.png", 1)
		else
			changeImg:loadTexture("zyfb_bg_xj.png", 1)
		end

		changeText:setString(math.abs(rankRecord:getChangeNum()))
	end
end

function SpStageRankMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and self._rankSystem:getRankCountByType(self._rankType) < self._rankSystem:getMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = self._rankSystem:getRankCountByType(self._rankType)

		self:doRequestNextRank()
	end
end

function SpStageRankMediator:doRequestNextRank()
	local dataEnough = self._rankSystem:isServerDataEnough(self._rankType)

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self._rankList = self._rankSystem:getRankListByType(self._rankType)

			self._tableView:reloadData()

			if self._requestNextCount then
				local diffCount = self._rankSystem:getRankCountByType(self._rankType) - self._requestNextCount
				local offsetY = -diffCount * self._cellHeight + self._cellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))
			end
		end

		local rankStart = self._rankSystem:getRankCountByType(self._rankType) + 1
		local rankEnd = rankStart + self._rankSystem:getRequestRankCountPerTime() - 1

		self._rankSystem:requestRankData(self._rankType, rankStart, rankEnd, onRequestRankDataSucc)
	end
end

function SpStageRankMediator:onClickCell(cell)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local index = cell:getTag()

	self._selectIndex = index

	local offset = self._tableView:getContentOffset()

	self._tableView:reloadData()
	self._tableView:setContentOffset(offset)

	local record = self._rankSystem:getRankRecordByTypeAndIndex(self._rankType, index)
	local friendSystem = self:getInjector():getInstance(FriendSystem)

	local function gotoView(response)
		record:setIsFriend(response.isFriend)
		friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(record:getRid(), function(response)
		gotoView(response)
	end)
end

function SpStageRankMediator:onClickClose(sender, eventType)
	self:close()
end
