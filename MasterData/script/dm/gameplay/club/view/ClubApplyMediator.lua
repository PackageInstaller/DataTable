-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubApplyMediator.lua

ClubApplyMediator = class("ClubApplyMediator", DmAreaViewMediator, _M)

ClubApplyMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubApplyMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubApplyMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubApplyMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
ClubApplyMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
ClubApplyMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local kBtnHandlers = {
	["main.findndoe.findbtn"] = {
		ignoreClickAudio = true,
		func = "onClickFindBtn"
	},
	["main.findndoe.backbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBackBtn"
	},
	["main.infonode.infopanel"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPlayerInfo"
	},
	["main.findndoe.viewbackbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickViewBackBtn"
	},
	["main.infonode.applaybtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickApplay"
	},
	["main.infonode.cancelbtn.button"] = {
		clickAudio = "Se_Click_Cancle",
		func = "onClickCancel"
	},
	["main.infonode.quickapplaybtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickQuickApplay"
	},
	["main.infonode.createclubbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCreateClub"
	},
	["main.nothasnode.createbtn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCreateClub"
	}
}
local applyMaxCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Number", "content")
local levelNeed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Create_Level", "content")

function ClubApplyMediator:initialize()
	super.initialize(self)
end

function ClubApplyMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubApplyMediator:disposeView()
	self._viewCache = nil
end

function ClubApplyMediator:userInject()
	return
end

function ClubApplyMediator:onRegister()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.findndoe.viewbackbtn", ThreeLevelMainButton, {})
	self:bindWidget("main.infonode.applaybtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.infonode.cancelbtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.infonode.quickapplaybtn", TwoLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.infonode.createclubbtn", TwoLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.nothasnode.createbtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	super.onRegister(self)
end

function ClubApplyMediator:enterWithData(data)
	self:initNodes()
	self:createData()
	self:refreshData()
	self:refreshView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_APPLYREFRESHCOUNT_SUCC, self, self.refreshApplyCount)
	self:setupClickEnvs()
end

function ClubApplyMediator:setSelectClubId(clubName)
	self._inPutStr = clubName

	self._editBox:setText(self._inPutStr)
	self._clubSystem:searchClub(self._inPutStr, 1, 20, true, function()
		self:onRequestFindSuccCallback()
	end)
end

function ClubApplyMediator:refreshApplyCount(event)
	self._tableView:updateCellAtIndex(self._curIndex - 1)
	self:refreshInfoPanel()
end

function ClubApplyMediator:createData()
	self._isAskingRank = false
	self._player = self._developSystem:getPlayer()
	self._curIndex = 1
	self._viewType = ClubRecordType.kApplay
	self._textFieldCanMove = true
end

function ClubApplyMediator:refreshData()
	self._inPutStr = ""
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._applyRecordListOj = self._clubSystem:getApplyRecordListOj()

	if self._viewType == ClubRecordType.kFind then
		self._applyRecordListOj = self._clubSystem:getFindRecordListOj()
	end

	self._applyList = self._applyRecordListOj:getList()
end

function ClubApplyMediator:refreshView()
	local notHasInfo = self._applyRecordListOj:getRecordCount() == 0

	self._infoNode:setVisible(not notHasInfo)
	self._findNode:setVisible(not notHasInfo)
	self._topNode:setVisible(not notHasInfo)
	self._notHasNode:setVisible(notHasInfo)
	self._renwuNode:setVisible(notHasInfo)

	if notHasInfo then
		self:refreshNotHasView()
	else
		self:createTableView()
		self:refreshInfoPanel()
		self:refreshFindPanel()
	end

	self:refeshRemoveBtn()
end

function ClubApplyMediator:refreshNotHasView()
	local rolePic = IconFactory:createRoleIconSpriteNew({
		id = "Model_MGNa",
		frameId = "bustframe9"
	})

	rolePic:setScale(0.7)
	rolePic:addTo(self._renwuNode):posite(446, 265)
end

function ClubApplyMediator:refreshViewByViewType()
	self._curIndex = 1

	self:refreshData()
	self._tableView:removeFromParent(true)

	self._tableView = nil

	self:createTableView()
	self:refreshInfoPanel()
	self._viewBackBtn:setVisible(self._viewType == ClubRecordType.kFind)
end

function ClubApplyMediator:onRequestFindSuccCallback()
	local list = self._clubSystem:getFindRecordListOj():getList()

	if #list ~= 0 then
		self._viewType = ClubRecordType.kFind

		self:refreshViewByViewType()
	else
		local delegate, outSelf = {}, self

		function delegate:willClose(popupMediator, data)
			outSelf._textFieldCanMove = true
		end

		local data = {
			resizeWidth = 550,
			richTextStr = Strings:get("Club_Text116", {
				fontName = TTF_FONT_FZYH_R
			}),
			btnOkDate = {}
		}
		local view = self:getInjector():getInstance("ClubWaringTipView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end

	self:refeshRemoveBtn()
end

function ClubApplyMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._mainPanel.originPos = cc.p(self._mainPanel:getPosition())
	self._infoNode = self._mainPanel:getChildByFullName("infonode")

	self._infoNode:getChildByFullName("infopanel"):setTouchEnabled(true)
	self._infoNode:setLocalZOrder(100)

	self._findNode = self._mainPanel:getChildByFullName("findndoe")
	self._findBtn = self._findNode:getChildByFullName("findbtn")

	self._findBtn:setVisible(true)

	self._editBox = self._findNode:getChildByName("textfiled")
	self._textFieldBackBtn = self._findNode:getChildByFullName("backbtn")
	self._viewBackBtn = self._findNode:getChildByFullName("viewbackbtn")

	self._viewBackBtn:setVisible(false)

	self._topNode = self._mainPanel:getChildByFullName("topnode")

	self._topNode:setLocalZOrder(10)

	self._notHasNode = self._mainPanel:getChildByFullName("nothasnode")
	self._cellPanel = self._mainPanel:getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._renwuNode = self._mainPanel:getChildByFullName("renwuNode")

	self._renwuNode:setVisible(false)

	local titlelabel = self._infoNode:getChildByFullName("titlelabel")
	local lineGradiantVec2 = {
		{
			ratio = 0.65,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.9,
			color = cc.c4b(37, 31, 32, 255)
		}
	}

	titlelabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	titlelabel:enableOutline(cc.c4b(3, 1, 4, 255), 2)

	local applaybtn = self._infoNode:getChildByFullName("applaybtn.button")

	applaybtn:setContentSize(cc.size(364, 99))

	local winSize = cc.Director:getInstance():getWinSize()

	self._infoNode:setPositionX(winSize.width - self._infoNode:getContentSize().width - (winSize.width - 1136) / 2)
	self._notHasNode:setPositionX(winSize.width - self._infoNode:getContentSize().width - (winSize.width - 1136) / 2)
end

function ClubApplyMediator:createTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
	end

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
		return size.width, size.height + 5
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(0, 0))
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
		return self._applyRecordListOj:getRecordCount()
	end

	local tableView = cc.TableView:create(cc.size(699, 388))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(28, 127)
	tableView:setDelegate()
	self._mainPanel:addChild(tableView, 200)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

local rankImgClubPath = {
	"paihangbang_icon_no1.png",
	"paihangbang_icon_no2.png",
	"paihangbang_icon_no3.png"
}
local backimgPath = {
	"st_bg_phb1.png",
	"st_bg_phb2.png",
	"st_bg_phb3.png",
	"st_bg_phb4.png",
	"st_bg_phb5.png"
}

function ClubApplyMediator:refreshRankLabel(cell, idx)
	local backImg = cell:getChildByFullName("baseImg")

	backImg:ignoreContentAdaptWithSize(true)
	backImg:removeChildByTag(1001, true)

	local rankLabel = cell:getChildByFullName("ranklabel")
	local selectedImg = cell:getChildByName("selectImg")

	selectedImg:setVisible(false)

	local bgPath = backimgPath[4]

	rankLabel:setVisible(idx > 3)

	if idx <= 3 then
		bgPath = backimgPath[idx]

		backImg:loadTexture(backimgPath[idx], ccui.TextureResType.plistType)

		local rankImgPath = rankImgClubPath[idx]
		local rankImg = cc.Sprite:create("asset/common/" .. rankImgPath)

		rankImg:addTo(backImg):posite(74, 65)
		rankImg:setTag(1001)
	else
		rankLabel:setString(tostring(idx))
		backImg:loadTexture(bgPath, ccui.TextureResType.plistType)
		rankLabel:enableOutline(cc.c4b(35, 15, 5, 153), 2)
	end

	if self._curIndex == idx then
		selectedImg:setVisible(true)
	end
end

function ClubApplyMediator:createCell(cell, idx)
	local data = self._applyList[idx]

	cell:setTouchEnabled(false)

	if not data then
		return
	end

	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)

	local function callFunc(sender, eventType)
		self:onCellClicked(eventType, idx)
	end

	mapButtonHandlerClick(nil, cell, {
		ignoreClickAudio = true,
		eventType = 4,
		func = callFunc
	})
	self:refreshRankLabel(cell, idx)

	local iconPanel = cell:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()
	iconPanel:setTouchEnabled(false)

	local icon = IconFactory:createClubIcon({
		id = data:getClubImg()
	}, {
		isWidget = true
	})

	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(0.8)

	local clubNameLabel = cell:getChildByFullName("clubnamelabel")

	clubNameLabel:setString(data:getClubName())

	local clubLevelLabel = cell:getChildByFullName("clublevellabel")

	clubLevelLabel:setString(Strings:get("Club_Text194", {
		level = data:getClubLevel()
	}))

	local numLabel = cell:getChildByFullName("numlabel")

	numLabel:setString(data:getMemberCount() .. "/" .. data:getMemberLimitCount())
	self:createLimitPanel(cell, data)

	local applyImg = cell:getChildByFullName("hasapplyimg")

	applyImg:setVisible(data:getApplayState() == ApplyClubState.kHas)
end

function ClubApplyMediator:createLimitPanel(cell, data)
	local auditCondition = data:getAuditCondition()
	local auditType = auditCondition:getType()
	local limitLevel = auditCondition:getLevel()
	local limitCombat = auditCondition:getCombat()
	local limitNode = cell:getChildByFullName("lvllimitlabel")

	limitNode:setString("")
	limitNode:removeAllChildren()

	local shenImg = cell:getChildByFullName("clubshen")

	shenImg:setVisible(false)

	local limitData = {}

	if auditType ~= ClubAuditType.kClose then
		local limitStr = ""

		if limitLevel > 0 then
			limitData[#limitData + 1] = Strings:get("Club_Text110", {
				level = limitLevel
			})
			limitStr = limitData[1] .. "   "
		end

		if limitCombat > 0 then
			limitData[#limitData + 1] = limitCombat

			local combatStr = Strings:get("ARENA_TEAM_SORT_COMBAT") .. " " .. limitCombat

			limitStr = limitStr .. combatStr
		end

		limitNode:setString(limitStr)
	end

	if auditType == ClubAuditType.kLimitCondition then
		shenImg:setVisible(true)

		if #limitData == 0 then
			limitNode:setString(Strings:get("Club_Text79"))
		end
	elseif auditType == ClubAuditType.kClose then
		limitNode:setString(Strings:get("Club_Text81"))

		limitData = {}
	elseif auditType == ClubAuditType.kFreeOpen and #limitData == 0 then
		limitNode:setString(Strings:get("Club_Text79"))
	end

	local factor1 = #limitData > 0
	local factor2 = #limitData == 0 and auditType == ClubAuditType.kLimitCondition

	if not factor1 and factor2 then
		-- block empty
	end
end

function ClubApplyMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local sureRequest = false
	local offsetY = self._tableView:getContentOffset().y

	if kMinRefreshHeight < offsetY then
		local factor1 = viewHeight < self._tableView:getContentSize().height
		local factor2 = self._applyRecordListOj:getRecordCount() < self._applyRecordListOj:getMaxCount()

		if factor1 and factor2 then
			sureRequest = true
		end
	end

	if sureRequest then
		self._isAskingRank = true
		self._requestNextCount = self._applyRecordListOj:getRecordCount()

		self:doRequestNextRank()
	end
end

function ClubApplyMediator:doRequestNextRank()
	local kCellHeight = self._cellPanel:getContentSize().height
	local dataEnough = self._applyRecordListOj:getDataEnough()

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self:refreshData()
			self._tableView:removeFromParent(true)
			self:createTableView()

			local kCellHeight = self._cellPanel:getContentSize().height

			if self._requestNextCount then
				local diffCount = self._applyRecordListOj:getRecordCount() - self._requestNextCount
				local offsetY = -diffCount * kCellHeight + kCellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))

				self._requestNextCount = nil
				self._isAskingRank = false
			end
		end

		local rankStart = self._applyRecordListOj:getRecordCount() + 1
		local rankEnd = rankStart + self._applyRecordListOj:getRequestRankCountPerTime() - 1

		if self._viewType == ClubRecordType.kFind then
			self._clubSystem:searchClub(self._inPutStr, rankStart, rankEnd, false, onRequestRankDataSucc)
		else
			self._clubSystem:requestApplyList(rankStart, rankEnd, false, onRequestRankDataSucc)
		end
	end
end

function ClubApplyMediator:getTableViewPosY()
	return self._tableView:getContentOffset().y
end

function ClubApplyMediator:refreshInfoPanel()
	if self._applyRecordListOj:getRecordCount() == 0 then
		for k, child in pairs(self._infoNode:getChildren()) do
			child:setVisible(false)
		end

		return
	end

	self._infoNode:setVisible(true)

	local data = self._applyList[self._curIndex]
	local iconPanel = self._infoNode:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createPlayerIcon({
		clipType = 1,
		frameStyle = 2,
		id = data:getPropHeadImg(),
		headFrameId = data:getHeadFrame()
	})

	icon:setScale(1.1)
	icon:addTo(iconPanel):center(iconPanel:getContentSize())

	local nameLabel = self._infoNode:getChildByFullName("namelabel")

	nameLabel:setString(data:getPropName())

	local manifestoLabel = self._infoNode:getChildByFullName("manifestolabel")

	manifestoLabel:setString(data:getSlogan())

	local applayBtn = self._infoNode:getChildByFullName("applaybtn")

	applayBtn:setVisible(data:getApplayState() == ApplyClubState.kNotHas)

	local cancelBtn = self._infoNode:getChildByFullName("cancelbtn")

	cancelBtn:setVisible(data:getApplayState() ~= ApplyClubState.kNotHas)
end

local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Name_Limited", "content")

function ClubApplyMediator:refreshFindPanel()
	if self._editBox:getDescription() == "TextField" then
		self._editBox:setPlaceHolder(Strings:get("Club_Text97"))
		self._editBox:setPlaceHolderColor(cc.c4b(255, 255, 255, 204))
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setString("")

		self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

		self._editBox:onEvent(function(eventName, sender)
			if eventName == "began" then
				-- block empty
			elseif eventName == "ended" then
				local state, finalString = StringChecker.checkString(self._editBox:getText(), MaskWordType.NAME)

				if state == StringCheckResult.AllOfCharForbidden then
					self._inPutStr = ""

					self._editBox:setText("")
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Input_Tip1")
					}))
				end
			elseif eventName == "return" then
				-- block empty
			elseif eventName == "changed" then
				self._inPutStr = self._editBox:getText()
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

			self:refeshRemoveBtn()
		end)
	end

	self._textFieldBackBtn:setVisible(false)
end

function ClubApplyMediator:onClickBack(sender, eventType)
	self:dismiss()
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

function ClubApplyMediator:onClickCancel(sender, eventType)
	local data = self._applyList[self._curIndex]

	self._clubSystem:cancelJoinClubApply(data:getClubId(), data:getRank(), function()
		self:refreshData()
		self._tableView:updateCellAtIndex(self._curIndex - 1)
		self:refreshInfoPanel()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text189")
		}))
	end)
end

function ClubApplyMediator:onClickApplay(sender, eventType)
	local data = self._applyList[self._curIndex]
	local auditCondition = data:getAuditCondition()
	local auditType = auditCondition:getType()
	local limitLevel = auditCondition:getLevel()
	local limitCombat = auditCondition:getCombat()

	if auditType == ClubAuditType.kClose then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text195")
		}))

		return
	end

	local factor1 = limitLevel > self._developSystem:getPlayer():getLevel()
	local factor2 = limitCombat > self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()

	if factor1 and not factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text196", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	elseif not factor1 and factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text197", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	elseif factor1 and factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text186", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	end

	self._clubSystem:requestApplyEnterClub(data:getClubId(), data:getRank(), function()
		if not self._clubSystem:getHasJoinClub() then
			if data:getMemberCount() >= data:getMemberLimitCount() then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Club_Text187")
				}))
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Club_Text172")
				}))
			end
		end

		self:refreshData()
		self._tableView:updateCellAtIndex(self._curIndex - 1)
		self:refreshInfoPanel()
	end)
end

function ClubApplyMediator:onClickQuickApplay(sender, eventType)
	self._clubSystem:quickJoinClub()
end

function ClubApplyMediator:onClickCreateClub(sender, eventType)
	local condition = {
		STAGE = levelNeed.STAGE,
		LEVEL = levelNeed.LEVEL
	}
	local isOpen, lockTip, unLockLevel = self._systemKeeper:isUnlockByCondition(condition)

	if not isOpen then
		self:dispatch(ShowTipEvent({
			tip = lockTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		outSelf._textFieldCanMove = true
	end

	local view = self:getInjector():getInstance("CreateClubTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, delegate))

	self._textFieldCanMove = false
end

function ClubApplyMediator:refeshRemoveBtn()
	self._textFieldBackBtn:setVisible(self._inPutStr ~= "")
end

function ClubApplyMediator:onCellClicked(eventType, idx)
	if eventType == ccui.TouchEventType.ended then
		local tableViewPosY = self:getTableViewPosY()
		local oldIndex = self._curIndex

		if math.abs(tableViewPosY - self._tableViewPosY) < 1 then
			self._curIndex = idx

			self._tableView:updateCellAtIndex(oldIndex - 1)
			self._tableView:updateCellAtIndex(self._curIndex - 1)
			self:refreshInfoPanel()
		end
	elseif eventType == ccui.TouchEventType.began then
		self._tableViewPosY = self:getTableViewPosY()
	end
end

function ClubApplyMediator:onClickFindBtn()
	if self._inPutStr == "" then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text170")
		}))

		return
	end

	local strList = {
		"%s",
		"\\"
	}
	local findSpecialStr = false

	for i = 1, #strList do
		if string.find(self._inPutStr, strList[i]) ~= nil then
			findSpecialStr = true
		end
	end

	if findSpecialStr then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubApplyFind_Text1")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		self._inPutStr = ""

		self._editBox:setText(self._inPutStr)
		self:refeshRemoveBtn()

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._clubSystem:searchClub(self._inPutStr, 1, 20, true, function()
		self:onRequestFindSuccCallback()
	end)
end

function ClubApplyMediator:onClickBackBtn(sender, eventType, idx)
	self._viewType = ClubRecordType.kApplay

	self:refreshViewByViewType()
	self._editBox:setText("")
	self:refeshRemoveBtn()
end

function ClubApplyMediator:onClickViewBackBtn(sender, eventType, idx)
	self._clubSystem:requestApplyList(1, 20, true, function()
		self._viewType = ClubRecordType.kApplay

		self:refreshViewByViewType()
		self._editBox:setText("")
	end)
end

function ClubApplyMediator:onClickPlayerInfo(sender, eventType, idx)
	local data = self._applyList[self._curIndex]
	local friendSystem = self:getInjector():getInstance(FriendSystem)

	local function gotoView(response)
		local record = BaseRankRecord:new()
		local var_52_0 = {
			rank = 1,
			rid = data:getPropRid(),
			level = data:getPropLevel(),
			nickname = data:getPropName(),
			vipLevel = data:getPropVipLevel(),
			combat = data:getPropCombat(),
			slogan = data:getPropManifesto(),
			headImage = data:getPropHeadImg(),
			headFrame = data:getHeadFrame(),
			master = data:getMaster(),
			heroes = data:getHeros(),
			clubName = data:getClubName(),
			isFriend = response.isFriend
		}

		if response.isFriend == 1 then
			var_52_0.close = response.close or nil
		end

		var_52_0.gender = data:getPropGender()
		var_52_0.city = data:getPropCity()
		var_52_0.birthday = data:getPropBirthday()
		var_52_0.tags = data:getPropTags()
		var_52_0.block = response.block
		var_52_0.leadStageId = data:getLeadStageId()
		var_52_0.leadStageLevel = data:getLeadStageLevel()

		record:synchronize(var_52_0)
		self._friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(data:getPropRid(), function(response)
		gotoView(response)
	end)
end

function ClubApplyMediator:setupClickEnvs()
	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local mainPanel = self._mainPanel

		storyDirector:setClickEnv("ClubApplyMediator.mainPanel", mainPanel, nil)

		local applaybtn = self._infoNode:getChildByFullName("applaybtn.button")

		storyDirector:setClickEnv("ClubApplyMediator.applaybtn", applaybtn, nil)

		local createclubbtn = self._infoNode:getChildByFullName("createclubbtn.button")

		storyDirector:setClickEnv("ClubApplyMediator.createclubbtn", createclubbtn, nil)
		storyDirector:notifyWaiting("enter_ClubMediator")
	end))

	self:getView():runAction(sequence)
end
