-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1FightSuccViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1FightSuccViewContainer", package.seeall)

local Season123_2_1FightSuccViewContainer = class("Season123_2_1FightSuccViewContainer", BaseViewContainer)

function Season123_2_1FightSuccViewContainer:buildViews()
	return {
		Season123_2_1FightSuccView.New()
	}
end

function Season123_2_1FightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_1FightSuccViewContainer
