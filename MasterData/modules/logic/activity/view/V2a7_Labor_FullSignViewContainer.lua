-- chunkname: @modules/logic/activity/view/V2a7_Labor_FullSignViewContainer.lua

module("modules.logic.activity.view.V2a7_Labor_FullSignViewContainer", package.seeall)

local V2a7_Labor_FullSignViewContainer = class("V2a7_Labor_FullSignViewContainer", V2a7_Labor_SignItemViewContainer)

function V2a7_Labor_FullSignViewContainer:onGetMainViewClassType()
	return V2a7_Labor_FullSignView
end

return V2a7_Labor_FullSignViewContainer
