-- chunkname: @modules/logic/fight/view/FightDeviceWaitAreaCardItem.lua

module("modules.logic.fight.view.FightDeviceWaitAreaCardItem", package.seeall)

local FightDeviceWaitAreaCardItem = class("FightDeviceWaitAreaCardItem", FightDeviceCardItem)

function FightDeviceWaitAreaCardItem.Create(goParent)
	local deviceItem = FightDeviceWaitAreaCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.WaitArea)

	return deviceItem
end

function FightDeviceWaitAreaCardItem:refreshUI(index, deviceInfo)
	if not deviceInfo then
		return
	end

	self.index = index

	FightDeviceWaitAreaCardItem.super.refreshUI(self, deviceInfo)
	self:refreshAnchor()
end

function FightDeviceWaitAreaCardItem:afterLoadDone()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
	self:playAnim("open1")
end

function FightDeviceWaitAreaCardItem:updateData()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
end

function FightDeviceWaitAreaCardItem:refreshAnchor()
	if not self.loadedDone then
		return
	end

	local anchor = FightDeviceHelper.getDeviceItemAnchorX(self.index)

	recthelper.setAnchorX(self.rectTr, anchor)
end

function FightDeviceWaitAreaCardItem:playStopEffect(skillId)
	if not self.deviceInfo then
		return
	end

	local groupIndex = self.deviceInfo.clientIndex

	if groupIndex == FightDeviceInfoData.Index.Unique then
		if self.uniqueComp:getSkillId() == skillId then
			AudioMgr.instance:trigger(380038)
			self.uniqueComp:playAnim("delicate_open")
		end
	elseif self.normalComp:getSkillId() == skillId then
		AudioMgr.instance:trigger(380038)
		self.normalComp:playAnim("delicate_open")
	elseif self.normal1Comp:getSkillId() == skillId then
		AudioMgr.instance:trigger(380038)
		self.normal1Comp:playAnim("delicate_open")
	end
end

function FightDeviceWaitAreaCardItem:restartDevice()
	if not self.deviceInfo then
		return
	end

	AudioMgr.instance:trigger(380039)
	self:playGroupAnim("delicate_close")
end

function FightDeviceWaitAreaCardItem:refreshStopEffect()
	if not self.deviceInfo then
		return
	end

	self.normalComp:refreshStopEffect()
	self.normal1Comp:refreshStopEffect()
	self.uniqueComp:refreshStopEffect()
end

return FightDeviceWaitAreaCardItem
