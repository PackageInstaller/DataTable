-- chunkname: @modules/logic/fight/system/work/FightWorkPlayAnimator.lua

module("modules.logic.fight.system.work.FightWorkPlayAnimator", package.seeall)

local FightWorkPlayAnimator = class("FightWorkPlayAnimator", FightWorkItem)
local AnimatorPlayer = SLFramework.AnimatorPlayer

function FightWorkPlayAnimator:onConstructor(obj, name, speed, callback, handle, safeTime)
	self.obj = obj
	self.name = name
	self.speed = speed or 1
	self.callback = callback
	self.handle = handle
	self.SAFETIME = safeTime or 5
end

function FightWorkPlayAnimator:onStart()
	local animatorPlayer = AnimatorPlayer.Get(self.obj)

	animatorPlayer.animator.speed = self.speed

	animatorPlayer:Play(self.name, self.onAniFinish, self)
end

function FightWorkPlayAnimator:onAniFinish()
	if self.IS_DISPOSED then
		return
	end

	if self.callback then
		self.callback(self.handle)
	end

	self:onDone(true)
end

return FightWorkPlayAnimator
