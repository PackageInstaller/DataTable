-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleRankMainView.lua

module("logic.extensions.starbattle.view.StarBattleRankMainView", package.seeall)

local StarBattleRankMainView = class("StarBattleRankMainView", ViewComponent)

function StarBattleRankMainView:ctor()
	StarBattleRankMainView.super.ctor(self)
end

function StarBattleRankMainView:unbindEvents()
	StarBattleRankMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StarBattleRankMainView:bindEvents()
	StarBattleRankMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StarBattleRankMainView:buildUI()
	StarBattleRankMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())
end

function StarBattleRankMainView:onExit()
	StarBattleRankMainView.super.onExit(self)
end

function StarBattleRankMainView:onEnter()
	StarBattleRankMainView.super.onEnter(self)

	local param = self:getOpenParam()

	self._tabFrameWorkShow:jumpTab((param and param[1] or nil) and checknumber(param[1]))
end

function StarBattleRankMainView:_getFrameId()
	return 21
end

return StarBattleRankMainView
