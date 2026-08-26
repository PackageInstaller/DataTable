-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotFinishViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotFinishViewContainer", package.seeall)

local V1a6_CachotFinishViewContainer = class("V1a6_CachotFinishViewContainer", BaseViewContainer)

function V1a6_CachotFinishViewContainer:buildViews()
	return {
		V1a6_CachotFinishView.New()
	}
end

function V1a6_CachotFinishViewContainer:playCloseTransition()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.onCloseAnimDone, self)
end

function V1a6_CachotFinishViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return V1a6_CachotFinishViewContainer
