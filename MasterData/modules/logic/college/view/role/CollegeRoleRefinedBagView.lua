-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedBagView.lua

module("modules.logic.college.view.role.CollegeRoleRefinedBagView", package.seeall)

local CollegeRoleRefinedBagView = class("CollegeRoleRefinedBagView", CollegeRoleBagView)

function CollegeRoleRefinedBagView:onInitView()
	CollegeRoleRefinedBagView.super.onInitView(self)
end

function CollegeRoleRefinedBagView:_btnConfirmOnClick()
	local selectMo = self._roleListModel._scrollViews[1]:getFirstSelect()

	CollegeController.instance:dispatchEvent(CollegeEvent.OnSelectRefined, selectMo)
	self:closeThis()
end

function CollegeRoleRefinedBagView:_btnCancelOnClick()
	self:closeThis()
end

function CollegeRoleRefinedBagView:refreshBtnVisible()
	gohelper.setActive(self._goBtnConfirm, true)
	gohelper.setActive(self._goBtnCancel, true)
end

function CollegeRoleRefinedBagView:getPanelClass()
	return CollegeRoleBasePanelItem
end

return CollegeRoleRefinedBagView
