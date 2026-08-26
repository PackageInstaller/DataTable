-- chunkname: @modules/logic/fight/view/FightDeviceSwitchCardItem.lua

module("modules.logic.fight.view.FightDeviceSwitchCardItem", package.seeall)

local FightDeviceSwitchCardItem = class("FightDeviceSwitchCardItem", FightDeviceCardItem)

function FightDeviceSwitchCardItem.Create(goParent)
	local deviceItem = FightDeviceSwitchCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.SwitchCard)

	return deviceItem
end

function FightDeviceSwitchCardItem:initViews()
	FightDeviceSwitchCardItem.super.initViews(self)

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.go)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPress, self)

	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClickDeviceCard, self)
end

function FightDeviceSwitchCardItem:onLongPress()
	self.longPressed = true

	FightController.instance:dispatchEvent(FightEvent.OnDevice_LongPressSwitchCardItem, self)
end

function FightDeviceSwitchCardItem:onClickDeviceCard()
	if self.longPressed then
		self.longPressed = false

		return
	end

	if not self:checkCanSwitch() then
		GameFacade.showToast(ToastEnum.FightDeviceSwitchCardItem_374002)

		return
	end

	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return
	end

	AudioMgr.instance:trigger(20001001)
	deviceArea:changeClientIndex(self.uid, self.index)
end

function FightDeviceSwitchCardItem:checkCanSwitch()
	local entityMo = FightDataHelper.entityMgr:getById(self.uid)

	if not entityMo then
		return
	end

	if self.index == FightDeviceInfoData.Index.Unique then
		local needPoint = entityMo:getUniqueSkillPoint()
		local curExPoint = entityMo.exPoint

		if curExPoint < needPoint then
			return
		end
	end

	return true
end

function FightDeviceSwitchCardItem:refreshUI(uid, index, groupSkillInfo)
	self.uid = uid
	self.index = index
	self.groupSkillInfo = groupSkillInfo

	if not self.loadedDone then
		return
	end

	if not groupSkillInfo then
		return
	end

	if index == FightDeviceInfoData.Index.Unique then
		gohelper.setActive(self.goNormal, false)
		gohelper.setActive(self.goNormal1, false)
		gohelper.setActive(self.goSpecialBg, false)
		gohelper.setActive(self.goUnique, true)
		self.uniqueComp:refreshUI(groupSkillInfo.skills[1])
		self.uniqueComp:setActive(true)
		self.normalComp:setActive(false)
		self.normal1Comp:setActive(false)
	else
		gohelper.setActive(self.goNormal, true)
		self.normalComp:refreshUI(groupSkillInfo.skills[1])
		self.normalComp:setActive(true)

		local skillInfo = groupSkillInfo.skills[2]

		if skillInfo then
			gohelper.setActive(self.goNormal1, true)
			self.normal1Comp:refreshUI(skillInfo)
			self.normal1Comp:setActive(true)
			gohelper.setActive(self.goSpecialBg, true)
		else
			self.normal1Comp:setActive(false)
			gohelper.setActive(self.goSpecialBg, false)
			gohelper.setActive(self.goNormal1, false)
		end

		self.uniqueComp:setActive(false)
		gohelper.setActive(self.goUnique, false)
	end

	recthelper.setWidth(self.rectTr, FightDeviceHelper.getDeviceGroupWidth(groupSkillInfo))
	self:setSelectFrameActive(self.selectFrameActive)
	self:setGrayMaskActive(not self:checkCanSwitch())
end

function FightDeviceSwitchCardItem:setSelectFrameActive(active)
	self.selectFrameActive = active

	if not self.loadedDone then
		return
	end

	if not self.groupSkillInfo then
		gohelper.setActive(self.goSelect, false)
		self.uniqueComp:setSelectFrameActive(active)

		return
	end

	if self.index == FightDeviceInfoData.Index.Unique then
		gohelper.setActive(self.goSelect, false)
		self.uniqueComp:setSelectFrameActive(active)
	else
		self.uniqueComp:setSelectFrameActive(false)
		gohelper.setActive(self.goSelect, active)
		recthelper.setWidth(self.rectSelect, FightDeviceHelper.getSelectFrameWidthByGroup(self.groupSkillInfo))
		recthelper.setAnchorX(self.rectSelect, FightDeviceHelper.getSelectFrameAnchorXByGroup(self.groupSkillInfo))
	end
end

function FightDeviceSwitchCardItem:afterLoadDone()
	self.parentTr = self.rectTr.parent

	self:refreshUI(self.uid, self.index, self.groupSkillInfo)
	self:playGroupAnim("open2")
end

function FightDeviceSwitchCardItem:playGroupAnim(animName, callback, callbackObj)
	if self.index == FightDeviceInfoData.Index.Unique then
		self.uniqueComp:playAnim(animName, callback, callbackObj)
	else
		self.normalComp:playAnim(animName, callback, callbackObj)
		self.normal1Comp:playAnim(animName)
	end
end

function FightDeviceSwitchCardItem:playAnim(animName, callback, callbackObj)
	return
end

function FightDeviceSwitchCardItem:playOneItemAnim(animName, index, callback, callbackObj)
	return
end

function FightDeviceSwitchCardItem:playScanEffect(success, index)
	return
end

function FightDeviceSwitchCardItem:getGroupInfo()
	return self.groupSkillInfo
end

function FightDeviceSwitchCardItem:setAnchorX(anchorX)
	recthelper.setAnchorX(self.rectTr, anchorX)
end

function FightDeviceSwitchCardItem:refreshSelectFrameActive(curSelectIndex)
	self.selectFrameActive = curSelectIndex == self.index

	if not self.loadedDone then
		return
	end

	self:setSelectFrameActive(self.selectFrameActive)
end

function FightDeviceSwitchCardItem:getUid()
	return self.uid
end

function FightDeviceSwitchCardItem:dispose()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end

	if self.longPress then
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	FightDeviceSwitchCardItem.super.dispose(self)
end

return FightDeviceSwitchCardItem
