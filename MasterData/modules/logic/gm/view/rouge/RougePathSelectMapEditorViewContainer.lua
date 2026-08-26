-- chunkname: @modules/logic/gm/view/rouge/RougePathSelectMapEditorViewContainer.lua

module("modules.logic.gm.view.rouge.RougePathSelectMapEditorViewContainer", package.seeall)

local RougePathSelectMapEditorViewContainer = class("RougePathSelectMapEditorViewContainer", BaseViewContainer)

function RougePathSelectMapEditorViewContainer:buildViews()
	return {
		RougePathSelectMapEditorView.New()
	}
end

return RougePathSelectMapEditorViewContainer
