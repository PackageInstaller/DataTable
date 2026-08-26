-- chunkname: @modules/logic/season/view1_3/Season1_3FightFailViewContainer.lua

module("modules.logic.season.view1_3.Season1_3FightFailViewContainer", package.seeall)

local Season1_3FightFailViewContainer = class("Season1_3FightFailViewContainer", BaseViewContainer)

function Season1_3FightFailViewContainer:buildViews()
	return {
		Season1_3FightFailView.New()
	}
end

function Season1_3FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_3FightFailViewContainer
