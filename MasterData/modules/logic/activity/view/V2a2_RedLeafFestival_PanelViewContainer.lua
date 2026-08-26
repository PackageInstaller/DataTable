-- chunkname: @modules/logic/activity/view/V2a2_RedLeafFestival_PanelViewContainer.lua

module("modules.logic.activity.view.V2a2_RedLeafFestival_PanelViewContainer", package.seeall)

local V2a2_RedLeafFestival_PanelViewContainer = class("V2a2_RedLeafFestival_PanelViewContainer", V2a2_RedLeafFestival_SignItemViewContainer)

function V2a2_RedLeafFestival_PanelViewContainer:onGetMainViewClassType()
	return V2a2_RedLeafFestival_PanelView
end

return V2a2_RedLeafFestival_PanelViewContainer
