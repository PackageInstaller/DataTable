-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGameResultViewContainer.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultViewContainer", package.seeall)

local XugoujiGameResultViewContainer = class("XugoujiGameResultViewContainer", BaseViewContainer)

function XugoujiGameResultViewContainer:buildViews()
	local views = {}

	self._resultView = XugoujiGameResultView.New()

	table.insert(views, self._resultView)

	return views
end

return XugoujiGameResultViewContainer
