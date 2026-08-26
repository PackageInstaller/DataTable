-- chunkname: @modules/logic/sp01/act205/view/Act205RuleTipsViewContainer.lua

module("modules.logic.sp01.act205.view.Act205RuleTipsViewContainer", package.seeall)

local Act205RuleTipsViewContainer = class("Act205RuleTipsViewContainer", BaseViewContainer)

function Act205RuleTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205RuleTipsView.New())

	return views
end

return Act205RuleTipsViewContainer
