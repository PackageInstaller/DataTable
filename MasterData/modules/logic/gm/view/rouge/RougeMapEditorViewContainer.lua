-- chunkname: @modules/logic/gm/view/rouge/RougeMapEditorViewContainer.lua

module("modules.logic.gm.view.rouge.RougeMapEditorViewContainer", package.seeall)

local RougeMapEditorViewContainer = class("RougeMapEditorViewContainer", BaseViewContainer)

function RougeMapEditorViewContainer:buildViews()
	return {
		RougeMapEditorView.New()
	}
end

return RougeMapEditorViewContainer
