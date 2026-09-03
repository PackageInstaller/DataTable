-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceScheduleMediator.lua

PetRaceScheduleMediator = class("PetRaceScheduleMediator", DmAreaViewMediator)

PetRaceScheduleMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
PetRaceScheduleMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local buttonClickEventMap = {
	["Panel_base.Button_shout"] = "onClickShout",
	["Panel_base.Button_refresh"] = "onClickRefresh"
}
local reportLCellTag = {
	PetRaceReportCell = 1001,
	PetRaceReportEightCell = 1002
}
local kCellWidth, kCellHeight, kCellGap = 858, 147, 0
local kCellWidth_1, kCellHeight_1 = 858, 357

function PetRaceScheduleMediator:initialize()
	super.initialize(self)
end

function PetRaceScheduleMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function PetRaceScheduleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(buttonClickEventMap)

	self._btn_embattle = self:bindWidget("Panel_base.Button_embattle", TwoLevelViceButton, {
		handler = {
			func = bind1(self.onClickEmbattle, self)
		}
	})
end

function PetRaceScheduleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_STATE_CHANGE, self, self.updateState)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_SHOUT_PUSH, self, self.showShout)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_ADJUSTTEAMORDER, self, self.refreshEmbattleShow)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_EMBATTLE_DATA_CHANGE, self, self.refreshEmbattleShow)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_GETREWARD, self, self.updateReward)
end

function PetRaceScheduleMediator:refreshEmbattleShow()
	self._schedule_current.mediator:refreshView()
end

function PetRaceScheduleMediator:enterWithData(data)
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())
	self:setupView()
	self:initScheculeCurrent()
	self:mapEventListeners()

	self._resultListData = {}

	self:createMyReportTableView()

	self._knockoutSta = self._petRaceSystem:knockout()

	self:refreshView()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:updateCD()
	end, 1, false)

	self:updateCD()
end

function PetRaceScheduleMediator:setupView()
	self._panel_base = self:getView():getChildByName("Panel_base")
	self._btnShout = self._panel_base:getChildByFullName("Button_shout")
	self._button_refresh = self._panel_base:getChildByFullName("Button_refresh")
	self._textEmbattleDes = self._panel_base:getChildByFullName("Text_embattle_des")
	self._nodeTitleDes = self._panel_base:getChildByFullName("Node_titleDes")
	self._textOverDes = self._nodeTitleDes:getChildByFullName("Text_over_des")

	self._textEmbattleDes:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._textOverDes:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local victoriesDes = self._panel_base:getChildByFullName("Node_titleDes.Text_victories_des")
	local text_victories = self._panel_base:getChildByFullName("Node_titleDes.Text_victories")
	local text_des_1 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_1")
	local text_des_2 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_2")
	local text_score = self._panel_base:getChildByFullName("Node_titleDes.Text_score")
	local text_rank = self._panel_base:getChildByFullName("Node_titleDes.Text_rank")

	victoriesDes:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_victories:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_des_1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_score:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_des_2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_rank:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._btnShout:setVisible(false)
end

function PetRaceScheduleMediator:showShout(event)
	local data = event:getData().response

	if data and self._schedule_current then
		self._schedule_current.mediator:showShout(data.content, data.isSelf)
	end
end

function PetRaceScheduleMediator:updateState(event)
	if self._knockoutSta then
		local state = self._petRaceSystem:getMyMatchState()

		if state == PetRaceEnum.state.matchOver then
			self._resultListData = self._petRaceSystem:getMyReportList()

			local round = self._petRaceSystem:getRound()

			if round > self._petRaceSystem:getScoreMaxRound() then
				self:tableViewReloadData(self._reportTableView, kCellHeight_1)
			else
				self:tableViewReloadData(self._reportTableView, kCellHeight)
			end
		end

		return
	end

	self._knockoutSta = self._petRaceSystem:knockout()

	self:refreshView()
end

function PetRaceScheduleMediator:refreshView()
	self:refreshEmbattleBtn()
	self:refreshMyRecord()
	self:updateCD()

	local round = self._petRaceSystem:getRound()
	local scoreRound = self._petRaceSystem:getScoreMaxRound()
	local knockout = self._petRaceSystem:knockout()
	local state = self._petRaceSystem:getMyMatchState()

	if knockout or state == PetRaceEnum.state.matchOver then
		self._nodeTitleDes:setVisible(true)
		self._schedule_current:setVisible(false)
		self._reportTableView:setVisible(true)

		self._resultListData = self._petRaceSystem:getMyReportList()

		self._reportTableView:reloadData()
	else
		self._schedule_current.mediator:refreshView()
		self._reportTableView:setVisible(false)
		self._schedule_current:setVisible(true)

		if scoreRound < round then
			self._nodeTitleDes:setVisible(false)
		else
			self._nodeTitleDes:setVisible(true)
		end
	end
end

function PetRaceScheduleMediator:initScheculeCurrent()
	local node_contains = self._panel_base:getChildByFullName("Node_contains")
	local view = self:getInjector():getInstance("PetRaceScheduleCurrentLayer")

	view.mediator = self:getInjector():instantiate("PetRaceScheduleCurrentLayer", {
		view = view
	})

	node_contains:addChild(view)

	self._schedule_current = view
end

function PetRaceScheduleMediator:refreshEmbattleBtn()
	local state = self._petRaceSystem:getMyMatchState()
	local knockout = self._petRaceSystem:knockout()
	local round = self._petRaceSystem:getRound()

	if knockout or state == PetRaceEnum.state.matchOver then
		self._btnShout:setVisible(false)
		self._btn_embattle:getView():setVisible(false)
		self._textEmbattleDes:setVisible(false)
		self._textOverDes:setVisible(true)
		self._button_refresh:setVisible(false)
	elseif state == PetRaceEnum.state.embattle then
		self._btnShout:setVisible(true)
		self._btn_embattle:getButton():setGray(false)
		self._btn_embattle:getButton():setTouchEnabled(true)
		self._btn_embattle:getView():setVisible(true)
		self._btn_embattle:getNameText():setString(Strings:get("Petrace_Text_102"))
		self._btn_embattle:getNameText1():setString(Strings:get("UITitle_EN_Tiaozhengduiwu"))
		self._textEmbattleDes:setVisible(false)
		self._textOverDes:setVisible(false)
		self._button_refresh:setGray(false)
		self._button_refresh:setTouchEnabled(true)
		self._button_refresh:setVisible(true)
	elseif state == PetRaceEnum.state.regist then
		self._btnShout:setVisible(false)
		self._btn_embattle:getButton():setGray(false)
		self._btn_embattle:getButton():setTouchEnabled(true)
		self._btn_embattle:getView():setVisible(true)
		self._btn_embattle:getNameText():setString(Strings:get("Petrace_Text_57"))
		self._btn_embattle:getNameText1():setString(Strings:get("UIPVP_EN_Buzhen"))
		self._textEmbattleDes:setVisible(false)
		self._textOverDes:setVisible(false)
	elseif round == 0 and state == PetRaceEnum.state.match then
		self._btnShout:setVisible(false)
		self._btn_embattle:getButton():setGray(true)
		self._btn_embattle:getButton():setTouchEnabled(false)
		self._btn_embattle:getView():setVisible(false)
		self._textEmbattleDes:setVisible(true)
		self._textOverDes:setVisible(false)
		self._button_refresh:setVisible(false)
	else
		self._btnShout:setVisible(false)
		self._btn_embattle:getButton():setGray(true)
		self._btn_embattle:getButton():setTouchEnabled(false)
		self._btn_embattle:getView():setVisible(false)
		self._textEmbattleDes:setVisible(true)
		self._textOverDes:setVisible(false)
		self._button_refresh:setGray(true)
		self._button_refresh:setTouchEnabled(false)
		self._button_refresh:setVisible(true)
	end

	self._btnShout:setVisible(false)
end

function PetRaceScheduleMediator:refreshMyRecord()
	local text_victories = self._nodeTitleDes:getChildByName("Text_victories")
	local text_score = self._nodeTitleDes:getChildByName("Text_score")
	local text_rank = self._nodeTitleDes:getChildByName("Text_rank")
	local winNum = self._petRaceSystem:getWinNum()
	local fileNum = self._petRaceSystem:getFileNum()
	local scoreNum = self._petRaceSystem:getScore()
	local rankNum = self._petRaceSystem:getRank()

	text_rank:setString(rankNum)
	text_score:setString(scoreNum)
	text_victories:setString(string.format(Strings:get("Petrace_Text_30"), winNum, fileNum))

	local victoriesDes = self._panel_base:getChildByFullName("Node_titleDes.Text_victories_des")
	local text_des_1 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_1")
	local text_des_2 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_2")

	text_rank:setPositionX(text_des_2:getPositionX() + text_des_2:getContentSize().width + 10)
	victoriesDes:setPositionX(text_rank:getPositionX() + text_rank:getContentSize().width + 30)
	text_victories:setPositionX(victoriesDes:getPositionX() + victoriesDes:getContentSize().width + 5)
	text_des_1:setPositionX(text_victories:getPositionX() + text_victories:getAutoRenderSize().width + 30)
	text_score:setPositionX(text_des_1:getPositionX() + text_des_1:getContentSize().width + 5)
end

function PetRaceScheduleMediator:updateCD()
	self._schedule_current.mediator:updateTime()
end

function PetRaceScheduleMediator:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceScheduleMediator:onClickEmbattle(sender, eventType)
	local knockout = self._petRaceSystem:knockout()

	if knockout then
		self:showTip(Strings:get("Petrace_Text_33"))

		return false
	end

	local state = self._petRaceSystem:getMyMatchState()

	if state == PetRaceEnum.state.embattle then
		local targetTime = self._petRaceSystem:getUpdateTime()
		local view = self:getInjector():getInstance("PetRaceEmBattleForScheduleView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			targetTime = targetTime
		})

		self:dispatch(event)
	elseif state == PetRaceEnum.state.regist then
		local view = self:getInjector():getInstance("PetRaceEmbattleForRegistView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, "PetRaceEmbattleForRegistView")

		self:dispatch(event)
	else
		self:showTip(Strings:get("Petrace_Text_13"))

		return false
	end
end

function PetRaceScheduleMediator:onClickShout(sender, eventType)
	local view = self:getInjector():getInstance("PetRaceShoutView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	})

	self:dispatch(event)
end

function PetRaceScheduleMediator:onClickRefresh(sender, eventType)
	local state = self._petRaceSystem:getMyMatchState()
	local knockout = self._petRaceSystem:knockout()

	if knockout or state ~= PetRaceEnum.state.embattle then
		return
	end

	local function callback()
		self:showTip(Strings:get("Petrace_Text_103"))
		self:refreshView()
	end

	self._petRaceSystem:requestData(callback, true)
end

function PetRaceScheduleMediator:createMyReportTableView()
	if self._reportTableView then
		return
	end

	local scoreRound = self._petRaceSystem:getScoreMaxRound()
	local listLocator = self:getChildView("Panel_base.Panel_listLocator")
	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._resultListData
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, index)
		local w, h = kCellWidth, kCellHeight

		if index + 1 > scoreRound then
			h = kCellHeight_1
			w = kCellWidth_1
		end

		return w, h + kCellGap
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local targetCell = "PetRaceOverCell"
		local targetViewCell = "asset/ui/Node_schedule_overCellN.csb"
		local celltag = reportLCellTag.PetRaceReportCell

		if index > scoreRound then
			targetCell = "PetRaceOverEightCell"
			targetViewCell = "asset/ui/Node_schedule_eight_overCellN.csb"
			celltag = reportLCellTag.PetRaceReportEightCell
		end

		local cell = tableView:dequeueCellByTag(celltag)

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setTag(celltag)

			local realCell = cc.CSLoader:createNode(targetViewCell)

			cell.m_cellMediator = self:getInjector():instantiate(targetCell, {
				view = realCell
			})

			cell:addChild(realCell)
		end

		if not self._resultListData[index] then
			local data = {}
			local round = data.round

			cell.m_cellMediator:update(data, round)

			return cell
		end
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(listLocator:getPosition())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._reportTableView = tableView
end

function PetRaceScheduleMediator:updateReward(event)
	if self._reportTableView and self._reportTableView:isVisible() then
		self:tableViewReloadData(self._reportTableView)
	end
end

function PetRaceScheduleMediator:tableViewReloadData(view, offsetY)
	offsetY = offsetY or 0

	local offset = view:getContentOffset()

	offset.y = offset.y - offsetY

	view:reloadData()
	view:setContentOffset(offset)
end
