-- chunkname: @modules/logic/survival/view/tippopview/SurvivalRoleLevelTipPopViewContainer.lua

module("modules.logic.survival.view.tippopview.SurvivalRoleLevelTipPopViewContainer", package.seeall)

local SurvivalRoleLevelTipPopViewContainer = class("SurvivalRoleLevelTipPopViewContainer", BaseViewContainer)

function SurvivalRoleLevelTipPopViewContainer:buildViews()
	return {
		SurvivalRoleLevelTipPopView.New()
	}
end

return SurvivalRoleLevelTipPopViewContainer
