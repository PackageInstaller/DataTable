-- chunkname: @modules/logic/season/view3_0/Season3_0CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view3_0.Season3_0CelebrityCardGetlViewContainer", package.seeall)

local Season3_0CelebrityCardGetlViewContainer = class("Season3_0CelebrityCardGetlViewContainer", BaseViewContainer)

function Season3_0CelebrityCardGetlViewContainer:buildViews()
	return {
		Season3_0CelebrityCardGetlView.New()
	}
end

function Season3_0CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season3_0CelebrityCardGetlViewContainer
