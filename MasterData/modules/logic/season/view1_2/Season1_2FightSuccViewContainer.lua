-- chunkname: @modules/logic/season/view1_2/Season1_2FightSuccViewContainer.lua

module("modules.logic.season.view1_2.Season1_2FightSuccViewContainer", package.seeall)

local Season1_2FightSuccViewContainer = class("Season1_2FightSuccViewContainer", BaseViewContainer)

function Season1_2FightSuccViewContainer:buildViews()
	return {
		Season1_2FightSuccView.New()
	}
end

function Season1_2FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_2FightSuccViewContainer
