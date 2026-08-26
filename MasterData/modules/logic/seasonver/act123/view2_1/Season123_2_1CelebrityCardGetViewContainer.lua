-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CelebrityCardGetViewContainer", package.seeall)

local Season123_2_1CelebrityCardGetViewContainer = class("Season123_2_1CelebrityCardGetViewContainer", BaseViewContainer)

function Season123_2_1CelebrityCardGetViewContainer:buildViews()
	return {
		Season123_2_1CelebrityCardGetView.New()
	}
end

function Season123_2_1CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_1CelebrityCardGetViewContainer
