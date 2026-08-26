-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSelectItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSelectItem", package.seeall)

local Rouge2_CareerSelectItem = class("Rouge2_CareerSelectItem", ListScrollCell)

function Rouge2_CareerSelectItem:init(go)
	self.go = go
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._goUnselected = gohelper.findChild(self.go, "#go_Unselected")
	self._imageIcon = gohelper.findChildImage(self.go, "#go_Selected/#image_Icon")
	self._txtName1 = gohelper.findChildText(self.go, "#go_Selected/#txt_Name")
	self._txtName2 = gohelper.findChildText(self.go, "#go_Unselected/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.go, "#go_Unselected/#txt_NameEn")
	self._goTag = gohelper.findChild(self.go, "#go_Tag")
	self._txtTag = gohelper.findChild(self.go, "#go_Tag/#txt_Tag")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click", AudioEnum.Rouge2.SwitchCareer)
end

function Rouge2_CareerSelectItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_CareerSelectItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_CareerSelectItem:_btnClickOnClick()
	local isUnlock, toastId = Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId)

	if not isUnlock then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId)
		end

		return
	end

	Rouge2_CareerSelectListModel.instance:selectCell(self._index, true)
end

function Rouge2_CareerSelectItem:onUpdateMO(careerCo)
	self._careerCo = careerCo
	self._careerId = careerCo and careerCo.id
	self._unlockRemainTime = Rouge2_OutsideModel.instance:getCareerUnlockRemainTime(self._careerId)
	self._isUnlock = Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId)

	TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)

	if self._unlockRemainTime and self._unlockRemainTime > 0 then
		TaskDispatcher.runRepeat(self.refreshUnlockRemainTime, self, 1)
	end

	self:refreshUI()
end

function Rouge2_CareerSelectItem:refreshUI()
	if self._careerCo then
		self._txtName1.text = self._careerCo
		self._txtName2.text = self._careerCo
		self._txtNameEn.text = self._careerCo and self._careerCo.nameEn

		gohelper.setActive(self._goLocked, not self._isUnlock)
		gohelper.setActive(self._goTag, self._careerCo and self._careerCo.isDifficult ~= 0)
		Rouge2_IconHelper.setCareerIcon(self._careerId, self._imageIcon, Rouge2_Enum.CareerIconSuffix.Tab)
	end
end

function Rouge2_CareerSelectItem:refreshUnlockRemainTime()
	self._unlockRemainTime = Rouge2_OutsideModel.instance:getCareerUnlockRemainTime(self._careerId)
	self._isUnlock = Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId)

	if not self._unlockRemainTime or self._unlockRemainTime <= 0 then
		TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)
	end

	self:refreshUI()
end

function Rouge2_CareerSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goSelected, isSelect)
	gohelper.setActive(self._goUnselected, not isSelect)
end

function Rouge2_CareerSelectItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)
end

return Rouge2_CareerSelectItem
