-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressMainTabView.lua

module("logic.extensions.groupregress.view.GroupRegressMainTabView", package.seeall)

local GroupRegressMainTabView = class("GroupRegressMainTabView", ViewComponent)

GroupRegressMainTabView.TabIndex = {
	Invite = 2,
	Shop = 3,
	Team = 1
}

function GroupRegressMainTabView:buildUI()
	GroupRegressMainTabView.super.buildUI(self)

	self._contentCol = self:getGo("bg")

	local scrView = self:getGo("tabCol/scrView")
	local scrCell = self:getGo("tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function GroupRegressMainTabView:bindEvents()
	GroupRegressMainTabView.super.bindEvents(self)
end

function GroupRegressMainTabView:unbindEvents()
	GroupRegressMainTabView.super.unbindEvents(self)
end

function GroupRegressMainTabView:onEnter()
	GroupRegressMainTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = GroupRegressController.instance:getActivityId()
	end

	local bindInviteOpenContext = GroupRegressController.instance:getBindInviteOpenContext(self._activityId)

	self._subMo = GroupRegressController.instance:getSubMo(self._activityId)

	if bindInviteOpenContext then
		self._curTabIndex = GroupRegressMainTabView.TabIndex.Invite
	elseif self._lastActivityId ~= self._activityId or checknumber(self._curTabIndex) <= 0 then
		self._curTabIndex = GroupRegressMainTabView.TabIndex.Team
	end

	self._lastActivityId = self._activityId

	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetInfoRes, self._onHandleGetInfoRes, self)
	self:_refreshTabDataList()
	self:_showCurTab()
	GroupRegressController.instance:sendPM_GroupRegressGetInfoReq(self._activityId)
end

function GroupRegressMainTabView:onExit()
	GroupRegressMainTabView.super.onExit(self)
	self:showTabAt(self._contentCol, "")
	self._tabScrollList:dispose()
end

function GroupRegressMainTabView:_buildTabDataList()
	return {
		{
			name = "我的邀约",
			index = GroupRegressMainTabView.TabIndex.Team,
			viewName = ViewName.GroupRegressTeamView,
			redPointIds = {}
		},
		{
			name = "绑定邀约",
			index = GroupRegressMainTabView.TabIndex.Invite,
			viewName = self:_getInviteTabViewName(),
			redPointIds = {}
		},
		{
			name = "兑换奖励",
			index = GroupRegressMainTabView.TabIndex.Shop,
			viewName = ViewName.ActivityshopexchangetabView,
			redPointIds = {}
		}
	}
end

function GroupRegressMainTabView:_getInviteTabViewName()
	if self:_isJoinedOtherTeam() then
		return ViewName.GroupRegressTeamOtherView
	end

	return ViewName.GroupRegressInviteView
end

function GroupRegressMainTabView:_isJoinedOtherTeam()
	local bindCode = self._subMo:getBindCode()
	local bindPlayerId = self._subMo:getBindPlayerId()

	return not string.nilorempty(bindCode) or not string.nilorempty(bindPlayerId) and bindPlayerId ~= "0"
end

function GroupRegressMainTabView:_refreshTabDataList()
	if self._tabDataList then
		local preTabData = self._tabDataList[self._curTabIndex]
		local preViewName = preTabData and preTabData.viewName

		self._tabDataList = self:_buildTabDataList()

		self._tabScrollList:reloadData(self._tabDataList)

		local curTabData = self._tabDataList[self._curTabIndex]

		if preViewName and curTabData and preViewName ~= curTabData.viewName then
			self:_showCurTab()
		end
	end
end

function GroupRegressMainTabView:_onHandleGetInfoRes()
	self:_refreshTabDataList()
end

function GroupRegressMainTabView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local isSelected = self._curTabIndex == data.index

	txtName.text = data.name

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.SetActive(redPoint, false)

	if #data.redPointIds > 0 then
		RedPointController.instance:regRedPoint(redPoint, GameUtil.unpack10(data.redPointIds))
	end

	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data.index))
end

function GroupRegressMainTabView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function GroupRegressMainTabView:_onClickTab(tabIndex)
	if self._curTabIndex == tabIndex then
		return
	end

	self._curTabIndex = tabIndex

	self._tabScrollList:reloadData(self._tabDataList)
	self:_showCurTab()
end

function GroupRegressMainTabView:_showCurTab()
	if not self._tabDataList[self._curTabIndex] then
		if self._tabDataList[self._curTabIndex] == nil then
			return
		end

		self._curTabIndex = self._tabDataList[self._curTabIndex].index

		self:showTabAt(self._contentCol, self._tabDataList[self._curTabIndex].viewName, self._activityId)
	end
end

return GroupRegressMainTabView
