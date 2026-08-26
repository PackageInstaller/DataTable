-- chunkname: @modules/logic/weekwalk/view/WeekWalkReviveViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkReviveViewContainer", package.seeall)

local WeekWalkReviveViewContainer = class("WeekWalkReviveViewContainer", BaseViewContainer)

function WeekWalkReviveViewContainer:buildViews()
	return {
		WeekWalkReviveView.New()
	}
end

return WeekWalkReviveViewContainer
