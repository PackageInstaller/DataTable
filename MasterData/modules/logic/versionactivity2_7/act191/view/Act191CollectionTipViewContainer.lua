-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionTipViewContainer", package.seeall)

local Act191CollectionTipViewContainer = class("Act191CollectionTipViewContainer", BaseViewContainer)

function Act191CollectionTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CollectionTipView.New())

	return views
end

return Act191CollectionTipViewContainer
