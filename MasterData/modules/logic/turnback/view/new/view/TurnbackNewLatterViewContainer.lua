-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewLatterViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewLatterViewContainer", package.seeall)

local TurnbackNewLatterViewContainer = class("TurnbackNewLatterViewContainer", BaseViewContainer)

function TurnbackNewLatterViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewLatterView.New())

	return views
end

return TurnbackNewLatterViewContainer
