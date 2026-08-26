-- chunkname: @modules/logic/season/view/SeasonFightSuccViewContainer.lua

module("modules.logic.season.view.SeasonFightSuccViewContainer", package.seeall)

local SeasonFightSuccViewContainer = class("SeasonFightSuccViewContainer", BaseViewContainer)

function SeasonFightSuccViewContainer:buildViews()
	return {
		SeasonFightSuccView.New()
	}
end

function SeasonFightSuccViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return SeasonFightSuccViewContainer
