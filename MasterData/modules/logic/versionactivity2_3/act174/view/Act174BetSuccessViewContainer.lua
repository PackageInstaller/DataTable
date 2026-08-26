-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174BetSuccessViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174BetSuccessViewContainer", package.seeall)

local Act174BetSuccessViewContainer = class("Act174BetSuccessViewContainer", BaseViewContainer)

function Act174BetSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174BetSuccessView.New())

	return views
end

return Act174BetSuccessViewContainer
