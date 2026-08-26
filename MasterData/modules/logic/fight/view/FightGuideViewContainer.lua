-- chunkname: @modules/logic/fight/view/FightGuideViewContainer.lua

module("modules.logic.fight.view.FightGuideViewContainer", package.seeall)

local FightGuideViewContainer = class("FightGuideViewContainer", BaseViewContainer)

function FightGuideViewContainer:buildViews()
	return {
		FightGuideView.New()
	}
end

function FightGuideViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return FightGuideViewContainer
