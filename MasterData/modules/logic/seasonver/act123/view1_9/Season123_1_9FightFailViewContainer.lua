-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightFailViewContainer", package.seeall)

local Season123_1_9FightFailViewContainer = class("Season123_1_9FightFailViewContainer", BaseViewContainer)

function Season123_1_9FightFailViewContainer:buildViews()
	return {
		Season123_1_9FightFailView.New()
	}
end

function Season123_1_9FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_9FightFailViewContainer
