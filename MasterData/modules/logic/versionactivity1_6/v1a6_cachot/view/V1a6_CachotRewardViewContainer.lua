-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRewardViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardViewContainer", package.seeall)

local V1a6_CachotRewardViewContainer = class("V1a6_CachotRewardViewContainer", BaseViewContainer)

function V1a6_CachotRewardViewContainer:buildViews()
	return {
		V1a6_CachotRewardView.New(),
		V1a6_CachotCurrencyView.New(),
		V1a6_CachotRoomEventTipsView.New()
	}
end

return V1a6_CachotRewardViewContainer
