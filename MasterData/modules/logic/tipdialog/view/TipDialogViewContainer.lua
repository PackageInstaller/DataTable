-- chunkname: @modules/logic/tipdialog/view/TipDialogViewContainer.lua

module("modules.logic.tipdialog.view.TipDialogViewContainer", package.seeall)

local TipDialogViewContainer = class("TipDialogViewContainer", BaseViewContainer)

function TipDialogViewContainer:buildViews()
	local views = {}

	table.insert(views, TipDialogView.New())
	table.insert(views, TabViewGroup.New(1, "#go_bottomcontent/top_left"))

	return views
end

function TipDialogViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function TipDialogViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return TipDialogViewContainer
