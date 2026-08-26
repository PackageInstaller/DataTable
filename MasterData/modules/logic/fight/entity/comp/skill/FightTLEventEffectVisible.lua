-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEffectVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEffectVisible", package.seeall)

local FightTLEventEffectVisible = class("FightTLEventEffectVisible", FightTimelineTrackItem)

function FightTLEventEffectVisible:onTrackStart(fightStepData, duration, paramsArr)
	local magicCircleVisible = paramsArr[1]

	self:com_sendFightEvent(FightEvent.SetMagicCircleVisible, magicCircleVisible == "1", "FightTLEventEffectVisible")

	local liangYueEffectVisible = paramsArr[2]

	self:com_sendFightEvent(FightEvent.SetLiangYueEffectVisible, liangYueEffectVisible == "1")

	local buffTypeIdSceneEffect = paramsArr[3]

	self:com_sendFightEvent(FightEvent.SetBuffTypeIdSceneEffect, buffTypeIdSceneEffect == "1")

	local buffLoopEffectVisible = paramsArr[4]

	if not string.nilorempty(buffLoopEffectVisible) then
		local entityDic = FightGameMgr.entityMgr.entityDic

		for k, entity in pairs(entityDic) do
			if entity.buff then
				if buffLoopEffectVisible == "1" then
					entity.buff:showBuffEffects("FightTLEventEffectVisible")
				else
					entity.buff:hideBuffEffects("FightTLEventEffectVisible")
				end
			end
		end
	end

	local dianJiShiEffectVisible = paramsArr[5]

	self:com_sendFightEvent(FightEvent.SetDianJiShiEffectVisible, dianJiShiEffectVisible == "1", "FightTLEventEffectVisible")
end

function FightTLEventEffectVisible:onTrackEnd()
	return
end

function FightTLEventEffectVisible:onDestructor()
	return
end

return FightTLEventEffectVisible
