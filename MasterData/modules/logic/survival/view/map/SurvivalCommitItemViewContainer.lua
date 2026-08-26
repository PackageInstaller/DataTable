-- chunkname: @modules/logic/survival/view/map/SurvivalCommitItemViewContainer.lua

module("modules.logic.survival.view.map.SurvivalCommitItemViewContainer", package.seeall)

local SurvivalCommitItemViewContainer = class("SurvivalCommitItemViewContainer", BaseViewContainer)

function SurvivalCommitItemViewContainer:buildViews()
	return {
		SurvivalCommitItemView.New()
	}
end

return SurvivalCommitItemViewContainer
