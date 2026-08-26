-- chunkname: @modules/logic/handbook/view/HandbookCGDetailViewContainer.lua

module("modules.logic.handbook.view.HandbookCGDetailViewContainer", package.seeall)

local HandbookCGDetailViewContainer = class("HandbookCGDetailViewContainer", BaseViewContainer)

function HandbookCGDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookCGDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_ui/#go_btns"))

	return views
end

function HandbookCGDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return HandbookCGDetailViewContainer
