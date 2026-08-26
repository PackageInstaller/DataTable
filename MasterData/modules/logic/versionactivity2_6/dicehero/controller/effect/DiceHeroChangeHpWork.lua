-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroChangeHpWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeHpWork", package.seeall)

local DiceHeroChangeHpWork = class("DiceHeroChangeHpWork", DiceHeroBaseEffectWork)

function DiceHeroChangeHpWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)

	if not targetEntity then
		logError("找不到实体" .. targetId)
	else
		targetEntity:addHp(self._effectMo.effectNum)
	end

	self:onDone(true)
end

return DiceHeroChangeHpWork
