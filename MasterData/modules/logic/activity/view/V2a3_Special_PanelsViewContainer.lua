-- chunkname: @modules/logic/activity/view/V2a3_Special_PanelsViewContainer.lua

module("modules.logic.activity.view.V2a3_Special_PanelsViewContainer", package.seeall)

local V2a3_Special_PanelsViewContainer = class("V2a3_Special_PanelsViewContainer", V2a3_Special_SignItemViewContainer)

function V2a3_Special_PanelsViewContainer:buildViews()
	local views = {}

	self._view = V2a3_Special_PanelsView.New()

	table.insert(views, self._view)

	return views
end

function V2a3_Special_PanelsViewContainer:view()
	return self._view
end

return V2a3_Special_PanelsViewContainer
