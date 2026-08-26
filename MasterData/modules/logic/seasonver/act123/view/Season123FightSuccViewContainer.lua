-- chunkname: @modules/logic/seasonver/act123/view/Season123FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123FightSuccViewContainer", package.seeall)

local Season123FightSuccViewContainer = class("Season123FightSuccViewContainer", BaseViewContainer)

function Season123FightSuccViewContainer:buildViews()
	return {
		Season123FightSuccView.New()
	}
end

function Season123FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123FightSuccViewContainer
