-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameRankMediator.lua

require("dm.gameplay.miniGame.view.common.MiniGameRankCell")

MiniGameRankMediator = class("MiniGameRankMediator", DmPopupViewMediator, _M)

MiniGameRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MiniGameRankMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
MiniGameRankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

local kCellWidth, kCellHeight = 704, 72

function MiniGameRankMediator:initialize()
	super.initialize(self)
end

function MiniGameRankMediator:dispose()
	super.dispose(self)
end

function MiniGameRankMediator:onRegister()
	super.onRegister(self)
end

function MiniGameRankMediator:enterWithData(data)
	self:initData(data)
	self:setupView()

	self._isAskingRank = false
	self._rankModel = self._rankSystem:getRank()

	self:refreshData()
	self:createTableView()
	self:refreshTableView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
end

function MiniGameRankMediator:activityClose(event)
	if self._gameEvn == MiniGameEvn.kClub then
		local data = event:getData()

		if self._activityId and data.activityId == self._activityId then
			self:close()
		end
	end
end

function MiniGameRankMediator:setupView()
	self._main = self:getView():getChildByFullName("main")
	self._notHasImg = self._main:getChildByFullName("empty_notice")
	self._myRankNode = self._main:getChildByFullName("myranknode")

	self._myRankNode:setLocalZOrder(10)

	local bgNode = self._main:getChildByFullName("bg_node")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		bgSize = {
			width = 820,
			height = 540
		},
		title = Strings:get("MiniGame_Rank_UI1"),
		title1 = Strings:get("MiniGame_Rank_UI2")
	})
end

function MiniGameRankMediator:initData(data)
	self._gameType = data.type
	self._activityId = data.activityId
	self._gameEvn = data.evn
	self._rankNum = data.rankNum
	self._rankType = data.rankType
end

function MiniGameRankMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(self._rankType)
end

function MiniGameRankMediator:refreshTableView()
	self._notHasImg:setVisible(#self._rankList == 0)
	self:refreshMyInfoForActivity()
end

function MiniGameRankMediator:refreshMyInfoForActivity()
	local data = self._rankSystem:getMyselfDataByType(self._rankType)

	self._myRankNode:setVisible(false)

	if data then
		if data:getRank() >= -1 then
			self._myRankNode:setVisible(true)
		end

		if data:getRank() >= -1 then
			local hightScoreLabel = self._myRankNode:getChildByFullName("highscorelabel")

			hightScoreLabel:setString(data:getScore())

			local lineGradiantVec1 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(221, 191, 143, 255)
				}
			}

			hightScoreLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
				x = 0,
				y = -1
			}))

			local nameLabel = self._myRankNode:getChildByFullName("namelabel")

			nameLabel:setString(data:getName())

			local iconNode = self._myRankNode:getChildByFullName("iconnode")

			iconNode:removeAllChildren(true)

			local headInfo = {
				clipType = 4,
				id = data:getHeadId(),
				headFrameId = data:getHeadFrame(),
				size = cc.size(93, 94)
			}
			local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

			headIcon:addTo(iconNode):center(iconNode:getContentSize()):offset(2, -2)
			headIcon:setScale(0.6)
			oldIcon:setScale(0.5)

			local rankLabel = self._myRankNode:getChildByFullName("ranklabel")

			if data:getRank() >= 1 then
				local rankNode = MiniGameRankCell:createRankImg(self._myRankNode, rankLabel, data, true)

				rankNode:setPosition(rankLabel:getPosition()):offset(0, 0)
			end

			if data:getRank() > self._rankNum or data:getRank() == -1 then
				rankLabel:setString(Strings:get("Activity_Darts_UI_7"))
				rankLabel:setScale(0.45)
			end
		end
	end
end

function MiniGameRankMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(705, 305))

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
		local rankRecord = self._rankSystem:getRankRecordByTypeAndIndex(self._rankType, idx + 1)
		local playerRid = self._developSystem:getPlayer():getRid()
		local rid = rankRecord:getRid()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local resFile = "asset/ui/minigameRankCell.csb"
			local rankCell = self:getInjector():injectInto(MiniGameRankCell:new(resFile))

			rankCell:createView()

			rankCell:getView().rankCell = rankCell

			rankCell:getView():setPosition(cc.p(-217, -180))
			rankCell:getView():addTo(cell, 100, 123)

			if rid == playerRid then
				rankCell:refreshView(rankRecord, true)
			else
				rankCell:refreshView(rankRecord)
			end
		else
			local cell_Old = cell:getChildByTag(123)

			if rid == playerRid then
				cell_Old.rankCell:refreshView(rankRecord, true)
			else
				cell_Old.rankCell:refreshView(rankRecord)
			end
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._rankList
	end

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(217, 160)
	self._main:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView
end

function MiniGameRankMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local sureRequest = false
	local offsetY = self._tableView:getContentOffset().y

	if kMinRefreshHeight < offsetY then
		local factor1 = viewHeight < self._tableView:getContentSize().height
		local factor2 = self._rankSystem:getRankCountByType(self._rankType) < 200

		if factor1 and factor2 then
			sureRequest = true
		end
	end

	if sureRequest then
		self._isAskingRank = true
		self._requestNextCount = self._rankSystem:getRankCountByType(self._rankType)

		self:doRequestNextRank()
	end
end

function MiniGameRankMediator:doRequestNextRank()
	local dataEnough = self._rankSystem:isServerDataEnough(self._rankType)

	if dataEnough == true then
		if self._gameEvn == MiniGameEvn.kClub then
			local rankStart = #self._rankList + 1
			local rankEnd = rankStart + self._rankSystem:getRequestRankCountPerTime() - 1
			local gameId = self._miniGameSystem:getGameByType(self._gameType):getId()

			self._miniGameSystem:requestClubGameRankData(gameId, rankStart, rankEnd, function()
				self:refreshTableViewByServer()
			end)
		elseif self._gameEvn == MiniGameEvn.kActivity then
			local rankStart = self._rankSystem:getRankCountByType(self._rankType) + 1
			local rankEnd = rankStart + self._rankSystem:getRequestRankCountPerTime() - 1

			self._miniGameSystem:requestActivityRankData(self._rankType, self._activityId, rankStart, rankEnd, function()
				self:refreshTableViewByServer()
			end)
		end
	end
end

function MiniGameRankMediator:refreshTableViewByServer()
	self:refreshData()

	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	self:createTableView()
	self:refreshTableView()

	if self._requestNextCount then
		local diffCount = self._rankSystem:getRankCountByType(self._rankType) - self._requestNextCount
		local offsetY = -diffCount * kCellHeight + kCellHeight

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end
end

function MiniGameRankMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
