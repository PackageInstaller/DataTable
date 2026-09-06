-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveEnterView.lua

module("logic.extensions.divineevolve.view.DivineEvolveEnterView", package.seeall)

local DivineEvolveEnterView = class("DivineEvolveEnterView", ViewComponent)

function DivineEvolveEnterView:ctor()
	DivineEvolveEnterView.super.ctor(self)
end

function DivineEvolveEnterView:buildUI()
	DivineEvolveEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnSurePlus = self:getBtn("btnSurePlus")
	self._btnInfo = self:getBtn("btnInfo")
	self.btnExchange = self:getBtn("btnExchange")
	self._btnSourceTrace = self:getGo("btnSourceTrace")
end

function DivineEvolveEnterView:bindEvents()
	DivineEvolveEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnSurePlus:AddClickListener(self._onClickSurePlus, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self.btnExchange:AddClickListener(self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnSourceTrace, self._onClickSourceTrace, self)
end

function DivineEvolveEnterView:unbindEvents()
	DivineEvolveEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnSurePlus:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self.btnExchange:RemoveClickListener()
end

function DivineEvolveEnterView:onEnter()
	DivineEvolveEnterView.super.onEnter(self)
	DivineEvolveController.instance:tryShowEnterPopup()
end

function DivineEvolveEnterView:onExit()
	DivineEvolveEnterView.super.onExit(self)
end

function DivineEvolveEnterView:_onClickClose()
	self:close()
end

function DivineEvolveEnterView:_onClickSure()
	UIStateManager.instance:push(ViewName.DivineEvolveMainView)
end

function DivineEvolveEnterView:_onClickSurePlus()
	UIStateManager.instance:push(ViewName.DivineEvolvePlusView)
end

function DivineEvolveEnterView:_onClickInfo()
	UIStateManager.instance:push(ViewName.DivineEvolveHandbookView)
end

function DivineEvolveEnterView:_onClickExchange()
	UIStateManager.instance:push(ViewName.ShenqishopexchangeView)
end

function DivineEvolveEnterView:_onClickSourceTrace()
	UIStateManager.instance:push(ViewName.SourceTraceEvolveView)
end

return DivineEvolveEnterView
