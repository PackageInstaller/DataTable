-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoInviteView.lua

module("logic.extensions.pindaodao.view.PinDaoDaoInviteView", package.seeall)

local PinDaoDaoInviteView = class("PinDaoDaoInviteView", ViewComponent)

function PinDaoDaoInviteView:ctor()
	PinDaoDaoInviteView.super.ctor(self)
end

function PinDaoDaoInviteView:unbindEvents()
	PinDaoDaoInviteView.super.unbindEvents(self)
	self._btnSend:RemoveClickListener()
	self._btnBack:RemoveClickListener()
end

function PinDaoDaoInviteView:bindEvents()
	PinDaoDaoInviteView.super.bindEvents(self)
	self._btnSend:AddClickListener(self._sendOnClick, self)
	self._btnBack:AddClickListener(self.close, self)
end

function PinDaoDaoInviteView:buildUI()
	PinDaoDaoInviteView.super.buildUI(self)

	self._btnSend = self:getBtn("btnSend")
	self._btnBack = self:getBtn("btnBack")
	self._emptyTips = self:getGo("emptyTips")
	self._tabCell = self:getGo("cell")
	self._tabView = self:getGo("srlC_Search")
	self._friendTab = ScrollerList.create(self._tabView, self._tabCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PinDaoDaoInviteView:onExit()
	PinDaoDaoInviteView.super.onExit(self)
	self._friendTab:dispose()
end

function PinDaoDaoInviteView:onEnter()
	PinDaoDaoInviteView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FriendInfoGeted, self._onFriendInfoGeted, self)
	FriendAgent.instance:sendGetBuddyInfoReq()

	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])
	self._goodsId = checknumber(param[2])

	if checknumber(self._activityId) <= 0 then
		self._activityId = 565001
	end

	if checknumber(self._goodsId) <= 0 then
		self._goodsId = 1
	end
end

function PinDaoDaoInviteView:_onFriendInfoGeted()
	self._curDataList = {}
	self._invitedMap = {}

	local mos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	for k, v in ipairs(mos) do
		table.insert(self._curDataList, v)
	end

	ArraySort.sortOn(self._curDataList, {
		function(a)
			if a:getIsOnline() then
				return 1
			else
				return 0
			end
		end,
		function(a)
			return a:getCurFetter()
		end
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})
	self._friendTab:reloadData(self._curDataList)
	goutil.setActive(self._emptyTips, #self._curDataList == 0)
end

function PinDaoDaoInviteView:_sendOnClick()
	local invitedList = {}

	for userId, _ in pairs(self._invitedMap) do
		table.insert(invitedList, userId)
	end

	if #invitedList == 0 then
		FloatWordMgr.instance:show("请先选择好友")

		return
	end

	PinDaoDaoController.instance:sendHelpInfo(self._activityId, invitedList, self._goodsId)
	self:close()
end

function PinDaoDaoInviteView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "imgC_Icon")
	local btnToggle = goutil.findChild(cell, "btnToggle")
	local toggle = goutil.findChild(cell, "btnToggle/toggle"):GetComponent("Toggle")
	local online = goutil.findChild(cell, "online")
	local offline = goutil.findChild(cell, "offline")
	local txtAera = goutil.findChildTextComponent(cell, "arean/txtAera")
	local txtName = goutil.findChildTextComponent(cell, "txtC_Name")
	local isSelect = self._invitedMap[data.headInfo.userId] ~= nil

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtAera.text = data.headInfo.areaName

	goutil.setActive(online, data:getIsOnline())
	goutil.setActive(offline, not data:getIsOnline())

	toggle.isOn = isSelect

	GameUtil.addClickHandler(btnToggle, function()
		if isSelect then
			self._invitedMap[data.headInfo.userId] = nil
		else
			self._invitedMap[data.headInfo.userId] = true
		end

		self._friendTab:reloadData(self._curDataList)
	end)
end

function PinDaoDaoInviteView:_clearCell(cell)
	local btnToggle = goutil.findChild(cell, "btnToggle")

	GameUtil.rmClickHandler(btnToggle)

	local head = goutil.findChild(cell, "imgC_Icon")

	HeadItemController.instance:resetHeadCell(head)
end

return PinDaoDaoInviteView
