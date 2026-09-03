-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/PlayerTitleMediator.lua

PlayerTitleMediator = class("PlayerTitleMediator", DmPopupViewMediator, _M)

PlayerTitleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlayerTitleMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local btnHandlers = {}
local kCount = 3
local tabNames = {
	Strings:get("Setting_Ui_Text_4"),
	Strings:get("Title_activity"),
	Strings:get("Title_rare"),
	Strings:get("Title_limit"),
	Strings:get("Title_achievement")
}

function PlayerTitleMediator:initialize()
	super.initialize(self)
end

function PlayerTitleMediator:dispose()
	super.dispose(self)
end

function PlayerTitleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(btnHandlers)
	self:bindWidgets()

	self._main = self:getView():getChildByName("main")
	self._titleCLone = self._main:getChildByName("titleclone")

	self._titleCLone:setVisible(false)

	self._rightPanel = self._main:getChildByName("rightview")
	self._btnPanel = self._main:getChildByName("Panel_btn")
	self._btnClone = self._btnPanel:getChildByName("btnclone")

	self._btnClone:setVisible(false)
end

function PlayerTitleMediator:onRemove()
	super.onRemove(self)
end

function PlayerTitleMediator:enterWithData(data)
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._selectType = 1
	self._useId = self._player:getCurTitleId()

	self:setupView()
	self:mapEventListeners()
end

function PlayerTitleMediator:bindWidgets()
	local bgNode = self:getView():getChildByFullName("main.bgNode")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.close, self)
		},
		title = Strings:get("PlayerTitle_Title"),
		bgSize = {
			width = 860,
			height = 435
		}
	})

	self._exchangeBtn = self:bindWidget("main.rightview.exchangeBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickChangeTitle, self)
		}
	})
end

function PlayerTitleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGETITLE_SUCC, self, self.refreshView)
end

function PlayerTitleMediator:initListData()
	local data = self._settingSystem:getShowTitleList()
	local activity = {}
	local rare = {}
	local limit = {}
	local achievement = {}

	for i, v in pairs(data) do
		if v.config.Type == KTitleType.ACTIVITY then
			activity[#activity + 1] = v
		end

		if v.config.Type == KTitleType.RARE then
			rare[#rare + 1] = v
		end

		if v.config.Type == KTitleType.LIMIT then
			limit[#limit + 1] = v
		end

		if v.config.Type == KTitleType.ACHIEVEMENT then
			achievement[#achievement + 1] = v
		end

		if v.id == self._useId then
			self._curData = v
		end
	end

	if self._curData == nil then
		self._curData = data[1]
	end

	self._dataList = {
		data,
		activity,
		rare,
		limit,
		achievement
	}
end

function PlayerTitleMediator:setupView()
	self:initListData()
	self:createTableView()
	self:createTabBtn()
	self:refreshRightPanel()
end

function PlayerTitleMediator:refreshView()
	self._useId = self._player:getCurTitleId()

	self:refreshRightPanel()

	local offset = self._tableView:getContentOffset()

	self._tableView:reloadData()
	self._tableView:setContentOffset(offset)
end

function PlayerTitleMediator:createTabBtn()
	local tabBtns = {}

	for i, v in pairs(tabNames) do
		local btn = self._btnClone:clone()

		btn:setVisible(true)
		btn:setTag(i)

		local nameText = btn:getChildByName("Text_51")

		nameText:setString(v)
		nameText:setLocalZOrder(99999)
		btn:addTo(self._btnPanel):posite(0 + (i - 1) * 90, 0)

		tabBtns[#tabBtns + 1] = btn
	end

	self._tabController = TabController:new(tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(self._selectType)
end

function PlayerTitleMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(490, 250))
	local cellSIze = self._titleCLone:getContentSize()

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 490, cellSIze.height + 5
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		else
			cell:removeAllChildren()
		end

		self:createLineCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		local tab = self._dataList[self._selectType]

		return math.ceil(#tab / kCount)
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(200, 125)
	tableView:setDelegate()
	self._main:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:setBounceable(false)

	self._tableView = tableView

	self._tableView:reloadData()
end

function PlayerTitleMediator:createLineCell(cell, index)
	local tab = self._dataList[self._selectType]

	for i = 1, kCount do
		local titleInfo = tab[(index - 1) * kCount + i]

		if titleInfo then
			local titleCell = self._titleCLone:clone()

			titleCell:setVisible(true)

			local size = titleCell:getContentSize()

			titleCell:addTo(cell):posite(3 + (size.width + 5) * (i - 1), 0)

			local lockPanel = titleCell:getChildByName("Panel_lock")

			lockPanel:setVisible(titleInfo.unlock == 0)
			lockPanel:setLocalZOrder(5)

			local usePanel = titleCell:getChildByName("used")

			usePanel:setVisible(titleInfo.id == self._useId)
			usePanel:setLocalZOrder(5)

			local selectImg = titleCell:getChildByName("Image_select")

			selectImg:setVisible(titleInfo.id == self._curData.id)
			selectImg:setLocalZOrder(6)

			local icon = IconFactory:createTitleIcon({
				id = titleInfo.id
			})

			icon:addTo(titleCell):center(titleCell:getContentSize()):offset(0, -0)
			icon:setScale(0.9)

			local function callFunc()
				self:onClickTitleIcon(titleInfo)
			end

			mapButtonHandlerClick(nil, titleCell, {
				clickAudio = "Se_Click_Select_1",
				func = callFunc
			})
			titleCell:setSwallowTouches(false)
		end
	end
end

function PlayerTitleMediator:refreshRightPanel()
	local config = self._curData.config
	local titleNode = self._rightPanel:getChildByName("title")

	titleNode:removeAllChildren()

	local icon = IconFactory:createTitleIcon({
		id = self._curData.id
	})

	icon:addTo(titleNode):center(titleNode:getContentSize())
	icon:setScale(1)

	local nameText = self._rightPanel:getChildByName("Text_name")

	nameText:setString(Strings:get(config.Name))
	self:setDescView(Strings:get(config.Desc))

	local btn = self._rightPanel:getChildByName("exchangeBtn")
	local getDesc = self._rightPanel:getChildByName("getDesc")
	local expireTime = self._rightPanel:getChildByName("expireTime")
	local getTime = self._rightPanel:getChildByName("getTime")

	if self._curData.unlock == 1 then
		btn:setVisible(true)
		getDesc:setVisible(false)
		getTime:setVisible(true)

		local tb = TimeUtil:localDate("*t", tonumber(self._curData.getTime) / 1000)

		getTime:setString(Strings:get("PlayerTitle_Time_1", {
			time = tb.year .. "." .. tb.month .. "." .. tb.day
		}))

		if self._curData.id == self._useId then
			self._exchangeBtn:setButtonName(Strings:get("Equip_UI22"))
		else
			self._exchangeBtn:setButtonName(Strings:get("bag_UI13"))
		end

		dump(self._curData, "self._curData")
		expireTime:setVisible(false)

		if self._curData.isLimit and self._curData.useText then
			expireTime:setVisible(true)

			local tb = TimeUtil:localDate("*t", tonumber(self._curData.expireTime) / 1000)

			expireTime:setString(Strings:get("PlayerTitle_Time_2", {
				hours = tb.year .. "." .. tb.month .. "." .. tb.day
			}))
		end
	else
		btn:setVisible(false)
		getTime:setVisible(false)
		expireTime:setVisible(false)
		getDesc:setVisible(true)
		getDesc:setString(Strings:get(config.ResourceDesc))
	end
end

function PlayerTitleMediator:setDescView(str)
	local scrollView = self._rightPanel:getChildByName("ScrollView_Desc")

	scrollView:setScrollBarEnabled(false)

	local descText = scrollView:getChildByName("desc")

	descText:getVirtualRenderer():setDimensions(scrollView:getContentSize().width, 0)
	descText:getVirtualRenderer():setLineSpacing(2)
	descText:setString(str)

	local h = descText:getContentSize().height < 96 and 96 or descText:getContentSize().height

	scrollView:setInnerContainerSize(cc.size(descText:getContentSize().width, h))
	scrollView:scrollToTop(0.01, false)
	descText:setPosition(cc.p(0, h))
end

function PlayerTitleMediator:onClickTitleIcon(titleInfo)
	self._curData = titleInfo

	self:refreshView()
end

function PlayerTitleMediator:onClickTab(name, tag)
	self._selectType = tag

	self._tableView:reloadData()
end

function PlayerTitleMediator:onClickChangeTitle()
	if self._curData.id == self._useId then
		self._settingSystem:requestChangeTitle(self._curData.id, 2)
	else
		self._settingSystem:requestChangeTitle(self._curData.id, 1)
	end
end
