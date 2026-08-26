-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipeViewContainer.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeViewContainer", package.seeall)

local ArmPuzzlePipeViewContainer = class("ArmPuzzlePipeViewContainer", BaseViewContainer)

function ArmPuzzlePipeViewContainer:buildViews()
	self._pipes = ArmPuzzlePipes.New()

	return {
		ArmPuzzlePipeView.New(),
		self._pipes,
		ArmPuzzlePipePieceView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function ArmPuzzlePipeViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.VersionActivity_1_3_LeftHand)

	navigateView:setOverrideClose(self.overrideCloseFunc, self)

	return {
		navigateView
	}
end

function ArmPuzzlePipeViewContainer:onContainerInit()
	Stat1_3Controller.instance:armPuzzleStatStart()
end

function ArmPuzzlePipeViewContainer:getPipesXYByPostion(position)
	return self._pipes:getXYByPostion(position)
end

function ArmPuzzlePipeViewContainer:getPipes()
	return self._pipes
end

function ArmPuzzlePipeViewContainer:overrideCloseFunc()
	Stat1_3Controller.instance:puzzleStatAbort()
	self:closeThis()
end

return ArmPuzzlePipeViewContainer
