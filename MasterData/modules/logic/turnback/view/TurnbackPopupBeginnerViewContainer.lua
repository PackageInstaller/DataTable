-- chunkname: @modules/logic/turnback/view/TurnbackPopupBeginnerViewContainer.lua

module("modules.logic.turnback.view.TurnbackPopupBeginnerViewContainer", package.seeall)

local TurnbackPopupBeginnerViewContainer = class("TurnbackPopupBeginnerViewContainer", BaseViewContainer)

function TurnbackPopupBeginnerViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackPopupBeginnerView.New())

	return views
end

return TurnbackPopupBeginnerViewContainer
