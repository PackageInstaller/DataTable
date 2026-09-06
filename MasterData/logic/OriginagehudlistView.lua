-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagehudlistView.lua

module("logic.extensions.originage.view.OriginagehudlistView", package.seeall)

local OriginagehudlistView = class("OriginagehudlistView", ViewComponent)

function OriginagehudlistView:ctor()
	OriginagehudlistView.super.ctor(self)
end

function OriginagehudlistView:unbindEvents()
	OriginagehudlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginagehudlistView:bindEvents()
	OriginagehudlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginagehudlistView:buildUI()
	OriginagehudlistView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist)
end

function OriginagehudlistView:onExit()
	OriginagehudlistView.super.onExit(self)
end

function OriginagehudlistView:onEnter()
	OriginagehudlistView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabIdx = checknumber(params[2])
	self._secTabIdx = checknumber(params[3])

	if self._activityId == 0 then
		self._activityId = OriginAgeController.instance:getDefaultActivityId()
	end

	self._tabFrameWorkShow:initTabViewWithFrameId(self:_getFrameId())

	if self._tabIdx > 0 then
		self._tabFrameWorkShow:jumpTab(self._tabIdx, self._secTabIdx)
	else
		self._tabFrameWorkShow:jumpTab()
	end
end

function OriginagehudlistView:_getFrameId()
	return self._activityId
end

return OriginagehudlistView
