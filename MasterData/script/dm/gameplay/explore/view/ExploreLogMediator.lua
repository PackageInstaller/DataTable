-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreLogMediator.lua

ExploreLogMediator = class("ExploreLogMediator", DmPopupViewMediator, _M)

ExploreLogMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreLogMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local kStrategyType = {
	kTop = 1,
	kSelf = 2,
	kNew = 3
}
local kStrategyTypeStr = {
	[kStrategyType.kTop] = Strings:get("EXPLORE_UI113"),
	[kStrategyType.kSelf] = Strings:get("EXPLORE_UI114"),
	[kStrategyType.kNew] = Strings:get("EXPLORE_UI61")
}
local kTabName = {
	{
		"EXPLORE_UI54",
		"UITitle_EN_Rizhi"
	},
	{
		"EXPLORE_UI55",
		"UITitle_EN_Gonglve"
	}
}

function ExploreLogMediator:initialize()
	super.initialize(self)
end

function ExploreLogMediator:dispose()
	super.dispose(self)
end

function ExploreLogMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.strategyPanel.send", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSendComment, self)
		}
	})
end

function ExploreLogMediator:bindWidgets()
	return
end

function ExploreLogMediator:mapEventListeners()
	return
end

function ExploreLogMediator:enterWithData(data)
	self:mapEventListeners()
	self:initData(data)
	self:setupView()
	self:initTabView()
end

function ExploreLogMediator:setupView()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalTabWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = self._pointData:getName(),
		title1 = Strings:get("UITitle_EN_MAPNAME"),
		bgSize = {
			width = 1063,
			height = 612
		}
	})
	self._mainPanel = self:getView():getChildByName("main")
	self._logPanel = self._mainPanel:getChildByName("logPanel")
	self._strategyPanel = self._mainPanel:getChildByName("strategyPanel")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._cellPanel = self._strategyPanel:getChildByFullName("clonecell")

	local zuirewzd = self._cellPanel:getChildByFullName("zuirewzd")
	local zuirewzt = zuirewzd:getChildByFullName("zuirewzt")

	zuirewzd:setContentSize(cc.size(zuirewzt:getContentSize().width + 20, zuirewzt:getContentSize().height + 6))
	zuirewzt:setPositionX(zuirewzd:getContentSize().width - 16)

	local selfTip = self._cellPanel:getChildByFullName("selfTip")
	local zuirewzt = selfTip:getChildByFullName("zuirewzt")

	selfTip:setContentSize(cc.size(zuirewzt:getContentSize().width + 20, zuirewzt:getContentSize().height + 6))
	zuirewzt:setPositionX(selfTip:getContentSize().width - 16)
	self._cellPanel:setVisible(false)
end

function ExploreLogMediator:initData(data)
	self._pointData = data.pointData
	self._curTabType = data.tabType or 1

	local logIds = CommonUtils.getDataFromLocalByKey(EXPLORE_LOG_KEY)

	if logIds then
		self._logData = logIds.logIdArr or {}
	end

	self._commentList = {}

	self:sortCommentList(data.serverdata)
end

function ExploreLogMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #kTabName do
		data[#data + 1] = {
			tabText = Strings:get(kTabName[i][1]),
			tabTextTranslate = Strings:get(kTabName[i][2])
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
	self._tabBtnWidget:selectTabByTag(self._curTabType)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function ExploreLogMediator:initLogView()
	local width = self._logPanel:getContentSize().width

	local function cellSizeForTable(table, idx)
		local logArr = string.split(self._logData[idx + 1], "$")
		local log = logArr[2]
		local desc = Strings:get(log, {
			fontSize = 18,
			fontName = TTF_FONT_FZYH_M
		})
		local logStr = ccui.RichText:createWithXML(desc, {})

		logStr:setVerticalSpace(10)
		logStr:renderContent(744, 0)
		logStr:setAnchorPoint(cc.p(0, 1))
		logStr:setPosition(cc.p(0, logStr:getContentSize().height))

		return width, logStr:getContentSize().height + 20
	end

	local function numberOfCellsInTableView(table)
		return #self._logData
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:removeAllChildren()

		local logArr = string.split(self._logData[idx + 1], "$")
		local log = logArr[2]
		local desc = Strings:get(log, {
			fontSize = 20,
			fontName = TTF_FONT_FZYH_R
		})
		local logStr = ccui.RichText:createWithXML(desc, {})

		logStr:setVerticalSpace(10)
		logStr:renderContent(width, 0)
		logStr:setAnchorPoint(cc.p(0, 1))
		logStr:setPosition(cc.p(0, logStr:getContentSize().height))
		logStr:addTo(cell)

		return cell
	end

	self._logPanel:removeAllChildren()

	local tableView = cc.TableView:create(self._logPanel:getContentSize())

	self._logTableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 10))
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._logPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
end

function ExploreLogMediator:initStrategyView()
	self:setTextField()

	local empty = self._strategyPanel:getChildByFullName("empty")

	empty:setVisible(#self._commentList == 0)

	local cellWidth = self._cellPanel:getContentSize().width
	local cellHeight = self._cellPanel:getContentSize().height

	local function cellSizeForTable(table, idx)
		local data = self._commentList[idx + 1]

		if data.type then
			return cellWidth, cellHeight + 25
		end

		return cellWidth, cellHeight
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(10, -10))
			sprite:setSwallowTouches(false)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setPosition(cc.p(0, 0))
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
		return #self._commentList
	end

	local tableView = cc.TableView:create(self._strategyPanel:getChildByFullName("tableView"):getContentSize())

	tableView:setAnchorPoint(0, 0)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(0, 0)

	self._strategyView = tableView

	self._strategyPanel:getChildByFullName("tableView"):addChild(tableView, 900)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
end

function ExploreLogMediator:createCell(cell, tag)
	local data = self._commentList[tag]

	if not data then
		return
	end

	local oldcell = cell:getChildByTag(123)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	local nameLabel = cell:getChildByFullName("playername")

	nameLabel:setString(data.nickname)

	local infoLabel = cell:getChildByFullName("commentinfo")

	infoLabel:getVirtualRenderer():setLineHeight(26)
	infoLabel:setString(data.content)

	local zanshu = cell:getChildByFullName("zandi.zanshu")

	zanshu:setString(data.like)
	cell:getChildByFullName("zuirewzd"):setVisible(false)
	cell:getChildByFullName("typeImage"):setVisible(false)

	if data.type then
		cell:getChildByFullName("typeImage"):setVisible(true)

		local str = kStrategyTypeStr[data.type]

		cell:getChildByFullName("typeImage.type"):setString(str)
	end

	local hotTip = cell:getChildByFullName("zuirewzd")
	local selfTip = cell:getChildByFullName("selfTip")

	if data.hot then
		hotTip:setVisible(true)
	end

	local posY = hotTip:isVisible() and 54 or 81

	selfTip:setVisible(data.isSelf)
	selfTip:setPositionY(posY)
	cell:getChildByFullName("zandi.no"):setVisible(true)
	cell:getChildByFullName("zandi.yes"):setVisible(data.mylike)

	local zanbtn = cell:getChildByFullName("zanbtn")

	zanbtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local yes = cell:getChildByFullName("zandi.yes")

			if yes:isVisible() then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("EXPLORE_UI59")
				}))

				return
			end

			local params = {
				pointId = self._pointData:getId(),
				commentId = data.id
			}

			self._exploreSystem:requestSupportPointComment(function(response)
				yes:setVisible(true)
				self:sortCommentList(response.data)
				self._strategyView:reloadData()
			end, params)
		end
	end)
end

function ExploreLogMediator:setTextField()
	if self._commentInfo then
		return
	end

	local inputWidget = self._strategyPanel:getChildByFullName("inputbg.input")

	if inputWidget:getDescription() == "TextField" then
		inputWidget:setMaxLengthEnabled(true)
		inputWidget:setMaxLength(50)
	end

	self._commentInfo = convertTextFieldToEditBox(inputWidget, nil, MaskWordType.CHAT)

	self._commentInfo:setPlaceHolder(Strings:get("EXPLORE_UI56"))
	self._commentInfo:setPlaceholderFontColor(cc.c3b(195, 195, 195))
	self._commentInfo:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			self._oldStr = self._commentInfo:getText()

			local state, finalString = StringChecker.checkString(self._oldStr, MaskWordType.CHAT)

			if state == StringCheckResult.AllOfCharForbidden then
				self._oldStr = ""

				self._commentInfo:setText("")
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Input_Tip1")
				}))
			end
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			-- block empty
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)
end

function ExploreLogMediator:sortCommentList(alldata)
	if not alldata then
		return
	end

	local rid = self._developSystem:getRid()
	local toplist = alldata.top
	local alllist = alldata.list
	local newlist = {}
	local count = 0

	for k, v in pairs(toplist) do
		count = count + 1

		if count == 1 then
			v.hot = true
			v.type = kStrategyType.kTop
		end

		v.isSelf = v.rid == rid

		table.insert(newlist, v)
	end

	count = 0

	for k, v in pairs(alllist) do
		count = count + 1

		if count == 1 then
			v.type = kStrategyType.kNew
		end

		v.isSelf = v.rid == rid

		table.insert(newlist, v)
	end

	self._commentList = newlist
end

function ExploreLogMediator:resetViews()
	self._logPanel:setVisible(false)
	self._strategyPanel:setVisible(false)
	self._logPanel:removeAllChildren()
	self._strategyPanel:getChildByFullName("tableView"):removeAllChildren()

	if self._curTabType == 1 then
		self:initLogView()
		self._logTableView:reloadData()
		self._logPanel:setVisible(true)
	elseif self._curTabType == 2 then
		self:initStrategyView()
		self._strategyView:reloadData()
		self._strategyPanel:setVisible(true)
	end
end

function ExploreLogMediator:onClickSendComment()
	if self._commentInfo:getText() == "" or self._commentInfo:getText() == Strings:get("EXPLORE_UI56") then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("EXPLORE_UI58")
		}))

		return
	end

	local params = {
		pointId = self._pointData:getId(),
		content = self._commentInfo:getText()
	}

	self._exploreSystem:requestPublishPointComment(function(response)
		self._commentList = response.data.list

		self:sortCommentList(response.data)
		self._strategyView:reloadData()
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("EXPLORE_UI57")
		}))
		self._commentInfo:setText("")
		self._commentInfo:setPlaceHolder(Strings:get("EXPLORE_UI56"))

		local empty = self._strategyPanel:getChildByFullName("empty")

		empty:setVisible(#self._commentList == 0)
	end, params)
end

function ExploreLogMediator:onClickTab(name, tag)
	self._curTabType = tag

	self:resetViews()
end

function ExploreLogMediator:onClickBack()
	self:close()
end
