-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/DamageBuff.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.DamageBuff", package.seeall)

local DamageBuff = class("DamageBuff", BuffBase)

function DamageBuff:execute()
	local canUse = DamageBuff.super.execute(self)

	if canUse and self._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local player = LengZhou6GameModel.instance:getPlayer()

		if player then
			local damageComp = player:getDamageComp()

			if damageComp then
				damageComp:setExDamage(self._layerCount * 1)
			end
		end
	end
end

return DamageBuff
