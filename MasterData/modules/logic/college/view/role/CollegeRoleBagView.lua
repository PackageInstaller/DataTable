-- chunkname: @modules/logic/college/view/role/CollegeRoleBagView.lua

module("modules.logic.college.view.role.CollegeRoleBagView", package.seeall)

local CollegeRoleBagView = class("CollegeRoleBagView", CollegeRoleBaseView)

function CollegeRoleBagView:onOpen()
	CollegeRoleBagView.super.onOpen(self)
end

function CollegeRoleBagView:_btnRefreshOnClick()
	local selectMo = self._roleListModel._scrollViews[1]:getFirstSelect()

	ViewMgr.instance:openView(ViewName.CollegeRoleRefinedView, {
		selectMo = selectMo
	})
end

function CollegeRoleBagView:_btnRecruitOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRecruitView)
end

function CollegeRoleBagView:refreshBtnVisible()
	self._trainCharacterMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)
	self._recruitCharacterMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.RecruitCharacter)

	gohelper.setActive(self._goBtnRefresh, self._trainCharacterMo ~= nil)
	gohelper.setActive(self._goBtnRecruit, self._recruitCharacterMo ~= nil)
end

function CollegeRoleBagView:getPanelClass()
	return CollegeRoleBagPanelItem
end

return CollegeRoleBagView
