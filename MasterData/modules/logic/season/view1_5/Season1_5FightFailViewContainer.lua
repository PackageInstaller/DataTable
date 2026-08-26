-- chunkname: @modules/logic/season/view1_5/Season1_5FightFailViewContainer.lua

module("modules.logic.season.view1_5.Season1_5FightFailViewContainer", package.seeall)

local Season1_5FightFailViewContainer = class("Season1_5FightFailViewContainer", BaseViewContainer)

function Season1_5FightFailViewContainer:buildViews()
	return {
		Season1_5FightFailView.New()
	}
end

function Season1_5FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_5FightFailViewContainer
