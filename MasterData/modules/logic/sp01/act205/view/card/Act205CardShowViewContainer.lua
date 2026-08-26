-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardShowViewContainer.lua

module("modules.logic.sp01.act205.view.card.Act205CardShowViewContainer", package.seeall)

local Act205CardShowViewContainer = class("Act205CardShowViewContainer", BaseViewContainer)

function Act205CardShowViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205CardShowView.New())

	return views
end

return Act205CardShowViewContainer
