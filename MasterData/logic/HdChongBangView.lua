-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdChongBangView.lua

module("logic.extensions.activitypopup.view.HdChongBangView", package.seeall)

local HdChongBangView = class("HdChongBangView", ActivityPopupBase)

function HdChongBangView:buildUI()
	HdChongBangView.super.buildUI(self)

	self._btnGo = self:getBtn("btnGo")
end

function HdChongBangView:bindEvents()
	HdChongBangView.super.bindEvents(self)
	self._btnGo:AddClickListener(self._onClickGo, self)
end

function HdChongBangView:unbindEvents()
	HdChongBangView.super.unbindEvents(self)
	self._btnGo:RemoveClickListener()
end

function HdChongBangView:_onClickGo()
	if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
		UIStateManager.instance:clear()
	end

	FuncOpenController.instance:openFunc(156)
end

return HdChongBangView
