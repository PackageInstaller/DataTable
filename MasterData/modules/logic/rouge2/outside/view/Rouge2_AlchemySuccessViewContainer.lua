-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemySuccessViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemySuccessViewContainer", package.seeall)

local Rouge2_AlchemySuccessViewContainer = class("Rouge2_AlchemySuccessViewContainer", BaseViewContainer)

function Rouge2_AlchemySuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AlchemySuccessView.New())

	return views
end

return Rouge2_AlchemySuccessViewContainer
