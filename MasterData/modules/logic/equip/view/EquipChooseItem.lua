-- chunkname: @modules/logic/equip/view/EquipChooseItem.lua

module("modules.logic.equip.view.EquipChooseItem", package.seeall)

local EquipChooseItem = class("EquipChooseItem", ListScrollCellExtend)

function EquipChooseItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._goreduce = gohelper.findChild(self.viewGO, "#go_reduce")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipChooseItem:addEvents()
	return
end

function EquipChooseItem:removeEvents()
	return
end

function EquipChooseItem:_editableInitView()
	self._longPressLister = SLFramework.UGUI.UILongPressListener.Get(self.viewGO)

	self._longPressLister:AddLongPressListener(self._longPressTimeEnd, self)
	self._longPressLister:SetLongPressTime({
		0.5,
		0.2
	})

	self._addClick = gohelper.getClick(self.viewGO)

	self._addClick:AddClickListener(self._onClick, self)

	self._reduceClick = gohelper.getClick(self._goreduce)

	self._reduceClick:AddClickListener(self._onReduceClick, self)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

	self._commonEquipIcon._overrideLoadIconFunc(self._commonEquipIcon, EquipHelper.getEquipIconLoadPath, self._commonEquipIcon)
end

function EquipChooseItem:_onReduceClick()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipChooseListModel.instance:deselectEquip(self._mo)
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function EquipChooseItem:_onClick()
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
	self:addSelf()
end

function EquipChooseItem:_longPressTimeEnd()
	if not EquipHelper.isExpEquip(self._mo.config) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local status = self:addSelf()

	if status == EquipEnum.ChooseEquipStatus.Success then
		self.animator:Play(UIAnimationName.Click, 0, 0)
	end
end

function EquipChooseItem:addSelf()
	if self._mo.isLock then
		return nil
	end

	local chooseStatus = EquipChooseListModel.instance:selectEquip(self._mo)

	if chooseStatus == EquipEnum.ChooseEquipStatus.BeyondEquipHadNum then
		return chooseStatus
	elseif chooseStatus == EquipEnum.ChooseEquipStatus.Lock then
		return chooseStatus
	elseif chooseStatus == EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip then
		GameFacade.showToast(ToastEnum.MaxEquips)

		return chooseStatus
	elseif chooseStatus == EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return chooseStatus
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, {
		self._mo.uid
	})

	return chooseStatus
end

function EquipChooseItem:_onChooseEquip()
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
end

function EquipChooseItem:_editableAddEvents()
	EquipController.instance:registerCallback(EquipEvent.onChooseChange, self._updateSelected, self)
	EquipController.instance:registerCallback(EquipEvent.onGuideChooseEquip, self._onGuideChooseEquip, self)
end

function EquipChooseItem:_editableRemoveEvents()
	EquipController.instance:unregisterCallback(EquipEvent.onChooseChange, self._updateSelected, self)
	EquipController.instance:unregisterCallback(EquipEvent.onGuideChooseEquip, self._onGuideChooseEquip, self)
end

function EquipChooseItem:_onGuideChooseEquip(index)
	if tonumber(index) == self._index then
		self:_onClick()
	end
end

function EquipChooseItem:_updateSelected()
	if self._mo._chooseNum > 0 then
		gohelper.setActive(self._goreduce, true)

		self._commonEquipIcon._txtnum.text = string.format("%s/%s", self._mo._chooseNum, GameUtil.numberDisplay(self._mo.count))
	else
		gohelper.setActive(self._goreduce, false)

		self._commonEquipIcon._txtnum.text = GameUtil.numberDisplay(self._mo.count)
	end
end

function EquipChooseItem:onUpdateMO(mo)
	self._mo = mo

	self._commonEquipIcon:setEquipMO(mo)
	self:_updateSelected()
end

function EquipChooseItem:onSelect(isSelect)
	self:onUpdateMO(self._mo)
end

function EquipChooseItem:refreshLockUI()
	self._commonEquipIcon:refreshLock(self._mo.isLock)
end

function EquipChooseItem:onDestroyView()
	self._longPressLister:RemoveLongPressListener()
	self._addClick:RemoveClickListener()
	self._reduceClick:RemoveClickListener()
end

return EquipChooseItem
