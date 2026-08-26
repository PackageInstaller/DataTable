-- chunkname: @modules/logic/seasonver/act123/view/Season123FightFailViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123FightFailViewContainer", package.seeall)

local Season123FightFailViewContainer = class("Season123FightFailViewContainer", BaseViewContainer)

function Season123FightFailViewContainer:buildViews()
	return {
		Season123FightFailView.New()
	}
end

function Season123FightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123FightFailViewContainer
