-- chunkname: @modules/logic/survival/view/leavemessage/SurvivalGiveBackViewContainer.lua

module("modules.logic.survival.view.leavemessage.SurvivalGiveBackViewContainer", package.seeall)

local SurvivalGiveBackViewContainer = class("SurvivalGiveBackViewContainer", BaseViewContainer)

function SurvivalGiveBackViewContainer:buildViews()
	return {
		SurvivalGiveBackView.New()
	}
end

function SurvivalGiveBackViewContainer:buildTabViews(tabContainerId)
	return
end

return SurvivalGiveBackViewContainer
