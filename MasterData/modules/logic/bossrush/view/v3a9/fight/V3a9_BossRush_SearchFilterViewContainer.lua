-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_SearchFilterViewContainer.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_SearchFilterViewContainer", package.seeall)

local V3a9_BossRush_SearchFilterViewContainer = class("V3a9_BossRush_SearchFilterViewContainer", BaseViewContainer)

function V3a9_BossRush_SearchFilterViewContainer:buildViews()
	return {
		V3a9_BossRush_SearchFilterView.New()
	}
end

return V3a9_BossRush_SearchFilterViewContainer
