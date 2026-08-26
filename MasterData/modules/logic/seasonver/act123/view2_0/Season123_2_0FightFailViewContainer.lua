-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightFailViewContainer", package.seeall)

local Season123_2_0FightFailViewContainer = class("Season123_2_0FightFailViewContainer", BaseViewContainer)

function Season123_2_0FightFailViewContainer:buildViews()
	return {
		Season123_2_0FightFailView.New()
	}
end

function Season123_2_0FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_0FightFailViewContainer
