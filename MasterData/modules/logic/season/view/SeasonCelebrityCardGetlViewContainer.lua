-- chunkname: @modules/logic/season/view/SeasonCelebrityCardGetlViewContainer.lua

module("modules.logic.season.view.SeasonCelebrityCardGetlViewContainer", package.seeall)

local SeasonCelebrityCardGetlViewContainer = class("SeasonCelebrityCardGetlViewContainer", BaseViewContainer)

function SeasonCelebrityCardGetlViewContainer:buildViews()
	return {
		SeasonCelebrityCardGetlView.New()
	}
end

function SeasonCelebrityCardGetlViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return SeasonCelebrityCardGetlViewContainer
