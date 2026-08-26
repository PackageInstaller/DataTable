-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5FightFailViewContainer", package.seeall)

local Season123_3_5FightFailViewContainer = class("Season123_3_5FightFailViewContainer", BaseViewContainer)

function Season123_3_5FightFailViewContainer:buildViews()
	return {
		Season123_3_5FightFailView.New()
	}
end

function Season123_3_5FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_3_5FightFailViewContainer
