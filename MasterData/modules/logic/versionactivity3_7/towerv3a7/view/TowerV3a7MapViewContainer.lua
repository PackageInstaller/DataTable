-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MapViewContainer.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MapViewContainer", package.seeall)

local TowerV3a7MapViewContainer = class("TowerV3a7MapViewContainer", BaseViewContainer)

function TowerV3a7MapViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerV3a7MapView.New())
	table.insert(views, TowerV3a7MapStoryView.New())
	table.insert(views, TowerV3a7MapRoomView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerV3a7MapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.closeCallback, self)

		return {
			self.navigateView
		}
	end
end

function TowerV3a7MapViewContainer:closeCallback()
	if not GuideController.instance:isForbidGuides() and TowerV3a7Model.instance:inFirstMap() and not GuideModel.instance:isGuideFinish(TowerV3a7Enum.GuideId) then
		GameFacade.showToast(ToastEnum.V3a7TowerGuideExitTip)

		return
	end

	TowerV3a7Model.instance:setPause(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerV3a7ConfirmQuit, MsgBoxEnum.BoxType.Yes_No, self._confirmExitGame, self._noExitGame, nil, self)
end

function TowerV3a7MapViewContainer:_confirmExitGame()
	self:closeThis()
end

function TowerV3a7MapViewContainer:_noExitGame()
	TowerV3a7Model.instance:setPause(false)
end

return TowerV3a7MapViewContainer
