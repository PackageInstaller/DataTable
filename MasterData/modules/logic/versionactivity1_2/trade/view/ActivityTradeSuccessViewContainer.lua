-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeSuccessViewContainer.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessViewContainer", package.seeall)

local ActivityTradeSuccessViewContainer = class("ActivityTradeSuccessViewContainer", BaseViewContainer)

function ActivityTradeSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityTradeSuccessView.New())

	return views
end

return ActivityTradeSuccessViewContainer
