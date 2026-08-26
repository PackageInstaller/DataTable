-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiCardInfoViewContainer.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoViewContainer", package.seeall)

local XugoujiCardInfoViewContainer = class("XugoujiCardInfoViewContainer", BaseViewContainer)

function XugoujiCardInfoViewContainer:buildViews()
	return {
		XugoujiCardInfoView.New()
	}
end

function XugoujiCardInfoViewContainer:_overrideClickHome()
	NavigateButtonsView.homeClick()
end

function XugoujiCardInfoViewContainer:setVisibleInternal(isVisible)
	XugoujiCardInfoViewContainer.super.setVisibleInternal(self, isVisible)
end

return XugoujiCardInfoViewContainer
