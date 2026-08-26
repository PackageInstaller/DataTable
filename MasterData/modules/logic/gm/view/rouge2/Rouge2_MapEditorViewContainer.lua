-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_MapEditorViewContainer.lua

module("modules.logic.gm.view.rouge2.Rouge2_MapEditorViewContainer", package.seeall)

local Rouge2_MapEditorViewContainer = class("Rouge2_MapEditorViewContainer", BaseViewContainer)

function Rouge2_MapEditorViewContainer:buildViews()
	return {
		Rouge2_MapEditorView.New()
	}
end

return Rouge2_MapEditorViewContainer
