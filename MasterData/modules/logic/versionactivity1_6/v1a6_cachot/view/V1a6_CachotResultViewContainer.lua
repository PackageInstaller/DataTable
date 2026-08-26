-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotResultViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultViewContainer", package.seeall)

local V1a6_CachotResultViewContainer = class("V1a6_CachotResultViewContainer", BaseViewContainer)

function V1a6_CachotResultViewContainer:buildViews()
	return {
		V1a6_CachotResultView.New()
	}
end

function V1a6_CachotResultViewContainer:playCloseTransition()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.onCloseAnimDone, self)
end

function V1a6_CachotResultViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return V1a6_CachotResultViewContainer
