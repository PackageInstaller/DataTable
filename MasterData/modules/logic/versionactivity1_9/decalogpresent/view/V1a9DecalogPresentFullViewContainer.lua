-- chunkname: @modules/logic/versionactivity1_9/decalogpresent/view/V1a9DecalogPresentFullViewContainer.lua

module("modules.logic.versionactivity1_9.decalogpresent.view.V1a9DecalogPresentFullViewContainer", package.seeall)

local V1a9DecalogPresentFullViewContainer = class("V1a9DecalogPresentFullViewContainer", BaseViewContainer)

function V1a9DecalogPresentFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V1a9DecalogPresentFullView.New())

	return views
end

return V1a9DecalogPresentFullViewContainer
