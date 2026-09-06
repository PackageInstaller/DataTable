-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupRankView.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupRankView", package.seeall)

local WeeklyGroupRankView = class("WeeklyGroupRankView", ViewComponent)

function WeeklyGroupRankView:ctor()
	WeeklyGroupRankView.super.ctor(self)
end

function WeeklyGroupRankView:unbindEvents()
	WeeklyGroupRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnPerson)
end

function WeeklyGroupRankView:bindEvents()
	WeeklyGroupRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnPerson, self._onClickPerson, self)
end

function WeeklyGroupRankView:buildUI()
	WeeklyGroupRankView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTeam = self:getBtn("tab/btnTeam")
	self._btnPerson = self:getBtn("tab/btnPerson")
	self._teamChange = self._btnTeam.gameObject:GetComponent(typeof(UIChangeGroup))
	self._personChange = self._btnPerson.gameObject:GetComponent(typeof(UIChangeGroup))
	self._container = self:getGo("container")
end

function WeeklyGroupRankView:onExit()
	WeeklyGroupRankView.super.onExit(self)
end

function WeeklyGroupRankView:onEnter()
	WeeklyGroupRankView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.WeeklyGroup, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	self:_onClickTeam()
end

function WeeklyGroupRankView:_onClickTeam()
	self._personChange:SetState(0)
	self._teamChange:SetState(1)
	self:showTabAt(self._container, ViewName.WeeklyGroupTeamRankView)
end

function WeeklyGroupRankView:_onClickPerson()
	self._personChange:SetState(1)
	self._teamChange:SetState(0)
	self:showTabAt(self._container, ViewName.WeeklyGroupPersonRankView)
end

return WeeklyGroupRankView
