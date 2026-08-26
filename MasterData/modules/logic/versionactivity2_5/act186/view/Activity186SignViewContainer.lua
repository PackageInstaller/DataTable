-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186SignViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186SignViewContainer", package.seeall)

local Activity186SignViewContainer = class("Activity186SignViewContainer", BaseViewContainer)

function Activity186SignViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186SignView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity186SignViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Activity186SignViewContainer
