-- chunkname: @modules/logic/fight/view/FightDevicePlayCardLockItem.lua

module("modules.logic.fight.view.FightDevicePlayCardLockItem", package.seeall)

local FightDevicePlayCardLockItem = class("FightDevicePlayCardLockItem", UserDataDispose)
local Status = {
	UnLock = 0,
	Lock = 1,
	PreUnlock = 2
}

function FightDevicePlayCardLockItem:init(cardItem)
	self:__onInit()

	self.cardItem = cardItem
	self.status = Status.UnLock

	self:addEvents()
	self:updateLock()
end

function FightDevicePlayCardLockItem:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.updateLock, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforePlayHandCard, self.updateLock, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self.updateLock, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.updateLock, self)
end

function FightDevicePlayCardLockItem:initStatusHandle()
	if self.statusHandleDict then
		return
	end

	self.statusHandleDict = {
		[Status.Lock] = self.switchToLock,
		[Status.PreUnlock] = self.switchToPreUnlock,
		[Status.UnLock] = self.switchToUnLock
	}
end

function FightDevicePlayCardLockItem:updateLock()
	self:initStatusHandle()

	local curStatus = self:getCurStatus()
	local handle = self.statusHandleDict[curStatus]

	if handle then
		handle(self)
	end
end

function FightDevicePlayCardLockItem:getCurStatus()
	local uid = self.cardItem:getUid()
	local skillCo = self.cardItem:getSkillCo()

	if not skillCo then
		return Status.UnLock
	end

	local skillId = skillCo.id
	local entityMo = FightDataHelper.entityMgr:getById(uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMo)
	local canUse = FightViewHandCardItemLock.canUseCardSkill(uid, skillId, buffList)

	if canUse then
		return Status.UnLock
	else
		local isPreRemove = FightViewHandCardItemLock.canPreRemove(uid, skillId, nil, buffList)

		return (isPreRemove or nil) and (Status.PreUnlock or Status.Lock)
	end
end

function FightDevicePlayCardLockItem:switchToLock()
	local uid = self.cardItem:getUid()
	local skillCo = self.cardItem:getSkillCo()
	local skillId = skillCo.id
	local entityMo = FightDataHelper.entityMgr:getById(uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMo)
	local buffCo = FightViewHandCardItemLock._getCardLockReason(uid, skillId, buffList)
	local animName = self.status ~= Status.Lock and "fight_lock_seal_all" or "fight_lock_seal_allnot"

	self.cardItem:playLockAnim(animName)

	local name = FightViewHandCardItemLock.getLockBuffName(buffCo)

	self.cardItem:setLockText(name)

	self.status = Status.Lock
end

function FightDevicePlayCardLockItem:switchToPreUnlock()
	local animName = self.status ~= Status.PreUnlock and "fight_lock_sealing_all" or "fight_lock_sealing_allnot"

	self.cardItem:playLockAnim(animName)

	self.status = Status.PreUnlock
end

function FightDevicePlayCardLockItem:switchToUnLock()
	if self.status ~= Status.UnLock then
		self.status = Status.UnLock

		self.cardItem:playLockAnim("fight_lock_unseal_all", self.onLockAnimDone, self)
	else
		self.cardItem:setLockActive(false)
	end
end

function FightDevicePlayCardLockItem:onLockAnimDone()
	self.cardItem:setLockActive(false)
end

function FightDevicePlayCardLockItem:dispose()
	self:__onDispose()
end

return FightDevicePlayCardLockItem
