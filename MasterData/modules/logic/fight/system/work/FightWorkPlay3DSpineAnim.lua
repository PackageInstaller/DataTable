-- chunkname: @modules/logic/fight/system/work/FightWorkPlay3DSpineAnim.lua

module("modules.logic.fight.system.work.FightWorkPlay3DSpineAnim", package.seeall)

local FightWorkPlay3DSpineAnim = class("FightWorkPlay3DSpineAnim", FightWorkItem)

function FightWorkPlay3DSpineAnim:onConstructor(entity, animName, reStart, donotProcess)
	self.entity = entity
	self.animName = animName
	self.donotProcess = donotProcess
	self.reStart = reStart
	self.SAFETIME = 30
end

function FightWorkPlay3DSpineAnim:onStart()
	local spine = self.entity.spine

	if spine.lockAct then
		self:onDone(true)

		return
	end

	if self.donotProcess then
		if not self.animName then
			local replaceAnimName = FightHelper.processEntityActionName(self.entity, self.animName)

			if spine._curAnimState == replaceAnimName and not self.reStart then
				self:onDone(true)

				return
			end

			spine._curAnimState = replaceAnimName

			local animatorPlayer = spine.animatorPlayer

			if not animatorPlayer then
				self:onDone(true)

				return
			end

			self:com_registMsg(FightMsgId.On3DSpineAnimPlayFinish, self.onAnimEnd)

			animatorPlayer.animator.speed = spine._timeScale

			animatorPlayer:Play(replaceAnimName)
			spine:invokeAnimEventCallback(SpineAnimEvent.ActionStart)
		end
	end
end

function FightWorkPlay3DSpineAnim:onAnimEnd(entityId, animState)
	if entityId ~= self.entity.id then
		return
	end

	self:onDone(true)
end

return FightWorkPlay3DSpineAnim
