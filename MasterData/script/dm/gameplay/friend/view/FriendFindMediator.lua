-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendFindMediator.lua

FriendFindMediator = class("FriendFindMediator", DmPopupViewMediator, _M)

FriendFindMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendFindMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_find"] = {
		ignoreClickAudio = true,
		func = "onClickFind"
	},
	["main.btn_refresh"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRefresh"
	},
	["main.btn_applyAll.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickOneKeyAdd"
	},
	["main.btn_del"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDelect"
	}
}
local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_Search_WordLimit", "content")

function FriendFindMediator:initialize()
	super.initialize(self)
end

function FriendFindMediator:dispose()
	super.dispose(self)
end

function FriendFindMediator:onRemove()
	super.onRemove(self)
end

function FriendFindMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.btn_applyAll", TwoLevelViceButton, {
		ignoreAddKerning = true
	})

	self._main = self:getView():getChildByName("main")
	self._friendCell = self._main:getChildByName("cell")

	self._friendCell:setVisible(false)

	self._delBtn = self._main:getChildByFullName("btn_del")
	self._tipsText = self._main:getChildByFullName("Text_tips")

	self._tipsText:setVisible(false)
	self._main:getChildByFullName("btn_refresh.Text_31"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._titletxt1 = self._main:getChildByFullName("dataPanel.Text_1")
	self._titlecount1 = self._main:getChildByFullName("dataPanel.Text_count")
	self._titletxt2 = self._main:getChildByFullName("dataPanel.Text_2")
	self._titlecount2 = self._main:getChildByFullName("dataPanel.Text_applycount")

	self._titlecount1:setString("")
	self._titlecount2:setString("")
	self._titletxt1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titletxt2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._titlecount1:setPositionX(self._titletxt1:getContentSize().width + self._titletxt1:getPositionX())
	self._titlecount2:setPositionX(self._titletxt2:getContentSize().width + self._titletxt2:getPositionX())
end

function FriendFindMediator:userInject()
	return
end

function FriendFindMediator:enterWithData(data)
	return
end

function FriendFindMediator:setupView(data)
	self._mediator = data.mediator
	self._friendList = {}
	self._hasApplyList = {}

	self:createTableView()
	self._friendSystem:requestRecommendList()
	self:mapEventListeners()
	self:setTextField()
	self:refreshDelBtnShow()
end

function FriendFindMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_GETRECOMMENDLIST_SUCC, self, self.onGetCommendSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_ADD_SUCC, self, self.onApplySuccCallback)
end

function FriendFindMediator:refreshView()
	self._friendModel = self._friendSystem:getFriendModel()

	local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)
	local maxCount = self._friendModel:getMaxFriendsCount()

	self._isFriendList = self._friendModel:getFriendList(kFriendType.kGame)
	self._friendList = self._friendModel:getFriendList(kFriendType.kFind)

	self._tableView:reloadData()

	if #self._friendList == 0 then
		self._tipsText:setVisible(true)
	else
		self._tipsText:setVisible(false)
	end

	self._titlecount1:setString(friendCount .. "/" .. maxCount)

	local maxCount1 = self._friendModel:getMaxApplyFriendsCount()
	local addTimes = self._friendModel:getAddTimes()

	self._titlecount2:setString(maxCount1 - addTimes .. "/" .. maxCount1)
end

function FriendFindMediator:setTextField()
	local textField = self._main:getChildByName("text_field")

	textField:setPlaceHolder(Strings:get("Friend_UI13"))

	self._editBox = convertTextFieldToEditBox(textField, nil, MaskWordType.NAME)

	self._editBox:setPlaceholderFontColor(cc.c4b(255, 255, 255, 170.85000000000002))
	self._editBox:getContentLabel():enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._editBox:getPlaceholderLabel():enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
	end

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			self._oldStr = self._editBox:getText()

			local state, finalString = StringChecker.checkString(self._oldStr, MaskWordType.NAME)

			if state == StringCheckResult.AllOfCharForbidden then
				self._oldStr = ""

				self._editBox:setText("")
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

		self:refreshDelBtnShow()
	end)
end

function FriendFindMediator:createTableView()
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

			local node = ccui.Widget:create()

			node:setContentSize(cc.size(828, self._friendCell:getContentSize().height))
			node:setAnchorPoint(cc.p(0, 0))
			node:setPosition(0, 0)
			cell:addChild(node, 1, 10000)
			node:setVisible(true)

			local cell_Old = cell:getChildByTag(10000)

			self:refreshCell(cell_Old, idx + 1)
		else
			local cell_Old = cell:getChildByTag(10000)

			self:refreshCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._friendList)
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
end

function FriendFindMediator:refreshCell(node, index)
	node:removeAllChildren(true)

	local friendData = self._friendList[index]

	if friendData then
		local cell = self._friendCell:clone()

		cell:setVisible(true)
		node:addChild(cell)
		cell:setPosition(cc.p(0, 0))
		cell:setSwallowTouches(false)

		local function cellCallFunc(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:getPushFriendInfo(friendData)
			end
		end

		mapButtonHandlerClick(nil, cell, {
			func = cellCallFunc
		})

		local nameText = cell:getChildByName("Text_name")

		nameText:setString(friendData:getNickName())

		local combatText = cell:getChildByName("Text_combat")

		combatText:setString(friendData:getCombat())

		local headBg = cell:getChildByName("headimg")

		headBg:removeAllChildren()

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
		headicon:setScale(0.85)
		cell:removeChildByTag(999)

		local levelText = cell:getChildByName("Text_level")

		levelText:setString("Lv." .. friendData:getLevel())
		levelText:setLocalZOrder(10)
		levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

		local reasonText = cell:getChildByName("Text_reason")
		local desc = friendData:getRecommendDesc()

		reasonText:setString(desc)

		local addBtn = cell:getChildByName("btn_add")

		addBtn:setTouchEnabled(true)

		local function callFunc(sender, eventType)
			self:onClickFriendCell(friendData)
		end

		local isFriendText = cell:getChildByName("isFriendText")

		mapButtonHandlerClick(nil, addBtn, {
			func = callFunc
		})

		local hasAddImag = cell:getChildByName("Image_hasadd")

		hasAddImag:setVisible(self._hasApplyList[friendData:getRid()])

		if self._developSystem:getPlayer():getRid() ~= friendData:getRid() and not self._hasApplyList[friendData:getRid()] then
			local isFriend = false

			for k, v in ipairs(self._isFriendList) do
				if v:getNickName() == friendData:getNickName() then
					isFriend = true

					break
				end
			end

			addBtn:setVisible(not isFriend)
			isFriendText:setVisible(isFriend)
		else
			addBtn:setVisible(false)
		end

		cell:getChildByName("Text_combat"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	end
end

function FriendFindMediator:getPushFriendInfo(data)
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
		friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(data:getRid(), function(response)
		gotoView(response)
	end)
end

function FriendFindMediator:onApplySuccCallback(event)
	local data = event:getData().response
	local needRefresh = event:getData().needRefresh

	if data and data.addFriends then
		for i, value in pairs(data.addFriends) do
			if self._hasApplyList[value] == nil then
				self._hasApplyList[value] = true
			end
		end

		local offset = self._tableView:getContentOffset()

		self._tableView:reloadData()
		self._tableView:setContentOffset(offset)

		if table.nums(self._hasApplyList) == #self._friendList or needRefresh then
			self._friendSystem:requestRecommendList()
		end
	else
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Add_All_Tips7")
		}))
	end

	local maxCount1 = self._friendModel:getMaxApplyFriendsCount()
	local addTimes = self._friendModel:getAddTimes()

	self._titlecount2:setString(maxCount1 - addTimes .. "/" .. maxCount1)
end

function FriendFindMediator:onGetCommendSuccCallback()
	self._hasApplyList = {}

	self:refreshView()
end

function FriendFindMediator:refreshDelBtnShow()
	local str = self._editBox:getText()

	self._delBtn:setVisible(str ~= "")
end

function FriendFindMediator:onClickFriendCell(data)
	local view = self:getInjector():getInstance("FriendAddPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function FriendFindMediator:onClickFind(sender, eventType)
	local str = self._editBox:getText()

	if str == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_tips3")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local spaceCount = string.find(str, "%s")

	if spaceCount ~= nil then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_tips1")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._friendSystem:requestFindFriend(str)
end

function FriendFindMediator:onClickRefresh(sender, eventType)
	self._friendSystem:requestRecommendList()
end

function FriendFindMediator:onClickDelect(sender, eventType)
	self._editBox:setText("")

	self._oldStr = ""

	self:refreshDelBtnShow()
end

function FriendFindMediator:onClickOneKeyAdd(sender, eventType)
	local remark = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()

	self._friendSystem:requestOneKeyFriends(remark)
end
