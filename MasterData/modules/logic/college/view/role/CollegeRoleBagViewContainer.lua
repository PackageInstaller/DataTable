-- chunkname: @modules/logic/college/view/role/CollegeRoleBagViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleBagViewContainer", package.seeall)

local CollegeRoleBagViewContainer = class("CollegeRoleBagViewContainer", CollegeRoleBaseViewContainer)

function CollegeRoleBagViewContainer:buildMainViews()
	return {
		CollegeRoleBagView.New(),
		CollegeVisibleBaseView.New()
	}
end

function CollegeRoleBagViewContainer:getRoleCellClass()
	return CollegeRoleBagListItem
end

function CollegeRoleBagViewContainer:getRoleListModelCls()
	return CollegeRoleListModel
end

return CollegeRoleBagViewContainer
