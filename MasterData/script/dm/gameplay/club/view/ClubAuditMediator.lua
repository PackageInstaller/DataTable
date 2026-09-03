-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubAuditMediator.lua

ClubAuditMediator = class("ClubAuditMediator", DmPopupViewMediator, _M)

ClubAuditMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubAuditMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubAuditMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.bottomnode.setbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSetting"
	},
	["main.bottomnode.chatbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChat"
	},
	["main.bottomnode.rejectbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRefuse"
	},
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}
local auditStrList = {
	[ClubAuditType.kClose] = Strings:get("Club_Text81"),
	[ClubAuditType.kLimitCondition] = Strings:get("Club_Text80"),
	[ClubAuditType.kFreeOpen] = Strings:get("Club_Text79")
}
local invite_Cd = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Invite_Cd", "content")

function ClubAuditMediator:initialize()
	super.initialize(self)
end

function ClubAuditMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubAuditMediator:disposeView()
	self._viewCache = nil

	if self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end
end

function ClubAuditMediator:userInject()
	return
end

function ClubAuditMediator:onRegister()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bottomnode.setbtn", TwoLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.bottomnode.chatbtn", TwoLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.bottomnode.rejectbtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	super.onRegister(self)
end

function ClubAuditMediator:enterWithData(data)
	self:initNodes()
	self:createData()
	self:refreshData(data)
	self:refreshView()
end

function ClubAuditMediator:createData()
	self._player = self._developSystem:getPlayer()
end

function ClubAuditMediator:refreshData(data)
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._auditRecordListOj = self._clubSystem:getAuditRecordListOj()
	self._curIndex = 1
	self._auditList = self._auditRecordListOj:getList()
end

function ClubAuditMediator:refreshView()
	self:refreshData()

	local notHasInfo = self._auditRecordListOj:getRecordCount() == 0

	self._nothasSprite:setVisible(false)
	self._notHasLabel:setVisible(false)

	local topNode = self._mainPanel:getChildByName("topnode")

	topNode:setVisible(true)

	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
	end

	if notHasInfo then
		self:refreshNotHasView()
	else
		self:createTableView()
	end

	self:refreshBottomPanel()
	self:createSchel()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_SETCLUBAUDIT_SUCC, self, self.refreshLimitView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBAUDIT_REFRESH_SUCC, self, self.refreshView)
end

function ClubAuditMediator:refreshLimitView(event)
	self:refreshBottomPanel()
end

function ClubAuditMediator:refreshNotHasView()
	self._notHasLabel:setVisible(true)
	self._nothasSprite:setVisible(true)

	local topNode = self._mainPanel:getChildByName("topnode")

	topNode:setVisible(false)
end

function ClubAuditMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._bottomPanel = self._mainPanel:getChildByFullName("bottomnode")
	self._chatBtnWidget = self._bottomPanel:getChildByFullName("chatbtn")
	self._notHasLabel = self._bottomPanel:getChildByFullName("nothaslabel")
	self._cellPanel = self._mainPanel:getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._listPanel = self._mainPanel:getChildByFullName("listPanel")
	self._nothasSprite = self._bottomPanel:getChildByFullName("nothasSprite")

	self._mainPanel:getChildByFullName("title_node.Text_1"):setString(Strings:get("Club_Text120"))
	self._mainPanel:getChildByFullName("title_node.Text_2"):setString(Strings:get("UITitle_EN_Shenhe"))
end

function ClubAuditMediator:refreshBottomPanel()
	local auditCondiRecord = self._clubInfoOj:getAuditCondition()
	local auditType = auditCondiRecord:getType()
	local limitLevel = auditCondiRecord:getLevel()
	local limitCombat = auditCondiRecord:getCombat()
	local auditLabel = self._bottomPanel:removeChildByTag(123, true)
	local str2 = ""

	if auditType ~= ClubAuditType.kClose then
		local hasLimit = false

		if limitLevel > 0 then
			hasLimit = true
			str2 = "["
			str2 = "[" .. Strings:get("Club_Text156", {
				level = limitLevel
			})
		end

		if limitCombat > 0 then
			str2 = hasLimit and str2 .. "," or "["
			hasLimit = true
			str2 = str2 .. Strings:get("Club_Text157", {
				combat = limitCombat
			})
		end

		if hasLimit then
			str2 = str2 .. "]"
		end

		if not hasLimit then
			str2 = str2 .. "[" .. Strings:get("ClubAudit_Text2") .. "]"
		end
	end

	local richTextStr = Strings:get("Club_Text155", {
		str1 = auditStrList[auditType],
		str2 = str2,
		fontName = TTF_FONT_FZYH_R
	})
	local titlelabel = self._bottomPanel:getChildByFullName("titlelabel")
	local descLabel = ccui.RichText:createWithXML(richTextStr, {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0, 0.5))
	descLabel:renderContent()
	self._bottomPanel:addChild(descLabel, 99)
	descLabel:setPosition(titlelabel:getPositionX() + 3, titlelabel:getPositionY())
	descLabel:setTag(123)
end

function ClubAuditMediator:createTableView()
	local size = self._cellPanel:getContentSize()

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height - 3
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(3, 0))
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
		return self._auditRecordListOj:getRecordCount()
	end

	local tableView = cc.TableView:create(self._listPanel:getContentSize())

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._listPanel:addChild(tableView, 10)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function ClubAuditMediator:createCell(cell, idx)
	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)

	local data = self._auditList[idx]
	local iconPanel = cell:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 1,
		headFrameScale = 0.4,
		id = data:getHeadId(),
		size = cc.size(84, 84),
		headFrameId = data:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(0.8)

	local clubNameLabel = cell:getChildByFullName("clubnamelabel")

	clubNameLabel:setString(data:getName())

	local clubLevelLabel = cell:getChildByFullName("clublevellabel")

	clubLevelLabel:setString(Strings:get("Club_Text194", {
		level = data:getLevel()
	}))

	local combatLabel = cell:getChildByFullName("combatlabel")
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(129, 118, 113, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	combatLabel:setString(data:getCombat())

	local timeLabel = cell:getChildByFullName("audittime")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local lastTime = gameServerAgent:remoteTimestamp() - data:getApplyTime()

	timeLabel:setString(self._clubSystem:getTimeStr(lastTime))

	local rid = data:getRid()
	local refuseBtn = cell:getChildByFullName("rejectbtn")

	local function refuseCallFunc(sender, eventType)
		self:refuseClick(rid)
	end

	mapButtonHandlerClick(nil, refuseBtn, {
		func = refuseCallFunc
	})

	local okBtn = cell:getChildByFullName("okbtn")

	local function okCallFunc(sender, eventType)
		self:agreeClick(rid)
	end

	mapButtonHandlerClick(nil, okBtn, {
		func = okCallFunc
	})
end

function ClubAuditMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local sureRequest = false
	local offsetY = self._tableView:getContentOffset().y

	if kMinRefreshHeight < offsetY then
		local factor1 = viewHeight < self._tableView:getContentSize().height
		local factor2 = self._auditRecordListOj:getRecordCount() < self._auditRecordListOj:getMaxCount()

		if factor1 and factor2 then
			sureRequest = true
		end
	end

	if sureRequest then
		self._isAskingRank = true
		self._requestNextCount = self._auditRecordListOj:getRecordCount()

		self:doRequestNextRank()
	end
end

function ClubAuditMediator:doRequestNextRank()
	local kCellHeight = self._cellPanel:getContentSize().height
	local dataEnough = self._auditRecordListOj:getDataEnough()

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self:refreshData()
			self._tableView:removeFromParent(true)
			self:createTableView()

			local kCellHeight = self._cellPanel:getContentSize().height

			if self._requestNextCount then
				local diffCount = self._auditRecordListOj:getRecordCount() - self._requestNextCount
				local offsetY = -diffCount * kCellHeight + kCellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))

				self._requestNextCount = nil
				self._isAskingRank = false
			end
		end

		local rankStart = self._auditRecordListOj:getRecordCount() + 1
		local rankEnd = rankStart + self._auditRecordListOj:getRequestRankCountPerTime() - 1

		self._clubSystem:requestAuditList(rankStart, rankEnd, false, onRequestRankDataSucc)
	end
end

function ClubAuditMediator:getTableViewPosY()
	return self._tableView:getContentOffset().y
end

function ClubAuditMediator:createSchel()
	if self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end

	local function checkTimeFunc()
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local curTime = gameServerAgent:remoteTimestamp()
		local lastTime = curTime - self._clubInfoOj:getRecruitTime()
		local btnLabel = self._chatBtnWidget:getChildByFullName("name")

		if lastTime < invite_Cd then
			btnLabel:setString(TimeUtil:formatTime("(${MM}:${SS})", invite_Cd - lastTime))
		else
			btnLabel:setString(Strings:get("Club_Text41"))
			self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

			self._timeSchel = nil
		end
	end

	self._timeSchel = self:getView():getScheduler():scheduleScriptFunc(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function ClubAuditMediator:onCellClicked(eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		local tableViewPosY = self:getTableViewPosY()
		local oldIndex = self._curIndex

		if math.abs(tableViewPosY - self._tableViewPosY) < 1 then
			self._curIndex = idx

			self._tableView:updateCellAtIndex(oldIndex - 1)
			self._tableView:updateCellAtIndex(self._curIndex - 1)
		end
	elseif eventType == ccui.TouchEventType.began then
		self._tableViewPosY = self:getTableViewPosY()
	end
end

function ClubAuditMediator:onClickBack(sender, eventType)
	self:close()
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

function ClubAuditMediator:onClickSetting(sender, eventType)
	self._clubSystem:getClubThresholdMax(function(level, combat)
		local delegate, outSelf = {}, self

		function delegate:willClose(popupMediator, data)
			return
		end

		local auditCondiRecord = self._clubInfoOj:getAuditCondition()
		local view = self:getInjector():getInstance("ClubAuditLimitTipView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			level = level,
			combat = combat,
			auditType = auditCondiRecord:getType()
		}, delegate))
	end)
end

function ClubAuditMediator:refuseClick(rid)
	self._clubSystem:refuseEnterClubApply(rid, function()
		self:refreshData()
		self:refreshView()
	end)
end

function ClubAuditMediator:agreeClick(rid)
	if self._clubInfoOj:getPlayerCount() >= self._clubInfoOj:getMemberLimitCount() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubAudit_Text1")
		}))

		return
	end

	self._clubSystem:agreeEnterClubApply(rid, function()
		self:refreshData()
		self:refreshView()
		self:dispatch(Event:new(EVT_CLUB_PUSHMEMBERCHANGE_SUCC))
	end)
end

function ClubAuditMediator:onClickChat(sender, eventType)
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local curTime = gameServerAgent:remoteTimestamp()
	local lastTime = curTime - self._clubInfoOj:getRecruitTime()

	if lastTime < invite_Cd then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text165")
		}))

		return
	end

	self._clubSystem:sendRecruitMsg(function()
		self:createSchel()
	end)
end

function ClubAuditMediator:onClickRefuse(sender, eventType)
	local notHasInfo = self._auditRecordListOj:getRecordCount() == 0

	if notHasInfo then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text174")
		}))

		return
	end

	self._clubSystem:refuseEnterClubApply("All", function()
		self:refreshData()
		self:refreshView()
	end)
end
