-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaGameViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameViewContainer", package.seeall)

local Activity201MaLiAnNaGameViewContainer = class("Activity201MaLiAnNaGameViewContainer", BaseViewContainer)

function Activity201MaLiAnNaGameViewContainer:buildViews()
	return {
		Activity201MaLiAnNaGameView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function Activity201MaLiAnNaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function Activity201MaLiAnNaGameViewContainer:_overrideClose()
	MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.cancel)
	ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaGameView)
end

return Activity201MaLiAnNaGameViewContainer
