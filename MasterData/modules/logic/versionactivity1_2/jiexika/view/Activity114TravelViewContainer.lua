-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TravelViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelViewContainer", package.seeall)

local Activity114TravelViewContainer = class("Activity114TravelViewContainer", BaseViewContainer)

function Activity114TravelViewContainer:buildViews()
	return {
		Activity114TravelView.New()
	}
end

function Activity114TravelViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity114TravelViewContainer
