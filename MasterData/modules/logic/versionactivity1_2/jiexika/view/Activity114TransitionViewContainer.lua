-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TransitionViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TransitionViewContainer", package.seeall)

local Activity114TransitionViewContainer = class("Activity114TransitionViewContainer", BaseViewContainer)

function Activity114TransitionViewContainer:buildViews()
	return {
		Activity114TransitionView.New()
	}
end

return Activity114TransitionViewContainer
