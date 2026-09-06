-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/ReviewintaptapView.lua

module("logic.extensions.tips.view.ReviewintaptapView", package.seeall)

local ReviewintaptapView = class("ReviewintaptapView", ViewComponent)

function ReviewintaptapView:ctor()
	ReviewintaptapView.super.ctor(self)
end

function ReviewintaptapView:unbindEvents()
	ReviewintaptapView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ReviewintaptapView:bindEvents()
	ReviewintaptapView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function ReviewintaptapView:buildUI()
	ReviewintaptapView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function ReviewintaptapView:onExit()
	ReviewintaptapView.super.onExit(self)
end

function ReviewintaptapView:onEnter()
	ReviewintaptapView.super.onEnter(self)
end

function ReviewintaptapView:_onClickbtnClose()
	self:close()
end

function ReviewintaptapView:_onClickbtnSure()
	SDKManager.openReviewInTapTap()
	self:close()
end

return ReviewintaptapView
