-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CelebrityCardGetViewContainer", package.seeall)

local Season123_1_8CelebrityCardGetViewContainer = class("Season123_1_8CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_1_8CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_1_8CelebrityCardGetView.New()
	}
end

function Season123_1_8CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_8CelebrityCardGetViewContainer
