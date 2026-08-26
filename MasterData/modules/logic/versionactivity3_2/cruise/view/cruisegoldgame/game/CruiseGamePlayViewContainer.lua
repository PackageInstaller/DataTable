-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGamePlayViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGamePlayViewContainer", package.seeall)

local CruiseGamePlayViewContainer = class("CruiseGamePlayViewContainer", BaseViewContainer)

function CruiseGamePlayViewContainer:buildViews()
	return {
		CruiseGamePlayView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function CruiseGamePlayViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self.navigateButtonView
		}
	end
end

function CruiseGamePlayViewContainer:closeCallback()
	if Activity218Model.instance.resultType ~= Activity218Enum.GameResultType.None or Activity218Controller.instance.isDiscardFlip then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.CruiseGameCloseTip, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)

	return false
end

function CruiseGamePlayViewContainer:onClickYes()
	Activity218Controller.instance:abandon()
end

return CruiseGamePlayViewContainer
