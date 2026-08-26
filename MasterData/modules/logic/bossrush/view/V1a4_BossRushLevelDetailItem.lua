-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushLevelDetailItem.lua

module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailItem", package.seeall)

local V1a4_BossRushLevelDetailItem = class("V1a4_BossRushLevelDetailItem", LuaCompBase)
local BtnStateEnum = {
	UnSelectd = 1,
	Locked = 0,
	Selected = 2
}
local EAnimEvt = BossRushEnum.AnimEvtLevelDetailItem

function V1a4_BossRushLevelDetailItem:init(go)
	local transform = go.transform

	self._lockedGo = transform:GetChild(BtnStateEnum.Locked).gameObject
	self._unSelectedGo = transform:GetChild(BtnStateEnum.UnSelectd).gameObject
	self._selectedGo = transform:GetChild(BtnStateEnum.Selected).gameObject
	self._animSelf = go:GetComponent(gohelper.Type_Animator)
	self._animEvent = go:GetComponent(gohelper.Type_AnimationEventWrap)
	self.go = go

	self._animEvent:AddEventListener(EAnimEvt.onPlayUnlockSound, self._onPlayUnlockSound, self)
end

function V1a4_BossRushLevelDetailItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayUnlockCallBack, self)
	self._animEvent:RemoveEventListener(EAnimEvt.onPlayUnlockSound)
end

function V1a4_BossRushLevelDetailItem:onDestroyView()
	self:onDestroy()
end

function V1a4_BossRushLevelDetailItem:setSelect(isSelect)
	gohelper.setActive(self._unSelectedGo, not isSelect)
	gohelper.setActive(self._selectedGo, isSelect)
end

function V1a4_BossRushLevelDetailItem:setData(index, stageLayerInfo)
	self._index = index
	self._stageLayerInfo = stageLayerInfo

	local isOpen = stageLayerInfo.isOpen

	self._isOpen = isOpen

	self:setIsLocked(not isOpen)

	if not isOpen then
		gohelper.setActive(self._unSelectedGo, false)
		gohelper.setActive(self._selectedGo, false)
	end
end

function V1a4_BossRushLevelDetailItem:setIsLocked(isLock)
	gohelper.setActive(self._lockedGo, isLock)
	self:playIdle(isLock)
end

function V1a4_BossRushLevelDetailItem:plaAnim(eAnimLevelDetailBtn, ...)
	self._animSelf:Play(eAnimLevelDetailBtn, ...)
end

function V1a4_BossRushLevelDetailItem:playIdle(isLock)
	if (isLock ~= nil or nil) and not isLock then
		self._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.UnlockedIdle, 0, 1)
	else
		self._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.LockedIdle, 0, 1)
	end
end

function V1a4_BossRushLevelDetailItem:setTrigger(name)
	self._animSelf:SetTrigger(name)
end

function V1a4_BossRushLevelDetailItem:_delayUnlockCallBack()
	self:setTrigger(BossRushEnum.AnimTriggerLevelDetailBtn.PlayUnlock)
end

function V1a4_BossRushLevelDetailItem:playUnlock()
	if self._isOpen then
		TaskDispatcher.cancelTask(self._delayUnlockCallBack, self)
		TaskDispatcher.runDelay(self._delayUnlockCallBack, self, 0.5)
		self:playIdle(true)
	end
end

function V1a4_BossRushLevelDetailItem:_onPlayUnlockSound()
	AudioMgr.instance:trigger(AudioEnum.ui_checkpoint.play_ui_checkpoint_light_up)
end

return V1a4_BossRushLevelDetailItem
