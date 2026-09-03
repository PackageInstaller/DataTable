-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/view/LoginServerListMediator.lua

LoginServerListMediator = class("LoginServerListMediator", DmPopupViewMediator, _M)

LoginServerListMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kBtnHandlers = {}
local showServerNum = 10

function LoginServerListMediator:initialize()
	super.initialize(self)
end

function LoginServerListMediator:dispose()
	super.dispose(self)
end

function LoginServerListMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function LoginServerListMediator:enterWithData(data)
	self:setupView()
	self:initData()
	self:initRecentView()
	self:initTableView()
	self:initTabView()
end

function LoginServerListMediator:setupView()
	self._mainPanel = self:getView():getChildByName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._listPanel = self._mainPanel:getChildByName("listPanel")

	self._listPanel:setVisible(false)

	self._recentPanel = self._mainPanel:getChildByName("recentPanel")

	self._recentPanel:setVisible(false)

	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)

	self._infoNode = self._mainPanel:getChildByName("infoNode")

	self._infoNode:setVisible(false)
	self._recentPanel:getChildByFullName("text1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	self._recentPanel:getChildByFullName("text2"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	self._infoNode:getChildByFullName("level"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	self:ajustServerStateUI()

	local bgNode = self._mainPanel:getChildByFullName("bgNode")
	local tempNode = bindWidget(self, bgNode, PopupNormalTabWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("LOGIN_UI12"),
		title1 = Strings:get("LOGIN_UI18")
	})
end

function LoginServerListMediator:ajustServerStateUI()
	local crowdedTxt = self._mainPanel:getChildByFullName("typePanel.text1")
	local crowdedIcon = self._mainPanel:getChildByFullName("typePanel.Image_46")

	crowdedTxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))

	local goodTxt = self._mainPanel:getChildByFullName("typePanel.text2")
	local goodIcon = self._mainPanel:getChildByFullName("typePanel.Image_46_0")

	goodTxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))

	local maintenanceTxt = self._mainPanel:getChildByFullName("typePanel.text3")
	local maintenanceIcon = self._mainPanel:getChildByFullName("typePanel.Image_46_1")

	maintenanceTxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	maintenanceIcon:setPositionX(maintenanceTxt:getPositionX() - maintenanceTxt:getAutoRenderSize().width - 5)
	goodTxt:setPositionX(maintenanceIcon:getPositionX() - 30)
	goodIcon:setPositionX(goodTxt:getPositionX() - goodTxt:getAutoRenderSize().width - 5)
	crowdedTxt:setPositionX(goodIcon:getPositionX() - 30)
	crowdedIcon:setPositionX(crowdedTxt:getPositionX() - crowdedTxt:getAutoRenderSize().width - 5)
end

function LoginServerListMediator:initData()
	self._curTabType = 1
	self._login = self:getLoginSystem():getLogin()
	self._serverList = self._login:getServerList()
	self._serverTime = self._login:getServerTime()
	self._recommendList = self._login:getRecommendList()
	self._recentlyList = self._login:getRecentlyList()
	self._tabName = {}
	self._tabNameTranslate = {}
	self._serverData = {}
	self._recentServerData = {}
	self._recommendServerData = {}
	self._tabName[1] = Strings:get("LOGIN_UI13")
	self._tabNameTranslate[1] = Strings:get("LOGIN_UI19")

	if #self._recentlyList >= 0 then
		for i = 1, #self._recentlyList do
			self._recentServerData[#self._recentServerData + 1] = self._recentlyList[i]
		end
	end

	if #self._recommendList > 0 then
		for i = #self._recommendList, 1, -1 do
			self._recommendServerData[#self._recommendServerData + 1] = self._recommendList[i]
		end
	end

	local startNum = 0
	local endNum = 0
	local length = math.ceil(#self._serverList / showServerNum)

	for i = 1, length do
		startNum = (i - 1) * showServerNum + 1
		endNum = (i - 1) * showServerNum + 1 - 1
		self._serverData[i] = self._serverData[i] or {}

		for j = 1, showServerNum do
			local index = showServerNum * (i - 1) + j

			if self._serverList[index] then
				endNum = endNum + 1

				table.insert(self._serverData[i], self._serverList[index])
			else
				break
			end
		end

		self._tabName[i + 1] = Strings:get("LOGIN_UI20", {
			num = startNum .. "-" .. endNum
		})
		self._tabNameTranslate[i + 1] = startNum .. "-" .. endNum
	end

	if #self._serverData > 1 then
		for i = 1, #self._serverData do
			table.reverse(self._serverData[i])
		end
	end

	self._showServerData = self._serverData[self._curTabType]
end

function LoginServerListMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._serverData + 1 do
		data[#data + 1] = {
			tabText = self._tabName[i],
			tabTextTranslate = self._tabNameTranslate[i]
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

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 4)
	view:setLocalZOrder(1100)
end

function LoginServerListMediator:initRecentView()
	local listView1 = self._recentPanel:getChildByFullName("recentView")

	listView1:removeAllItems()
	listView1:setScrollBarEnabled(false)

	local length = math.ceil(#self._recentServerData / 2)

	for i = 1, length do
		local data = {
			self._recentServerData[2 * i - 1],
			self._recentServerData[2 * i]
		}
		local cellPanel = self:createServerCell(data)

		listView1:pushBackCustomItem(cellPanel)
	end

	local listView2 = self._recentPanel:getChildByFullName("recommendView")

	listView2:removeAllItems()
	listView2:setScrollBarEnabled(false)

	local length = math.ceil(#self._recommendServerData / 2)

	for i = 1, length do
		local data = {
			self._recommendServerData[2 * i - 1],
			self._recommendServerData[2 * i]
		}
		local cellPanel = self:createServerCell(data)

		listView2:pushBackCustomItem(cellPanel)
	end
end

function LoginServerListMediator:initTableView()
	local width, height = self._cellPanel:getContentSize().width, self._cellPanel:getContentSize().height

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._showServerData / 2)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._listPanel:getContentSize())

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	tableView:setMaxBounceOffset(20)
	self._listPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)

	self._tableView = tableView
end

function LoginServerListMediator:createCell(cell, index)
	cell:removeAllChildren()

	local data = {
		self._showServerData[2 * index - 1],
		self._showServerData[2 * index]
	}
	local cellPanel = self:createServerCell(data)

	cellPanel:addTo(cell)
end

function LoginServerListMediator:createServerCell(data)
	local cellPanel = self._cellPanel:clone()

	cellPanel:setVisible(true)
	cellPanel:setPosition(0, 0)

	for i = 1, 2 do
		local panel = cellPanel:getChildByFullName("panel" .. i)

		panel:setVisible(false)
		panel:setTouchEnabled(true)

		if data[i] then
			panel:setVisible(true)

			local cellData = data[i]
			local serverName = panel:getChildByName("text")

			serverName:setString(cellData:getName())
			panel:getChildByName("time"):setVisible(cellData:getLastLoginTime() ~= 0)

			local remainTime = (self._serverTime - cellData:getLastLoginTime()) / 1000
			local timeStr = TimeUtil:formatTime("${d}:${HH}:${MM}:${SS}", remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			panel:getChildByName("time"):setString((timeTab.day > 0 and timeTab.day .. Strings:get("Arena_UI100") or timeTab.hour > 0 and timeTab.hour .. Strings:get("Arena_UI108") or timeTab.min .. Strings:get("Arena_UI109")) .. Strings:get("LOGIN_UI22"))

			local markType = cellData:getMarkType()
			local imageTag = panel:getChildByName("imageTag")
			local imageTagText = imageTag:getChildByName("text")

			if not markType or markType == ServerMarkType.kNone then
				imageTag:setVisible(false)
			else
				imageTag:loadTexture(ServerMarkTagBgNames[markType] or ServerMarkTagBgNames[ServerMarkType.kClose], UI_TEX_TYPE_LOCAL)
				imageTagText:setString(Strings:get(ServerMarkTagStringNames[markType] or ServerMarkTagStringNames[ServerMarkType.kClose]))
				imageTagText:enableOutline(ServerMarkTagOutlineStyle[markType] or ServerMarkTagOutlineStyle[ServerMarkType.kClose])
				imageTag:setVisible(true)
			end

			local state = cellData:getState()
			local imageState = panel:getChildByName("imageHot")

			imageState:loadTexture(ServerStateImgNames[state], 1)

			local bgImage = panel:getChildByFullName("image1")
			local bgLine = panel:getChildByFullName("line1")
			local imageFile = "common_bg_01di_1.png"
			local lineFile = "common_bg_01di_line.png"
			local color = cc.c3b(0, 0, 0)
			local color1 = cc.c3b(112, 112, 112)

			if state == ServerState.kMaintain then
				imageFile = "common_bg_02di_1.png"
				lineFile = "common_bg_02di_line.png"
				color = cc.c3b(255, 255, 255)
				color1 = cc.c3b(191, 191, 191)
			end

			bgImage:loadTexture(imageFile, 1)
			bgLine:loadTexture(lineFile, 1)
			bgImage:setCapInsets(cc.rect(0, 3, 366, 2))
			serverName:setTextColor(color)
			panel:getChildByName("time"):setTextColor(color1)
			panel:setSwallowTouches(false)
			panel:addTouchEventListener(function(sender, eventType)
				self:onClickCell(sender, eventType, cellData)
			end)

			local playerNode = panel:getChildByName("icon")

			playerNode:removeAllChildren()

			if cellData:getHeadId() then
				local node = self._infoNode:clone()

				node:setVisible(true)
				node:addTo(playerNode):center(playerNode:getContentSize())

				local iconNode = node:getChildByFullName("icon")
				local icon, oldIcon = IconFactory:createPlayerIcon({
					frameStyle = 1,
					clipType = 4,
					id = cellData:getHeadId(),
					size = cc.size(82, 82)
				})

				oldIcon:setScale(0.4)
				icon:addTo(iconNode):center(iconNode:getContentSize()):setScale(0.8)
				node:getChildByFullName("level"):setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. cellData:getLevel())

				local name = node:getChildByFullName("name")

				name:setString(cellData:getNickName())
				name:setTextColor(state == ServerState.kMaintain and cc.c3b(191, 191, 191) or cc.c3b(0, 0, 0))
			end
		end
	end

	return cellPanel
end

function LoginServerListMediator:onClickTab(name, tag)
	if tag == 1 then
		self._tableView:stopScroll()
		self._recentPanel:setVisible(true)
		self._listPanel:setVisible(false)
	else
		self._recentPanel:setVisible(false)
		self._listPanel:setVisible(true)

		self._showServerData = self._serverData[tag - 1]

		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function LoginServerListMediator:onClickCell(sender, eventType, cellData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._loginSystem:setCurServer(cellData)
		self:dispatch(Event:new(EVT_LOGIN_REFRESH_SERVER))
		self:close()
	end
end

function LoginServerListMediator:onClickBack()
	self:close()
end
