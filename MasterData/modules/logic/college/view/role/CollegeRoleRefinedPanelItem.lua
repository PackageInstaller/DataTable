-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedPanelItem.lua

module("modules.logic.college.view.role.CollegeRoleRefinedPanelItem", package.seeall)

local CollegeRoleRefinedPanelItem = class("CollegeRoleRefinedPanelItem", CollegeRoleBasePanelItem)

function CollegeRoleRefinedPanelItem:updateData(mo)
	CollegeRoleRefinedPanelItem.super.updateData(self, mo)
end

function CollegeRoleRefinedPanelItem:_btnClickOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRefinedBagView, {
		selectMo = self._mo
	})
end

function CollegeRoleRefinedPanelItem:refreshEmptyUI()
	CollegeRoleRefinedPanelItem.super.refreshEmptyUI(self)
	gohelper.setActive(self._goAdd, true)
	gohelper.setActive(self._goHas, false)
	gohelper.setActive(self._goEmpty, false)

	self._canvasAdd.interactable = true
	self._canvasAdd.blocksRaycasts = true

	self:playAnim("add")
end

function CollegeRoleRefinedPanelItem:refreshCommonUI()
	CollegeRoleRefinedPanelItem.super.refreshCommonUI(self)
	gohelper.setActive(self._goHas, true)
	gohelper.setActive(self._goAdd, false)
	gohelper.setActive(self._goEmpty, false)

	self._canvasAdd.interactable = false
	self._canvasAdd.blocksRaycasts = false
end

function CollegeRoleRefinedPanelItem:getEntryClass()
	return CollegeRoleRefinedEntryItem
end

function CollegeRoleRefinedPanelItem:getShowEntries()
	return self._mo.entries
end

return CollegeRoleRefinedPanelItem
