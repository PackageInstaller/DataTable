-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/FriendSelectView.lua

module("logic.extensions.share.view.FriendSelectView", package.seeall)

local FriendSelectView = class("FriendSelectView", TableViewComponent)

function FriendSelectView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "SrlC_Search"
	}
end

function FriendSelectView:ctor()
	FriendSelectView.super.ctor(self)
end

function FriendSelectView:destroyUI()
	FriendSelectView.super.destroyUI(self)
end

function FriendSelectView:onExitFinished()
	FriendSelectView.super.onExitFinished(self)
end

function FriendSelectView:onEnterFinished()
	FriendSelectView.super.onEnterFinished(self)
end

function FriendSelectView:unbindEvents()
	FriendSelectView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSend:RemoveClickListener()
	self._btnBack:RemoveClickListener()
end

function FriendSelectView:bindEvents()
	FriendSelectView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSend:AddClickListener(self._onClickSend, self)
	self._btnBack:AddClickListener(self._onClickClose, self)
end

function FriendSelectView:onExit()
	FriendSelectView.super.onExit(self)
end

function FriendSelectView:buildUI()
	FriendSelectView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSend = self:getBtn("btnSend")
	self._emptyTips = self:getGo("EmptyTips")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._btnBack = self:getBtn("btnBack")
end

function FriendSelectView:onEnter()
	FriendSelectView.super.onEnter(self)

	self._curViewDatas = {}
	self._openParam = self:getOpenParam() or {}
	self._curViewDatas = self._openParam[1] == GameEnum.ShareType.ShareBoss and FriendModel.instance:getShareFriendsList() or type(self._openParam[1]) == "table" and self._openParam[1] or FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	table.sort(self._curViewDatas, FriendSelectView._sortFriends)

	self._friendIds = {}

	self:reloadData()
	goutil.setActive(self._emptyTips, #self._curViewDatas == 0)

	self._selectedCount = 0
	self._maxCount = checknumber(self._openParam[2])

	if self._openParam[1] == GameEnum.ShareType.GoldendTen then
		self._maxCount = 3
	end

	if self._maxCount <= 0 then
		self._maxCount = FriendConfig.instance:getCommonValue("MAX_BATCH_SEND_TO_BUDDY__CLIENT_COUNT", true)
	end

	self._titleStr = self._openParam[3] or lang("请选择好友进行展示")

	self:_updateTitle()
end

function FriendSelectView._sortFriends(a, b)
	local isOnlineA = a._onlineZoneId > 0
	local isOnlineB = b._onlineZoneId > 0

	if isOnlineA == isOnlineB then
		if isOnlineA then
			if a._zdl ~= b._zdl then
				return checknumber(a._zdl) > checknumber(b._zdl)
			elseif a:getLevel() ~= b:getLevel() then
				return checknumber(a:getLevel()) > checknumber(b:getLevel())
			end
		else
			return checknumber(a:lastOpTime()) > checknumber(b:lastOpTime())
		end
	else
		return isOnlineA
	end
end

function FriendSelectView:_updateCell(view, cell, data)
	local container = cell.gameObject
	local imgIcon = goutil.findChild(container, "ImgC_Icon")
	local txtName = goutil.findChildTextComponent(container, "TxtC_Name")
	local txtPower = goutil.findChildTextComponent(container, "ImgZdl/TxtZdl")
	local btnRemove = Framework.ButtonAdapter.GetFrom(container, "btnRemove")
	local txtLevel = goutil.findChildTextComponent(container, "txtLevel")
	local txtOnline = goutil.findChildTextComponent(container, "txtOnline")
	local txtOnlineChange = txtOnline:GetComponent("UITextColorChange")
	local btnToggle = Framework.ButtonAdapter.GetFrom(container, "btnToggle")

	goutil.setActive(container, true)

	local toggle = Framework.ToggleAdapter.GetFrom(btnToggle.gameObject, "Toggle")

	toggle.isOn = self._friendIds[data._id] == true

	btnToggle:AddClickListener(function()
		self:_onClickToggle(data._id, toggle)
	end)

	txtName.text = data._name

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtPower.text = data._zdl
	txtLevel.text = "Lv." .. data:getLevel()

	if data:getIsOnline() then
		txtOnline.text = "在线"

		txtOnlineChange:SetState(1)
	else
		txtOnline.text = TimeUtil.getLeftTime(data._lastOpTime, true)

		txtOnlineChange:SetState(0)
	end
end

function FriendSelectView:_onClickToggle(friendId, toggle)
	local isOn = self._friendIds[friendId] ~= true

	if isOn and self._selectedCount >= self._maxCount then
		FloatWordMgr.instance:show(string.format("最多选择%s名好友进行发送", self._maxCount))

		return
	end

	local curIsActive = self._friendIds[friendId] == true

	print("friendId = " .. friendId .. " curIsActive = " .. tostring(curIsActive) .. " isOn = " .. tostring(isOn))

	if curIsActive ~= isOn then
		local offset = isOn and 1 or -1

		self._selectedCount = self._selectedCount + offset
	end

	self._friendIds[friendId] = isOn
	toggle.isOn = isOn

	self:_updateTitle()
end

function FriendSelectView:_updateTitle()
	self._txtTitle.text = string.format("%s（%s / %s）", self._titleStr, self._selectedCount, self._maxCount)
end

function FriendSelectView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.FriendSelectedClose)
end

function FriendSelectView:_onClickSend()
	local t = {}

	for k, v in pairs(self._friendIds) do
		if v == true then
			table.insert(t, k)
		end
	end

	if #t == 0 then
		FloatWordMgr.instance:show("选中至少一名好友进行发送")
	else
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.FriendSelected, t)
	end
end

return FriendSelectView
