-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameMainViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameMainViewContainer", package.seeall)

local MusicGameMainViewContainer = class("MusicGameMainViewContainer", BaseViewContainer)

function MusicGameMainViewContainer:buildViews()
	local views = {}

	self._view = MusicGameMainView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MusicGameMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self._navigateButtonView
		}
	end
end

function MusicGameMainViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.MusicGameCloseTip, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function MusicGameMainViewContainer:onClickYes()
	MusicGameController.instance:dispatchEvent(MusicGameEvent.CancelGame)
end

return MusicGameMainViewContainer
