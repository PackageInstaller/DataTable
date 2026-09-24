-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedNewPanelItem.lua

module("modules.logic.college.view.role.CollegeRoleRefinedNewPanelItem", package.seeall)

local CollegeRoleRefinedNewPanelItem = class("CollegeRoleRefinedNewPanelItem", CollegeRoleRefinedPanelItem)

function CollegeRoleRefinedNewPanelItem:onUpdateMO(mo, newEntryIndexMap)
	self._newEntryIndexMap = newEntryIndexMap

	CollegeRoleRefinedNewPanelItem.super.onUpdateMO(self, mo)
end

function CollegeRoleRefinedNewPanelItem:getEntryClass()
	return CollegeRoleRefinedNewEntryItem
end

function CollegeRoleRefinedNewPanelItem:_refreshEntryItem(entryItem, entryMo, index)
	if self._newEntryIndexMap then
		local isNew = self._newEntryIndexMap[index] == true

		entryItem:onUpdateMO(entryMo, self._mo, self, index, isNew)
	end
end

return CollegeRoleRefinedNewPanelItem
