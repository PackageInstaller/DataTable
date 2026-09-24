-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedBagViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleRefinedBagViewContainer", package.seeall)

local CollegeRoleRefinedBagViewContainer = class("CollegeRoleRefinedBagViewContainer", CollegeRoleBaseViewContainer)

function CollegeRoleRefinedBagViewContainer:buildMainViews()
	return {
		CollegeRoleRefinedBagView.New(),
		CollegeVisibleBaseView.New()
	}
end

return CollegeRoleRefinedBagViewContainer
