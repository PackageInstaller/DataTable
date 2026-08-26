-- chunkname: @modules/logic/partygame/view/common/PartyGameResultViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameResultViewContainer", package.seeall)

local PartyGameResultViewContainer = class("PartyGameResultViewContainer", BaseViewContainer)

function PartyGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameResultView.New())

	return views
end

return PartyGameResultViewContainer
