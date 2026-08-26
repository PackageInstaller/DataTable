-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191SettlementViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191SettlementViewContainer", package.seeall)

local Act191SettlementViewContainer = class("Act191SettlementViewContainer", BaseViewContainer)

function Act191SettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191SettlementView.New())

	return views
end

return Act191SettlementViewContainer
