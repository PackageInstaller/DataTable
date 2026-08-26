-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionGetViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionGetViewContainer", package.seeall)

local Act191CollectionGetViewContainer = class("Act191CollectionGetViewContainer", BaseViewContainer)

function Act191CollectionGetViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CollectionGetView.New())

	return views
end

return Act191CollectionGetViewContainer
