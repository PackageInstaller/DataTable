-- chunkname: @modules/logic/season/view3_0/Season3_0FightSuccViewContainer.lua

module("modules.logic.season.view3_0.Season3_0FightSuccViewContainer", package.seeall)

local Season3_0FightSuccViewContainer = class("Season3_0FightSuccViewContainer", BaseViewContainer)

function Season3_0FightSuccViewContainer:buildViews()
	return {
		Season3_0FightSuccView.New()
	}
end

function Season3_0FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season3_0FightSuccViewContainer
