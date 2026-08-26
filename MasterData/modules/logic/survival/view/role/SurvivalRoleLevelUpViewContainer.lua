-- chunkname: @modules/logic/survival/view/role/SurvivalRoleLevelUpViewContainer.lua

module("modules.logic.survival.view.role.SurvivalRoleLevelUpViewContainer", package.seeall)

local SurvivalRoleLevelUpViewContainer = class("SurvivalRoleLevelUpViewContainer", BaseViewContainer)

function SurvivalRoleLevelUpViewContainer:buildViews()
	return {
		SurvivalRoleLevelUpView.New()
	}
end

return SurvivalRoleLevelUpViewContainer
