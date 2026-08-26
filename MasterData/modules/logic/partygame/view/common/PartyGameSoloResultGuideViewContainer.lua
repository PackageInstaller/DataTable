-- chunkname: @modules/logic/partygame/view/common/PartyGameSoloResultGuideViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameSoloResultGuideViewContainer", package.seeall)

local PartyGameSoloResultGuideViewContainer = class("PartyGameSoloResultGuideViewContainer", BaseViewContainer)

function PartyGameSoloResultGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameSoloResultGuideView.New())

	return views
end

return PartyGameSoloResultGuideViewContainer
