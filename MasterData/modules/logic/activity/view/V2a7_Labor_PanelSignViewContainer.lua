-- chunkname: @modules/logic/activity/view/V2a7_Labor_PanelSignViewContainer.lua

module("modules.logic.activity.view.V2a7_Labor_PanelSignViewContainer", package.seeall)

local V2a7_Labor_PanelSignViewContainer = class("V2a7_Labor_PanelSignViewContainer", V2a7_Labor_SignItemViewContainer)

function V2a7_Labor_PanelSignViewContainer:onGetMainViewClassType()
	return V2a7_Labor_PanelSignView
end

return V2a7_Labor_PanelSignViewContainer
