-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardTabView.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardTabView", package.seeall)

local DestroyEvilRewardTabView = class("DestroyEvilRewardTabView", ViewComponent)

DestroyEvilRewardTabView.TabName = {
	[1] = "好友积分",
	[2] = "战报"
}

function DestroyEvilRewardTabView:ctor()
	DestroyEvilRewardTabView.super.ctor(self)
end

function DestroyEvilRewardTabView:buildUI()
	DestroyEvilRewardTabView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._container = self:getGo("container")
	self._tableview = self:getGo("tabscrollview")
	self._tableCell = self:getGo("tabcell")
	self._btnOneKey = self:getBtn("btnOneKey")
end

function DestroyEvilRewardTabView:bindEvents()
	DestroyEvilRewardTabView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function DestroyEvilRewardTabView:unbindEvents()
	DestroyEvilRewardTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function DestroyEvilRewardTabView:onEnter()
	DestroyEvilRewardTabView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self._refreshView, self)

	self._tabScroll = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tabScroll:getView():RegisterReloadFinishCallback(self._listReloadFinish, self)

	self._firstEnter = true

	self:_refreshView()

	self._activityId = self:getFirstParam()
end

function DestroyEvilRewardTabView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self._refreshView, self)
	DestroyEvilRewardTabView.super.onExit(self)
	self._tabScroll:dispose()
end

function DestroyEvilRewardTabView:_refreshView()
	local list = {
		1,
		2
	}

	self._tabScroll:reloadData(list)
end

function DestroyEvilRewardTabView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local changeGroup = goutil.findChildComponent(go, "bg", "UIChangeGroup")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local redPoint = goutil.findChild(go, "redpoint")

	txtName.text = lang(DestroyEvilRewardTabView.TabName[data])

	if data == checknumber(self._curIndex) then
		changeGroup:SetState(1)
	else
		changeGroup:SetState(0)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickTab(data)
	end)

	if data == 1 then
		GameUtil.SetActive(redPoint, DestroyEvilModel.instance:haveFriendScorePrize() == true)
	elseif data == 2 then
		GameUtil.SetActive(redPoint, false)
	end
end

function DestroyEvilRewardTabView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))

	btn:RemoveClickListener()
end

function DestroyEvilRewardTabView:_onClickTab(index)
	self:_changeTab(index)
end

function DestroyEvilRewardTabView:_changeTab(index)
	self._curIndex = index

	if self._curIndex == 1 then
		self:showTabAt(self._container, ViewName.DestroyEvilRewardFriendView, self._activityId)
		GameUtil.SetActive(self._btnOneKey, true)
	elseif self._curIndex == 2 then
		self:showTabAt(self._container, ViewName.DestroyEvilRewardReportView, self._activityId)
		GameUtil.SetActive(self._btnOneKey, false)
	end

	self._tabScroll:reloadData({
		1,
		2
	})
end

function DestroyEvilRewardTabView:_listReloadFinish()
	if self._firstEnter == true then
		self._firstEnter = false

		self:_onClickTab(1)
	end
end

function DestroyEvilRewardTabView:_onClickOneKey()
	GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilRewardRecvieAll, self._curIndex)
end

return DestroyEvilRewardTabView
