-- chunkname: @modules/logic/season/view1_4/Season1_4CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view1_4.Season1_4CelebrityCardGetlViewContainer", package.seeall)

local Season1_4CelebrityCardGetlViewContainer = class("Season1_4CelebrityCardGetlViewContainer", BaseViewContainer)

function Season1_4CelebrityCardGetlViewContainer:buildViews()
	return {
		Season1_4CelebrityCardGetlView.New()
	}
end

function Season1_4CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_4CelebrityCardGetlViewContainer
