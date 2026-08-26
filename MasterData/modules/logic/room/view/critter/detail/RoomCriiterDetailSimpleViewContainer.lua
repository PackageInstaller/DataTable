-- chunkname: @modules/logic/room/view/critter/detail/RoomCriiterDetailSimpleViewContainer.lua

module("modules.logic.room.view.critter.detail.RoomCriiterDetailSimpleViewContainer", package.seeall)

local RoomCriiterDetailSimpleViewContainer = class("RoomCriiterDetailSimpleViewContainer", BaseViewContainer)

function RoomCriiterDetailSimpleViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCriiterDetailSimpleView.New())

	return views
end

function RoomCriiterDetailSimpleViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function RoomCriiterDetailSimpleViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseRoomCriiterDetailSimpleView)
end

return RoomCriiterDetailSimpleViewContainer
