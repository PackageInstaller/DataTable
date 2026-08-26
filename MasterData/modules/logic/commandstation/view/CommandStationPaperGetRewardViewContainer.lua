-- chunkname: @modules/logic/commandstation/view/CommandStationPaperGetRewardViewContainer.lua

module("modules.logic.commandstation.view.CommandStationPaperGetRewardViewContainer", package.seeall)

local CommandStationPaperGetRewardViewContainer = class("CommandStationPaperGetRewardViewContainer", BaseViewContainer)

function CommandStationPaperGetRewardViewContainer:buildViews()
	return {
		CommandStationPaperGetRewardView.New()
	}
end

return CommandStationPaperGetRewardViewContainer
