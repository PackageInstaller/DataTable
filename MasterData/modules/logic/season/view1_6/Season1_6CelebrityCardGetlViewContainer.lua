-- chunkname: @modules/logic/season/view1_6/Season1_6CelebrityCardGetlViewContainer.lua

module("modules.logic.season.view1_6.Season1_6CelebrityCardGetlViewContainer", package.seeall)

local Season1_6CelebrityCardGetlViewContainer = class("Season1_6CelebrityCardGetlViewContainer", BaseViewContainer)

function Season1_6CelebrityCardGetlViewContainer:buildViews()
	return {
		Season1_6CelebrityCardGetlView.New()
	}
end

function Season1_6CelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_6CelebrityCardGetlViewContainer
