-- chunkname: @modules/logic/survival/view/map/SurvivalCommonTipsViewContainer.lua

module("modules.logic.survival.view.map.SurvivalCommonTipsViewContainer", package.seeall)

local SurvivalCommonTipsViewContainer = class("SurvivalCommonTipsViewContainer", BaseViewContainer)

function SurvivalCommonTipsViewContainer:buildViews()
	return {
		SurvivalCommonTipsView.New()
	}
end

function SurvivalCommonTipsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return SurvivalCommonTipsViewContainer
