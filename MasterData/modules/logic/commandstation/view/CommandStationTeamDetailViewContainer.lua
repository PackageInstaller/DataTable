-- chunkname: @modules/logic/commandstation/view/CommandStationTeamDetailViewContainer.lua

module("modules.logic.commandstation.view.CommandStationTeamDetailViewContainer", package.seeall)

local CommandStationTeamDetailViewContainer = class("CommandStationTeamDetailViewContainer", BaseViewContainer)

function CommandStationTeamDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationTeamDetailView.New())

	return views
end

return CommandStationTeamDetailViewContainer
