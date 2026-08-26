-- chunkname: @modules/logic/fight/system/work/FightWorkLoadAnimator.lua

module("modules.logic.fight.system.work.FightWorkLoadAnimator", package.seeall)

local FightWorkLoadAnimator = class("FightWorkLoadAnimator", FightWorkItem)

function FightWorkLoadAnimator:onConstructor(url, obj, handle)
	self.url = url
	self.obj = obj
	self.handle = handle
	self.SAFETIME = 5
end

function FightWorkLoadAnimator:onStart()
	local comp = self.handle:getComponent(FightLoaderComponent)

	comp:loadAsset(self.url, self.onLoaded, self)
end

function FightWorkLoadAnimator:onLoaded(success, loader)
	if not success then
		return self:onDone(true)
	end

	self:com_registTimer(self.delaySetAnimator, 0.01, loader)
end

function FightWorkLoadAnimator:delaySetAnimator(loader)
	local animator = gohelper.onceAddComponent(self.obj, typeof(UnityEngine.Animator))

	animator.runtimeAnimatorController = loader:GetResource()

	self:onDone(true)
end

return FightWorkLoadAnimator
