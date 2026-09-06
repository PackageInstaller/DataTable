-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdMibaoPetView.lua

module("logic.extensions.activitypopup.view.HdMibaoPetView", package.seeall)

local HdMibaoPetView = class("HdMibaoPetView", ActivityPopupBase)

function HdMibaoPetView:buildUI()
	HdMibaoPetView.super.buildUI(self)

	self._btnJump = self:getBtn("Image")
end

function HdMibaoPetView:bindEvents()
	HdMibaoPetView.super.bindEvents(self)
	self._btnJump:AddClickListener(self._onClickJump, self)
end

function HdMibaoPetView:unbindEvents()
	HdMibaoPetView.super.unbindEvents(self)
	self._btnJump:RemoveClickListener()
end

function HdMibaoPetView:_onClickJump()
	if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
		UIStateManager.instance:clear()
	end

	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.TehuiGift)
end

return HdMibaoPetView
