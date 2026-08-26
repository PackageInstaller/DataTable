-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityRenderOrder.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRenderOrder", package.seeall)

local FightTLEventEntityRenderOrder = class("FightTLEventEntityRenderOrder", FightTimelineTrackItem)

function FightTLEventEntityRenderOrder:onTrackStart(fightStepData, duration, paramsArr)
	local atkRenderOrder = tonumber(paramsArr[1]) or -1
	local defRenderOrder = tonumber(paramsArr[2]) or -1
	local attacker = FightHelper.getEntity(fightStepData.fromId)

	if attacker:getSide() == FightEnum.EntitySide.MySide then
		if not FightEnum.EntitySide.EnemySide then
			local oppoSide = FightEnum.EntitySide.MySide
			local defEntitys = FightHelper.getSideEntitys(oppoSide, true)

			self:_setRenderOrder(attacker, atkRenderOrder)

			for _, defEntity in ipairs(defEntitys) do
				self:_setRenderOrder(defEntity, defRenderOrder)
			end

			FightRenderOrderMgr.instance:refreshRenderOrder()
		end
	end
end

function FightTLEventEntityRenderOrder:_setRenderOrder(entity, renderOrder)
	if renderOrder ~= -1 then
		FightRenderOrderMgr.instance:setOrder(entity.id, renderOrder)
	end
end

return FightTLEventEntityRenderOrder
