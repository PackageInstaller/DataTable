-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKRankMainView.lua

module("logic.extensions.teenchampionking.view.TCKRankMainView", package.seeall)

local TCKRankMainView = class("TCKRankMainView", ViewComponent)

function TCKRankMainView:ctor()
	TCKRankMainView.super.ctor(self)
end

function TCKRankMainView:unbindEvents()
	TCKRankMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TCKRankMainView:bindEvents()
	TCKRankMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TCKRankMainView:buildUI()
	TCKRankMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())
end

function TCKRankMainView:onExit()
	TCKRankMainView.super.onExit(self)
end

function TCKRankMainView:onEnter()
	TCKRankMainView.super.onEnter(self)

	local param = self:getOpenParam()
	local rootId = checknumber(param and param[1])
	local leaveId = checknumber(param and param[2])

	if rootId > 0 and leaveId > 0 then
		self._tabFrameWorkShow:jumpTab(rootId, leaveId)
	elseif rootId > 0 then
		self._tabFrameWorkShow:jumpTab(rootId, 1)
	else
		self._tabFrameWorkShow:jumpTab()
	end
end

function TCKRankMainView:_getFrameId()
	return 18
end

return TCKRankMainView
