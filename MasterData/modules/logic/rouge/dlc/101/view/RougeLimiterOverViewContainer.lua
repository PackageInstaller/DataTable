-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterOverViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterOverViewContainer", package.seeall)

local RougeLimiterOverViewContainer = class("RougeLimiterOverViewContainer", BaseViewContainer)

function RougeLimiterOverViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeLimiterOverView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_container"))

	return views
end

function RougeLimiterOverViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			RougeLimiterDebuffOverView.New(),
			RougeLimiterBuffOverView.New()
		}
	end
end

function RougeLimiterOverViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return RougeLimiterOverViewContainer
