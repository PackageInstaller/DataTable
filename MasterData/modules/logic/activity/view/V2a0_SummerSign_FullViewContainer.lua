-- chunkname: @modules/logic/activity/view/V2a0_SummerSign_FullViewContainer.lua

module("modules.logic.activity.view.V2a0_SummerSign_FullViewContainer", package.seeall)

local V2a0_SummerSign_FullViewContainer = class("V2a0_SummerSign_FullViewContainer", V2a0_SummerSign_SignItemViewContainer)

function V2a0_SummerSign_FullViewContainer:onGetMainViewClassType()
	return V2a0_SummerSign_FullView
end

return V2a0_SummerSign_FullViewContainer
