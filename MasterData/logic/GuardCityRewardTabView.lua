-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardTabView.lua

module("logic.extensions.guardcity.view.GuardCityRewardTabView", package.seeall)

local GuardCityRewardTabView = class("GuardCityRewardTabView", ViewComponent)

GuardCityRewardTabView.TabName = {
	"好友积分",
	"积分",
	"战报"
}

function GuardCityRewardTabView:ctor()
	GuardCityRewardTabView.super.ctor(self)
end

function GuardCityRewardTabView:buildUI()
	GuardCityRewardTabView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._container = self:getGo("container")
	self._tableview = self:getGo("tabscrollview")
	self._tableCell = self:getGo("tabcell")
	self._btnOneKey = self:getBtn("btnOneKey")
end

function GuardCityRewardTabView:bindEvents()
	GuardCityRewardTabView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function GuardCityRewardTabView:unbindEvents()
	GuardCityRewardTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function GuardCityRewardTabView:onEnter()
	GuardCityRewardTabView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshView, self)

	self._tabScroll = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tabScroll:getView():RegisterReloadFinishCallback(self._listReloadFinish, self)

	self._firstEnter = true

	self:_refreshView()

	self._activityId = self:getFirstParam()
end

function GuardCityRewardTabView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshView, self)
	GuardCityRewardTabView.super.onExit(self)
	self._tabScroll:dispose()
end

function GuardCityRewardTabView:_refreshView()
	local list = {
		1,
		2,
		3
	}

	self._tabScroll:reloadData(list)
end

function GuardCityRewardTabView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local changeGroup = goutil.findChildComponent(go, "bg", "UIChangeGroup")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local redPoint = goutil.findChild(go, "redpoint")

	txtName.text = lang(GuardCityRewardTabView.TabName[data])

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
		GameUtil.SetActive(redPoint, GuardCiytModel.instance:haveFriendScorePrize() == true)
	elseif data == 2 then
		GameUtil.SetActive(redPoint, #GuardCiytModel.instance:getRewardScoreInfo() > 0)
	elseif data == 3 then
		GameUtil.SetActive(redPoint, false)
	end
end

function GuardCityRewardTabView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))

	btn:RemoveClickListener()
end

function GuardCityRewardTabView:_onClickTab(index)
	self:_changeTab(index)
end

function GuardCityRewardTabView:_changeTab(index)
	self._curIndex = index

	if self._curIndex == 1 then
		self:showTabAt(self._container, ViewName.GuardCityRewardFriendView, self._activityId)
		GameUtil.SetActive(self._btnOneKey, true)
	elseif self._curIndex == 2 then
		self:showTabAt(self._container, ViewName.GuardCityRewardScoreView, self._activityId)
		GameUtil.SetActive(self._btnOneKey, true)
	elseif self._curIndex == 3 then
		self:showTabAt(self._container, ViewName.GuardCityRewardReportView, self._activityId)
		GameUtil.SetActive(self._btnOneKey, false)
	end

	self._tabScroll:reloadData({
		1,
		2,
		3
	})
end

function GuardCityRewardTabView:_listReloadFinish()
	if self._firstEnter == true then
		self._firstEnter = false

		self:_onClickTab(1)
	end
end

function GuardCityRewardTabView:_onClickOneKey()
	GlobalDispatcher:dispatch(GlobalNotify.GuardCityRewardRecvieAll, self._curIndex)
end

return GuardCityRewardTabView
