-- chunkname: @modules/logic/commandstation/view/CommandStationMapDisplayViewContainer.lua

module("modules.logic.commandstation.view.CommandStationMapDisplayViewContainer", package.seeall)

local CommandStationMapDisplayViewContainer = class("CommandStationMapDisplayViewContainer", BaseViewContainer)

function CommandStationMapDisplayViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationMapDisplayView.New())

	return views
end

return CommandStationMapDisplayViewContainer
