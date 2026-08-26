-- chunkname: @modules/logic/commandstation/view/CommandStationDetailViewContainer.lua

module("modules.logic.commandstation.view.CommandStationDetailViewContainer", package.seeall)

local CommandStationDetailViewContainer = class("CommandStationDetailViewContainer", BaseViewContainer)

function CommandStationDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationDetailView.New())

	return views
end

return CommandStationDetailViewContainer
