-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaGameViewContainer.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameViewContainer", package.seeall)

local JiaLaBoNaGameViewContainer = class("JiaLaBoNaGameViewContainer", BaseViewContainer)

function JiaLaBoNaGameViewContainer:buildViews()
	local views = {}

	table.insert(views, JiaLaBoNaGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(2, "gamescene"))

	return views
end

function JiaLaBoNaGameViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function JiaLaBoNaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Role1Chess)

		navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			navigateView
		}
	elseif tabContainerId == 2 then
		return {
			JiaLaBoNaGameScene.New()
		}
	end
end

function JiaLaBoNaGameViewContainer:_overrideCloseFunc()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	self._yesExitFunc = self._yesExitFunc or function()
		Stat1_3Controller.instance:jiaLaBoNaStatAbort()
		self:closeThis()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self._yesExitFunc)
end

function JiaLaBoNaGameViewContainer:_onEscape()
	self:_overrideCloseFunc()
end

return JiaLaBoNaGameViewContainer
