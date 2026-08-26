-- chunkname: @modules/logic/scene/cachot/entity/CachotDoorEffect.lua

module("modules.logic.scene.cachot.entity.CachotDoorEffect", package.seeall)

local CachotDoorEffect = class("CachotDoorEffect", LuaCompBase)
local AnimName = {
	enter = UnityEngine.Animator.StringToHash("enter"),
	active = UnityEngine.Animator.StringToHash("active"),
	exit = UnityEngine.Animator.StringToHash("exit")
}
local exitAnimLen = 0.5

function CachotDoorEffect.Create(containerGO)
	return MonoHelper.addNoUpdateLuaComOnceToGo(containerGO, CachotDoorEffect)
end

function CachotDoorEffect:init(go)
	CachotDoorEffect.super.init(self, go)

	self.go = go
	self.trans = go.transform
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(go, false)

	self._isInDoor = false
end

function CachotDoorEffect:setIsInDoor(isInDoor)
	if self._isInDoor == isInDoor then
		return
	end

	self._isInDoor = isInDoor

	gohelper.setActive(self.go, true)
	TaskDispatcher.cancelTask(self.hideEffect, self)

	local info = self._animator:GetCurrentAnimatorStateInfo(0)
	local time = 0

	if isInDoor then
		if info.shortNameHash == AnimName.exit then
			time = 1 - info.normalizedTime
		end

		self._animator:Play(AnimName.enter, 0, time)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_light)
	else
		if info.shortNameHash == AnimName.enter then
			time = 1 - info.normalizedTime
		end

		self._animator:Play(AnimName.exit, 0, time)
		TaskDispatcher.runDelay(self.hideEffect, self, (1 - time) * exitAnimLen)
	end
end

function CachotDoorEffect:hideEffect()
	self._isInDoor = false

	TaskDispatcher.cancelTask(self.hideEffect, self)
	gohelper.setActive(self.go, false)
end

function CachotDoorEffect:dispose()
	gohelper.destroy(self.go)
	TaskDispatcher.cancelTask(self.hideEffect, self)
end

return CachotDoorEffect
