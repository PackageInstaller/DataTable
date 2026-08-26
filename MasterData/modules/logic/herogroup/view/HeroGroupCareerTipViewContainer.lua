-- chunkname: @modules/logic/herogroup/view/HeroGroupCareerTipViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupCareerTipViewContainer", package.seeall)

local HeroGroupCareerTipViewContainer = class("HeroGroupCareerTipViewContainer", BaseViewContainer)

function HeroGroupCareerTipViewContainer:buildViews()
	return {
		HeroGroupCareerTipView.New()
	}
end

function HeroGroupCareerTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return HeroGroupCareerTipViewContainer
