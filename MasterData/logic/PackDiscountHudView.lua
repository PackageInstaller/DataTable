-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/view/PackDiscountHudView.lua

module("logic.extensions.packdiscount.view.PackDiscountHudView", package.seeall)

local PackDiscountHudView = class("PackDiscountHudView", ViewComponent)

function PackDiscountHudView:ctor()
	PackDiscountHudView.super.ctor(self)
end

function PackDiscountHudView:unbindEvents()
	PackDiscountHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPackView)
end

function PackDiscountHudView:bindEvents()
	PackDiscountHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPackView, self._onClickPopView, self)
end

function PackDiscountHudView:buildUI()
	PackDiscountHudView.super.buildUI(self)

	self._btnPackView = self:getBtn("btnPackView")
end

function PackDiscountHudView:_onClickPopView()
	UIStateManager.instance:push(ViewName.PackDiscountView)
end

return PackDiscountHudView
