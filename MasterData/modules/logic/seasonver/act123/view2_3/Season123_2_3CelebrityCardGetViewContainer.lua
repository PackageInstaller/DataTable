-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3CelebrityCardGetViewContainer", package.seeall)

local Season123_2_3CelebrityCardGetViewContainer = class("Season123_2_3CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_2_3CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_2_3CelebrityCardGetView.New()
	}
end

function Season123_2_3CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_3CelebrityCardGetViewContainer
