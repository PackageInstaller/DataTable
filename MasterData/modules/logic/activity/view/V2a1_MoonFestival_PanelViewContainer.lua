-- chunkname: @modules/logic/activity/view/V2a1_MoonFestival_PanelViewContainer.lua

module("modules.logic.activity.view.V2a1_MoonFestival_PanelViewContainer", package.seeall)

local V2a1_MoonFestival_PanelViewContainer = class("V2a1_MoonFestival_PanelViewContainer", V2a1_MoonFestival_SignItemViewContainer)

function V2a1_MoonFestival_PanelViewContainer:onGetMainViewClassType()
	return V2a1_MoonFestival_PanelView
end

return V2a1_MoonFestival_PanelViewContainer
