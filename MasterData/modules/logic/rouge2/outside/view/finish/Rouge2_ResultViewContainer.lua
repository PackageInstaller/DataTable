-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultViewContainer", package.seeall)

local Rouge2_ResultViewContainer = class("Rouge2_ResultViewContainer", BaseViewContainer)

function Rouge2_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ResultView.New())

	return views
end

return Rouge2_ResultViewContainer
