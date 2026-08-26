-- chunkname: @modules/logic/equip/view/EquipRefineItem.lua

module("modules.logic.equip.view.EquipRefineItem", package.seeall)

local EquipRefineItem = class("EquipRefineItem", ListScrollCellExtend)

function EquipRefineItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._goreduce = gohelper.findChild(self.viewGO, "#go_reduce")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipRefineItem:addEvents()
	return
end

function EquipRefineItem:removeEvents()
	return
end

function EquipRefineItem:_editableInitView()
	self.click = gohelper.getClick(self.viewGO)

	self.click:AddClickListener(self._onClick, self)

	self._reduceClick = gohelper.getClick(self._goreduce)

	self._reduceClick:AddClickListener(self._onReduceClick, self)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

	self._commonEquipIcon._overrideLoadIconFunc(self._commonEquipIcon, EquipHelper.getEquipIconLoadPath, self._commonEquipIcon)
end

function EquipRefineItem:_editableAddEvents()
	EquipController.instance:registerCallback(EquipEvent.OnRefineSelectedEquipChange, self.updateSelected, self)
	EquipController.instance:registerCallback(EquipEvent.onEquipLockChange, self.onEquipLockChange, self)
end

function EquipRefineItem:_editableRemoveEvents()
	EquipController.instance:unregisterCallback(EquipEvent.OnRefineSelectedEquipChange, self.updateSelected, self)
	EquipController.instance:unregisterCallback(EquipEvent.onEquipLockChange, self.onEquipLockChange, self)
end

function EquipRefineItem:onEquipLockChange(param)
	if self._mo.id == tonumber(param.uid) then
		self:refreshLockUI()

		if param.isLock then
			EquipRefineListModel.instance:deselectEquip(self._mo)
		end
	end
end

function EquipRefineItem:_onReduceClick()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipRefineListModel.instance:deselectEquip(self._mo)
	gohelper.setActive(self._goreduce, false)
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function EquipRefineItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	self.animator:Play(UIAnimationName.Click, 0, 0)

	if self._mo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)

		if EquipHelper.isNormalEquip(self._mo.config) then
			ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
				equipMo = self._mo
			})
		end

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	local status = EquipRefineListModel.instance:selectEquip(self._mo)

	if status == EquipRefineListModel.SelectStatusEnum.OutMaxRefineLv then
		GameFacade.showToast(ToastEnum.EquipOutMaxRefineLv)

		return
	elseif status == EquipRefineListModel.SelectStatusEnum.Selected then
		return
	end

	gohelper.setActive(self._goreduce, true)
end

function EquipRefineItem:refreshLockUI()
	self._commonEquipIcon:refreshLock(self._mo.isLock)
end

function EquipRefineItem:updateSelected()
	gohelper.setActive(self._goreduce, EquipRefineListModel.instance:isSelected(self._mo))
end

function EquipRefineItem:onUpdateMO(mo)
	self._mo = mo

	self._commonEquipIcon:setEquipMO(mo)
	self:updateSelected()
end

function EquipRefineItem:onDestroyView()
	self.click:RemoveClickListener()
	self._reduceClick:RemoveClickListener()
end

return EquipRefineItem
