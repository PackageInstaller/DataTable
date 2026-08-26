-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightFailViewContainer", package.seeall)

local Season123_1_8FightFailViewContainer = class("Season123_1_8FightFailViewContainer", BaseViewContainer)

function Season123_1_8FightFailViewContainer:buildViews()
	return {
		Season123_1_8FightFailView.New()
	}
end

function Season123_1_8FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_8FightFailViewContainer
