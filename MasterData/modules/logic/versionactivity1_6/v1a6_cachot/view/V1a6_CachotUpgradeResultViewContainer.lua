-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotUpgradeResultViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeResultViewContainer", package.seeall)

local V1a6_CachotUpgradeResultViewContainer = class("V1a6_CachotUpgradeResultViewContainer", BaseViewContainer)

function V1a6_CachotUpgradeResultViewContainer:buildViews()
	return {
		V1a6_CachotUpgradeResultView.New(),
		V1a6_CachotCurrencyView.New("top")
	}
end

return V1a6_CachotUpgradeResultViewContainer
