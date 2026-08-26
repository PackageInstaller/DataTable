-- chunkname: @modules/logic/activity/view/V2a0_SummerSign_PanelViewContainer.lua

module("modules.logic.activity.view.V2a0_SummerSign_PanelViewContainer", package.seeall)

local V2a0_SummerSign_PanelViewContainer = class("V2a0_SummerSign_PanelViewContainer", V2a0_SummerSign_SignItemViewContainer)

function V2a0_SummerSign_PanelViewContainer:onGetMainViewClassType()
	return V2a0_SummerSign_PanelView
end

return V2a0_SummerSign_PanelViewContainer
