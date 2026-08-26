-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_PanelViewContainer.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_PanelViewContainer", package.seeall)

local V3a8_DragonBoatActivity_PanelViewContainer = class("V3a8_DragonBoatActivity_PanelViewContainer", V3a8_DragonBoatActivity_ImplContainer)

function V3a8_DragonBoatActivity_PanelViewContainer:buildViews()
	self._mainView = V3a8_DragonBoatActivity_PanelView.New()

	return {
		self._mainView
	}
end

return V3a8_DragonBoatActivity_PanelViewContainer
