-- chunkname: @modules/logic/herogroup/view/HeroGroupModifyNameViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupModifyNameViewContainer", package.seeall)

local HeroGroupModifyNameViewContainer = class("HeroGroupModifyNameViewContainer", BaseViewContainer)

function HeroGroupModifyNameViewContainer:buildViews()
	return {
		HeroGroupModifyNameView.New()
	}
end

function HeroGroupModifyNameViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function HeroGroupModifyNameViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

return HeroGroupModifyNameViewContainer
