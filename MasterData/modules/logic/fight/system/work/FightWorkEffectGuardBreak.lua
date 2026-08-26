-- chunkname: @modules/logic/fight/system/work/FightWorkEffectGuardBreak.lua

module("modules.logic.fight.system.work.FightWorkEffectGuardBreak", package.seeall)

local FightWorkEffectGuardBreak = class("FightWorkEffectGuardBreak", FightEffectBase)

function FightWorkEffectGuardBreak:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity and entity.effect then
		local effectTime = 0.5
		local effectWrap = entity.effect:addHangEffect("buff/buff_podun", ModuleEnum.SpineHangPoint.mountmiddle, nil, effectTime)

		effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
		self:com_registTimer(self._delayAfterPerformance, effectTime)
		AudioMgr.instance:trigger(410000102)

		return
	end

	self:onDone(true)
end

return FightWorkEffectGuardBreak
