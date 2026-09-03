-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceReportMediator.lua

PetRaceReportMediator = class("PetRaceReportMediator", DmAreaViewMediator)

PetRaceReportMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
PetRaceReportMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local reportLCellTag = {
	PetRaceReportCell = 1001,
	PetRaceReportEightCell = 1002
}
local kCellWidth, kCellHeight, kCellGap = 858, 144, 0
local kCellWidth_1, kCellHeight_1 = 858, 357

function PetRaceReportMediator:initialize()
	super.initialize(self)
end

function PetRaceReportMediator:dispose()
	super.dispose(self)
end

function PetRaceReportMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._scoreMaxRound = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_ScoreMaxRound", "content")
end

function PetRaceReportMediator:enterWithData(data)
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())

	self._elitebattleData = {}

	self:setupView()

	self._reportClickIndex = self._petRaceSystem._reportClickIndex
	self._curTabType = self._reportClickIndex

	self:createTabControl()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_STATE_CHANGE, self, self.updateState)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_GETREWARD, self, self.updateReward)
end

function PetRaceReportMediator:setupView()
	self._panel_base = self:getChildView("Panel_base")
	self._tabpanel = self._panel_base:getChildByFullName("tabpanel")

	self._panel_base:getChildByFullName("Node_titleDes.Text_victories_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._panel_base:getChildByFullName("Node_titleDes.Text_victories"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._panel_base:getChildByFullName("Node_titleDes.Text_des_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._panel_base:getChildByFullName("Node_titleDes.Text_score"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._panel_base:getChildByFullName("Node_titleDes.Text_des_2"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._panel_base:getChildByFullName("Node_titleDes.Text_rank"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._viewMap = {}

	self:refreshBattleDes()
end

function PetRaceReportMediator:updateLayerVisible(index)
	for i, v in pairs(self._viewMap) do
		v:setVisible(i == index)
	end
end

function PetRaceReportMediator:switchToEightView()
	if self._eightView then
		return
	end

	self._eightView = self:createEightView()
	self._viewMap[2] = self._eightView
end

function PetRaceReportMediator:switchToEliteView()
	if not self._eliteReportTableView then
		self._eliteReportTableView = self:createEliteReportTableView()
		self._viewMap[3] = self._eliteReportTableView
	end

	self._petRaceSystem:requestWonderBattle(nil, true, function()
		self._elitebattleData = self._petRaceSystem:getWonderBattle()

		self._eliteReportTableView:reloadData()
	end)
end

function PetRaceReportMediator:switchToReportView()
	self._resultListData = self._petRaceSystem:getMyReportList()

	if not self._myReportTableView then
		self._myReportTableView = self:createMyReportTableView()
		self._viewMap[1] = self._myReportTableView
	end

	self._myReportTableView:reloadData()
end

function PetRaceReportMediator:createMyReportTableView()
	local listLocator = self:getChildView("Panel_base.Panel_listLocator")

	if not listLocator then
		return
	end

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

		if index + 1 > self._scoreMaxRound then
			h = kCellHeight_1
			w = kCellWidth_1
		end

		return w, h + kCellGap
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local targetCell = "PetRaceOverCell"
		local celltag = reportLCellTag.PetRaceReportCell

		if index > self._scoreMaxRound then
			targetCell = "PetRaceOverEightCell"
			celltag = reportLCellTag.PetRaceReportEightCell
		end

		local cell = tableView:dequeueCellByTag(celltag)

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setTag(celltag)

			local realCell = self:getInjector():getInstance(targetCell)

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

	return tableView
end

function PetRaceReportMediator:createEightView()
	local eightLayer = self:getInjector():getInstance("PetRaceFinalEightLayer")

	eightLayer.mediator = self:getInjector():instantiate(PetRaceFinalEightLayer, {
		view = eightLayer
	})

	self._panel_base:addChild(eightLayer)
	eightLayer.mediator:updateFinalHeroIconInfo()
	eightLayer:getChildByFullName("Panel_base.Node_time"):setVisible(false)
	eightLayer:setPositionX(eightLayer:getPositionX() + 210)
	eightLayer:setPositionY(eightLayer:getPositionY() + 82)
	eightLayer:setScale(0.82)

	return eightLayer
end

function PetRaceReportMediator:createEliteReportTableView()
	local listLocator = self:getChildView("Panel_base.Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._elitebattleData
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, index)
		local num = index + 1
		local data = self._elitebattleData[num]

		if data and data.myEmbattle and data.rivalEmbattle and #data.myEmbattle > 1 and #data.rivalEmbattle > 1 then
			return kCellWidth_1, kCellHeight_1 + kCellGap
		end

		return kCellWidth, kCellHeight + kCellGap
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local targetCell = "PetRaceOverCell"
		local celltag = reportLCellTag.PetRaceReportCell
		local dataBattle = self._elitebattleData[index]

		if dataBattle and dataBattle.myEmbattle and dataBattle.rivalEmbattle and #dataBattle.myEmbattle > 1 and #dataBattle.rivalEmbattle > 1 then
			targetCell = "PetRaceOverEightCell"
			celltag = reportLCellTag.PetRaceReportEightCell
		end

		local cell = tableView:dequeueCellByTag(celltag)

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setTag(celltag)

			local realCell = self:getInjector():getInstance(targetCell)

			cell.m_cellMediator = self:getInjector():instantiate(targetCell, {
				view = realCell
			})

			cell:addChild(realCell)
		end

		if not self._elitebattleData[index] then
			local roundData = {}
			local data = table.deepcopy(roundData)

			data.report = true

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

	return tableView
end

function PetRaceReportMediator:onClickTab(tag)
	self._curTabType = tag
	self._petRaceSystem._reportClickIndex = tag

	if tag == 1 then
		self:switchToReportView()
		self:updateLayerVisible(tag)
	elseif tag == 2 then
		self:switchToEightView()
		self:updateLayerVisible(tag)
	else
		self:switchToEliteView()
		self:updateLayerVisible(tag)
	end
end

function PetRaceReportMediator:onClickTab_1()
	self:onClickTab(1)
end

function PetRaceReportMediator:onClickTab_2()
	self:onClickTab(2)
end

function PetRaceReportMediator:onClickTab_3()
	self:onClickTab(3)
end

function PetRaceReportMediator:refreshBattleDes()
	local text_victories = self._panel_base:getChildByFullName("Node_titleDes.Text_victories")
	local text_score = self._panel_base:getChildByFullName("Node_titleDes.Text_score")
	local text_rank = self._panel_base:getChildByFullName("Node_titleDes.Text_rank")

	text_score:setString(self._petRaceSystem:getScore())
	text_rank:setString(self._petRaceSystem:getRank())

	local winNum = self._petRaceSystem:getWinNum()
	local fileNum = self._petRaceSystem:getFileNum()

	text_victories:setString(string.format(Strings:get("Petrace_Text_30"), winNum, fileNum))

	local text_des_2 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_2")
	local victoriesDes = self._panel_base:getChildByFullName("Node_titleDes.Text_victories_des")
	local text_des_1 = self._panel_base:getChildByFullName("Node_titleDes.Text_des_1")

	text_rank:setPositionX(text_des_2:getPositionX() + text_des_2:getContentSize().width + 10)
	victoriesDes:setPositionX(text_rank:getPositionX() + text_rank:getContentSize().width + 40)
	text_victories:setPositionX(victoriesDes:getPositionX() + victoriesDes:getContentSize().width + 5)
	text_des_1:setPositionX(text_victories:getPositionX() + text_victories:getContentSize().width + 40)
	text_score:setPositionX(text_des_1:getPositionX() + text_des_1:getContentSize().width + 5)
end

function PetRaceReportMediator:updateState(event)
	if self._curTabType == 1 then
		local resultListData = self._petRaceSystem:getMyReportList()
		local state = self._petRaceSystem:getMyMatchState()

		if #self._resultListData ~= #resultListData or state == PetRaceEnum.state.matchOver then
			self._resultListData = resultListData

			if self._myReportTableView then
				local round = self._petRaceSystem:getRound()

				if round > self._petRaceSystem:getScoreMaxRound() then
					self:tableViewReloadData(self._myReportTableView, kCellHeight_1)
				else
					self:tableViewReloadData(self._myReportTableView, kCellHeight)
				end
			end
		end
	elseif self._curTabType == 2 then
		local view = self._viewMap[2]

		if view and view.mediator then
			view.mediator:updateFinalHeroIconInfo()
		end
	end
end

function PetRaceReportMediator:updateReward(event)
	if self._curTabType == 1 then
		self._resultListData = self._petRaceSystem:getMyReportList()

		if self._myReportTableView then
			self:tableViewReloadData(self._myReportTableView)
		end
	end
end

function PetRaceReportMediator:tableViewReloadData(view, offsetY)
	offsetY = offsetY or 0

	local offset = view:getContentOffset()

	offset.y = offset.y - offsetY

	view:reloadData()
	view:setContentOffset(offset)
end

function PetRaceReportMediator:createTabControl()
	local tabBtnList = {
		"Petrace_Text_97",
		"Petrace_Text_73",
		"Petrace_Text_79"
	}
	local tabBtnList_1 = {
		"UITitle_EN_Wodezhanbao",
		"UITitle_EN_Baqiangduijue",
		"UITitle_EN_Jingcaiduijue"
	}

	self._tabBtnControl = tabBtnList

	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(tag)
		end
	}
	local data = {}

	for i = 1, #tabBtnList do
		local textdes = tabBtnList[i]
		local textdes1 = tabBtnList_1[i]

		data[#data + 1] = {
			tabText = Strings:get(textdes),
			tabTextTranslate = Strings:get(textdes1)
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 470)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end
