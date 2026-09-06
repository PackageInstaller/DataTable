-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/FriendBargainView.lua

module("logic.extensions.bargain.view.FriendBargainView", package.seeall)

local FriendBargainView = class("FriendBargainView", ViewComponent)

function FriendBargainView:ctor()
	FriendBargainView.super.ctor(self)
end

function FriendBargainView:unbindEvents()
	FriendBargainView.super.unbindEvents(self)
	self._btnSend:RemoveClickListener()
	self._btnBack:RemoveClickListener()
end

function FriendBargainView:bindEvents()
	FriendBargainView.super.bindEvents(self)
	self._btnSend:AddClickListener(self._sendOnClick, self)
	self._btnBack:AddClickListener(self.close, self)
end

function FriendBargainView:onExit()
	FriendBargainView.super.onExit(self)
	self._friendTab:dispose()
end

function FriendBargainView:buildUI()
	FriendBargainView.super.buildUI(self)

	self._btnSend = self:getBtn("btnSend")
	self._btnBack = self:getBtn("btnBack")
	self._emptyTips = self:getGo("emptyTips")
	self._tabCell = self:getGo("cell")
	self._tabView = self:getGo("srlC_Search")
	self._friendTab = ScrollerList.create(self._tabView, self._tabCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FriendBargainView:onEnter()
	FriendBargainView.super.onEnter(self)

	self._goodsId = self:getFirstParam()
	self._activityId = BargainModel.instance:getActivityId()
	self._friendInfo = BargainModel.instance:getFriendInfo()
	self._friendList = {}

	self._friendTab:reloadData(self._friendInfo)
	goutil.setActive(self._emptyTips, #self._friendInfo <= 0)
end

function FriendBargainView:_sendOnClick()
	if #self._friendList > 0 then
		FriendBargainAgent.instance:sendPM_FriendBargainChatReq(self._activityId, self._friendList, self._goodsId)
		self:close()
	else
		FloatWordMgr.instance:show("请先选择好友")
	end
end

function FriendBargainView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "imgC_Icon")
	local btnToggle = goutil.findChild(cell, "btnToggle")
	local toggle = goutil.findChild(cell, "btnToggle/toggle"):GetComponent("Toggle")
	local online = goutil.findChild(cell, "online")
	local offline = goutil.findChild(cell, "offline")
	local txtAera = goutil.findChildTextComponent(cell, "arean/txtAera")
	local txtName = goutil.findChildTextComponent(cell, "txtC_Name")
	local idx = table.indexof(self._friendList, data.headInfo.userId)
	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtName.text = data.headInfo.userName
	txtAera.text = data.headInfo.areaName

	goutil.setActive(online, data:getIsOnline())
	goutil.setActive(offline, not data:getIsOnline())

	toggle.isOn = not not idx

	GameUtil.asBtn(btnToggle):RemoveClickListener()
	GameUtil.asBtn(btnToggle):AddClickListener(function()
		local index = table.indexof(self._friendList, data.headInfo.userId)

		if index then
			table.remove(self._friendList, index)

			toggle.isOn = false
		else
			table.insert(self._friendList, data.headInfo.userId)

			toggle.isOn = true
		end
	end)
end

function FriendBargainView:_clearCell(cell)
	local btnToggle = goutil.findChild(cell, "btnToggle")

	GameUtil.asBtn(btnToggle):RemoveClickListener()
end

return FriendBargainView
