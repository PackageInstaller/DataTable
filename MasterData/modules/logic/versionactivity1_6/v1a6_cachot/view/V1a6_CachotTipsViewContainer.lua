-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTipsViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsViewContainer", package.seeall)

local V1a6_CachotTipsViewContainer = class("V1a6_CachotTipsViewContainer", BaseViewContainer)

function V1a6_CachotTipsViewContainer:buildViews()
	return {
		V1a6_CachotTipsView.New()
	}
end

function V1a6_CachotTipsViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

return V1a6_CachotTipsViewContainer
