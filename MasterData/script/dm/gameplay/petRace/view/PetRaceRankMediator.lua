-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceRankMediator.lua

require("dm.gameplay.rank.view.component.BaseRankCell")

PetRaceRankMediator = class("PetRaceRankMediator", DmPopupViewMediator)

PetRaceRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceRankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
PetRaceRankMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kCellHeight = 47

function PetRaceRankMediator:initialize()
	super.initialize(self)
end

function PetRaceRankMediator:dispose()
	super.dispose(self)
end

function PetRaceRankMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)

	local bgNode = self:getView():getChildByFullName("main.bgNode")
	local tempNode = bindWidget(self, bgNode, PopupNormalTabWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Petrace_Daily_Rank"),
		title1 = Strings:get("UITitle_EN_Paihang")
	})
end

function PetRaceRankMediator:enterWithData(data)
	local matchNumbers = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_MatchNumber", "content")

	self._curTabIdx = 1
	self._matchCount = #matchNumbers
	self._selfTagImg = nil
	self._isAskingRank = false

	self:refreshData()
	self:initWigetInfo()
	self:createTableView()
	self:createTabController()
	self:initMyselfImg()
end

function PetRaceRankMediator:resumeWithData()
	self:onClickTab("", self._curTabIdx)
end

function PetRaceRankMediator:initWigetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._viewPanel = self:getView():getChildByFullName("main.viewPanel")
	self._myselfInfo = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg")
	self._myselfText1 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_1")
	self._myselfText2 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_2")
	self._myselfText3 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_3")
	self._myselfText4 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_4")
	self._imgNoRank = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.img_no_in_rank")
	self._imgMyself = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.img_myself")

	self._viewPanel:getChildByName("Image"):setVisible(false)
	self._viewPanel:getChildByName("rewardPanel"):setVisible(false)
	self._mainPanel:getChildByName("rankBg"):setVisible(false)
	self._mainPanel:getChildByName("main_bg"):setVisible(false)
	self._viewPanel:setPosition(249, 42)

	local kRankTitleKey = {
		"RANK_UI2",
		"RANK_UI3",
		"Rank_Petrace_WinNum",
		"Rank_Petrace_Score"
	}

	for i = 1, #kRankTitleKey do
		local title = self._mainPanel:getChildByFullName("viewPanel.property_bg.property_" .. i)

		title:setString(Strings:get(kRankTitleKey[i]))
	end
end

function PetRaceRankMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, self._matchCount do
		data[#data + 1] = {
			tabText = string.format(Strings:get("Petrace_Text_1"), i),
			tabTextTranslate = Strings:get("UITitle_EN_Zhandouli")
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 496)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabIdx)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 4)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabIdx)
end

function PetRaceRankMediator:createTableView()
	local scrollLayer = self._mainPanel:getChildByFullName("viewPanel.tableView")
	local viewSize = scrollLayer:getContentSize()
	local offsetY = scrollLayer:getPositionY()

	viewSize.height = viewSize.height + offsetY

	scrollLayer:setPositionY(0)

	local tableView = cc.TableView:create(viewSize)

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableView()
		end
	end

	local function numberOfCells(view)
		return #self._rankList < 6 and 6 or #self._rankList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		cell:removeAllChildren()

		local rankCell = PetRaceRankCell:new({
			mediator = self
		})

		cell:addChild(rankCell:getView(), 0)
		rankCell:getView():setPosition(0, 0)

		cell.rankCell = rankCell

		local index = idx + 4
		local record = self._rankList[index]

		cell:setTag(idx)

		if record then
			cell.rankCell:refreshData(record)
		else
			cell.rankCell:refreshEmpty(index)
		end

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(scrollLayer)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(36)

	self._tableView = tableView
end

function PetRaceRankMediator:onClickRankCell(cell)
	return
end

function PetRaceRankMediator:touchForTableView()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._rankList < self._rankSystem:getMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = #self._rankList

		self:doRequestNextRank()
	end
end

function PetRaceRankMediator:doRequestNextRank()
	local dataEnough = self:getRankSystem():isServerDataEnough(RankType.kSubPetRace)

	if dataEnough == true then
		self._tableView:stopScroll()

		local function onRequestRankDataSucc()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshData()
			self:refreshView()
		end

		local rankStart = #self._rankList - 10

		rankStart = math.max(rankStart, 1)

		local rankEnd = rankStart + 10 + self._rankSystem:getRequestRankCountPerTime()
		local sendData = {
			type = RankType.kSubPetRace,
			subId = self._curTabIdx - 1,
			rankStart = rankStart,
			rankEnd = rankEnd
		}

		self._rankSystem:requestAloneRankData(sendData, onRequestRankDataSucc)
	end
end

function PetRaceRankMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(RankType.kSubPetRace)
end

function PetRaceRankMediator:onClickTab(name, tag)
	self._curTabIdx = tag

	self._tableView:stopScroll()

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
	end

	self._rankSystem:cleanUpRankListByType(RankType.kSubPetRace)

	local var_20_0 = {
		rankStart = 1,
		type = RankType.kSubPetRace,
		subId = self._curTabIdx - 1
	}

	var_20_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()

	local sendData = var_20_0

	self._rankSystem:requestAloneRankData(sendData, switchTabView)

	self._requestNextCount = nil
	self._isAskingRank = false
end

function PetRaceRankMediator:dailyReset()
	self:close()
end

function PetRaceRankMediator:refreshView()
	self:refreshMyselfInfo()
	self._tableView:stopScroll()
	self._tableView:reloadData()
	self:refreshTop3()

	if self._requestNextCount then
		local diffCount = #self._rankList - self._requestNextCount
		local offsetY = diffCount == 0 and 0 or -diffCount * kCellHeight + kCellHeight * 1.2

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end
end

function PetRaceRankMediator:refreshTop3()
	for i = 1, 3 do
		local record = self._rankList[i]
		local node = self._viewPanel:getChildByName("cellPanel_" .. i)

		if node then
			local nameText = node:getChildByName("name")
			local rolePanel = node:getChildByName("rolePanel")
			local numText = node:getChildByName("rankNum")
			local rankText = node:getChildByName("rankTxt1")

			if record then
				local headIcon, oldIcon = IconFactory:createPlayerIcon({
					clipType = 4,
					id = record:getHeadId(),
					size = rolePanel:getContentSize(),
					headFrameId = record:getHeadFrame()
				})

				headIcon:addTo(rolePanel):center(rolePanel:getContentSize())
				oldIcon:setScale(0.5)
				headIcon:setScale(0.8)
				nameText:setString(record:getName())
				numText:setString(record:getScore())
				rankText:setString(Strings:get("Petrace_Text_44"))
			else
				rolePanel:removeAllChildren()
				nameText:setString(Strings:get("RankRuleUI_4"))
				numText:setString("")
				rankText:setString("")
			end
		end
	end
end

function PetRaceRankMediator:refreshMyselfInfo()
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()

	if enterIndex + 1 == self._curTabIdx then
		self._myselfInfo:setVisible(true)
	else
		self._myselfInfo:setVisible(false)

		return
	end

	local myselfData = self:getRankSystem():getMyselfDataByType(RankType.kSubPetRace)

	if not myselfData then
		return
	end

	local str = self:getRankSystem():getMyselfShowInfoByType(myselfData)
	local var_25_0 = {
		myselfData,
		(myselfData:getRank())
	}

	var_25_0[3] = self:getRankSystem():getMaxRank()

	dump(var_25_0, "refreshMyselfInfo")

	local rank = myselfData:getRank()
	local maxRank = self:getRankSystem():getMaxRank()

	self._myselfText1:setString(str[1])
	self._myselfText2:setString(str[2])
	self._myselfText3:setString(str[3])

	if rank <= 0 or maxRank < rank then
		self._imgNoRank:setVisible(true)
		self._myselfText1:setVisible(false)
	else
		self._imgNoRank:setVisible(false)
		self._myselfText1:setVisible(true)
	end

	self._myselfText4:setString(str[4])
end

function PetRaceRankMediator:initMyselfImg()
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()

	if enterIndex ~= -1 and not self._selfTagImg then
		local tabBtns = self._tabBtnWidget:getTabBtns()
		local tabBtn = tabBtns[enterIndex + 1]

		if tabBtn then
			self._selfTagImg = self._imgMyself:clone()

			self._selfTagImg:setVisible(true)
			self._selfTagImg:addTo(tabBtn):posit(tabBtn:getContentSize().width, tabBtn:getContentSize().height):offset(-30, -17)
		end
	end
end

function PetRaceRankMediator:onClickBack()
	self:close()
end
