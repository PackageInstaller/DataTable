-- chunkname: @modules/logic/season/view1_6/Season1_6FightSuccViewContainer.lua

module("modules.logic.season.view1_6.Season1_6FightSuccViewContainer", package.seeall)

local Season1_6FightSuccViewContainer = class("Season1_6FightSuccViewContainer", BaseViewContainer)

function Season1_6FightSuccViewContainer:buildViews()
	return {
		Season1_6FightSuccView.New()
	}
end

function Season1_6FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_6FightSuccViewContainer
