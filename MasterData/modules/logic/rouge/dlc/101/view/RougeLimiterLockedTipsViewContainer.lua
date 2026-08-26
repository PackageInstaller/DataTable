-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterLockedTipsViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsViewContainer", package.seeall)

local RougeLimiterLockedTipsViewContainer = class("RougeLimiterLockedTipsViewContainer", BaseViewContainer)

function RougeLimiterLockedTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeLimiterLockedTipsView.New())

	return views
end

return RougeLimiterLockedTipsViewContainer
