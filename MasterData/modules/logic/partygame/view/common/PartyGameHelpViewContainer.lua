-- chunkname: @modules/logic/partygame/view/common/PartyGameHelpViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameHelpViewContainer", package.seeall)

local PartyGameHelpViewContainer = class("PartyGameHelpViewContainer", BaseViewContainer)

function PartyGameHelpViewContainer:buildViews()
	return {
		PartyGameHelpView.New()
	}
end

return PartyGameHelpViewContainer
