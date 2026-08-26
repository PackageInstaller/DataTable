-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_EnterViewContainer.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_EnterViewContainer", package.seeall)

local V1a6_BossRush_EnterViewContainer = class("V1a6_BossRush_EnterViewContainer", BaseViewContainer)

function V1a6_BossRush_EnterViewContainer:buildViews()
	return {
		V1a6_BossRush_EnterView.New()
	}
end

return V1a6_BossRush_EnterViewContainer
