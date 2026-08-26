-- chunkname: @modules/logic/season/view1_2/Season1_2FightFailViewContainer.lua

module("modules.logic.season.view1_2.Season1_2FightFailViewContainer", package.seeall)

local Season1_2FightFailViewContainer = class("Season1_2FightFailViewContainer", BaseViewContainer)

function Season1_2FightFailViewContainer:buildViews()
	return {
		Season1_2FightFailView.New()
	}
end

function Season1_2FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_2FightFailViewContainer
