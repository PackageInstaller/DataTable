-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaReportViewMediator.lua

require("dm.gameplay.leadStageArena.view.component.LeadStageArenaReportCell")

LeadStageArenaReportViewMediator = class("LeadStageArenaReportViewMediator", DmAreaViewMediator, _M)

LeadStageArenaReportViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaReportViewMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local kCellHeight = 97

function LeadStageArenaReportViewMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaReportViewMediator:dispose()
	super.dispose(self)
end

function LeadStageArenaReportViewMediator:onRegister()
	super.onRegister(self)
end

function LeadStageArenaReportViewMediator:enterWithData(data)
	self:setupView()
end

function LeadStageArenaReportViewMediator:setupView()
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

function LeadStageArenaReportViewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
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

function LeadStageArenaReportViewMediator:createTableView()
	self._reportList = self._leadStageArenaSystem:getReportList()

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

			local rankCell = LeadStageArenaReportCell:new({
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

function LeadStageArenaReportViewMediator:updateTableCell(cell, idx)
	local realIndex = idx + 1
	local report = self._reportList[realIndex]
	local bg = cell.renderNode:getView():getChildByName("bg")
	local btnVideo = bg:getChildByName("button_video")
	local btnShare = bg:getChildByName("button_share")

	cell.renderNode:refreshReportData(self._reportList[realIndex])
	btnVideo:addTouchEventListener(function(sender, eventType)
		self:onClickVideo(sender, eventType, report:getId())
	end)
end

function LeadStageArenaReportViewMediator:onClickVideo(sender, eventType, id)
	if eventType == ccui.TouchEventType.ended then
		self._leadStageArenaSystem:requestBattleReport(id)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function LeadStageArenaReportViewMediator:onClickShare(sender, eventType, id)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENAVIEW_NOTICE")
		}))
	end
end

function LeadStageArenaReportViewMediator:onClickBack()
	self:dismiss()
end
