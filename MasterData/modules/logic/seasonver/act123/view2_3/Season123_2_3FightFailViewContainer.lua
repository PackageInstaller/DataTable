-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightFailViewContainer", package.seeall)

local Season123_2_3FightFailViewContainer = class("Season123_2_3FightFailViewContainer", BaseViewContainer)

function Season123_2_3FightFailViewContainer:buildViews()
	return {
		Season123_2_3FightFailView.New()
	}
end

function Season123_2_3FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_3FightFailViewContainer
