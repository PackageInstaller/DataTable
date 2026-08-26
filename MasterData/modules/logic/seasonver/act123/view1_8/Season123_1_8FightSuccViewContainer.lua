-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightSuccViewContainer", package.seeall)

local Season123_1_8FightSuccViewContainer = class("Season123_1_8FightSuccViewContainer", BaseViewContainer)

function Season123_1_8FightSuccViewContainer:buildViews()
	return {
		Season123_1_8FightSuccView.New()
	}
end

function Season123_1_8FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_8FightSuccViewContainer
