-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessHandbookChessItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessHandbookChessItem", package.seeall)

local AutoChessHandbookChessItem = class("AutoChessHandbookChessItem", ListScrollCell)

function AutoChessHandbookChessItem:init(go)
	self.go = go
	self.chessCard = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCard)

	local anim = gohelper.findComponentAnim(go)

	anim.enabled = false
end

function AutoChessHandbookChessItem:initInternal(go, view)
	AutoChessHandbookChessItem.super.initInternal(self, go, view)

	local scroll = gohelper.findChildComponent(go, "layout/scroll_desc", gohelper.Type_LimitedScrollRect)

	scroll.parentGameObject = gohelper.findChild(self._view.viewGO, "#scroll_book")
end

function AutoChessHandbookChessItem:onUpdateMO(mo)
	self.chessCard:setData(mo)
end

return AutoChessHandbookChessItem
