-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaReportMainMediator.lua

require("dm.gameplay.arena.view.component.ArenaReportCell")

ArenaReportMainMediator = class("ArenaReportMainMediator", DmAreaViewMediator, _M)

ArenaReportMainMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaReportMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kCellHeight = 97

function ArenaReportMainMediator:initialize()
	super.initialize(self)
end

function ArenaReportMainMediator:dispose()
	super.dispose(self)
end

function ArenaReportMainMediator:onRegister()
	super.onRegister(self)
end

function ArenaReportMainMediator:enterWithData(data)
	self:setupView()
end

function ArenaReportMainMediator:setupView()
	self._bg = self:getView():getChildByName("bg")
	self._emptyNotice = self._bg:getChildByName("empty_notice")

	local viewPanel = self._bg:getChildByName("viewPanel")

	self._cellWidth = viewPanel:getContentSize().width

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	viewPanel:setContentSize(cc.size(self._cellWidth, winSize.height - 80))
	self:setupTopInfoWidget()
	self:createTableView()
end

function ArenaReportMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kHonor,
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Arena_UI67")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ArenaReportMainMediator:createTableView()
	self._reportList = self._arenaSystem:getReportList()

	if #self._reportList == 0 then
		self._emptyNotice:setVisible(true)

		return
	end

	local scrollLayer = self._bg:getChildByName("viewPanel")
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._reportList
	end

	local function cellSize(table, idx)
		return self._cellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local rankCell = ArenaReportCell:new({
				mediator = self
			})

			cell.renderNode = rankCell

			cell:addChild(rankCell:getView())
			rankCell:getView():setPosition(0, 0)
		end

		self:updateTableCell(cell, idx)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	scrollLayer:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function ArenaReportMainMediator:updateTableCell(cell, idx)
	local realIndex = idx + 1
	local report = self._reportList[realIndex]
	local bg = cell.renderNode:getView():getChildByName("bg")
	local btnVideo = bg:getChildByName("button_video")
	local btnShare = bg:getChildByName("button_share")

	cell.renderNode:refreshReportData(self._reportList[realIndex])
	btnVideo:addTouchEventListener(function(sender, eventType)
		self:onClickVideo(sender, eventType, report:getId())
	end)
	btnShare:addTouchEventListener(function(sender, eventType)
		self:onClickShare(sender, eventType, report:getId())
	end)
end

function ArenaReportMainMediator:onClickVideo(sender, eventType, id)
	if eventType == ccui.TouchEventType.ended then
		self._arenaSystem:setShowViewAfterBattle("ArenaReportMainView")
		self._arenaSystem:requestReportDetail(id)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function ArenaReportMainMediator:onClickShare(sender, eventType, id)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENAVIEW_NOTICE")
		}))
	end
end

function ArenaReportMainMediator:onClickBack()
	self:dismiss()
end
