-- chunkname: @modules/logic/survival/view/reputation/SurvivalReputationSelectViewContainer.lua

module("modules.logic.survival.view.reputation.SurvivalReputationSelectViewContainer", package.seeall)

local SurvivalReputationSelectViewContainer = class("SurvivalReputationSelectViewContainer", BaseViewContainer)

function SurvivalReputationSelectViewContainer:buildViews()
	return {
		SurvivalReputationSelectView.New()
	}
end

function SurvivalReputationSelectViewContainer:buildTabViews(tabContainerId)
	return
end

function SurvivalReputationSelectViewContainer:onContainerOpenFinish()
	return
end

return SurvivalReputationSelectViewContainer
