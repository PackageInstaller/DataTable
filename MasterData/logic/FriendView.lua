-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendView.lua

module("logic.extensions.friend.view.FriendView", package.seeall)

local FriendView = class("FriendView", ViewComponent)

function FriendView:ctor()
	FriendView.super.ctor(self)
end

function FriendView:_getPath()
	return {
		cellPath = "main/middle/Cell",
		viewPath = "main/middle/friendList"
	}
end

function FriendView:destroyUI()
	return
end

function FriendView:onEnterFinished()
	return
end

function FriendView:onExitFinished()
	NewChatModel.instance:reStartCountDownToSaveChat()
end

function FriendView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickRule, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnHeartTip:AddClickListener(self._onClickHeartTip, self)
	self._btnOnekey:AddClickListener(self._onClickOnekey, self)
	self._btnHeart:AddClickListener(self._onClickHeart, self)
	self._btnDelList:AddClickListener(self._onClickDelList, self)
	GameUtil.addClickHandler(self._btnSetStrangerSwitch, self._onClickSetStrangerSwitch, self)
	self._btnFoldTop:AddClickListener(self._onClickbtnFoldTop, self)
end

function FriendView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnHeartTip:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
	self._btnHeart:RemoveClickListener()
	self._btnDelList:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnSetStrangerSwitch)
	self._btnFoldTop:RemoveClickListener()
end

function FriendView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._heartTip, false)
	end
end

function FriendView:_onClickHeartTip()
	local ins = FriendModel.instance

	self._txtHeartTip.text = string.format("每日赠送上限：%s/%s\n每日收取上限：%s/%s", ins:getSendedHeartNum(), ins:getMaxSendHeartOneDay(), ins:getGainedHeartNum(), ins:getMaxGainHeartOneDay())

	goutil.setActive(self._heartTip, true)
end

function FriendView:buildUI()
	FriendView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tabs = {}

	local tabs = self:getGo("left_tab")

	for i = 1, 6 do
		local tab = {}
		local go = goutil.findChild(tabs, i)

		tab.btn = Framework.ButtonAdapter.Get(go)
		tab.uiChange = go:GetComponent("UIChangeGroup")

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.redPoint = goutil.findChild(go, "redPoint")
		tab.redCount = goutil.findChildTextComponent(tab.redPoint, "text")

		GameUtil.SetActive(tab.redPoint, false)
		table.insert(self._tabs, tab)
	end

	self._container = self:getGo("container")
	self._main = self:getGo("main")
	self._btnHeart = self:getBtn("main/middle/btnHeart")
	self._txtHeartCount = goutil.findChildTextComponent(self._btnHeart.gameObject, "txtCount")
	self._txtCount = goutil.findChildTextComponent(self._main, "middle/txtCount")
	self._txtTip = goutil.findChildTextComponent(self._main, "middle/bottom/tip/txtTip")
	self._emptyTips = goutil.findChild(self._main, "Tip")
	self._txtEmptyTips = goutil.findChildTextComponent(self._emptyTips, "txtTip")
	self._chatarea = self:getGo("main/chatarea")
	self._btnSetStrangerSwitch = self:getGo("main/Tip/btnSetStrangerSwitch")
	self._btnTip = self:getBtn("btnTip")
	self._btnSort = self:getBtn("main/middle/btnSort")

	self:_initSortPanel()

	self._btnHeartTip = self:getBtn("main/middle/bottom/btnTip")
	self._heartTip = self:getGo("main/middle/bottom/tip")
	self._txtHeartTip = goutil.findChildTextComponent(self._heartTip, "txtTip")
	self._customInput = UICustomInput.Get(self._heartTip)
	self._bottomHeart = self:getGo("main/middle/bottom")

	goutil.setActive(self._heartTip, false)

	self._btnOnekey = self:getBtn("btnOneKey")
	self._redPointOnekey = goutil.findChild(self._btnOnekey.gameObject, "redPoint")
	self._btnDelList = self:getBtn("main/btnDelList")
	self._imgStrangerUndLine = self:getGo("main/Tip/img")
	self._tableviewGo = self:getGo("main/middle/friendList")
	self._tablecellGo = self:getGo("main/middle/Cell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(function()
		self:_onReloadFinish()
	end)

	self._btnFoldTop = self:getBtn("main/middle/titlebg2/btnFoldTop")
	self._txtFoldTip = self:getTxt("main/middle/titlebg2/txtFoldTip")
	self._txtTopCount = self:getTxt("main/middle/titlebg2/txt/txtTopCount")
	self._foldTabGo = self:getGo("main/middle/titlebg2")
end

function FriendView:_initSortPanel()
	self._sortPanel = self:getGo("sortpanel")

	goutil.setActive(self._sortPanel, false)
end

function FriendView:_onClickSort(i)
	FriendController.instance:setSortValue()
end

function FriendView:_updateOnekeyRed()
	goutil.setActive(self._redPointOnekey, FriendController.instance:getOnekeyRedActive())
end

function FriendView.sortFriends(a, b)
	return
end

function FriendView:onEnter()
	FriendView.super.onEnter(self)
	FriendModel.instance:clearChatTime()
	FriendAgent.instance:sendGetBuddyRequestInfoReq(true)
	FriendController.instance:registerLocalNotify("FriendApplyUpdate", self._refreshDot, self)

	self._isFoldTop = FriendController.instance:getIsTopFold()

	local curId = FriendController.instance:getCurSelectedId()
	local curMo = FriendModel.instance:getFriendMo(curId)

	self._curSelectedId = curId

	local gg = FriendController.instance:getGroupIdx()

	if gg ~= nil then
		self:_onClickTab(gg, true)
	else
		self:_onClickTab((curMo and curMo._groupType == GameEnum.FriendGroup.Stranger or nil) and 2, true)
	end

	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendAdd, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListRemove, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListAdd, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendBuddyRelationshipRes, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.GainNewHeart, self._onGainNewHeart, self)
	GlobalDispatcher:addListener(GlobalNotify.ChatRedPointUpdate, self._updateMsgRed, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendStateChange, self._onFriendStateChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._dailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendWelfareRedPointUpdate, self._updateWelfareRed, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateFriendChatTime, self._updateFriendList, self)
	self.addGEvent(self, GlobalNotify.ChangeStrangerSwitch, self._onChangeStrangerSwitch, self)
	self.addGEvent(self, GlobalNotify.TopFriendChange, self._onTopFriendChange, self)
	FriendController.instance:registerLocalNotify("SelectedIdChange", self._onSelectIdChange, self)
	FriendController.instance:registerLocalNotify("OneKeySendOrGainHearts", self._onOnekeySuccess, self)
	self:_refreshDot()
	self:_updateHeartCount()
	self:_updateTabMsgRed()
	self:_updateOnekeyRed()
	self:_updateWelfareRed()

	if FriendController.instance:isNeedReloadFriendData() then
		FriendController.instance:LoadFriends()
	end

	self:_udpateFoldState()
end

function FriendView:_dailyRefresh()
	self:_refreshDot()
	self:_updateHeartCount()
	self:_updateTabMsgRed()
	self:_updateOnekeyRed()
	self:_refresh()
	FloatWordMgr.instance:show("今日好友数据已经刷新")
end

function FriendView:_onSelectIdChange()
	self:reloadData()
	self:_updateEmptyTips()
end

function FriendView:onExit()
	FriendController.instance:setCurSelctedId(0)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)
	FriendController.instance:unregisterLocalNotify("FriendApplyUpdate", self._refreshDot, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendRemove, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendAdd, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.BlackListRemove, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.BlackListAdd, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBuddyRelationshipRes, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.GainNewHeart, self._onGainNewHeart, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChatRedPointUpdate, self._updateMsgRed, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendStateChange, self._onFriendStateChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	FriendController.instance:unregisterLocalNotify("SelectedIdChange", self._onSelectIdChange, self)
	FriendController.instance:unregisterLocalNotify("OneKeySendOrGainHearts", self._onOnekeySuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendInfoGeted, self._dailyRefresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendWelfareRedPointUpdate, self._updateWelfareRed, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateFriendChatTime, self._updateFriendList, self)
	QieCuoAgent.instance:getDispatcher():removeAllListener(QieCuoAgent.PM_FightSwitchInfoRes)
	self._scrollerList:dispose()
end

function FriendView:_onFriendStateChanged(buddyId)
	self:_refresh()
end

function FriendView:_updateMsgRed(channel, friendId)
	self:_updateCellById(friendId)
	self:_updateTabMsgRed()
end

function FriendView:_onGainNewHeart()
	self:reloadData()
	self:_updateOnekeyRed()
end

function FriendView:_updateTabMsgRed()
	self:_updateTabRed(1)
	self:_updateTabRed(2)
end

function FriendView:_updateTabRed(tab)
	local redPoint = self._tabs[tab].redPoint

	goutil.setActive(redPoint, false)

	local group

	if tab == 1 then
		group = GameEnum.FriendGroup.Friend
	elseif tab == 2 then
		group = GameEnum.FriendGroup.Stranger
	end

	local t = FriendModel.instance:getGroupDatas(group)
	local channel = GameEnum.ChatChannel.Private

	for _, v in ipairs(t) do
		if NewChatModel.instance:getRedPointCount(channel, v._id) > 0 then
			goutil.setActive(redPoint, true)

			return
		end
	end
end

function FriendView:_updateWelfareRed()
	local redPoint = self._tabs[5].redPoint

	goutil.setActive(redPoint, FriendController.instance:checkWelfareRdState())
end

function FriendView:_refresh()
	self:_onClickTab(self._curIndex, true)
end

function FriendView:_updateHeartCount()
	self._txtHeartCount.text = MaterialModel.instance:getMaterialsNumber(MatType.Item, 29)
end

function FriendView:_onClickTab(index, force)
	GameUtil.SetActive(self._chatarea, false)
	GameUtil.SetActive(self._btnSetStrangerSwitch, false)
	GameUtil.SetActive(self._imgStrangerUndLine, false)

	if self._curIndex ~= index or force then
		if not force then
			FriendController.instance:onClickItemFriend(0)
		end

		local preIdx = self._curIndex

		self._curIndex = index

		FriendController.instance:setGroupIdx(self._curIndex)
		goutil.setActive(self._main, index <= 2)
		goutil.setActive(self._btnOnekey.gameObject, index <= 2)
		self:_udpateFoldState()

		if index == 1 then
			self:_updateMainList(true)
		elseif index == 2 then
			self:_updateMainList(false)
		elseif index == 3 then
			self:showTabAt(self._container)
			self:showTabAt(self._container, ViewName.FriendBlackList)
		elseif index == 4 then
			self:showTabAt(self._container)
			self:showTabAt(self._container, ViewName.FriendAdd)
		elseif index == 5 then
			self:showTabAt(self._container)
			self:showTabAt(self._container, ViewName.FriendWelfare)
		elseif index == 6 then
			goutil.setActive(self._main, true)
			self:_updateRecentList()
		else
			FloatWordMgr.instance:show("暂未开放")

			self._curIndex = preIdx

			FriendController.instance:setGroupIdx(self._curIndex)

			return
		end

		for i = 1, #self._tabs do
			self._tabs[i].uiChange:SetState(i == index and 1 or 0)
		end

		goutil.setActive(self._bottomHeart, index == 1)
		goutil.setActive(self._btnOnekey.gameObject, index == 1)
	end
end

function FriendView:_updateMainList(isFriend)
	self:showTabAt()

	local config = FriendConfig.instance
	local group
	local preStr = ""

	if isFriend == true then
		group = GameEnum.FriendGroup.Friend
		preStr = "好友数"
	else
		group = GameEnum.FriendGroup.Stranger
		preStr = "陌生人数"
	end

	self._txtCount.text = string.format("%s %s/%s", preStr, FriendModel.instance:getGroupCellNums(group), config:GetMaxCount(group))

	local datas = FriendModel.instance:getGroupDatas(group)

	self._topFriendList = nil
	self._normalFriendList = nil

	if isFriend then
		self._curViewDatas = {}
		self._topFriendList = {}
		self._normalFriendList = {}

		local totalList = {}

		for i, v in ipairs(datas or {}) do
			if FriendController.instance:isTopFriendId(v.headInfo.userId) then
				table.insert(self._topFriendList, v)
			else
				table.insert(self._normalFriendList, v)
			end
		end

		self._txtTopCount.text = #self._topFriendList

		table.sort(self._normalFriendList, FriendModel.sortFriends)

		if not self._isFoldTop then
			FriendController.instance:sortTopFriendList(self._topFriendList)
			table.insertto(totalList, self._topFriendList)
			table.insertto(totalList, self._normalFriendList)

			self._curViewDatas = totalList
		else
			self._curViewDatas = self._normalFriendList
		end
	else
		self._curViewDatas = datas

		table.sort(self._curViewDatas, FriendModel.sortFriends)
	end

	self._needCenterOn = true

	self:reloadData()
	self:_updateEmptyTips()

	if #self._curViewDatas == 0 then
		FriendController.instance:onClickItemFriend(0)
	end
end

function FriendView:_updateRecentList()
	self:showTabAt()

	local mo = FriendModel.instance
	local num = 10
	local list = {}
	local friend = mo:getGroupDatas(GameEnum.FriendGroup.Friend)

	for i, v in ipairs(friend) do
		local t = NewChatModel.instance:GetMsgsByChannel(GameEnum.ChatChannel.Private, v._id)

		if t and #t > 0 then
			table.insert(list, v)
		end
	end

	local friend = mo:getGroupDatas(GameEnum.FriendGroup.Stranger)

	for i, v in ipairs(friend) do
		local t = NewChatModel.instance:GetMsgsByChannel(GameEnum.ChatChannel.Private, v._id)

		if t and #t > 0 then
			table.insert(list, v)
		end
	end

	self._curViewDatas = {}

	local listNormal = {}
	local totalList = {}

	for i, v in ipairs(list or {}) do
		if FriendController.instance:isTopFriendId(v.headInfo.userId) then
			table.insert(totalList, v)
		else
			table.insert(listNormal, v)
		end
	end

	FriendController.instance:sortTopFriendList(totalList)
	table.sort(listNormal, FriendModel.sortFriends)
	table.insertto(totalList, listNormal)

	self._curViewDatas = totalList
	self._txtCount.text = string.format("列表人数 %s/%s", #self._curViewDatas, num)
	self._needCenterOn = true

	self:reloadData()
	self:_updateEmptyTips()

	if #self._curViewDatas == 0 then
		FriendController.instance:onClickItemFriend(0)
	end
end

function FriendView:_updateFriendList()
	if self._curViewDatas and #self._curViewDatas > 0 then
		if self:_isShowTopStateTab() then
			if not self._isFoldTop then
				local totalList = {}

				FriendController.instance:sortTopFriendList(self._topFriendList)
				table.insertto(totalList, self._topFriendList)
				table.insertto(totalList, self._normalFriendList)

				self._curViewDatas = totalList
			else
				self._curViewDatas = self._normalFriendList
			end
		else
			table.sort(self._curViewDatas, FriendModel.sortFriends)
		end

		self._needCenterOn = true

		self:reloadData()
	end
end

function FriendView:_onReloadFinish()
	if self._needCenterOn and checknumber(self._curSelectedId) > 0 then
		self._needCenterOn = false

		local idx = self:_getCellIdxById(self._curSelectedId)

		if idx >= 0 then
			self._scrollerList:MoveCellToCenter(idx)
		end
	end
end

function FriendView:_updateEmptyTips()
	GameUtil.SetActive(self._btnSetStrangerSwitch, false)
	GameUtil.SetActive(self._imgStrangerUndLine, false)

	local tipsContent = ""

	if #self._curViewDatas == 0 then
		if self._curIndex == 1 then
			tipsContent = self._topFriendList and #self._topFriendList > 0 and "快展开置顶好友，聊天吧" or "当前没有好友，快去添加好友吧"
		elseif self._curIndex == 2 then
			tipsContent = "当前\"陌生人功能\"尚未开启\n前往开启"

			GameUtil.SetActive(self._chatarea, false)
			GameUtil.SetActive(self._btnSetStrangerSwitch, true)
			GameUtil.SetActive(self._imgStrangerUndLine, true)
		end
	elseif checknumber(FriendController.instance:getCurSelectedId()) <= 0 then
		if self._curIndex == 1 then
			tipsContent = "请选择一个好友聊天吧"
		elseif self._curIndex == 2 then
			local strangerMsgSwitch = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)

			if strangerMsgSwitch then
				tipsContent = "请选择一个陌生人聊天吧"
			else
				tipsContent = "当前\"陌生人功能\"尚未开启\n前往开启"

				GameUtil.SetActive(self._chatarea, false)
				GameUtil.SetActive(self._btnSetStrangerSwitch, true)
				GameUtil.SetActive(self._imgStrangerUndLine, true)
			end
		end
	else
		local strangerMsgSwitch = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)
		local curSelectId = checknumber(FriendController.instance:getCurSelectedId())
		local curMo = FriendModel.instance:getFriendMo(curSelectId)

		if curMo._groupType == GameEnum.FriendGroup.Stranger and not strangerMsgSwitch then
			tipsContent = "当前\"陌生人功能\"尚未开启\n前往开启"

			GameUtil.SetActive(self._chatarea, false)
			GameUtil.SetActive(self._btnSetStrangerSwitch, true)
			GameUtil.SetActive(self._imgStrangerUndLine, true)
		end
	end

	self._txtEmptyTips.text = tipsContent

	goutil.setActive(self._emptyTips, not string.nilorempty(tipsContent))
end

function FriendView:reloadData()
	self._nowTime = ServerTime.nowServerLook()

	self._scrollerList:reloadData(self._curViewDatas)
end

function FriendView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local imgIconChange = goutil.findChild(container, "Head")
	local returnGo = goutil.findChild(container, "returnGo")
	local txtLevel = goutil.findChildTextComponent(container, "level/txtLevel")
	local txtPower = goutil.findChildTextComponent(container, "Power/txtPower")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local txtOnline = goutil.findChildTextComponent(container, "txtOnline")
	local selected = goutil.findChild(container, "selected")
	local txtOnlineChange = txtOnline:GetComponent("UITextColorChange")
	local relationshipTab = goutil.findChild(container, "relationshipTab")
	local txtRelationshipTab = goutil.findChildTextComponent(container, "relationshipTab/txt")
	local imgBkChange = container:GetComponent(typeof(UIImageSpriteChange))
	local btn = Framework.ButtonAdapter.Get(container)
	local btnIcon = Framework.ButtonAdapter.GetFrom(container, "btnHead")
	local btnSendHeart = Framework.ButtonAdapter.GetFrom(container, "btnSend")
	local btnGainHeart = Framework.ButtonAdapter.GetFrom(container, "btnGain")
	local btnSendFlower = Framework.ButtonAdapter.GetFrom(container, "btnFlower")
	local imgSendChange = btnSendHeart:GetComponent("UIImageSpriteChange")
	local imgGainChange = btnGainHeart:GetComponent("UIImageSpriteChange")
	local area = goutil.findChild(container, "area")
	local txtArea = goutil.findChildTextComponent(container, "area/txt")
	local topBgGo = goutil.findChild(cell.gameObject, "container/list/topbg")

	goutil.setActive(topBgGo, FriendController.instance:isTopFriendId(data.headInfo.userId))
	GameUtil.SetActive(area, false)

	txtName.text = data._name

	if data.headInfo and not string.nilorempty(data.headInfo.areaName) then
		GameUtil.SetActive(area, true)

		txtArea.text = data.headInfo.areaName
	end

	returnGo:SetActive(data:getRegressEndTime() > self._nowTime)
	HeadItemController.instance:setHeadCellByInfo(imgIconChange, data.headInfo)

	txtPower.text = data._zdl
	txtLevel.text = data:getLevel()

	if data:getIsOnline() then
		txtOnline.text = "在线"

		txtOnlineChange:SetState(1)
	else
		txtOnline.text = TimeUtil.getLeftTime(data._lastOpTime, true)

		txtOnlineChange:SetState(0)
	end

	btn:AddClickListener(function()
		self:_onClickSelf(data)
	end)
	GameUtil.addClickHandler(btnIcon, function()
		self:_onClickIcon(data, container)
	end)
	goutil.setActive(selected, tostring(data._id) == tostring(FriendController.instance:getCurSelectedId()))

	local redPoint = goutil.findChild(container, "redPoint")
	local redCount = goutil.findChildTextComponent(redPoint, "text")
	local newMsgCount = NewChatModel.instance:getNotReadMsgCount(GameEnum.ChatChannel.Private, data._id)

	goutil.setActive(redPoint, newMsgCount > 0)

	redCount.text = newMsgCount

	local sendState = FriendModel.instance:getCanSendState(data._id)

	imgSendChange:SetState(sendState)
	btnSendHeart:AddClickListener(function()
		self:_onClickSendHeart(data._id)
	end)

	local gainState = FriendModel.instance:getCanGainState(data._id)

	if gainState >= 0 then
		imgGainChange.gameObject:SetActive(true)
		imgGainChange:SetState(gainState)
		btnGainHeart:AddClickListener(function()
			self:_onClickGainHeart(data._id)
		end)
	else
		imgGainChange.gameObject:SetActive(false)
	end

	if self._curIndex ~= 1 then
		goutil.setActive(btnSendHeart.gameObject, false)
		goutil.setActive(btnGainHeart.gameObject, false)

		txtOnline.text = ""
	else
		goutil.setActive(btnSendHeart.gameObject, true)
	end

	local relTypeList = FriendModel.instance:getRelTypeList(data.headInfo.userId)
	local str = ""

	for _, relType in ipairs(relTypeList) do
		str = ""

		if relType == GameEnum.RelTypeByFriend.Tutor then
			local relId = FriendModel.instance:getRelIdByTutor(data.headInfo.userId)

			if relId == GameEnum.RelIdByTutor.Teacher then
				str = "师傅"

				break
			end

			if relId == GameEnum.RelIdByTutor.Student then
				str = "学生"
			end

			break
		end
	end

	txtRelationshipTab.text = str

	GameUtil.SetActive(relationshipTab, not string.nilorempty(str))
	btnSendFlower:AddClickListener(function()
		self:_onClickSendFlower(data.headInfo)
	end)

	local goodEvilIcon = goutil.findChildComponent(txtName.gameObject, "goodEvilIcon", "UIImageSpriteChange")

	goutil.setActive(goodEvilIcon.gameObject, false)
end

function FriendView:_clearCell(cell)
	return
end

function FriendView:_updateCellById(id)
	local idx = self:_getCellIdxById(id)

	if idx >= 0 then
		self._scrollerList:updateCellAtIndex(idx)
	end
end

function FriendView:_getCellIdxById(id)
	for k, v in ipairs(self._curViewDatas) do
		if v._id == id then
			return k - 1
		end
	end

	return -1
end

function FriendView:_onClickSelf(data)
	self._curSelectedId = FriendController.instance:getCurSelectedId()

	if self._curSelectedId == data._id then
		return
	end

	local preId = self._curSelectedId

	FriendController.instance:onClickItemFriend(data._id)

	self._curSelectedId = data._id

	self:_updateCellById(preId)
	self:_updateCellById(data._id)
	self:_updateEmptyTips()
end

function FriendView:_onClickIcon(data, go)
	UIStateManager.instance:open(ViewName.playerInfo, data.simpleInfo, data:Group(), go)
end

function FriendView:_onSendOrGainHeart(isSend, msg)
	local content = isSend and "赠送友情点成功" or "领取友情点成功"

	FloatWordMgr.instance:show(content)
	self:_updateHeartCount()
	self:reloadData()
	self:_updateOnekeyRed()
end

function FriendView:_onClickSendHeart(friendId)
	if FriendModel.instance:getCanSendState(friendId, true) == 1 then
		FriendAgent.instance:sendSendHeartsReq({
			friendId
		})
	end
end

function FriendView:_onClickGainHeart(friendId)
	if FriendModel.instance:getCanGainState(friendId, true) == 1 then
		FriendAgent.instance:sendGainHeartsReq({
			friendId
		})
	end
end

function FriendView:_onClickSendFlower(headInfo)
	SendFlowerController.instance:openSendFlowerView(headInfo)
end

function FriendView:_onClickOnekey()
	if FriendController.instance:onekeyHeart(self._onOnekeySuccess, self) then
		GlobalDispatcher:removeListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	end
end

function FriendView:_onOnekeySuccess()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_SEND_FRIEND_HEART)
	GlobalDispatcher:addListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	FloatWordMgr.instance:show("一键赠送和领取友情点成功")
	self:reloadData()
	self:_updateHeartCount()
	self:_updateOnekeyRed()
end

function FriendView:_refreshDot()
	local count = #FriendModel.instance:getRequests()
	local redPoint = self._tabs[4].redPoint
	local redCount = self._tabs[4].redCount

	goutil.setActive(redPoint, count > 0)

	redCount.text = count
end

function FriendView:_onChangeStrangerSwitch(open)
	self:_refresh()

	local curSelectId = checknumber(FriendController.instance:getCurSelectedId())

	if curSelectId <= 0 then
		GameUtil.SetActive(self._chatarea, false)
	else
		GameUtil.SetActive(self._chatarea, open)
	end
end

function FriendView:_onClickClose()
	FriendController.instance:setGroupIdx(nil)
	self:close()
end

function FriendView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "friend")
end

function FriendView:_onClickHeart()
	CommonTipsMgr.instance:openMaterialTips(self._btnHeart.gameObject, MatType.Item, 29)
end

function FriendView:_onClickDelList()
	UIStateManager.instance:push(ViewName.FriendmemberdelView)
end

function FriendView:_onClickSetStrangerSwitch()
	UIStateManager.instance:push(ViewName.SystemSetting, 2)
end

function FriendView:_onClickbtnFoldTop()
	self._isFoldTop = FriendController.instance:changeTopFold()

	self:_udpateFoldState()
	self:_updateMainList(true)
end

function FriendView:_udpateFoldState()
	local showTab = self:_isShowTopStateTab()

	self._txtFoldTip.text = self._isFoldTop and "点击展开置顶" or "点击折叠置顶"

	local y = not showTab and -10.1 or -41.5
	local height = not showTab and 538 or 508

	GameUtil.setHeight(self._tableviewGo, height)
	Framework.TransformUtil.SetAnchoredPos(self._tableviewGo.transform, 0, y)
	goutil.setActive(self._foldTabGo, showTab)
end

function FriendView:_onTopFriendChange()
	if self._curIndex == 1 then
		self:_updateMainList(true)
	elseif self._curIndex == 6 then
		self:_updateRecentList()
	end
end

function FriendView:_isShowTopStateTab()
	return self._curIndex == 1
end

return FriendView
