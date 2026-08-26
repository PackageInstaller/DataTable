-- chunkname: @modules/logic/season/view1_3/Season1_3CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view1_3.Season1_3CelebrityCardGetlViewContainer", package.seeall)

local Season1_3CelebrityCardGetlViewContainer = class("Season1_3CelebrityCardGetlViewContainer", BaseViewContainer)

function Season1_3CelebrityCardGetlViewContainer:buildViews()
	return {
		Season1_3CelebrityCardGetlView.New()
	}
end

function Season1_3CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_3CelebrityCardGetlViewContainer
