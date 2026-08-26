-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentDetailViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentDetailViewContainer", package.seeall)

local Rouge2_BackpackTalentDetailViewContainer = class("Rouge2_BackpackTalentDetailViewContainer", BaseViewContainer)

function Rouge2_BackpackTalentDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackTalentDetailView.New())

	return views
end

return Rouge2_BackpackTalentDetailViewContainer
