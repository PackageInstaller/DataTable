-- chunkname: @modules/logic/commandstation/view/CommandStationPaperGetViewContainer.lua

module("modules.logic.commandstation.view.CommandStationPaperGetViewContainer", package.seeall)

local CommandStationPaperGetViewContainer = class("CommandStationPaperGetViewContainer", BaseViewContainer)

function CommandStationPaperGetViewContainer:buildViews()
	return {
		CommandStationPaperGetView.New()
	}
end

return CommandStationPaperGetViewContainer
