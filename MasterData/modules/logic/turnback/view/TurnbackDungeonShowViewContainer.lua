-- chunkname: @modules/logic/turnback/view/TurnbackDungeonShowViewContainer.lua

module("modules.logic.turnback.view.TurnbackDungeonShowViewContainer", package.seeall)

local TurnbackDungeonShowViewContainer = class("TurnbackDungeonShowViewContainer", BaseViewContainer)

function TurnbackDungeonShowViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackDungeonShowView.New())

	return views
end

return TurnbackDungeonShowViewContainer
