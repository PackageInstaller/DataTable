-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_SwitchViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_SwitchViewContainer", package.seeall)

local Rouge2_SwitchViewContainer = class("Rouge2_SwitchViewContainer", BaseViewContainer)

function Rouge2_SwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_SwitchView.New())

	return views
end

return Rouge2_SwitchViewContainer
