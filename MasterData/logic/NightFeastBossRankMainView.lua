-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankMainView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankMainView", package.seeall)

local NightFeastBossRankMainView = class("NightFeastBossRankMainView", ViewComponent)

function NightFeastBossRankMainView:ctor()
	NightFeastBossRankMainView.super.ctor(self)
end

function NightFeastBossRankMainView:unbindEvents()
	NightFeastBossRankMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NightFeastBossRankMainView:bindEvents()
	NightFeastBossRankMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NightFeastBossRankMainView:buildUI()
	NightFeastBossRankMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())
end

function NightFeastBossRankMainView:onExit()
	NightFeastBossRankMainView.super.onExit(self)
end

function NightFeastBossRankMainView:onEnter()
	NightFeastBossRankMainView.super.onEnter(self)

	local param = self:getOpenParam()

	self._tabFrameWorkShow:jumpTab((param and param[1] or nil) and checknumber(param[1]))
end

function NightFeastBossRankMainView:_getFrameId()
	return 22
end

return NightFeastBossRankMainView
