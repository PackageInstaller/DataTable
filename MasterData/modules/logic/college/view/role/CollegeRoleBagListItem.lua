-- chunkname: @modules/logic/college/view/role/CollegeRoleBagListItem.lua

module("modules.logic.college.view.role.CollegeRoleBagListItem", package.seeall)

local CollegeRoleBagListItem = class("CollegeRoleBagListItem", CollegeRoleBaseListItem)

function CollegeRoleBagListItem:onInitView()
	CollegeRoleBagListItem.super.onInitView(self)
end

function CollegeRoleBagListItem:addEvents()
	CollegeRoleBagListItem.super.addEvents(self)
end

function CollegeRoleBagListItem:removeEvents()
	CollegeRoleBagListItem.super.removeEvents(self)
end

function CollegeRoleBagListItem:updateData(mo)
	CollegeRoleBagListItem.super.updateData(self, mo)

	self._canLevelUp = not self._isMaxLv and CollegeModel.instance:isEnoughItemsTb(self._cost)
end

function CollegeRoleBagListItem:refreshOtherUI()
	gohelper.setActive(self._goLvUp, self._canLevelUp)
end

return CollegeRoleBagListItem
