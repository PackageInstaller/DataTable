-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentResetViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentResetViewContainer", package.seeall)

local Rouge2_BackpackTalentResetViewContainer = class("Rouge2_BackpackTalentResetViewContainer", BaseViewContainer)

function Rouge2_BackpackTalentResetViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackTalentResetView.New())

	return views
end

return Rouge2_BackpackTalentResetViewContainer
