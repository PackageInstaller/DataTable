-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1FightFailViewContainer", package.seeall)

local Season123_2_1FightFailViewContainer = class("Season123_2_1FightFailViewContainer", BaseViewContainer)

function Season123_2_1FightFailViewContainer:buildViews()
	return {
		Season123_2_1FightFailView.New()
	}
end

function Season123_2_1FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_1FightFailViewContainer
