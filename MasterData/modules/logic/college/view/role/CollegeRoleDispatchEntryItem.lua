-- chunkname: @modules/logic/college/view/role/CollegeRoleDispatchEntryItem.lua

module("modules.logic.college.view.role.CollegeRoleDispatchEntryItem", package.seeall)

local CollegeRoleDispatchEntryItem = class("CollegeRoleDispatchEntryItem", CollegeRoleBaseEntryItem)

function CollegeRoleDispatchEntryItem:updateData(entryMo, characterMo, parentView, index)
	CollegeRoleDispatchEntryItem.super.updateData(self, entryMo, characterMo, parentView, index)

	self._newLocation = parentView._newLocation
end

function CollegeRoleDispatchEntryItem:refreshOtherUI()
	local isTendency = CollegeConfig.instance:isEntryTendencyBuilding(self._entryId, self._newLocation.id)

	gohelper.setActive(self._goLike, isTendency)
end

return CollegeRoleDispatchEntryItem
