-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3SignViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3SignViewContainer", package.seeall)

local Anniversary3SignViewContainer = class("Anniversary3SignViewContainer", BaseViewContainer)

function Anniversary3SignViewContainer:buildViews()
	local views = {}

	table.insert(views, Anniversary3SignView.New())
	table.insert(views, TabViewGroup.New(1, "Root/#go_lefttop"))

	return views
end

function Anniversary3SignViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Anniversary3SignViewContainer
