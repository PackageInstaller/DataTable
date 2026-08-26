-- chunkname: @modules/logic/season/view1_5/Season1_5FightSuccViewContainer.lua

module("modules.logic.season.view1_5.Season1_5FightSuccViewContainer", package.seeall)

local Season1_5FightSuccViewContainer = class("Season1_5FightSuccViewContainer", BaseViewContainer)

function Season1_5FightSuccViewContainer:buildViews()
	return {
		Season1_5FightSuccView.New()
	}
end

function Season1_5FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_5FightSuccViewContainer
