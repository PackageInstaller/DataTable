-- chunkname: @modules/logic/season/view1_2/Season1_2CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view1_2.Season1_2CelebrityCardGetlViewContainer", package.seeall)

local Season1_2CelebrityCardGetlViewContainer = class("Season1_2CelebrityCardGetlViewContainer", BaseViewContainer)

function Season1_2CelebrityCardGetlViewContainer:buildViews()
	return {
		Season1_2CelebrityCardGetlView.New()
	}
end

function Season1_2CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_2CelebrityCardGetlViewContainer
