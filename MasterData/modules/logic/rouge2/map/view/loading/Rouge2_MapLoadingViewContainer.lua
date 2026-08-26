-- chunkname: @modules/logic/rouge2/map/view/loading/Rouge2_MapLoadingViewContainer.lua

module("modules.logic.rouge2.map.view.loading.Rouge2_MapLoadingViewContainer", package.seeall)

local Rouge2_MapLoadingViewContainer = class("Rouge2_MapLoadingViewContainer", BaseViewContainer)

function Rouge2_MapLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapLoadingView.New())

	return views
end

function Rouge2_MapLoadingViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play("end", self.onPlayCloseTransitionFinish, self)
end

return Rouge2_MapLoadingViewContainer
