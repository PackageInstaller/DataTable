-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotDifficultyViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotDifficultyViewContainer", package.seeall)

local V1a6_CachotDifficultyViewContainer = class("V1a6_CachotDifficultyViewContainer", BaseViewContainer)

function V1a6_CachotDifficultyViewContainer:buildViews()
	return {
		V1a6_CachotDifficultyView.New()
	}
end

return V1a6_CachotDifficultyViewContainer
