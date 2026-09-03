-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendBlackMediator.lua

FriendBlackMediator = class("FriendBlackMediator", DmPopupViewMediator, _M)

FriendBlackMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendBlackMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
FriendBlackMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

local kBtnHandlers = {}

function FriendBlackMediator:initialize()
	super.initialize(self)
end

function FriendBlackMediator:dispose()
	super.dispose(self)
end

function FriendBlackMediator:onRemove()
	super.onRemove(self)
end

function FriendBlackMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()

	self._main = self:getView():getChildByName("main")
	self._scrollPanel = self._main:getChildByName("ScrollView_1")
	self._friendCell = self:getView():getChildByName("cell")

	self._friendCell:setVisible(false)
	self._friendCell:getChildByName("Text_level"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._friendCell:getChildByName("Text_combat"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._titletxt = self._main:getChildByFullName("dataPanel.Text_2")
	self._titlecount = self._main:getChildByFullName("dataPanel.Text_applycount")

	self._titletxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount:setPositionX(self._titletxt:getContentSize().width + self._titletxt:getPositionX())
end

function FriendBlackMediator:userInject()
	return
end

function FriendBlackMediator:setupView(data)
	self._mediator = data.mediator

	self:refreshData()
	self:createTableView()
	self:refreshView()
end

function FriendBlackMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_SHIELD_MESSAGE_SUCC, self, self.onShieldSucc)
end

function FriendBlackMediator:onShieldSucc()
	self:refreshData()
	self:refreshView()
end

function FriendBlackMediator:refreshData()
	self._friendList = self._chatSystem:getShieldList()
end

function FriendBlackMediator:refreshView()
	self._friendModel = self._friendSystem:getFriendModel()

	local maxCount1 = self._friendModel:getBlockFriendsCount()

	self._titlecount:setString(#self._friendList .. "/" .. maxCount1)
	self._tableView:reloadData()
end

function FriendBlackMediator:createTableView()
	local ssize = self._scrollPanel:getContentSize()
	local size = self._friendCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(ssize.width, ssize.height))

	local function numberOfCells(view)
		return #self._friendList
	end

	local function cellTouched(table, cell)
		self:onClickFriendCell(cell.data)
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = self._friendCell:clone()

			cloneCell:setVisible(true)
			cloneCell:setSwallowTouches(false)
			cloneCell:addTo(cell):setName("main")
			cloneCell:setPosition(cc.p(0, 0))
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(-3, -2))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._scrollPanel)
	tableView:reloadData()

	self._tableView = tableView
end

function FriendBlackMediator:updataCell(cell, index)
	local friendData = self._friendList[index]

	cell.data = friendData

	local cell = cell:getChildByName("main")
	local headBg = cell:getChildByName("headimg")

	headBg:removeAllChildren(true)

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = friendData.headImage,
		size = cc.size(84, 84),
		headFrameId = friendData.headFrame
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize())
	headicon:setScale(0.75)

	local nameText = cell:getChildByName("Text_name")

	nameText:setString(friendData.nickname)

	local levelText = cell:getChildByName("Text_level")

	levelText:setString("Lv." .. friendData.level)
	levelText:setLocalZOrder(10)

	local combatText = cell:getChildByName("Text_combat")

	combatText:setString(friendData.combat)

	local removeBtn = cell:getChildByName("btn_add")

	removeBtn:setTouchEnabled(true)

	local function callFunc(sender, eventType)
		self:onClickRemoveBtn(friendData.rid, true)
	end

	mapButtonHandlerClick(nil, removeBtn, {
		func = callFunc
	})
end

function FriendBlackMediator:onClickRemoveBtn(shieldId, status)
	local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)
	local maxCount = self._friendModel:getMaxFriendsCount()

	if maxCount <= friendCount then
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == AlertResponse.kOK then
				outSelf:requestBlockUser(shieldId, status)
			elseif data.response == AlertResponse.kCancel then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("UPDATE_UI7"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = Strings:get("RANK_REMOVE_SHIELD_FRIENDFULL_CONTENT"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
	else
		self:requestBlockUser(shieldId, status)
	end
end

function FriendBlackMediator:requestBlockUser(shieldId, status)
	local function callback(data)
		if data then
			if self._chatSystem:getBlockUserStatus(shieldId) then
				local var_21_0 = Strings:get("Chat_ShieldSuccess_Tips")

				if not var_21_0 then
					var_21_0 = Strings:get("Chat_ShieldCancel_Tips")

					local tips = var_21_0

					self:getEventDispatcher():dispatchEvent(ShowTipEvent({
						duration = 0.35,
						tip = tips
					}))
				end
			end
		end
	end

	local block = status and {} or {
		shieldId
	}
	local unblock = status and {
		shieldId
	} or {}

	self._chatSystem:requestBlockUser(block, unblock, callback)
end

function FriendBlackMediator:onClickFriendCell(data)
	if not data then
		return
	end

	local function gotoView(response)
		local record = BaseRankRecord:new()

		record:synchronize({
			headImage = data.headImage,
			headFrame = data.headFrame,
			rid = data.rid,
			level = data.level,
			nickname = data.nickname,
			vipLevel = data.vipLevel,
			combat = data.combat,
			slogan = data.slogan,
			master = data.master,
			heroes = data.heroes,
			clubName = data.clubName,
			online = data.online,
			lastOfflineTime = data.lastOfflineTime,
			isFriend = response.isFriend,
			close = response.close,
			gender = data.gender,
			city = data.city,
			birthday = data.birthday,
			tags = data.tags,
			block = response.block,
			leadStageId = data.leadStageId,
			leadStageLevel = data.leadStageLevel
		})
		self._friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	self._friendSystem:requestSimpleFriendInfo(data.rid, function(response)
		gotoView(response)
	end)
end
