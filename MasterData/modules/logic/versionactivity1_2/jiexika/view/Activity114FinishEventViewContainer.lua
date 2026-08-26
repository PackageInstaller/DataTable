-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114FinishEventViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114FinishEventViewContainer", package.seeall)

local Activity114FinishEventViewContainer = class("Activity114FinishEventViewContainer", BaseViewContainer)

function Activity114FinishEventViewContainer:buildViews()
	return {
		Activity114FinishEventView.New()
	}
end

return Activity114FinishEventViewContainer
