-- chunkname: @modules/logic/fight/system/work/FightWorkStartBornExtendForEffect.lua

module("modules.logic.fight.system.work.FightWorkStartBornExtendForEffect", package.seeall)

local FightWorkStartBornExtendForEffect = class("FightWorkStartBornExtendForEffect", FightWorkStartBornNormal)

function FightWorkStartBornExtendForEffect:ctor(entity, needPlayBornAnim, effect_name, hangPoint, time)
	FightWorkStartBornExtendForEffect.super.ctor(self, entity, needPlayBornAnim)

	self._effect_name = effect_name
	self._hangPoint = hangPoint
	self._time = time
end

function FightWorkStartBornExtendForEffect:_playEffect()
	self._effectWrap = self._entity.effect:addHangEffect(self._effect_name, self._hangPoint, nil, nil, {
		z = 0,
		x = 0,
		y = 0
	})

	self._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._effectWrap)
	TaskDispatcher.runDelay(self._onEffectDone, self, self._time)
end

return FightWorkStartBornExtendForEffect
