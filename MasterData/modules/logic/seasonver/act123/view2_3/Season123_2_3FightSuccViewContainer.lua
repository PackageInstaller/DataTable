-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightSuccViewContainer", package.seeall)

local Season123_2_3FightSuccViewContainer = class("Season123_2_3FightSuccViewContainer", BaseViewContainer)

function Season123_2_3FightSuccViewContainer:buildViews()
	return {
		Season123_2_3FightSuccView.New()
	}
end

function Season123_2_3FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_3FightSuccViewContainer
