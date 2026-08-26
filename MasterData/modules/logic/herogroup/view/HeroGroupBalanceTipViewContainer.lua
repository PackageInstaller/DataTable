-- chunkname: @modules/logic/herogroup/view/HeroGroupBalanceTipViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupBalanceTipViewContainer", package.seeall)

local HeroGroupBalanceTipViewContainer = class("HeroGroupBalanceTipViewContainer", BaseViewContainer)

function HeroGroupBalanceTipViewContainer:buildViews()
	return {
		HeroGroupBalanceTipView.New()
	}
end

return HeroGroupBalanceTipViewContainer
