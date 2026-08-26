-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotUpgradeViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeViewContainer", package.seeall)

local V1a6_CachotUpgradeViewContainer = class("V1a6_CachotUpgradeViewContainer", BaseViewContainer)

function V1a6_CachotUpgradeViewContainer:buildViews()
	return {
		V1a6_CachotUpgradeView.New(),
		V1a6_CachotCurrencyView.New("top")
	}
end

return V1a6_CachotUpgradeViewContainer
