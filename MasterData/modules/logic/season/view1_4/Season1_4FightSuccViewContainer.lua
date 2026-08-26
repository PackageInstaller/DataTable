-- chunkname: @modules/logic/season/view1_4/Season1_4FightSuccViewContainer.lua

module("modules.logic.season.view1_4.Season1_4FightSuccViewContainer", package.seeall)

local Season1_4FightSuccViewContainer = class("Season1_4FightSuccViewContainer", BaseViewContainer)

function Season1_4FightSuccViewContainer:buildViews()
	return {
		Season1_4FightSuccView.New()
	}
end

function Season1_4FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_4FightSuccViewContainer
