-- chunkname: @modules/logic/partycloth/view/PartyClothLoadingViewContainer.lua

module("modules.logic.partycloth.view.PartyClothLoadingViewContainer", package.seeall)

local PartyClothLoadingViewContainer = class("PartyClothLoadingViewContainer", BaseViewContainer)

function PartyClothLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyClothLoadingView.New())

	return views
end

return PartyClothLoadingViewContainer
