-- chunkname: @modules/logic/college/view/role/CollegeRoleRecruitPanelItem.lua

module("modules.logic.college.view.role.CollegeRoleRecruitPanelItem", package.seeall)

local CollegeRoleRecruitPanelItem = class("CollegeRoleRecruitPanelItem", CollegeRoleBasePanelItem)

function CollegeRoleRecruitPanelItem:onUpdateMO(mo, buildingMo)
	self._buildingMo = buildingMo
	self._buildingId = self._buildingMo and self._buildingMo.id
	self._characterBox = CollegeModel.instance:getSceneMo().characterBox

	CollegeRoleRecruitPanelItem.super.onUpdateMO(self, mo)
end

function CollegeRoleRecruitPanelItem:_btnRecruitOnClick()
	if CollegeHelper.instance:checkCanRecruit() then
		CollegeController.instance:dispatchEvent(CollegeEvent.ConfirmRecruit, self._index)
	end
end

function CollegeRoleRecruitPanelItem:refreshBtnVisible()
	gohelper.setActive(self._goBtnRecruit, true)
end

return CollegeRoleRecruitPanelItem
