-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendListView.lua

module("logic.extensions.friend.view.FriendListView", package.seeall)

local FriendListView = class("FriendListView", ViewComponent)
local FriendListPath = {}

FriendListPath[GameEnum.FriendGroup.Friend] = "Nego_Left/Nego_List/Nego_Friend/SrlC_Friend"
FriendListPath[GameEnum.FriendGroup.Stranger] = "Nego_Left/Nego_List/Nego_Stranger/SrlC_Stranger"
FriendListPath[GameEnum.FriendGroup.Blacklist] = "Nego_Left/Nego_List/Nego_Blacklist/SrlC_Blacklist"
FriendListPath[GameEnum.FriendGroup.Msg] = "Nego_Left/MsgList/SrlC_Msg"

function FriendListView:ctor()
	FriendListView.super.ctor(self)

	self._views = {}
	self._viewDatas = {}
end

function FriendListView:bindEvents()
	self._Btn_Friend:AddClickListener(function()
		self:_onClickListBtn(GameEnum.FriendGroup.Friend)
	end)
	self._Btn_Stranger:AddClickListener(function()
		self:_onClickListBtn(GameEnum.FriendGroup.Stranger)
	end)
	self._Btn_Blacklist:AddClickListener(function()
		self:_onClickListBtn(GameEnum.FriendGroup.Blacklist)
	end)
	self._clearBtn:AddClickListener(self._onClickClear, self)
	self._searchText:AddOnValueChanged(self._onClickSearch, self)
	self._btnFriendTab:AddClickListener(function()
		self:_changeTab(false)
	end, self)
	self._btnMsgTab:AddClickListener(function()
		self:_changeTab(true)
	end, self)
end

function FriendListView:unbindEvents()
	self._Btn_Friend:RemoveClickListener()
	self._Btn_Stranger:RemoveClickListener()
	self._Btn_Blacklist:RemoveClickListener()
	self._clearBtn:RemoveClickListener()
	self._btnFriendTab:RemoveClickListener()
	self._btnMsgTab:RemoveClickListener()
	self._searchText:RemoveOnValueChanged()
end

function FriendListView:buildUI()
	self._Btn_Friend = self:getBtn("Nego_Left/Nego_List/Nego_Friend/Btn_Friend")
	self._Btn_Stranger = self:getBtn("Nego_Left/Nego_List/Nego_Stranger/Btn_Stranger")
	self._Btn_Blacklist = self:getBtn("Nego_Left/Nego_List/Nego_Blacklist/Btn_Blacklist")
	self._TxtC_Count_Friend = goutil.findChildComponent(self._Btn_Friend, "TxtC_Count", "Text")
	self._TxtC_Count_Stranger = goutil.findChildComponent(self._Btn_Stranger, "TxtC_Count", "Text")
	self._TxtC_Count_Blacklist = goutil.findChildComponent(self._Btn_Blacklist, "TxtC_Count", "Text")
	self._anim = self.mainGO:GetComponent("Animator")
	self._Nego_FriendEmpty = self:getGo("Nego_Left/Nego_List/Nego_Friend/SrlC_Friend/Nego_Empty")
	self._Nego_StrangerEmpty = self:getGo("Nego_Left/Nego_List/Nego_Stranger/SrlC_Stranger/Nego_Empty")
	self._Nego_BlacklistEmpty = self:getGo("Nego_Left/Nego_List/Nego_Blacklist/SrlC_Blacklist/Nego_Empty")
	self._msgEmpty = self:getGo("Nego_Left/MsgList/SrlC_Msg/SearchEmpty")
	self._searchEmpty = self:getGo("Nego_Left/Nego_List/Nego_Friend/SrlC_Friend/SearchEmpty")
	self._searchText = self:getInput("Nego_Left/InputC_Search")
	self._clearBtn = self:getBtn("Nego_Left/InputC_Search/BtnClear")
	self._btnFriendTab = self:getBtn("Nego_Left/BtnFriend")
	self._btnMsgTab = self:getBtn("Nego_Left/BtnMsg")
	self._oriFrdText = self:getGo("Nego_Left/BtnFriend/Txt"):GetComponent("Text")
	self._oriMsgText = self:getGo("Nego_Left/BtnMsg/Txt"):GetComponent("Text")
	self._frdImg = self._btnFriendTab.gameObject:GetComponent("UIImageSpriteChange")
	self._msgImg = self._btnMsgTab.gameObject:GetComponent("UIImageSpriteChange")
	self._msgRedObj = self:getGo("Nego_Left/BtnMsg/ImgRedDot")
	self._frdRedObj = self:getGo("Nego_Left/Nego_List/Nego_Friend/Btn_Friend/ImgRedDot")
	self._stgRedObj = self:getGo("Nego_Left/Nego_List/Nego_Stranger/Btn_Stranger/ImgRedDot")
	self._msgRedTxt = goutil.findChildTextComponent(self._msgRedObj, "TxtRed")
	self._frdRedTxt = goutil.findChildTextComponent(self._frdRedObj, "TxtRed")
	self._stgRedTxt = goutil.findChildTextComponent(self._stgRedObj, "TxtRed")
	self._friendTabGo = self:getGo("Nego_Left/Nego_List")
	self._msgTabGo = self:getGo("Nego_Left/MsgList")

	self:buildListUI()

	self._anim.enabled = false
end

function FriendListView:buildListUI()
	self._tableCell = self:getGo("Nego_Left/Nego_List/Cell")

	for k, v in pairs(FriendListPath) do
		local tableView = self:getGo(v):GetComponent("UITableview")

		local function numInView()
			return self:_numInView(k)
		end

		local function cellAtIndex(target, view, idx)
			return self:_cellAtIndex(k, view, idx)
		end

		local function onReloadFinish()
			self:_onReloadFinish(k)
		end

		local function updateCell(target, view, cell)
			return self:_updateCell(k, view, cell)
		end

		tableView:RegisterCallback(numInView, self._cellSize, cellAtIndex, self)
		tableView:RegisterReloadFinishCallback(onReloadFinish, self)
		tableView:RegisterUpdateCellCallback(updateCell)
		tableView:SetOffsetWithoutRefresh(0)
		table.insert(self._views, tableView)
	end

	self._tableCell:SetActive(false)
end

function FriendListView:_numInView(group)
	return (self._viewDatas[group] or nil) and (#self._viewDatas[group] or 0)
end

function FriendListView:_cellSize()
	return 3200, 80
end

function FriendListView:_cellAtIndex(group, view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)
	cell.index = idx

	self:_updateCell(group, view, cell)

	return cell
end

function FriendListView:_updateCell(group, view, cell)
	local container = cell.gameObject
	local uiIconChange = goutil.findChildComponent(container, "Head", "UIImageSpriteChange")
	local uiHeartChange = goutil.findChildComponent(container, "imgHeart", "UIImageSpriteChange")
	local txtLevel = goutil.findChildTextComponent(container, "level/txtLevel")
	local txtPower = goutil.findChildTextComponent(container, "power/txtPower")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local txtOnline = goutil.findChildTextComponent(container, "txtOnline")
	local selected = goutil.findChild(container, "selected")

	return cell
end

function FriendListView:_onReloadFinish(group)
	return
end

function FriendListView:destroyUI()
	return
end

function FriendListView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.MsgRead, self._refreshDot, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMsgAdd, self._refreshDot, self)
	FriendController.instance:registerLocalNotify("SelectedIdChange", self._onSelectedIdChange, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendAdd, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListRemove, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListAdd, self._refresh, self)
	self:_refresh()
	self:_changeTab(false)
end

function FriendListView:onEnterFinished()
	return
end

function FriendListView:onExit()
	self._anim.enabled = false
	self._lastFrdTabGroup = nil

	GlobalDispatcher:removeListener(GlobalNotify.MsgRead, self._refreshDot, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMsgAdd, self._refreshDot, self)
	FriendController.instance:unregisterLocalNotify("SelectedIdChange", self._onSelectedIdChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendRemove, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendAdd, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.BlackListRemove, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.BlackListAdd, self._refresh, self)
end

function FriendListView:onExitFinished()
	return
end

function FriendListView:_onClickClear()
	self._searchText:SetText("")
	self:_refresh()
end

function FriendListView:_onClickSearch()
	self:_refresh()
end

function FriendListView:_onClickListBtn(group)
	self._anim.enabled = true

	if group == FriendController.instance:getSelectedGroup() then
		self._anim:SetInteger("state", -1)
		FriendController.instance:setSelectedGroup(-1)

		return
	end

	self._anim:SetInteger("state", group - 1)
	FriendController.instance:setSelectedGroup(group)
	self:_updateList(group, true)
end

function FriendListView:_refresh()
	self:_updateText()
	self:_updateList(FriendController.instance:getSelectedGroup())
	self:_refreshDot()
end

function FriendListView:_refreshDot()
	self:_procRedDot(self._msgRedObj, self._msgRedTxt, GameEnum.FriendGroup.Msg)
	self:_procRedDot(self._frdRedObj, self._frdRedTxt, GameEnum.FriendGroup.Friend)
	self:_procRedDot(self._stgRedObj, self._stgRedTxt, GameEnum.FriendGroup.Stranger)
end

function FriendListView:_procRedDot(obj, txt, group)
	local msgCount = FriendModel.instance:getGroupUnreadMsgCnt(group)

	obj:SetActive(msgCount > 0)

	txt.text = msgCount
end

function FriendListView:_updateText()
	local group = GameEnum.FriendGroup.Friend

	self._TxtC_Count_Friend.text = string.format("%d/%d", FriendModel.instance:getGroupCellNums(group), FriendConfig.instance:GetMaxCount(group))
	group = GameEnum.FriendGroup.Stranger
	self._TxtC_Count_Stranger.text = string.format("%d/%d", FriendModel.instance:getGroupCellNums(GameEnum.FriendGroup.Stranger), FriendConfig.instance:GetMaxCount(GameEnum.FriendGroup.Stranger))
	group = GameEnum.FriendGroup.Blacklist
	self._TxtC_Count_Blacklist.text = string.format("%d/%d", FriendModel.instance:getGroupCellNums(GameEnum.FriendGroup.Blacklist), FriendConfig.instance:GetMaxCount(GameEnum.FriendGroup.Blacklist))
end

function FriendListView:_searchFilter(friendMo)
	if not string.nilorempty(self._searchText:GetText()) then
		local str = StringUtil.RelpaceEscapeChar(self._searchText:GetText())
		local count = string.find(friendMo:getValue("name"), str)

		if not count then
			return false
		end
	end

	return true
end

function FriendListView:_updateList(group, skipAnim)
	if group == nil or group <= 0 then
		return
	end

	if not skipAnim then
		self._anim.enabled = true

		self._anim:SetInteger("state", group - 1)
	end

	self._Nego_FriendEmpty:SetActive(false)
	self._Nego_StrangerEmpty:SetActive(false)
	self._Nego_BlacklistEmpty:SetActive(false)

	local ori = FriendModel.instance:getGroupDatas(group)

	if group == GameEnum.FriendGroup.Friend or group == GameEnum.FriendGroup.Msg then
		local tab = {}

		for i, v in ipairs(ori) do
			if self:_searchFilter(v) then
				table.insert(tab, v)
			end
		end

		self._viewDatas[group] = tab

		self._Nego_FriendEmpty:SetActive(#ori == 0)
		self._searchEmpty:SetActive(#tab == 0 and #ori ~= 0)
		self._msgEmpty:SetActive(#tab == 0)
	elseif group == GameEnum.FriendGroup.Stranger then
		self._viewDatas[group] = ori

		self._Nego_StrangerEmpty:SetActive(#ori == 0)
	elseif group == GameEnum.FriendGroup.Blacklist then
		self._viewDatas[group] = ori

		self._Nego_BlacklistEmpty:SetActive(#ori == 0)
	else
		self._viewDatas[group] = ori
	end

	table.sort(self._viewDatas[group], FriendModel.instance:getSortFunc(group))
	self._views[group]:ReloadData()
end

function FriendListView:_onSelectedIdChange(preId)
	self:_updateCellById(preId)
	self:_updateCellById(FriendController.instance:getCurSelectedId())
	self:_refreshDot()
	self:_updateText()
end

function FriendListView:_updateCellById(id)
	if not id or checknumber(id) <= 0 then
		return
	end

	local mo = FriendModel.instance:getFriendMo(id)

	if not mo then
		return
	end

	local group = mo:getValue("groupType")

	if FriendController.instance:getSelectedGroup() == GameEnum.FriendGroup.Msg then
		for k, v in ipairs(self._viewDatas[GameEnum.FriendGroup.Msg] or {}) do
			if v:getValue("id") == id then
				self._views[GameEnum.FriendGroup.Msg]:UpdateCellAtIndex(k - 1)
			end
		end
	end

	if group ~= FriendController.instance:getSelectedGroup() then
		return
	end

	if not self._viewDatas[group] then
		local datas = {}

		for k, v in ipairs(datas) do
			if v:getValue("id") == id then
				self._views[group]:UpdateCellAtIndex(k - 1)
			end
		end
	end
end

function FriendListView:sortStrangers(a, b)
	return
end

function FriendListView:sortBlackLists(a, b)
	return
end

function FriendListView:_changeTab(isMsg)
	self._isMsg = isMsg

	self._msgTabGo:SetActive(isMsg)
	self._friendTabGo:SetActive(not isMsg)

	if isMsg then
		self._oriFrdText.color = Framework.ColorUtil.ParseColor("#5B698A")
		self._oriMsgText.color = Color.white

		self._frdImg:ChangeStateNow(1)
		self._msgImg:ChangeStateNow(0)

		self._lastFrdTabGroup = FriendController.instance:getSelectedGroup()

		self:_onClickListBtn(GameEnum.FriendGroup.Msg)
	else
		if self._lastFrdTabGroup then
			self:_onClickListBtn(self._lastFrdTabGroup)
		end

		self._oriFrdText.color = Color.white
		self._oriMsgText.color = Framework.ColorUtil.ParseColor("#5B698A")

		self._frdImg:ChangeStateNow(0)
		self._msgImg:ChangeStateNow(1)
	end
end

return FriendListView
