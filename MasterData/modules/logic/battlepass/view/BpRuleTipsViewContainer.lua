-- chunkname: @modules/logic/battlepass/view/BpRuleTipsViewContainer.lua

module("modules.logic.battlepass.view.BpRuleTipsViewContainer", package.seeall)

local BpRuleTipsViewContainer = class("BpRuleTipsViewContainer", BaseViewContainer)

function BpRuleTipsViewContainer:buildViews()
	return {
		BpRuleTipsView.New()
	}
end

function BpRuleTipsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return BpRuleTipsViewContainer
