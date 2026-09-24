-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedNewEntryItem.lua

module("modules.logic.college.view.role.CollegeRoleRefinedNewEntryItem", package.seeall)

local CollegeRoleRefinedNewEntryItem = class("CollegeRoleRefinedNewEntryItem", CollegeRoleBaseEntryItem)

function CollegeRoleRefinedNewEntryItem:onUpdateMO(entryMo, characterMo, parentView, index, isNew)
	self._isNew = isNew

	CollegeRoleRefinedNewEntryItem.super.onUpdateMO(self, entryMo, characterMo, parentView, index)
end

function CollegeRoleRefinedNewEntryItem:refreshOtherUI()
	CollegeRoleRefinedNewEntryItem.super.refreshOtherUI(self)
	gohelper.setActive(self._goNew, self._isNew)
	gohelper.setActive(self._goRefreshBg, self._isNew)

	if self._isNew then
		self:playAnim("update")
	end
end

return CollegeRoleRefinedNewEntryItem
