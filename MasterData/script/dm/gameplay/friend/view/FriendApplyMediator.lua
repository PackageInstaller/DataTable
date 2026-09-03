-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendApplyMediator.lua

FriendApplyMediator = class("FriendApplyMediator", DmPopupViewMediator, _M)

FriendApplyMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendApplyMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.btn_allagree.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAllAgree"
	},
	["main.btn_allrefuse.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAllRefuse"
	},
	["main.noapply.btn_find.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickFind"
	}
}

function FriendApplyMediator:initialize()
	super.initialize(self)
end

function FriendApplyMediator:dispose()
	super.dispose(self)
end

function FriendApplyMediator:onRemove()
	super.onRemove(self)
end

function FriendApplyMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._friendCell = self._main:getChildByName("cell")

	self._friendCell:setVisible(false)

	self._noApplyPanel = self._main:getChildByName("noapply")

	self._noApplyPanel:setLocalZOrder(100)
	self._noApplyPanel:setVisible(false)

	self._allAgreeBtn = self._main:getChildByName("btn_allagree")
	self._allRefuseBtn = self._main:getChildByName("btn_allrefuse")

	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.noapply.btn_find", TwoLevelViceButton, {})
	self:bindWidget("main.btn_allagree", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.btn_allrefuse", TwoLevelMainButton, {
		ignoreAddKerning = true
	})
	self._allAgreeBtn:setLocalZOrder(99)
	self._allRefuseBtn:setLocalZOrder(99)

	self._selectIndex = 1

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local Text_1 = self._main:getChildByFullName("dataPanel.Text_1")
		local Text_count = self._main:getChildByFullName("dataPanel.Text_count")

		Text_count:setPositionX(Text_1:getPositionX() + Text_1:getContentSize().width)
	end

	self._titletxt1 = self._main:getChildByFullName("dataPanel.Text_1")
	self._titlecount1 = self._main:getChildByFullName("dataPanel.Text_count")
	self._titletxt2 = self._main:getChildByFullName("dataPanel.Text_2")
	self._titlecount2 = self._main:getChildByFullName("dataPanel.Text_applycount")

	self._titletxt1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titletxt2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount1:setPositionX(self._titletxt1:getContentSize().width + self._titletxt1:getPositionX())
	self._titlecount2:setPositionX(self._titletxt2:getContentSize().width + self._titletxt2:getPositionX())
end

function FriendApplyMediator:userInject()
	return
end

function FriendApplyMediator:setupView(data)
	self._mediator = data.mediator

	self._friendSystem:requestApplyList()

	self._friendModel = self._friendSystem:getFriendModel()
	self._friendList = self._friendModel:getFriendList(kFriendType.kApply)

	self:mapEventListeners()
	self:createTableView()
	self:refreshView()
	self._friendModel:setFriendApplyCount(0)
end

function FriendApplyMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_GETAPPLYLIST_SUCC, self, self.refreshView)
end

function FriendApplyMediator:refreshView()
	local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)
	local maxCount = self._friendModel:getMaxFriendsCount()

	self._friendList = self._friendModel:getFriendList(kFriendType.kApply)

	self._tableView:reloadData()
	self._noApplyPanel:setVisible(#self._friendList == 0)
	self._allAgreeBtn:setVisible(#self._friendList > 0)
	self._allRefuseBtn:setVisible(#self._friendList > 0)
	self._titlecount1:setString(friendCount .. "/" .. maxCount)

	local maxCount1 = self._friendModel:getMaxFindFriendsCount()

	self._titlecount2:setString(#self._friendList .. "/" .. maxCount1)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
end

function FriendApplyMediator:createTableView()
	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return self._friendCell:getContentSize().width, self._friendCell:getContentSize().height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._friendCell:clone()

			sprite:setPosition(4, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(10000)

			local cell_Old = cell:getChildByTag(10000)

			self:refreshCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		else
			local cell_Old = cell:getChildByTag(10000)

			self:refreshCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._friendList
	end

	local tableView = cc.TableView:create(cc.size(828, 366))

	tableView:setTag(1234)

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(cc.p(260, 160))
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._main:addChild(tableView, -1)
	self._main:getChildByName("effectImage"):setLocalZOrder(0)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function FriendApplyMediator:refreshCell(cell, index)
	local friendData = self._friendList[index]
	local headBg = cell:getChildByName("headimg")

	headBg:removeAllChildren(true)

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = friendData:getHeadId(),
		size = cc.size(84, 84),
		headFrameId = friendData:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize())
	headicon:setScale(0.75)

	local nameText = cell:getChildByName("Text_name")

	nameText:setString(friendData:getNickName())

	local reasonText = cell:getChildByName("Text_reason")

	reasonText:getVirtualRenderer():setDimensions(283, 0)
	reasonText:setString(friendData:getRemark())

	local timeText = cell:getChildByName("Text_time")
	local time = self._gameServerAgent:remoteTimestamp() - friendData:getApplyTime()

	timeText:setString(self._friendSystem:formatApplyTime(time))
	cell:removeChildByTag(999)

	local levelText = cell:getChildByName("Text_level")

	levelText:setString("Lv." .. friendData:getLevel())
	levelText:setLocalZOrder(10)
	levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local agreeBtn = cell:getChildByName("btn_agree")
	local text1 = agreeBtn:getChildByName("text")

	text1:setAdditionalKerning(8)

	local function agreeCallFunc(sender, eventType)
		self:onClickAgree(friendData, index)
	end

	mapButtonHandlerClick(nil, agreeBtn, {
		func = agreeCallFunc
	})

	local function refuseCallFunc(sender, eventType)
		self:onClickRefuse(friendData, index)
	end

	local refuseBtn = cell:getChildByName("btn_refuse")
	local text2 = refuseBtn:getChildByName("text")

	text2:setAdditionalKerning(8)
	mapButtonHandlerClick(nil, refuseBtn, {
		func = refuseCallFunc
	})

	local function cellCallFunc(sender, eventType)
		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()

		if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
			self:getPushFriendInfo(friendData)
		end
	end

	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)
	mapButtonHandlerClick(nil, cell, {
		func = cellCallFunc
	})
end

function FriendApplyMediator:onClickAllAgree(sender, eventType)
	self._friendSystem:requestAgreeFriend("ALL")

	self._tableOffset = self._tableView:getContentOffset()
end

function FriendApplyMediator:onClickAllRefuse(sender, eventType)
	self._friendSystem:requestRefuseFriend("ALL")

	self._tableOffset = self._tableView:getContentOffset()
end

function FriendApplyMediator:onClickRefuse(data, index)
	self._friendSystem:requestRefuseFriend(data:getRid())

	self._tableOffset = self._tableView:getContentOffset()
	self._selectIndex = index
end

function FriendApplyMediator:onClickAgree(data, index)
	self._friendSystem:requestAgreeFriend(data:getRid())

	self._tableOffset = self._tableView:getContentOffset()
	self._selectIndex = index
end

function FriendApplyMediator:onClickFind(sender, eventType)
	self._mediator:changeTabView(kFriendType.kFind)
end

function FriendApplyMediator:getPushFriendInfo(data)
	if not data then
		return
	end

	local friendSystem = self:getFriendSystem()

	local function gotoView(response)
		local record = BaseRankRecord:new()

		record:synchronize({
			headImage = data:getHeadId(),
			headFrame = data:getHeadFrame(),
			rid = data:getRid(),
			level = data:getLevel(),
			nickname = data:getNickName(),
			vipLevel = data:getVipLevel(),
			combat = data:getCombat(),
			slogan = data:getSlogan(),
			master = data:getMaster(),
			heroes = data:getHeroes(),
			clubName = data:getUnionName(),
			online = data:getOnline() == ClubMemberOnLineState.kOnline,
			lastOfflineTime = data:getLastOfflineTime(),
			isFriend = response.isFriend,
			block = response.block,
			close = response.close,
			gender = data:getGender(),
			city = data:getCity(),
			birthday = data:getBirthday(),
			tags = data:getTags(),
			block = response.block,
			leadStageId = data:getLeadStageId(),
			leadStageLevel = data:getLeadStageLevel()
		})
		friendSystem:showFriendPlayerInfoView(record:getRid(), record, "friendApply")
	end

	friendSystem:requestSimpleFriendInfo(data:getRid(), function(response)
		gotoView(response)
	end)
end
