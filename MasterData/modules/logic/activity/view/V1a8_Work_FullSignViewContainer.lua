-- chunkname: @modules/logic/activity/view/V1a8_Work_FullSignViewContainer.lua

module("modules.logic.activity.view.V1a8_Work_FullSignViewContainer", package.seeall)

local V1a8_Work_FullSignViewContainer = class("V1a8_Work_FullSignViewContainer", V1a8_Work_SignItem_SignViewContainer)

function V1a8_Work_FullSignViewContainer:onGetMainViewClassType()
	return V1a8_Work_FullSignView
end

return V1a8_Work_FullSignViewContainer
