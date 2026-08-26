-- chunkname: @modules/logic/partygame/view/common/PartyGameSoloResultViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameSoloResultViewContainer", package.seeall)

local PartyGameSoloResultViewContainer = class("PartyGameSoloResultViewContainer", BaseViewContainer)

function PartyGameSoloResultViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameSoloResultView.New())

	return views
end

return PartyGameSoloResultViewContainer
