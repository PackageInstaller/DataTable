-- chunkname: @modules/logic/season/view1_4/Season1_4FightFailViewContainer.lua

module("modules.logic.season.view1_4.Season1_4FightFailViewContainer", package.seeall)

local Season1_4FightFailViewContainer = class("Season1_4FightFailViewContainer", BaseViewContainer)

function Season1_4FightFailViewContainer:buildViews()
	return {
		Season1_4FightFailView.New()
	}
end

function Season1_4FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_4FightFailViewContainer
