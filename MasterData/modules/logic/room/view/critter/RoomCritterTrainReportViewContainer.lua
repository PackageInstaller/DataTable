-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainReportViewContainer.lua

module("modules.logic.room.view.critter.RoomCritterTrainReportViewContainer", package.seeall)

local RoomCritterTrainReportViewContainer = class("RoomCritterTrainReportViewContainer", BaseViewContainer)

function RoomCritterTrainReportViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterTrainReportView.New())

	return views
end

function RoomCritterTrainReportViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function RoomCritterTrainReportViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return RoomCritterTrainReportViewContainer
