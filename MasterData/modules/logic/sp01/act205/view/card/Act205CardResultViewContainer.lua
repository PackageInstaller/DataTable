-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardResultViewContainer.lua

module("modules.logic.sp01.act205.view.card.Act205CardResultViewContainer", package.seeall)

local Act205CardResultViewContainer = class("Act205CardResultViewContainer", BaseViewContainer)

function Act205CardResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205CardResultView.New())

	return views
end

return Act205CardResultViewContainer
