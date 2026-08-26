-- chunkname: @modules/logic/explore/view/ExploreBonusSceneViewContainer.lua

module("modules.logic.explore.view.ExploreBonusSceneViewContainer", package.seeall)

local ExploreBonusSceneViewContainer = class("ExploreBonusSceneViewContainer", BaseViewContainer)

function ExploreBonusSceneViewContainer:buildViews()
	return {
		ExploreBonusSceneView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ExploreBonusSceneViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return ExploreBonusSceneViewContainer
