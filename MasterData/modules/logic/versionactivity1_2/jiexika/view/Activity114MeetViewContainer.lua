-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114MeetViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetViewContainer", package.seeall)

local Activity114MeetViewContainer = class("Activity114MeetViewContainer", BaseViewContainer)

function Activity114MeetViewContainer:buildViews()
	return {
		Activity114MeetView.New()
	}
end

function Activity114MeetViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity114MeetViewContainer
