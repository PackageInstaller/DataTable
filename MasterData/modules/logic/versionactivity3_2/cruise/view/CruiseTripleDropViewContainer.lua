-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseTripleDropViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseTripleDropViewContainer", package.seeall)

local CruiseTripleDropViewContainer = class("CruiseTripleDropViewContainer", BaseViewContainer)

function CruiseTripleDropViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseTripleDropView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function CruiseTripleDropViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return CruiseTripleDropViewContainer
