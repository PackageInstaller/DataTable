-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewProgressViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewProgressViewContainer", package.seeall)

local TurnbackNewProgressViewContainer = class("TurnbackNewProgressViewContainer", BaseViewContainer)

function TurnbackNewProgressViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewProgressView.New())

	return views
end

return TurnbackNewProgressViewContainer
