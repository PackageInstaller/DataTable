-- chunkname: @modules/logic/college/view/role/CollegeRoleDispatchViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleDispatchViewContainer", package.seeall)

local CollegeRoleDispatchViewContainer = class("CollegeRoleDispatchViewContainer", CollegeRoleBaseViewContainer)

function CollegeRoleDispatchViewContainer:buildMainViews()
	return {
		CollegeRoleDispatchView.New(),
		CollegeVisibleBaseView.New()
	}
end

function CollegeRoleDispatchViewContainer:onContainerInit()
	CollegeRoleDispatchViewContainer.super.onContainerInit(self)
	CollegeRoleDispatchListModel.instance:clear()
end

function CollegeRoleDispatchViewContainer:getRoleCellClass()
	return CollegeRoleDispatchListItem
end

function CollegeRoleDispatchViewContainer:getRoleListModelCls()
	return CollegeRoleDispatchListModel
end

return CollegeRoleDispatchViewContainer
