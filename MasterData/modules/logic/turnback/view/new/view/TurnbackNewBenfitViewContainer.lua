-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewBenfitViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewBenfitViewContainer", package.seeall)

local TurnbackNewBenfitViewContainer = class("TurnbackNewBenfitViewContainer", BaseViewContainer)

function TurnbackNewBenfitViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewBenfitView.New())

	return views
end

return TurnbackNewBenfitViewContainer
