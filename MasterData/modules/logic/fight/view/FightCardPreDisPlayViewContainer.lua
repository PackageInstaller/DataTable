-- chunkname: @modules/logic/fight/view/FightCardPreDisPlayViewContainer.lua

module("modules.logic.fight.view.FightCardPreDisPlayViewContainer", package.seeall)

local FightCardPreDisPlayViewContainer = class("FightCardPreDisPlayViewContainer", BaseViewContainer)

function FightCardPreDisPlayViewContainer:buildViews()
	return {
		FightCardPreDisPlayView.New()
	}
end

function FightCardPreDisPlayViewContainer:buildTabViews(tabContainerId)
	return
end

return FightCardPreDisPlayViewContainer
