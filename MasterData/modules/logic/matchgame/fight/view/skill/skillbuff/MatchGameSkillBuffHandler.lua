-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameSkillBuffHandler.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameSkillBuffHandler", package.seeall)

local MatchGameSkillBuffHandler = class("MatchGameSkillBuffHandler")

function MatchGameSkillBuffHandler:handleBuffEffect(buffConfig, targetInfoList, skillData, viewContent, skillBuffMo)
	local buffEffectData = string.splitToNumber(buffConfig.buffEffect, "#")
	local buffEffectId = buffEffectData[1]
	local buffEffectType = MatchGameFightConfig.instance:getSkillBuffConfig(buffEffectId).buffEffectType
	local cls = _G[string.format("MatchGameBuffEffect_%s", buffEffectType)]

	if cls then
		local buffEffectHandler = cls.New()

		buffEffectHandler:init(viewContent)

		local func = buffEffectHandler["progressBuff_" .. buffEffectId]

		if func then
			return func(buffEffectHandler, buffEffectData, targetInfoList, skillData, skillBuffMo)
		end
	end
end

function MatchGameSkillBuffHandler:attachBuffToTarget(targetObj, skillBuffMo)
	if not targetObj or not skillBuffMo then
		return
	end

	targetObj.skillBuffMoMap = targetObj.skillBuffMoMap or {}

	if targetObj.skillBuffMoMap[skillBuffMo:getBuffUid()] then
		return
	end

	targetObj.skillBuffMoMap[skillBuffMo:getBuffUid()] = skillBuffMo

	skillBuffMo:addHoldCount()
end

function MatchGameSkillBuffHandler:removeTargetBuff(targetObj, skillBuffMo, viewContent)
	if not targetObj or not targetObj.skillBuffMoMap or not skillBuffMo then
		return
	end

	local buffUid = skillBuffMo:getBuffUid()

	if not targetObj.skillBuffMoMap[buffUid] then
		return
	end

	local buffEffectData = string.splitToNumber(skillBuffMo.buffConfig.buffEffect, "#")
	local buffEffectId = buffEffectData[1]
	local buffEffectType = MatchGameFightConfig.instance:getSkillBuffConfig(buffEffectId).buffEffectType
	local cls = _G[string.format("MatchGameBuffEffect_%s", buffEffectType)]

	if cls then
		local buffEffectHandler = cls.New()

		buffEffectHandler:init(viewContent)

		local func = buffEffectHandler["removeBuff_" .. buffEffectId]

		if func then
			func(buffEffectHandler, buffEffectData, targetObj, skillBuffMo)
		end
	end

	targetObj.skillBuffMoMap[buffUid] = nil

	if skillBuffMo:subHoldCount() <= 0 then
		skillBuffMo:removeBuff()
	end
end

function MatchGameSkillBuffHandler:removeTargetBuffByEffectType(targetObj, buffEffectType, viewContent)
	if not targetObj or not targetObj.skillBuffMoMap then
		return
	end

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap) do
		if skillBuffMo.buffEffectType == buffEffectType then
			self:removeTargetBuff(targetObj, skillBuffMo, viewContent)
		end
	end
end

function MatchGameSkillBuffHandler:removeTargetBuffByBuffId(targetObj, buffId, viewContent)
	if not targetObj or not targetObj.skillBuffMoMap then
		return
	end

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap) do
		if skillBuffMo.buffId == buffId then
			self:removeTargetBuff(targetObj, skillBuffMo, viewContent)
		end
	end
end

function MatchGameSkillBuffHandler:removeTargetBuffByBuffType(targetObj, buffType, viewContent)
	if not targetObj or not targetObj.skillBuffMoMap then
		return
	end

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap) do
		if skillBuffMo.buffType == buffType then
			self:removeTargetBuff(targetObj, skillBuffMo, viewContent)
		end
	end
end

function MatchGameSkillBuffHandler:removeAllTargetBuff(targetObj, viewContent)
	if not targetObj or not targetObj.skillBuffMoMap then
		return
	end

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap) do
		self:removeTargetBuff(targetObj, skillBuffMo, viewContent)
	end
end

function MatchGameSkillBuffHandler:revertBuffEffect(skillBuffMo, viewContent)
	if not skillBuffMo or not skillBuffMo.buffConfig then
		return
	end

	local buffUid = skillBuffMo:getBuffUid()
	local curElementItemMap = viewContent.sceneView:getElementItemMap()

	for posXIndex, dataMap in pairs(curElementItemMap) do
		for posYIndex, elementItem in pairs(dataMap) do
			if elementItem and elementItem.comp and elementItem.comp.skillBuffMoMap and elementItem.comp.skillBuffMoMap[buffUid] then
				self:removeTargetBuff(elementItem.comp, skillBuffMo, viewContent)
			end
		end
	end

	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()

	for posIndex, heroFightMo in pairs(heroFightInfoMap) do
		if heroFightMo and heroFightMo.skillBuffMoMap and heroFightMo.skillBuffMoMap[buffUid] then
			self:removeTargetBuff(heroFightMo, skillBuffMo, viewContent)
		end
	end

	local enemyInfoMo = viewContent.fightView:getCurEnemyInfoMo()

	if enemyInfoMo and enemyInfoMo.skillBuffMoMap and enemyInfoMo.skillBuffMoMap[buffUid] then
		self:removeTargetBuff(enemyInfoMo, skillBuffMo, viewContent)
	end

	local gameInfoMo = viewContent.sceneView:getGameInfoMo()

	if gameInfoMo.skillBuffMoMap and gameInfoMo.skillBuffMoMap[buffUid] then
		self:removeTargetBuff(gameInfoMo, skillBuffMo, viewContent)
	end
end

MatchGameSkillBuffHandler.instance = MatchGameSkillBuffHandler.New()

return MatchGameSkillBuffHandler
