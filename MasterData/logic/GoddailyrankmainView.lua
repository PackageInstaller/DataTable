-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailyrankmainView.lua

module("logic.extensions.goddailyrank.view.GoddailyrankmainView", package.seeall)

local GoddailyrankmainView = class("GoddailyrankmainView", ViewComponent)

function GoddailyrankmainView:ctor()
	GoddailyrankmainView.super.ctor(self)
end

function GoddailyrankmainView:unbindEvents()
	GoddailyrankmainView.super.unbindEvents(self)
end

function GoddailyrankmainView:bindEvents()
	GoddailyrankmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddailyrankmainView:buildUI()
	GoddailyrankmainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._container = self:getGo("container")
	self._rootcell = self:getGo("tablist/rootcell")
	self._leafcell = self:getGo("tablist/leafcell")
	self._tablist = self:getGo("tablist")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._container, self._tablist, self:_getFrameId(), GameUtil.handler(self._getParams, self))

	self._tabFrameWorkShow:setShowByExCondAsHeadTabCallBack(GameUtil.handler(self._setShowByExCondAsHeadTabCallBack, self))
end

function GoddailyrankmainView:onExit()
	GoddailyrankmainView.super.onExit(self)
end

function GoddailyrankmainView:onEnter()
	GoddailyrankmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local params = self:getOpenParam() or {}

	self._frameId = checknumber(params[2])

	if self._frameId == 0 then
		self._frameId = 26
	end

	self._tabFrameWorkShow:initTabViewWithFrameId(self._frameId)
	self._tabFrameWorkShow:jumpTab()
end

function GoddailyrankmainView:_getFrameId()
	return 0
end

function GoddailyrankmainView:_getParams(data)
	return self._activityId
end

function GoddailyrankmainView:_setShowByExCondAsHeadTabCallBack(headTabId)
	if headTabId == 2 then
		local config = GodDailyRankConfig.instance:getRankCfgById(self._activityId)

		if config then
			return GameUtil.checkIsInTimePeriod(config.dailyRankStartTime, config.dailyRankEndTime)
		end
	end

	return true
end

return GoddailyrankmainView
