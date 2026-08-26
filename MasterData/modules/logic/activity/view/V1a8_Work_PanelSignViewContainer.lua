-- chunkname: @modules/logic/activity/view/V1a8_Work_PanelSignViewContainer.lua

module("modules.logic.activity.view.V1a8_Work_PanelSignViewContainer", package.seeall)

local V1a8_Work_PanelSignViewContainer = class("V1a8_Work_PanelSignViewContainer", V1a8_Work_SignItem_SignViewContainer)

function V1a8_Work_PanelSignViewContainer:onGetMainViewClassType()
	return V1a8_Work_PanelSignView
end

return V1a8_Work_PanelSignViewContainer
