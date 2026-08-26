-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEpisodeViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEpisodeViewContainer", package.seeall)

local V1a6_CachotEpisodeViewContainer = class("V1a6_CachotEpisodeViewContainer", BaseViewContainer)

function V1a6_CachotEpisodeViewContainer:buildViews()
	return {
		V1a6_CachotEpisodeView.New(),
		V1a6_CachotInteractView.New(),
		V1a6_CachotHeartView.New("top/#go_heart"),
		V1a6_CachotCurrencyView.New("top")
	}
end

return V1a6_CachotEpisodeViewContainer
