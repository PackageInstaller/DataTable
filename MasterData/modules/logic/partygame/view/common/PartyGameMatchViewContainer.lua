-- chunkname: @modules/logic/partygame/view/common/PartyGameMatchViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameMatchViewContainer", package.seeall)

local PartyGameMatchViewContainer = class("PartyGameMatchViewContainer", BaseViewContainer)

function PartyGameMatchViewContainer:buildViews()
	return {
		PartyGameMatchView.New()
	}
end

return PartyGameMatchViewContainer
