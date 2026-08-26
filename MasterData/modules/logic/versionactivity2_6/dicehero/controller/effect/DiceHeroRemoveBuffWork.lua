-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroRemoveBuffWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroRemoveBuffWork", package.seeall)

local DiceHeroRemoveBuffWork = class("DiceHeroRemoveBuffWork", DiceHeroBaseEffectWork)

function DiceHeroRemoveBuffWork:onStart(context)
	local targetId = self._effectMo.fromId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)

	if not targetEntity then
		logError("找不到实体" .. targetId)
	else
		targetEntity:removeBuff(self._effectMo.targetId)
	end

	self:onDone(true)
end

return DiceHeroRemoveBuffWork
