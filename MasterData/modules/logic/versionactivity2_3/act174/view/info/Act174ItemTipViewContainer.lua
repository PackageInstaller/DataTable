-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174ItemTipViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipViewContainer", package.seeall)

local Act174ItemTipViewContainer = class("Act174ItemTipViewContainer", BaseViewContainer)

function Act174ItemTipViewContainer:buildViews()
	self.view = Act174ItemTipView.New()

	return {
		self.view
	}
end

function Act174ItemTipViewContainer:playCloseTransition()
	self.view:playCloseAnim()
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.2)
end

return Act174ItemTipViewContainer
