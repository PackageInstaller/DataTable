-- chunkname: @modules/logic/fight/view/FightTechniqueGuideViewContainer.lua

module("modules.logic.fight.view.FightTechniqueGuideViewContainer", package.seeall)

local FightTechniqueGuideViewContainer = class("FightTechniqueGuideViewContainer", BaseViewContainer)

function FightTechniqueGuideViewContainer:buildViews()
	return {
		FightTechniqueGuideView.New()
	}
end

function FightTechniqueGuideViewContainer:buildTabViews(tabContainerId)
	return
end

return FightTechniqueGuideViewContainer
