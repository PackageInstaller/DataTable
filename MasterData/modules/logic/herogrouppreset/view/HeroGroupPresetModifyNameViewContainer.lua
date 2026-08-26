-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetModifyNameViewContainer.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetModifyNameViewContainer", package.seeall)

local HeroGroupPresetModifyNameViewContainer = class("HeroGroupPresetModifyNameViewContainer", BaseViewContainer)

function HeroGroupPresetModifyNameViewContainer:buildViews()
	return {
		HeroGroupPresetModifyNameView.New()
	}
end

function HeroGroupPresetModifyNameViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function HeroGroupPresetModifyNameViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

return HeroGroupPresetModifyNameViewContainer
