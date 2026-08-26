-- chunkname: @modules/logic/activity/view/V2a3_Special_FullSignViewContainer.lua

module("modules.logic.activity.view.V2a3_Special_FullSignViewContainer", package.seeall)

local V2a3_Special_FullSignViewContainer = class("V2a3_Special_FullSignViewContainer", V2a3_Special_SignItemViewContainer)

function V2a3_Special_FullSignViewContainer:buildViews()
	local views = {}

	self._view = V2a3_Special_FullSignView.New()

	table.insert(views, self._view)

	return views
end

function V2a3_Special_FullSignViewContainer:view()
	return self._view
end

return V2a3_Special_FullSignViewContainer
