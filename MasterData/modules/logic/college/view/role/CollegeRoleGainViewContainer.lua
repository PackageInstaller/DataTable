-- chunkname: @modules/logic/college/view/role/CollegeRoleGainViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleGainViewContainer", package.seeall)

local CollegeRoleGainViewContainer = class("CollegeRoleGainViewContainer", BaseViewContainer)

function CollegeRoleGainViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeRoleGainView.New())
	table.insert(views, CollegeVisibleBaseView.New())

	return views
end

return CollegeRoleGainViewContainer
