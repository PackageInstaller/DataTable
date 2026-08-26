-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_ResultViewContainer.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultViewContainer", package.seeall)

local V1a6_BossRush_ResultViewContainer = class("V1a6_BossRush_ResultViewContainer", BaseViewContainer)

function V1a6_BossRush_ResultViewContainer:buildViews()
	return {
		V1a6_BossRush_ResultView.New()
	}
end

return V1a6_BossRush_ResultViewContainer
