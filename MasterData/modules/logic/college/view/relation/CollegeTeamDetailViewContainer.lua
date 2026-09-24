-- chunkname: @modules/logic/college/view/relation/CollegeTeamDetailViewContainer.lua

module("modules.logic.college.view.relation.CollegeTeamDetailViewContainer", package.seeall)

local CollegeTeamDetailViewContainer = class("CollegeTeamDetailViewContainer", BaseViewContainer)

function CollegeTeamDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeTeamDetailView.New())

	return views
end

return CollegeTeamDetailViewContainer
