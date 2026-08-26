-- chunkname: @modules/logic/season/view/SeasonFightFailViewContainer.lua

module("modules.logic.season.view.SeasonFightFailViewContainer", package.seeall)

local SeasonFightFailViewContainer = class("SeasonFightFailViewContainer", BaseViewContainer)

function SeasonFightFailViewContainer:buildViews()
	return {
		SeasonFightFailView.New()
	}
end

function SeasonFightFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return SeasonFightFailViewContainer
