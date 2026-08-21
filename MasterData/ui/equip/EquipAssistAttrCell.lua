-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipAssistAttrCell.lua

local EquipAssistAttrCell = Class("EquipAssistAttrCell", UIControls.Panel)

function EquipAssistAttrCell:ctor()
	self.textName = UIControls.Label(self, self.mPath .. "/TextName")
	self.textNumber = UIControls.Label(self, self.mPath .. "/TextNum1")

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnLock") then
		self.btnLock = UIControls.Button(self, self.mPath .. "/BtnLock")

		self.btnLock:addEventClick(self.onBtnLockClick)
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnLockSel") then
		self.btnLockSel = UIControls.Button(self, self.mPath .. "/BtnLockSel")

		self.btnLockSel:addEventClick(self.onBtnLockSelClick)
	end
end

function EquipAssistAttrCell:setAttr(attrType, value)
	self.attrType = attrType

	local zhName, attrValue = ClientUtils.getRolePropZhNameByType(attrType, value)

	self.textName:setText(zhName)
	self.textNumber:setText(attrValue)
end

function EquipAssistAttrCell:setLockInfo(index, lock)
	self.pos = index
	self.lockState = lock

	if self.btnLock then
		self.btnLock:setVisible(self.lockState == Const.REFORM_EQUIP_SUB_ATTR_UNLOCK)
	end

	if self.btnLockSel then
		self.btnLockSel:setVisible(self.lockState == Const.REFORM_EQUIP_SUB_ATTR_LOCK)
	end
end

function EquipAssistAttrCell:setLockClick(mEventLock)
	self.mEventLock = mEventLock
end

function EquipAssistAttrCell:setLockSelClick(mEventLockSel)
	self.mEventLockSel = mEventLockSel
end

function EquipAssistAttrCell:onBtnLockClick()
	if self.mEventLock then
		self.mEventLock(self)
	end
end

function EquipAssistAttrCell:onBtnLockSelClick()
	if self.mEventLockSel then
		self.mEventLockSel(self)
	end
end

return EquipAssistAttrCell
