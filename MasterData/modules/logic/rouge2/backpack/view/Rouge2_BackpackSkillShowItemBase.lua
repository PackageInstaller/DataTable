-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillShowItemBase.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillShowItemBase", package.seeall)

local Rouge2_BackpackSkillShowItemBase = class("Rouge2_BackpackSkillShowItemBase", LuaCompBase)

function Rouge2_BackpackSkillShowItemBase:ctor(index)
	self._index = index
end

function Rouge2_BackpackSkillShowItemBase:init(go)
	self.go = go
	self._goLock = gohelper.findChild(self.go, "#go_Lock")
	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goUnEmpty = gohelper.findChild(self.go, "#go_UnEmpty")
	self._goUnlockNotActive = gohelper.findChild(self.go, "#go_UnlockNotActive")
	self._goUnlockCanActive = gohelper.findChild(self.go, "#go_UnlockCanActive")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	gohelper.setActive(self.go, true)
end

function Rouge2_BackpackSkillShowItemBase:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_BackpackSkillShowItemBase:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackSkillShowItemBase:_btnClickOnClick()
	if self._status <= Rouge2_Enum.ActiveSkillHoleStatus.Empty then
		if self._status < Rouge2_Enum.ActiveSkillHoleStatus.Empty then
			GameFacade.showToast(ToastEnum.Rouge2SkillHoleLock)
		end

		return
	end

	self:onBtnClickCallback()
end

function Rouge2_BackpackSkillShowItemBase:onBtnClickCallback()
	return
end

function Rouge2_BackpackSkillShowItemBase:onUpdateMO()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillShowItemBase:refreshInfo()
	self._preIsEmpty = self._isEmpty
	self._skillMo = Rouge2_BackpackModel.instance:index2UseActiveSkill(self._index)
	self._skillUid = self._skillMo and self._skillMo:getUid()
	self._skillId = self._skillMo and self._skillMo:getItemId()

	local status = Rouge2_BackpackModel.instance:getActiveSkillHoleStatus(self._index)

	self._preStatus = self._status or status
	self._status = status
	self._isEmpty = self._status == Rouge2_Enum.ActiveSkillHoleStatus.Empty
end

function Rouge2_BackpackSkillShowItemBase:refreshUI()
	gohelper.setActive(self._goLock, self._status == Rouge2_Enum.ActiveSkillHoleStatus.Lock)
	gohelper.setActive(self._goUnlockNotActive, self._status == Rouge2_Enum.ActiveSkillHoleStatus.UnlockNotActive)
	gohelper.setActive(self._goUnlockCanActive, self._status == Rouge2_Enum.ActiveSkillHoleStatus.UnlockCanActive)
	gohelper.setActive(self._goEmpty, self._status == Rouge2_Enum.ActiveSkillHoleStatus.Empty)
	gohelper.setActive(self._goUnEmpty, self._status == Rouge2_Enum.ActiveSkillHoleStatus.Equip)
	self:refreshCommonUI()

	if self._status == Rouge2_Enum.ActiveSkillHoleStatus.Lock then
		self:refreshLockUI()
	elseif self._status == Rouge2_Enum.ActiveSkillHoleStatus.UnlockNotActive then
		self:refreshUnlockNotActiveUI()
	elseif self._status == Rouge2_Enum.ActiveSkillHoleStatus.UnlockCanActive then
		self:refreshUnlockCanActiveUI()
	elseif self._status == Rouge2_Enum.ActiveSkillHoleStatus.Empty then
		self:refreshEmptyUI()
	elseif self._status == Rouge2_Enum.ActiveSkillHoleStatus.Equip then
		self:refreshEquipUI()
	end

	self:playAnim()
end

function Rouge2_BackpackSkillShowItemBase:refreshLockUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:refreshEmptyUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:refreshEquipUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:refreshUnlockNotActiveUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:refreshUnlockCanActiveUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:refreshCommonUI()
	return
end

function Rouge2_BackpackSkillShowItemBase:playAnim()
	if self._preIsEmpty == nil or self._preIsEmpty == self._isEmpty then
		if self._preStatus ~= self._status then
			if self._status == Rouge2_Enum.BagTalentStatus.Lock then
				self._animator:Play("lock", 0, 0)
			elseif self._status == Rouge2_Enum.BagTalentStatus.UnlockNotActive then
				if self._preStatus ~= Rouge2_Enum.BagTalentStatus.UnlockCanActive then
					self._animator:Play("unlock", 0, 0)
				end
			elseif self._status == Rouge2_Enum.BagTalentStatus.UnlockCanActive and self._preStatus ~= Rouge2_Enum.BagTalentStatus.UnlockNotActive then
				self._animator:Play("unlock", 0, 0)
			end
		end

		return
	end

	if self._isEmpty then
		self._animator:Play("empty", 0, 0)
	else
		self._animator:Play("unempty", 0, 0)
	end
end

function Rouge2_BackpackSkillShowItemBase:_onUpdateActiveSkillInfo()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillShowItemBase:_onUpdateRougeInfo()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillShowItemBase:getSkillDataTypeAndId()
	return Rouge2_Enum.ItemDataType.Server, self._skillUid
end

function Rouge2_BackpackSkillShowItemBase:onDestroy()
	return
end

return Rouge2_BackpackSkillShowItemBase
