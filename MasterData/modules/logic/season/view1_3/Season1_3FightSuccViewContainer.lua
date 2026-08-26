-- chunkname: @modules/logic/season/view1_3/Season1_3FightSuccViewContainer.lua

module("modules.logic.season.view1_3.Season1_3FightSuccViewContainer", package.seeall)

local Season1_3FightSuccViewContainer = class("Season1_3FightSuccViewContainer", BaseViewContainer)

function Season1_3FightSuccViewContainer:buildViews()
	return {
		Season1_3FightSuccView.New()
	}
end

function Season1_3FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_3FightSuccViewContainer
