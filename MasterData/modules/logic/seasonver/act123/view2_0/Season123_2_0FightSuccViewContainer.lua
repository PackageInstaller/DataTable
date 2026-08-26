-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightSuccViewContainer", package.seeall)

local Season123_2_0FightSuccViewContainer = class("Season123_2_0FightSuccViewContainer", BaseViewContainer)

function Season123_2_0FightSuccViewContainer:buildViews()
	return {
		Season123_2_0FightSuccView.New()
	}
end

function Season123_2_0FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_0FightSuccViewContainer
