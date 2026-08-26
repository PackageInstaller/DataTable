-- chunkname: @modules/logic/season/view3_0/Season3_0FightFailViewContainer.lua

module("modules.logic.season.view3_0.Season3_0FightFailViewContainer", package.seeall)

local Season3_0FightFailViewContainer = class("Season3_0FightFailViewContainer", BaseViewContainer)

function Season3_0FightFailViewContainer:buildViews()
	return {
		Season3_0FightFailView.New()
	}
end

function Season3_0FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season3_0FightFailViewContainer
