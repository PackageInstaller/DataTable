-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRoleItemBase.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRoleItemBase", package.seeall)

local V3a9RacingCarRoleItemBase = class("V3a9RacingCarRoleItemBase", ListScrollCellExtend)

function V3a9RacingCarRoleItemBase:addEvents()
	self._btnUnlockBtn:AddClickListener(self._btnUnlockBtnOnClick, self)
end

function V3a9RacingCarRoleItemBase:removeEvents()
	self._btnUnlockBtn:RemoveClickListener()
end

function V3a9RacingCarRoleItemBase:_btnUnlockBtnOnClick()
	local cost = self._config.cost
	local currency = V3a9RacingTalentModel.instance:getCurrencyNum(self._actId).quantity or 0
	local isEnough = cost <= currency

	if not isEnough then
		GameFacade.showToast(ToastEnum.V3a9_Racing_Car_Tip1)

		return
	end

	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.V3a9RacingCarUnlockRacerTip, MsgBoxEnum.BoxType.Yes_No, self._yesCallback, nil, nil, self)
end

function V3a9RacingCarRoleItemBase:_yesCallback()
	self._animator:Play("unlock", 0, 0)
	V3a9RacingCarRpc.instance:sendAct243UnlockRacerRequest(self._actId, self._config.id)
end

function V3a9RacingCarRoleItemBase:_editableInitView()
	self._powerSpeedItems = self:getUserDataTb_()
	self._actId = V3a9RacingTalentModel.instance:getActId()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function V3a9RacingCarRoleItemBase:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self:_getIsUnlock() then
		GameFacade.showToast(ToastEnum.V3a9_Racing_Car_Tip2)

		return
	end
end

function V3a9RacingCarRoleItemBase:_editableAddEvents()
	return
end

function V3a9RacingCarRoleItemBase:_editableRemoveEvents()
	return
end

function V3a9RacingCarRoleItemBase:_getIsUnlock()
	return self._mo:isUnlock() or self._config.cost <= 0
end

function V3a9RacingCarRoleItemBase:_refreshAttr()
	local powerSpeed = self._mo:getPowerSpeed()

	for i = 1, V3a9RacingCarEnum.MaxPowerSpeed do
		local item = self:_getPowerSpeedItem(i)

		gohelper.setActive(item.goPowerLight, i <= powerSpeed)
		gohelper.setActive(item.go, true)
	end
end

function V3a9RacingCarRoleItemBase:_getPowerSpeedItem(index)
	local item = self._powerSpeedItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._goItem or gohelper.cloneInPlace(self._goItem)
		end

		item.goPowerLight = gohelper.findChild(item.go, "#go_ProgressFG")
		self._powerSpeedItems[index] = item
	end

	return item
end

function V3a9RacingCarRoleItemBase:_refreshUnlock()
	local isUnlock = self:_getIsUnlock()

	if not isUnlock then
		local cost = self._config.cost

		self._txtCurrencyNum.text = cost

		local currency = V3a9RacingTalentModel.instance:getCurrencyNum(self._actId).quantity or 0
		local isEnough = cost <= currency

		gohelper.setActive(self._goLockBG.gameObject, not isEnough)
		gohelper.setActive(self._goNormalBG.gameObject, isEnough)
	end

	gohelper.setActive(self._goLock, not isUnlock)
	gohelper.setActive(self._goRole, isUnlock)
end

function V3a9RacingCarRoleItemBase:onSelect(isSelect)
	self._isSelected = isSelect

	gohelper.setActive(self._goSelect, isSelect)
end

function V3a9RacingCarRoleItemBase:onDestroyView()
	self._click:RemoveClickListener()
end

return V3a9RacingCarRoleItemBase
