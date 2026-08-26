-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CelebrityCardGetViewContainer", package.seeall)

local Season123_3_5CelebrityCardGetViewContainer = class("Season123_3_5CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_3_5CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_3_5CelebrityCardGetView.New()
	}
end

function Season123_3_5CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_3_5CelebrityCardGetViewContainer
