-- chunkname: @modules/logic/rouge/view/RougeEndingThreeViewContainer.lua

module("modules.logic.rouge.view.RougeEndingThreeViewContainer", package.seeall)

local RougeEndingThreeViewContainer = class("RougeEndingThreeViewContainer", BaseViewContainer)

function RougeEndingThreeViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeEndingThreeView.New())

	return views
end

return RougeEndingThreeViewContainer
