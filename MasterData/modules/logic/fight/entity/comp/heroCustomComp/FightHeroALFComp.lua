-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHeroALFComp.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHeroALFComp", package.seeall)

local FightHeroALFComp = class("FightHeroALFComp", FightHeroCustomCompBase)

function FightHeroALFComp:init(go)
	FightHeroALFComp.super.init(self, go)

	local entityMo = self.entity:getMO()

	self.alfTimeLineCo = lua_fight_sp_effect_alf_timeline.configDict[entityMo.skin]

	if not self.alfTimeLineCo then
		logError("阿莱夫插牌timeline未配置，skinId : " .. tostring(entityMo.skin))
	end
end

function FightHeroALFComp:addEventListeners()
	FightController.instance:registerCallback(FightEvent.AfterAddUseCardContainer, self.onAfterAddUseCardOnContainer, self)
end

function FightHeroALFComp:removeEventListeners()
	FightController.instance:unregisterCallback(FightEvent.AfterAddUseCardContainer, self.onAfterAddUseCardOnContainer, self)
end

FightHeroALFComp.ALFSkillDict = {
	[31130152] = true,
	[31130153] = true,
	[31130154] = true,
	[31130151] = true
}
FightHeroALFComp.CardAddEffect = "ui/viewres/fight/card_alf.prefab"

function FightHeroALFComp:onAfterAddUseCardOnContainer(fightStepData)
	if not fightStepData then
		return
	end

	if not self.alfTimeLineCo then
		return
	end

	local count = 0
	local effectList = fightStepData.actEffect
	local skillId = 0

	for _, actEffectData in ipairs(effectList) do
		if actEffectData.effectType == FightEnum.EffectType.ADDUSECARD and FightHeroALFComp.ALFSkillDict[actEffectData.effectNum1] then
			count = count + 1
			skillId = actEffectData.effectNum1
		end
	end

	if count < 1 then
		return
	end

	local timeline

	if count <= 2 then
		timeline = self.alfTimeLineCo.timeline_2
	elseif count == 3 then
		timeline = self.alfTimeLineCo.timeline_3
	elseif count == 4 then
		timeline = self.alfTimeLineCo.timeline_4
	else
		logError("阿莱夫记忆牌大于4了？ count " .. tostring(count))

		timeline = self.alfTimeLineCo.timeline_4
	end

	if string.nilorempty(timeline) then
		return
	end

	fightStepData.fromId = self.entity.id
	fightStepData.actId = skillId

	self.entity.skill:playTimeline(timeline, fightStepData)
end

function FightHeroALFComp:setCacheRecordSkillList(skillList)
	self.cacheSkillList = skillList
end

function FightHeroALFComp:getCacheSkillList()
	return self.cacheSkillList
end

return FightHeroALFComp
