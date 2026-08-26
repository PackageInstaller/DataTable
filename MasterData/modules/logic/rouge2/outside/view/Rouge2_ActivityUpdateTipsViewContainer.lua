-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ActivityUpdateTipsViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_ActivityUpdateTipsViewContainer", package.seeall)

local Rouge2_ActivityUpdateTipsViewContainer = class("Rouge2_ActivityUpdateTipsViewContainer", BaseViewContainer)

function Rouge2_ActivityUpdateTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ActivityUpdateTipsView.New())

	return views
end

return Rouge2_ActivityUpdateTipsViewContainer
