-- chunkname: @modules/logic/season/view1_5/Season1_5CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view1_5.Season1_5CelebrityCardGetlViewContainer", package.seeall)

local Season1_5CelebrityCardGetlViewContainer = class("Season1_5CelebrityCardGetlViewContainer", BaseViewContainer)

function Season1_5CelebrityCardGetlViewContainer:buildViews()
	return {
		Season1_5CelebrityCardGetlView.New()
	}
end

function Season1_5CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_5CelebrityCardGetlViewContainer
