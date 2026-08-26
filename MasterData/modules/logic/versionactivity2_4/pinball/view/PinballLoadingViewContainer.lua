-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballLoadingViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballLoadingViewContainer", package.seeall)

local PinballLoadingViewContainer = class("PinballLoadingViewContainer", BaseViewContainer)

function PinballLoadingViewContainer:buildViews()
	return {}
end

function PinballLoadingViewContainer:onContainerOpen()
	TaskDispatcher.runDelay(self.closeThis, self, self._viewSetting.delayTime or 2)
end

function PinballLoadingViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return PinballLoadingViewContainer
