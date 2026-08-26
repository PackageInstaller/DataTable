-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_PathSelectMapEditorViewContainer.lua

module("modules.logic.gm.view.rouge2.Rouge2_PathSelectMapEditorViewContainer", package.seeall)

local Rouge2_PathSelectMapEditorViewContainer = class("Rouge2_PathSelectMapEditorViewContainer", BaseViewContainer)

function Rouge2_PathSelectMapEditorViewContainer:buildViews()
	return {
		Rouge2_PathSelectMapEditorView.New()
	}
end

return Rouge2_PathSelectMapEditorViewContainer
