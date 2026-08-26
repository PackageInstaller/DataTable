-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryBranchViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryBranchViewContainer", package.seeall)

local NecrologistStoryBranchViewContainer = class("NecrologistStoryBranchViewContainer", BaseViewContainer)

function NecrologistStoryBranchViewContainer:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryBranchView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NecrologistStoryBranchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return NecrologistStoryBranchViewContainer
