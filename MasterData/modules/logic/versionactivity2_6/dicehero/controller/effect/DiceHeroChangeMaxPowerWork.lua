-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroChangeMaxPowerWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeMaxPowerWork", package.seeall)

local DiceHeroChangeMaxPowerWork = class("DiceHeroChangeMaxPowerWork", DiceHeroBaseEffectWork)

function DiceHeroChangeMaxPowerWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)

	if not targetEntity then
		logError("找不到实体" .. targetId)
	else
		targetEntity:addMaxPower(self._effectMo.effectNum)
	end

	self:onDone(true)
end

return DiceHeroChangeMaxPowerWork
