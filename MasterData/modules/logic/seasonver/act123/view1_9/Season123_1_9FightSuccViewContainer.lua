-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightSuccViewContainer", package.seeall)

local Season123_1_9FightSuccViewContainer = class("Season123_1_9FightSuccViewContainer", BaseViewContainer)

function Season123_1_9FightSuccViewContainer:buildViews()
	return {
		Season123_1_9FightSuccView.New()
	}
end

function Season123_1_9FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_9FightSuccViewContainer
