-- chunkname: @modules/logic/versionactivity1_9/decalogpresent/view/V1a9DecalogPresentViewContainer.lua

module("modules.logic.versionactivity1_9.decalogpresent.view.V1a9DecalogPresentViewContainer", package.seeall)

local V1a9DecalogPresentViewContainer = class("V1a9DecalogPresentViewContainer", DecalogPresentViewContainer)

function V1a9DecalogPresentViewContainer:buildViews()
	local views = {}

	table.insert(views, V1a9DecalogPresentView.New())

	return views
end

return V1a9DecalogPresentViewContainer
