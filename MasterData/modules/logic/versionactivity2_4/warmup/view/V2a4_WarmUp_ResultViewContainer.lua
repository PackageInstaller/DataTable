-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_ResultViewContainer.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_ResultViewContainer", package.seeall)

local V2a4_WarmUp_ResultViewContainer = class("V2a4_WarmUp_ResultViewContainer", Activity125ViewBaseContainer)

function V2a4_WarmUp_ResultViewContainer:buildViews()
	return {
		V2a4_WarmUp_ResultView.New()
	}
end

return V2a4_WarmUp_ResultViewContainer
