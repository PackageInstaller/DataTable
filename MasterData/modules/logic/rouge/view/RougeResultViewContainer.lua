-- chunkname: @modules/logic/rouge/view/RougeResultViewContainer.lua

module("modules.logic.rouge.view.RougeResultViewContainer", package.seeall)

local RougeResultViewContainer = class("RougeResultViewContainer", BaseViewContainer)

function RougeResultViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeResultView.New())

	return views
end

return RougeResultViewContainer
