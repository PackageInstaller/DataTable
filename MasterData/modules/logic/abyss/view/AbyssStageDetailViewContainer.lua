-- chunkname: @modules/logic/abyss/view/AbyssStageDetailViewContainer.lua

module("modules.logic.abyss.view.AbyssStageDetailViewContainer", package.seeall)

local AbyssStageDetailViewContainer = class("AbyssStageDetailViewContainer", BaseViewContainer)

function AbyssStageDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, AbyssStageDetailView.New())

	return views
end

return AbyssStageDetailViewContainer
