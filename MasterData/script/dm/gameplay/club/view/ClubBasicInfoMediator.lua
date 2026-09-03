-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBasicInfoMediator.lua

ClubBasicInfoMediator = class("ClubBasicInfoMediator", DmAreaViewMediator, _M)

ClubBasicInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBasicInfoMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubBasicInfoMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubBasicInfoMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")

local kSortType = {
	Common = 1,
	Contribution = 4,
	Combat = 2,
	State = 3
}
local kBtnHandlers = {
	["main.leftnode.changenamebtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChangeName"
	},
	["main.leftnode.weixinbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickWeiXin"
	},
	["main.leftnode.quitbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickQuit"
	},
	["main.leftnode.manifestobtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickManifesto"
	},
	["main.leftnode.backbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTextFiledBack"
	},
	["main.leftnode.welcomebtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickWelcome"
	},
	["main.leftnode.mailbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMail"
	},
	["managepanel.sendmessagebtn.text"] = {
		clickAudio = "Se_Click_Common_2",
		func = "sendMessageBtn"
	},
	["managepanel.addfriendbtn.text"] = {
		clickAudio = "Se_Click_Common_2",
		func = "addFriendBtn"
	},
	["managepanel.infobtn.text"] = {
		clickAudio = "Se_Click_Common_2",
		func = "infoBtn"
	},
	["managepanel.managerbtn.text"] = {
		clickAudio = "Se_Click_Common_2",
		func = "managerBtn"
	},
	["managepanel.quitbtn.text"] = {
		clickAudio = "Se_Click_Common_2",
		func = "quitMemberBtn"
	}
}
local kSortTypeFunc = {
	function(a, b)
		return a:getPosition() < b:getPosition()
	end,
	function(a, b)
		return a:getCombat() > b:getCombat()
	end,
	function(a, b)
		return a:getLastOnlineTime() > b:getLastOnlineTime()
	end,
	function(a, b)
		return a:getContribution() > b:getContribution()
	end
}
local clubIconList, maxLength

function ClubBasicInfoMediator:initialize()
	super.initialize(self)

	clubIconList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Icon", "content")
	maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Notice_Words", "content")
end

function ClubBasicInfoMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubBasicInfoMediator:disposeView()
	self._viewCache = nil
end

function ClubBasicInfoMediator:userInject()
	return
end

function ClubBasicInfoMediator:onRegister()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.leftnode.welcomebtn", OneLevelViceButton, {})
	self:bindWidget("main.leftnode.quitbtn", OneLevelViceButton, {})
	super.onRegister(self)
end

function ClubBasicInfoMediator:enterWithData(data)
	self:initNodes()
	self:createData()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CHANGECLUBICON_SUCC, self, self.refreshClubIconByServer)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_KICKOUT_SUCC, self, self.kickOutMember)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CHANGENAME_SUCC, self, self.changeName)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHMEMBERCHANGE_SUCC, self, self.refreshViewByPush)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBDONATE_SUCC, self, self.refreshClubInfoByDonate)
end

function ClubBasicInfoMediator:refreshViewByPush(event)
	self._clubSystem:requestClubInfo(function()
		self:refreshData()
		self:createTableView()
	end)
end

function ClubBasicInfoMediator:refreshClubIconByServer(event)
	self:refreshClubIcon()
end

function ClubBasicInfoMediator:kickOutMember(event)
	self._clubSystem:requestClubInfo(function()
		self:refreshView()
	end)
end

function ClubBasicInfoMediator:changeName(event)
	self:refreshInfoView()
end

function ClubBasicInfoMediator:refreshClubInfoByDonate(event)
	self._clubSystem:requestClubInfo(function()
		self:refreshView()
	end)
end

function ClubBasicInfoMediator:createData()
	self._player = self._developSystem:getPlayer()
	self._curIndex = 0
	self._inPutStr = ""
end

function ClubBasicInfoMediator:refreshData()
	self._curIndex = 0
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._memberRecordListOj = self._clubSystem:getMemberRecordListOj()
	self._memberList = self._memberRecordListOj:getList()

	table.sort(self._memberList, kSortTypeFunc[self._indexOrderType])

	if self._isReverse == 1 then
		table.reverse(self._memberList)
	end
end

function ClubBasicInfoMediator:refreshView()
	self:refreshData()
	self:refreshInfoView()
	self:createTableView()
end

function ClubBasicInfoMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._mainPanel.originPos = cc.p(self._mainPanel:getPosition())
	self._cellPanel = self:getView():getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._cellpanelTitle = self:getView():getChildByFullName("cellpanelTitle")

	self._cellpanelTitle:setVisible(false)

	self._leftNode = self._mainPanel:getChildByFullName("leftnode")
	self._rightNode = self._mainPanel:getChildByFullName("rightnode")
	self._managePanel = self:getView():getChildByFullName("managepanel")

	self._managePanel:setTouchEnabled(true)
	self._managePanel:setVisible(false)
	self._managePanel:setLocalZOrder(999)

	self._manifestoEditBox = self._leftNode:getChildByFullName("textfiled")

	local maskPanel = self._managePanel:getChildByName("maskPanel")

	local function touchCallFunc(sender, eventType)
		self._managePanel:setVisible(false)
		self._touchLayer:setVisible(false)

		local oldIndex = self._curIndex

		self._curIndex = 0

		self._tableView:updateCellAtIndex(oldIndex - 1)
	end

	mapButtonHandlerClick(nil, maskPanel, {
		ignoreClickAudio = true,
		func = touchCallFunc
	})

	self._mailBtn = self._leftNode:getChildByFullName("mailbtn")
	self._manifestoBtn = self._leftNode:getChildByFullName("manifestobtn")
	self._backBtn = self._leftNode:getChildByFullName("backbtn")

	local winSize = cc.Director:getInstance():getWinSize()

	self._touchLayer = ccui.Layout:create()

	self._touchLayer:setVisible(false)
	self._touchLayer:setTouchEnabled(true)
	self._touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	self._touchLayer:addTo(self:getView()):center(self:getView():getContentSize())
	self._touchLayer:setLocalZOrder(100)

	local function callFunc(sender, eventType)
		self:onClickTouchLayer()
	end

	mapButtonHandlerClick(nil, self._touchLayer, {
		func = callFunc
	})

	self._indexOrderType = kSortType.Common

	local topNode = self._mainPanel:getChildByFullName("topnode")
	local type1Btn = topNode:getChildByName("combatlabel")
	local type2Btn = topNode:getChildByName("statelabel")
	local type3Btn = topNode:getChildByName("contributionlabel")
	local _tab = {
		type1Btn,
		type2Btn,
		type3Btn
	}

	for i = 1, 3 do
		local function callFunc()
			self:sortClubPlayerByType(i + 1)
		end

		mapButtonHandlerClick(nil, _tab[i], {
			ignoreClickAudio = true,
			func = callFunc
		})
	end

	local topView
	local mediatorMap = self:getMediatorMap()

	for k, v in pairs(mediatorMap._registeredMediators) do
		if v:getViewName() == "ClubView" then
			topView = v:getView()
		end
	end

	self._managePanel:changeParent(topView)
	self._managePanel:setLocalZOrder(10000)
end

function ClubBasicInfoMediator:sortClubPlayerByType(type)
	local topNode = self._mainPanel:getChildByFullName("topnode")
	local type1Btn = topNode:getChildByName("combatlabel")
	local type2Btn = topNode:getChildByName("statelabel")
	local type3Btn = topNode:getChildByName("contributionlabel")
	local _tab = {
		type1Btn,
		type2Btn,
		type3Btn
	}

	if self._indexOrderType == type then
		local _btnTag = _tab[type - 1]:getChildByName("orderTag")

		self._isReverse = _btnTag:isFlippedY() and -1 or 1

		_btnTag:setFlippedY(not _btnTag:isFlippedY())
		table.reverse(self._memberList)
	else
		self._isReverse = -1

		local oldTypeBtn = _tab[self._indexOrderType - 1]

		if oldTypeBtn then
			oldTypeBtn:getChildByName("orderTag"):loadTexture("btn_sjxu_old.png", ccui.TextureResType.plistType)
		end

		local newTypeBtnTag = _tab[type - 1]:getChildByName("orderTag")

		newTypeBtnTag:loadTexture("btn_sjxu_up.png", ccui.TextureResType.plistType)
		table.sort(self._memberList, kSortTypeFunc[type])

		self._indexOrderType = type
	end

	self._tableView:reloadData()
end

function ClubBasicInfoMediator:refreshClubIcon()
	local iconPanel = self._leftNode:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createClubIcon({
		id = self._clubInfoOj:getIcon()
	}, {
		isWidget = true
	})

	IconFactory:bindClickAction(icon, function()
		return self:onClickChangeIcon()
	end, {
		checkFunc = function()
			local curPosition = self._clubInfoOj:getPosition()

			if curPosition ~= ClubPosition.kProprieter then
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Club_Text122")
				}))

				return false
			end

			return true
		end
	})
	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(1.1)
end

function ClubBasicInfoMediator:refreshInfoView()
	local curPosition = self._clubInfoOj:getPosition()

	self:refreshClubIcon()

	local nameLabel = self._leftNode:getChildByFullName("namelabel")

	nameLabel:setString(self._clubInfoOj:getName())

	local changeNameBtn = self._leftNode:getChildByFullName("changenamebtn")

	changeNameBtn:setVisible(curPosition == ClubPosition.kProprieter)

	local idtitlelabel = self._leftNode:getChildByFullName("idtitlelabel")
	local idLabel = self._leftNode:getChildByFullName("idlabel")
	local clubId = self._clubInfoOj:getClubId()
	local strs = string.split(clubId, "_")

	idLabel:setString(strs[1])
	idLabel:setPositionX(idtitlelabel:getContentSize().width + idtitlelabel:getPositionX() + 4)

	local proprieterLabel = self._leftNode:getChildByFullName("proprieterlabel")

	proprieterLabel:setString(self._clubInfoOj:getProprieterName())

	local proprietertitlelabel = self._leftNode:getChildByFullName("proprietertitlelabel")

	proprieterLabel:setPositionX(proprietertitlelabel:getPositionX() + proprietertitlelabel:getContentSize().width + 12)

	local levelLabel = self._leftNode:getChildByFullName("levellabel")

	levelLabel:setString(self._clubInfoOj:getLevel())

	local numLabel = self._leftNode:getChildByFullName("numlabel")
	local numStr = self._clubInfoOj:getPlayerCount() .. "/" .. self._clubInfoOj:getMemberLimitCount()

	numLabel:setString(numStr)

	local ranktitlelabel = self._leftNode:getChildByFullName("ranktitlelabel")

	numLabel:setPositionX(ranktitlelabel:getPositionX() + ranktitlelabel:getContentSize().width + 12)

	local rankLabel = self._leftNode:getChildByFullName("ranklabel")

	rankLabel:setString(Strings:get("Club_Text1", {
		rank = self._clubInfoOj:getRank()
	}))
	self._mailBtn:setVisible(false)
	self._backBtn:setVisible(false)
	self:refreshTextFiled()
end

function ClubBasicInfoMediator:refreshTextFiled()
	self._inPutStr = self._clubInfoOj:getSlogan()

	if self._manifestoEditBox:getDescription() == "TextField" then
		self._manifestoEditBox:setMaxLength(maxLength)
		self._manifestoEditBox:setMaxLengthEnabled(true)

		self._manifestoEditBox = convertTextFieldToEditBox(self._manifestoEditBox, nil, MaskWordType.CHAT)

		self._manifestoEditBox:setText(self._inPutStr)
		self._manifestoEditBox:onEvent(function(eventName, sender)
			if eventName == "began" then
				self._manifestoBtn:setVisible(false)
				self._backBtn:setVisible(false)
			elseif eventName == "ended" then
				self._backBtn:setVisible(false)

				local state, finalString = StringChecker.checkString(self._manifestoEditBox:getText(), MaskWordType.CHAT)

				self._clubSystem:changeClubAnnounce(self._manifestoEditBox:getText(), function()
					self:refreshInfoView()
				end)
			elseif eventName == "return" then
				-- block empty
			elseif eventName == "changed" then
				self._inPutStr = self._manifestoEditBox:getText()
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

	local isProprieter = self._clubInfoOj:getPosition() == ClubPosition.kProprieter

	self._manifestoEditBox:setTouchEnabled(isProprieter)
	self._manifestoBtn:setVisible(isProprieter)
end

function ClubBasicInfoMediator:refreshCellInfoPanel()
	local btnCahce = {}
	local data = self._memberList[self._curIndex]
	local position = data:getPosition()
	local curRid = self._developSystem:getPlayer():getRid()
	local isSelf = curRid == data:getRid()
	local sendMessageBtn = self._managePanel:getChildByFullName("sendmessagebtn")

	sendMessageBtn:setVisible(false)

	if not isSelf then
		btnCahce[#btnCahce + 1] = sendMessageBtn

		sendMessageBtn:setVisible(true)
	end

	local friendState = data:getFriendState()
	local friendBtn = self._managePanel:getChildByFullName("addfriendbtn")

	friendBtn:setVisible(false)

	if friendState == ClubMemberFriendState.kNotFriend and not isSelf then
		btnCahce[#btnCahce + 1] = friendBtn

		friendBtn:setVisible(true)
	end

	btnCahce[#btnCahce + 1] = self._managePanel:getChildByFullName("infobtn")

	local curPosition = self._clubInfoOj:getPosition()
	local managerBtn = self._managePanel:getChildByFullName("managerbtn")

	managerBtn:setVisible(false)

	local quitMemberBtn = self._managePanel:getChildByFullName("quitbtn")

	quitMemberBtn:setVisible(false)

	if not isSelf then
		if curPosition == ClubPosition.kProprieter then
			btnCahce[#btnCahce + 1] = managerBtn

			managerBtn:setVisible(true)

			btnCahce[#btnCahce + 1] = quitMemberBtn

			quitMemberBtn:setVisible(true)
		elseif curPosition == ClubPosition.kDeputyProprieter and position ~= ClubPosition.kProprieter and position ~= ClubPosition.kDeputyProprieter then
			btnCahce[#btnCahce + 1] = managerBtn

			managerBtn:setVisible(true)

			btnCahce[#btnCahce + 1] = quitMemberBtn

			quitMemberBtn:setVisible(true)
		end
	end

	local btnGapTop = 10
	local btnGapY = 7.7
	local btnNum = #btnCahce
	local btn_height = 40
	local panel_height = btnNum * btn_height + (btnNum - 1) * btnGapY + btnGapTop * 2 + 4

	self._managePanel:setContentSize(cc.size(self._managePanel:getContentSize(), panel_height))

	local panelBg = self._managePanel:getChildByFullName("panel_bg")

	panelBg:setAnchorPoint(cc.p(0, 1))
	panelBg:setContentSize(cc.size(panelBg:getContentSize().width, panel_height))
	panelBg:setPosition(cc.p(0, panel_height))

	for i = 1, #btnCahce do
		local index = #btnCahce - i + 1

		btnCahce[i]:setPositionY(btnGapTop + (index - 1) * btnGapY + (index - 0.5) * btn_height - 7)
	end
end

function ClubBasicInfoMediator:createTableView()
	self._managePanel:setVisible(false)

	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local size = self._cellPanel:getContentSize()

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self._managePanel:setVisible(false)
			self:touchForTableview()
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(-8, -15))
			sprite:setAnchorPoint(cc.p(0, 0))
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
		return self._memberRecordListOj:getRecordCount()
	end

	local tableView = cc.TableView:create(cc.size(600, 460))

	tableView:setSwallowsTouches(false)
	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(175, 50)
	tableView:setDelegate()
	self._rightNode:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function ClubBasicInfoMediator:createCell(cell, idx)
	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)

	local function cellCallFunc(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end

	mapButtonHandlerClick(nil, cell, {
		ignoreClickAudio = true,
		eventType = 4,
		func = cellCallFunc
	})

	local data = self._memberList[idx]
	local id = data:getRid()
	local playerId = self._developSystem:getPlayer():getRid()

	if id == playerId then
		cell:getChildByName("playerMe"):setVisible(true)
		cell:getChildByName("playerMe2"):setVisible(true)
	else
		cell:getChildByName("playerMe"):setVisible(false)
		cell:getChildByName("playerMe2"):setVisible(false)
	end

	local iconPanel = cell:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()
	iconPanel:setTouchEnabled(false)

	local icon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		headFrameScale = 0.4,
		id = data:getHeadId(),
		size = cc.size(82, 82),
		headFrameId = data:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(0.8)

	local nameLabel = cell:getChildByFullName("namelabel")

	nameLabel:setString(data:getName())

	local levelLabel = cell:getChildByFullName("levellabel")

	levelLabel:setString(Strings:get("Club_Text194", {
		level = data:getLevel()
	}))

	local playerOnline = cell:getChildByFullName("playerOnline")
	local playerOffline = cell:getChildByFullName("playerOffline")

	cell:removeChildByTag(999)

	local vipNode = PlayerVipWidget:createWidgetNode()

	vipNode:setScale(0.8)

	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidget:new(vipNode))

	self._playerVipWidget:updateView(data:getVip())
	vipNode:addTo(cell)
	vipNode:setTag(999)
	vipNode:setPosition(levelLabel:getPositionX() + levelLabel:getContentSize().width + 10, levelLabel:getPositionY() - 15)

	local positionLabel = cell:getChildByFullName("positionlabel")
	local positionStr = self._clubSystem:getPositionNameStr(data:getPosition())

	positionLabel:setString(positionStr)

	local stateLabel = cell:getChildByFullName("statelabel")
	local onlineTag = cell:getChildByFullName("onlineTag")
	local isOnline = data:getIsOnline()

	stateLabel:setVisible(isOnline ~= ClubMemberOnLineState.kOnline)
	onlineTag:setVisible(isOnline == ClubMemberOnLineState.kOnline)

	if isOnline ~= ClubMemberOnLineState.kOnline then
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local lastLoginTime = gameServerAgent:remoteTimestamp() - data:getLastOnlineTime()
		local timeStr = self._clubSystem:getTimeStr(lastLoginTime)

		stateLabel:setString(timeStr)
	end

	playerOnline:setVisible(isOnline == ClubMemberOnLineState.kOnline)
	playerOffline:setVisible(isOnline ~= ClubMemberOnLineState.kOnline)

	local contributeLabel1 = cell:getChildByFullName("contributelabel1")

	contributeLabel1:setString(data:getContribution())

	local contributeLabel2 = cell:getChildByFullName("contributelabel2")

	contributeLabel2:setString(Strings:get("Club_Text167", {
		time = data:getLastWeekCon()
	}))

	if getCurrentLanguage() ~= GameLanguageType.CN then
		contributeLabel2:setFontSize(15)
	end

	local combatLabel = cell:getChildByName("combatLabel")

	combatLabel:setString(data:getCombat())
	cell:removeChildByTag(9999)

	if ClubPositionShowTitle[data:getPosition()] then
		local titlePanel = self._cellpanelTitle:clone()

		titlePanel:setVisible(true)
		titlePanel:addTo(cell):posite(4, 73):setTag(9999)
		titlePanel:getChildByFullName("titleName"):setString(self._clubSystem:getPositionNameStr(data:getPosition()))
	end
end

function ClubBasicInfoMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local sureRequest = false
	local offsetY = self._tableView:getContentOffset().y

	if kMinRefreshHeight < offsetY then
		local factor1 = viewHeight < self._tableView:getContentSize().height
		local factor2 = self._memberRecordListOj:getRecordCount() < self._memberRecordListOj:getMaxCount()

		if factor1 and factor2 then
			sureRequest = true
		end
	end

	if sureRequest then
		self._isAskingRank = true
		self._requestNextCount = self._memberRecordListOj:getRecordCount()

		self:doRequestNextRank()
	end
end

function ClubBasicInfoMediator:doRequestNextRank()
	local kCellHeight = self._cellPanel:getContentSize().height
	local dataEnough = self._memberRecordListOj:getDataEnough()

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self:refreshData()
			self._tableView:reloadData()

			if self._requestNextCount then
				local diffCount = self._memberRecordListOj:getRecordCount() - self._requestNextCount
				local offsetY = -diffCount * kCellHeight + kCellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))
			end

			self._isAskingRank = false
		end

		local rankStart = self._memberRecordListOj:getRecordCount() + 1
		local rankEnd = rankStart + self._memberRecordListOj:getRequestRankCountPerTime() - 1

		self._clubSystem:getOtherPlayerList(rankStart, rankEnd, false, onRequestRankDataSucc)
	end
end

function ClubBasicInfoMediator:getTableViewPosY()
	return self._tableView:getContentOffset().y
end

function ClubBasicInfoMediator:refreshMangerPanel(idx)
	local cell = self._tableView:cellAtIndex(idx)
	local worldSp = cell:getParent():convertToWorldSpace(cc.p(cell:getPosition()))

	self._managePanel:setVisible(true)

	local posY

	if worldSp.y > 250 then
		posY = worldSp.y + 98

		self._managePanel:setAnchorPoint(cc.p(0, 1))
		self._managePanel:getChildByName("panel_bg"):loadTexture("asset/common/st_bg_qpd2.png", ccui.TextureResType.localType)
	else
		posY = worldSp.y + 8

		self._managePanel:setAnchorPoint(cc.p(0, 0))
		self._managePanel:getChildByName("panel_bg"):loadTexture("asset/common/st_bg_qpd3.png", ccui.TextureResType.localType)
	end

	self:refreshCellInfoPanel()
	self._managePanel:setPosition(cc.p(512, posY))

	local maskPanel = self._managePanel:getChildByName("maskPanel")
	local rowPosX, rowPosY = maskPanel:getPosition()
	local offsetPos = self._managePanel:convertToWorldSpace(cc.p(rowPosX, rowPosY))
	local winSize = cc.Director:getInstance():getWinSize()
	local offX = winSize.width / 2 - offsetPos.x
	local offY = winSize.height / 2 - offsetPos.y

	maskPanel:setPosition(cc.p(rowPosX + offX, rowPosY + offY))
end

function ClubBasicInfoMediator:changeListViewOffset(index)
	local size = self._tableView:getContainer():getContentSize()
	local viewSize = self._tableView:getViewSize()
	local item = self._tableView:cellAtIndex(index - 1)
	local bottom = item:getPositionY() + self._tableView:getContainer():getPositionY()

	if bottom < 0 then
		self._tableView:getContainer():setPositionY(self._tableView:getContainer():getPositionY() - bottom)
	end

	local kHeight = self._cellPanel:getContentSize().height + 5
	local top = item:getPositionY() + kHeight + self._tableView:getContainer():getPositionY()

	if top > viewSize.height then
		self._tableView:getContainer():setPositionY(self._tableView:getContainer():getPositionY() - (top - viewSize.height))
	end
end

function ClubBasicInfoMediator:onCellClicked(sender, eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		local tableViewPosY = self:getTableViewPosY()
		local oldIndex = self._curIndex

		if math.abs(tableViewPosY - self._tableViewPosY) < 1 then
			if self._memberList[idx]:getRid() == self._developSystem:getPlayer():getRid() then
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

				return
			end

			if oldIndex == idx then
				self._managePanel:setVisible(not self._managePanel:isVisible())

				if not self._managePanel:isVisible() then
					self._curIndex = 0
				end

				return
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._curIndex = idx

			self._tableView:updateCellAtIndex(oldIndex - 1)
			self._tableView:updateCellAtIndex(self._curIndex - 1)
			self:changeListViewOffset(idx)
			self:refreshMangerPanel(idx - 1)
			self._touchLayer:setVisible(true)
		else
			self._managePanel:setVisible(false)
		end
	elseif eventType == ccui.TouchEventType.began then
		self._tableViewPosY = self:getTableViewPosY()
	end
end

function ClubBasicInfoMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ClubBasicInfoMediator:onClickChangeName(sender, eventType)
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local view = self:getInjector():getInstance("ClubChangeNameTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, delegate))
end

function ClubBasicInfoMediator:onClickWeiXin(sender, eventType)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))
end

function ClubBasicInfoMediator:onClickChangeIcon(sender, eventType)
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		if type(data) == "table" then
			local iconId = clubIconList[data.index].id

			outSelf._clubSystem:changeClubHeadImg(iconId)
		end
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("ClubIconSelectTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, delegate))
end

function ClubBasicInfoMediator:onClickMail(sender, eventType)
	if self._clubInfoOj:getSendMailCount() >= self._clubSystem:getMailLimitCount() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text123")
		}))

		return
	end

	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local view = self:getInjector():getInstance("ClubMailTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, delegate))
end

function ClubBasicInfoMediator:onClickWelcome(sender, eventType)
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local data = {}
	local view = self:getInjector():getInstance("ClubWelcomeTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ClubBasicInfoMediator:sendMessageBtn(sender, eventType)
	local clubName = self._clubSystem:getName()
	local memberData = self._memberList[self._curIndex]
	local friendSystem = self:getInjector():getInstance(FriendSystem)

	local function gotoFriendChat(response)
		local var_62_0 = {
			rid = memberData:getRid(),
			nickname = memberData:getName(),
			level = memberData:getLevel(),
			combat = memberData:getCombat(),
			headImage = memberData:getHeadId(),
			headFrame = memberData:getHeadFrame(),
			vipLevel = memberData:getVip(),
			online = memberData:getIsOnline(),
			lastOfflineTime = memberData:getLastOnlineTime(),
			heroes = memberData:getHeroes(),
			slogan = memberData:getSlogan(),
			master = memberData:getMaster(),
			clubName = clubName,
			isFriend = response.isFriend
		}

		if response.isFriend == 1 then
			var_62_0.close = response.close or nil
		end

		var_62_0.block = response.block
		var_62_0.leadStageId = memberData:getLeadStageId()
		var_62_0.leadStageLevel = memberData:getLeadStageLevel()

		local data = var_62_0

		friendSystem:addRecentFriend(data)

		local data = {
			subTabType = 2,
			selectFriendIndex = 1,
			tabType = kFriendType.kRecent
		}

		friendSystem:tryEnter(data)
		self:closeInfoPanel()
	end

	friendSystem:requestSimpleFriendInfo(memberData:getRid(), function(response)
		gotoFriendChat(response)
	end)
end

function ClubBasicInfoMediator:addFriendBtn(sender, eventType)
	local memberData = self._memberList[self._curIndex]
	local record = Friend:new()

	record:synchronize({
		rid = memberData:getRid(),
		nickname = memberData:getName(),
		level = memberData:getLevel(),
		combat = memberData:getCombat(),
		headImage = memberData:getHeadId(),
		headFrame = memberData:getHeadFrame(),
		clubName = self._clubInfoOj:getName(),
		vip = memberData:getVip()
	})

	local view = self:getInjector():getInstance("FriendAddPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, record))
	self:closeInfoPanel()
end

function ClubBasicInfoMediator:infoBtn(sender, eventType)
	local memberData = self._memberList[self._curIndex]
	local friendSystem = self:getInjector():getInstance(FriendSystem)

	local function gotoView(response)
		local record = BaseRankRecord:new()

		record:synchronize({
			headImage = memberData:getHeadId(),
			headFrame = memberData:getHeadFrame(),
			rid = memberData:getRid(),
			level = memberData:getLevel(),
			nickname = memberData:getName(),
			vipLevel = memberData:getVip(),
			combat = memberData:getCombat(),
			slogan = memberData:getSlogan(),
			master = memberData:getMaster(),
			heroes = memberData:getHeroes(),
			clubName = self._clubInfoOj:getName(),
			online = memberData:getIsOnline() == ClubMemberOnLineState.kOnline,
			offlineTime = memberData:getLastOnlineTime(),
			isFriend = response.isFriend,
			close = response.close,
			gender = memberData:getGender(),
			city = memberData:getCity(),
			birthday = memberData:getBirthday(),
			tags = memberData:getTags(),
			block = response.block
		})
		friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(memberData:getRid(), function(response)
		gotoView(response)
	end)
end

function ClubBasicInfoMediator:managerBtn(sender, eventType)
	local memberData = self._memberList[self._curIndex]
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local view = self:getInjector():getInstance("ClubPositionManageTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, memberData, delegate))
	self:closeInfoPanel()
end

function ClubBasicInfoMediator:onClickTextFiledBack(sender, eventType)
	self._manifestoEditBox:setText("")

	self._inPutStr = ""
end

function ClubBasicInfoMediator:closeInfoPanel()
	self._touchLayer:setVisible(false)
	self._managePanel:setVisible(false)

	local oldIndex = self._curIndex

	self._curIndex = 0

	self._tableView:updateCellAtIndex(oldIndex - 1)
end

function ClubBasicInfoMediator:onClickTouchLayer()
	self:closeInfoPanel()
end

function ClubBasicInfoMediator:onClickManifesto(sender, eventType)
	self._manifestoEditBox:openKeyboard()
end

function ClubBasicInfoMediator:quitMemberBtn(sender, eventType)
	local memberData = self._memberList[self._curIndex]
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local data = {
		richTextStr = Strings:get("Club_Text89", {
			playername = memberData:getName(),
			fontName = TTF_FONT_FZYH_R
		}),
		btnOkDate = {
			titleStr = Strings:get("Club_Text117"),
			callBack = function()
				outSelf._clubSystem:kickoutPlayer(memberData:getRid())
			end
		},
		btnCancelDate = {}
	}
	local view = self:getInjector():getInstance("ClubWaringTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
	self:closeInfoPanel()
end

function ClubBasicInfoMediator:onClickQuit(sender, eventType)
	local curPosition = self._clubInfoOj:getPosition()
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local data = {
		richTextStr = Strings:get("Club_Text87", {
			clubname = self._clubInfoOj:getName(),
			fontName = TTF_FONT_FZYH_R
		}),
		btnCancelDate = {
			titleStr = Strings:get("Club_Text94"),
			callBack = function()
				return
			end
		},
		btnOkDate = {
			titleStr = Strings:get("Club_Text93"),
			callBack = function()
				outSelf._clubSystem:quitClub(function()
					return
				end)
			end
		}
	}
	local view = self:getInjector():getInstance("ClubWaringTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, (curPosition == ClubPosition.kProprieter or nil) and (self._clubInfoOj:getPlayerCount() == 1 and {
		richTextStr = Strings:get("Club_Text88", {
			fontName = TTF_FONT_FZYH_R
		}),
		btnCancelDate = {
			titleStr = Strings:get("Club_Text94"),
			callBack = function()
				return
			end
		},
		btnOkDate = {
			titleStr = Strings:get("Club_Text93"),
			callBack = function()
				outSelf._clubSystem:quitClub(function()
					return
				end)
			end
		}
	} or {
		richTextStr = Strings:get("Club_Text90", {
			fontName = TTF_FONT_FZYH_R
		}),
		btnOkDate = {}
	}), delegate))
end
