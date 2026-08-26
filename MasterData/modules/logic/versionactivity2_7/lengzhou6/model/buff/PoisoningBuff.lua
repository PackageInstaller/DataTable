-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/PoisoningBuff.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.PoisoningBuff", package.seeall)

local PoisoningBuff = class("PoisoningBuff", BuffBase)

function PoisoningBuff:execute()
	local canUse = PoisoningBuff.super.execute(self)

	if canUse and self._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local enemy = LengZhou6GameModel.instance:getEnemy()

		if enemy then
			enemy:changeHp(-self._layerCount * 1)

			if isDebugBuild then
				logNormal("中毒伤害：" .. self._layerCount * 1)
			end

			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, LengZhou6Enum.BuffEffect.poison)
		end
	end
end

return PoisoningBuff
