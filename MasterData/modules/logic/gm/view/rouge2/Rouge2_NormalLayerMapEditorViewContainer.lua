-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_NormalLayerMapEditorViewContainer.lua

module("modules.logic.gm.view.rouge2.Rouge2_NormalLayerMapEditorViewContainer", package.seeall)

local Rouge2_NormalLayerMapEditorViewContainer = class("Rouge2_NormalLayerMapEditorViewContainer", BaseViewContainer)

function Rouge2_NormalLayerMapEditorViewContainer:buildViews()
	return {
		Rouge2_NormalLayerMapEditorView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function Rouge2_NormalLayerMapEditorViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return Rouge2_NormalLayerMapEditorViewContainer
