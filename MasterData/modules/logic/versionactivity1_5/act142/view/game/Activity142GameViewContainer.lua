-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142GameViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameViewContainer", package.seeall)

local Activity142GameViewContainer = class("Activity142GameViewContainer", BaseViewContainer)

function Activity142GameViewContainer:buildViews()
	local views = {}

	self._gameView = Activity142GameView.New()

	table.insert(views, self._gameView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(2, "gamescene"))

	return views
end

function Activity142GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navigateView:setHelpId(HelpEnum.HelpId.Activity142)
		navigateView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			navigateView
		}
	elseif tabContainerId == 2 then
		return {
			Activity142GameScene.New()
		}
	end
end

function Activity142GameViewContainer:overrideOnCloseClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self.yesCloseView, nil, nil, self)
end

function Activity142GameViewContainer:yesCloseView()
	Activity142StatController.instance:statAbort()
	self:closeThis()
end

return Activity142GameViewContainer
