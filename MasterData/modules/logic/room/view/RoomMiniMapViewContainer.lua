-- chunkname: @modules/logic/room/view/RoomMiniMapViewContainer.lua

module("modules.logic.room.view.RoomMiniMapViewContainer", package.seeall)

local RoomMiniMapViewContainer = class("RoomMiniMapViewContainer", BaseViewContainer)

function RoomMiniMapViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_navigatebuttonscontainer"))
	table.insert(views, RoomMiniMapView.New())

	return views
end

function RoomMiniMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function RoomMiniMapViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_checkpoint_story_close)
end

return RoomMiniMapViewContainer
