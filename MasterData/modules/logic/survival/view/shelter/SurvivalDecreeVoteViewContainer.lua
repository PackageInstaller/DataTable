-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeVoteViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeVoteViewContainer", package.seeall)

local SurvivalDecreeVoteViewContainer = class("SurvivalDecreeVoteViewContainer", BaseViewContainer)

function SurvivalDecreeVoteViewContainer:buildViews()
	local views = {}

	table.insert(views, SurvivalDecreeVoteView.New())

	return views
end

return SurvivalDecreeVoteViewContainer
