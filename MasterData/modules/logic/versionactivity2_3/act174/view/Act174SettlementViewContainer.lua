-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174SettlementViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174SettlementViewContainer", package.seeall)

local Act174SettlementViewContainer = class("Act174SettlementViewContainer", BaseViewContainer)

function Act174SettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174SettlementView.New())

	return views
end

return Act174SettlementViewContainer
