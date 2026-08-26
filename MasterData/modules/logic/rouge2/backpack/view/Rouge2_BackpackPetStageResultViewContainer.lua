-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackPetStageResultViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackPetStageResultViewContainer", package.seeall)

local Rouge2_BackpackPetStageResultViewContainer = class("Rouge2_BackpackPetStageResultViewContainer", BaseViewContainer)

function Rouge2_BackpackPetStageResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackPetStageResultView.New())

	return views
end

return Rouge2_BackpackPetStageResultViewContainer
