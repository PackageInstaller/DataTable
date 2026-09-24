-- chunkname: @modules/logic/college/view/role/CollegeRoleBagPanelItem.lua

module("modules.logic.college.view.role.CollegeRoleBagPanelItem", package.seeall)

local CollegeRoleBagPanelItem = class("CollegeRoleBagPanelItem", CollegeRoleBasePanelItem)

function CollegeRoleBagPanelItem:onInitView()
	CollegeRoleBagPanelItem.super.onInitView(self)

	self._goEnableUpgrade = gohelper.findChild(self.viewGO, "has/#btn_UpGrade/go_Enable")
	self._goDisableUpgrade = gohelper.findChild(self.viewGO, "has/#btn_UpGrade/go_Disable")
end

function CollegeRoleBagPanelItem:updateData(mo)
	CollegeRoleBagPanelItem.super.updateData(self, mo)

	self._isCanUpGrade = not self._isMaxLv and CollegeModel.instance:isEnoughItemsTb(self._cost, self._costRate)
	self._isNpc = self._co.type == CollegeEnum.ActorType.Npc
end

function CollegeRoleBagPanelItem:_btnExitOnClick()
	if not self._isNpc then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.CollegeCharacterDismiss, MsgBoxEnum.BoxType.Yes_No, self._onCharacterDismissConfirm, nil, nil, self)
end

function CollegeRoleBagPanelItem:_onCharacterDismissConfirm()
	CollegeRpc.instance:sendCollegeCharacterDismiss(self._uid)
end

function CollegeRoleBagPanelItem:_btnUpGradeOnClick()
	if self._mo.isRefreshEntry then
		GameFacade.showToast(ToastEnum.CollegeRefreshUpLvOperLock)

		return
	end

	if not self._isCanUpGrade then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoleUpgrade)
	CollegeRpc.instance:sendCollegeCharacterUpgrade(self._uid)
	CollegeController.instance:dispatchEvent(CollegeEvent.PlayUpgradeAnim)
end

function CollegeRoleBagPanelItem:refreshBtnVisible()
	gohelper.setActive(self._goBtnExit, self._isNpc)
	gohelper.setActive(self._goBtnUpGrade, not self._isMaxLv)
	gohelper.setActive(self._goEnableUpgrade, self._isCanUpGrade)
	gohelper.setActive(self._goDisableUpgrade, not self._isCanUpGrade)
	self:refreshCostList()
end

return CollegeRoleBagPanelItem
