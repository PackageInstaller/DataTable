-- chunkname: @modules/logic/sodache/view/inside/SodacheDialoguePanelViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheDialoguePanelViewContainer", package.seeall)

local SodacheDialoguePanelViewContainer = class("SodacheDialoguePanelViewContainer", BaseViewContainer)

function SodacheDialoguePanelViewContainer:buildViews()
	return {
		SodacheDialoguePanelView.New(),
		SodacheCheckPanelView.New()
	}
end

return SodacheDialoguePanelViewContainer
