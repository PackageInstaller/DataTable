-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessHandbookLeaderItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessHandbookLeaderItem", package.seeall)

local AutoChessHandbookLeaderItem = class("AutoChessHandbookLeaderItem", ListScrollCell)

function AutoChessHandbookLeaderItem:init(go)
	self.go = go
	self.leaderCard = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderCard)

	local anim = gohelper.findComponentAnim(go)

	anim.enabled = false
end

function AutoChessHandbookLeaderItem:initInternal(go, view)
	AutoChessHandbookLeaderItem.super.initInternal(self, go, view)

	local scroll = gohelper.findChildComponent(go, "#go_Scroll", gohelper.Type_LimitedScrollRect)

	scroll.parentGameObject = gohelper.findChild(self._view.viewGO, "#scroll_Leader")
end

function AutoChessHandbookLeaderItem:onUpdateMO(mo)
	self.leaderCard:setData(mo)
end

return AutoChessHandbookLeaderItem
