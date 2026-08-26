-- chunkname: @modules/logic/season/view1_6/Season1_6FightFailViewContainer.lua

module("modules.logic.season.view1_6.Season1_6FightFailViewContainer", package.seeall)

local Season1_6FightFailViewContainer = class("Season1_6FightFailViewContainer", BaseViewContainer)

function Season1_6FightFailViewContainer:buildViews()
	return {
		Season1_6FightFailView.New()
	}
end

function Season1_6FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_6FightFailViewContainer
