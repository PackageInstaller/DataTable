-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/FmtPopupView.lua

module("logic.extensions.recommendfmt.view.FmtPopupView", package.seeall)

local FmtPopupView = class("FmtPopupView", ViewComponent)

function FmtPopupView:ctor()
	FmtPopupView.super.ctor(self)
end

function FmtPopupView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btn:AddClickListener(self._onClickGo, self)
end

function FmtPopupView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btn:RemoveClickListener()
end

function FmtPopupView:buildUI()
	self._closeButton = self:getBtn("main/btnClose")
	self._btn = self:getBtn("main/Btn")
end

function FmtPopupView:onEnter()
	if ViewMgr.instance:isOpen(ViewName.formationpopupmenu) then
		ViewMgr.instance:close(ViewName.formationpopupmenu)
	end
end

function FmtPopupView:onExit()
	return
end

function FmtPopupView:_onClickClose()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
end

function FmtPopupView:_onClickGo()
	PetsHandbookFacade.instance:getDefaultWays(10030)
	self:_onClickClose()

	if ViewMgr.instance:isOpen(ViewName.formationpopupmenu) then
		ViewMgr.instance:close(ViewName.formationpopupmenu)
	end
end

return FmtPopupView
