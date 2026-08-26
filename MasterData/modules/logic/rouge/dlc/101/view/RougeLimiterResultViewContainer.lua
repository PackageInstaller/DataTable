-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterResultViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterResultViewContainer", package.seeall)

local RougeLimiterResultViewContainer = class("RougeLimiterResultViewContainer", BaseViewContainer)

function RougeLimiterResultViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeLimiterResultView.New())

	return views
end

return RougeLimiterResultViewContainer
