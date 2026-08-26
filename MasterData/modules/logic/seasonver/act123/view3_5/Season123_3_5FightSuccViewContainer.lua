-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5FightSuccViewContainer", package.seeall)

local Season123_3_5FightSuccViewContainer = class("Season123_3_5FightSuccViewContainer", BaseViewContainer)

function Season123_3_5FightSuccViewContainer:buildViews()
	return {
		Season123_3_5FightSuccView.New()
	}
end

function Season123_3_5FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_3_5FightSuccViewContainer
