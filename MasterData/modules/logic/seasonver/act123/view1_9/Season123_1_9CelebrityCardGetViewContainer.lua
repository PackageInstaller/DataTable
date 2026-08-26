-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9CelebrityCardGetViewContainer", package.seeall)

local Season123_1_9CelebrityCardGetViewContainer = class("Season123_1_9CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_1_9CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_1_9CelebrityCardGetView.New()
	}
end

function Season123_1_9CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_9CelebrityCardGetViewContainer
