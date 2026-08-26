-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardGetViewContainer", package.seeall)

local Season123_2_0CelebrityCardGetViewContainer = class("Season123_2_0CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_2_0CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_2_0CelebrityCardGetView.New()
	}
end

function Season123_2_0CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_0CelebrityCardGetViewContainer
