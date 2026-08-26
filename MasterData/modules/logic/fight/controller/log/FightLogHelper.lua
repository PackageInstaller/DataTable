-- chunkname: @modules/logic/fight/controller/log/FightLogHelper.lua

module("modules.logic.fight.controller.log.FightLogHelper", package.seeall)

local FightLogHelper = _M

function FightLogHelper.getPrefix(level)
	return string.rep("\t", level)
end

function FightLogHelper.getMoListString(moList, singleMoLogFunc, name, level, stack)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)

	if not moList then
		return string.format("%s %s : nil", initPre, name)
	end

	if #moList == 0 then
		return string.format("%s %s : []", initPre, name)
	end

	local strTb = {
		string.format("%s %s : [", initPre, name)
	}

	for index, mo in ipairs(moList) do
		table.insert(strTb, singleMoLogFunc(mo, level + 1, index))
	end

	table.insert(strTb, initPre .. "]")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getMoDictString(moDict, singleMoLogFunc, name, level, stack)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)

	if not moDict then
		return string.format("%s %s : nil", initPre, name)
	end

	if GameUtil.tabletool_dictIsEmpty(moDict) then
		return string.format("%s %s : []", initPre, name)
	end

	local strTb = {
		string.format("%s %s : [", initPre, name)
	}

	FightLogHelper.addStack(strTb, FightLogHelper.getPrefix(level + 1), stack, name)

	stack = FightLogHelper.getStack(stack, name)

	for key, mo in pairs(moDict) do
		table.insert(strTb, singleMoLogFunc(mo, level + 1, tostring(key), stack))
	end

	table.insert(strTb, initPre .. "]")

	return table.concat(strTb, "\n")
end

function FightLogHelper.buildClassNameByIndex(className, index)
	if index and index ~= 0 then
		return className .. "_" .. tostring(index)
	end

	return className
end

function FightLogHelper.getFightRoundString(fightRoundData, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightRoundData", index)

	if not fightRoundData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {}

	table.insert(strTb, string.format("%s %s {", initPre, className))

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s actPoint : %s", pre, fightRoundData.actPoint))
	table.insert(strTb, string.format("%s isFinish : %s", pre, fightRoundData.isFinish))
	table.insert(strTb, string.format("%s moveNum : %s", pre, fightRoundData.moveNum))
	table.insert(strTb, string.format("%s power : %s", pre, fightRoundData.power))
	table.insert(strTb, FightLogHelper.getFightStepListString(fightRoundData.fightStep, level, "fightStep", "FightRound"))
	table.insert(strTb, FightLogHelper.getFightStepListString(fightRoundData.nextRoundBeginStep, level, "nextRoundBeginStep", "FightRound"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getFightStepString(fightStepData, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightStepData", index)

	if not fightStepData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {}
	local initStr = string.format("%s %s {", initPre, className)

	table.insert(strTb, initStr)

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s actType : %s %s", pre, fightStepData.actType, FightLogHelper.getActTypeName(fightStepData.actType)))

	if fightStepData.actType == FightEnum.ActType.SKILL then
		table.insert(strTb, string.format("%s fromId : %s 技能发起者:%s", pre, fightStepData.fromId, FightLogHelper.getEntityName(fightStepData.fromId)))
		table.insert(strTb, string.format("%s toId : %s 技能承受者:%s", pre, fightStepData.toId, FightLogHelper.getEntityName(fightStepData.toId)))
		table.insert(strTb, string.format("%s actId : %s 技能名字:%s timeline : %s", pre, fightStepData.actId, FightLogHelper.getSkillName(fightStepData.actId), FightLogHelper.getTimelineName(fightStepData.fromId, fightStepData.actId)))
	else
		table.insert(strTb, string.format("%s fromId : %s", pre, fightStepData.fromId))
		table.insert(strTb, string.format("%s toId : %s", pre, fightStepData.toId))
		table.insert(strTb, string.format("%s actId : %s", pre, fightStepData.actId))
	end

	table.insert(strTb, string.format("%s cardIndex : %s", pre, fightStepData.cardIndex))
	table.insert(strTb, string.format("%s supportHeroId : %s", pre, fightStepData.supportHeroId))
	table.insert(strTb, string.format("%s fakeTimeline : %s", pre, fightStepData.fakeTimeline))
	table.insert(strTb, FightLogHelper.getFightActEffectListString(fightStepData.actEffect, level, "actEffect"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getFightStepListString(fightStepDataList, level, name, stack)
	name = name or "fightStepDataList"

	return FightLogHelper.getMoListString(fightStepDataList, FightLogHelper.getFightStepString, name, level, stack)
end

function FightLogHelper.getFightActEffectString(actEffectData, level, index, stack)
	if FightLogFilterHelper.checkActEffectDataIsFilter(actEffectData) then
		return ""
	end

	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("ActEffectData", index)

	if not actEffectData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	FightLogHelper.addStack(strTb, pre, stack, className)
	table.insert(strTb, string.format("%s targetId : %s 作用对象:%s", pre, actEffectData.targetId, FightLogHelper.getEntityName(actEffectData.targetId)))
	table.insert(strTb, string.format("%s effectType : %s 效果类型:%s", pre, actEffectData.effectType, FightLogHelper.getEffectTypeName(actEffectData.effectType)))
	table.insert(strTb, string.format("%s effectNum : %s", pre, actEffectData.effectNum))
	table.insert(strTb, string.format("%s effectNum1 : %s", pre, actEffectData.effectNum1))
	table.insert(strTb, string.format("%s fromSide : %s", pre, actEffectData.fromSide))
	table.insert(strTb, string.format("%s configEffect : %s", pre, actEffectData.configEffect))
	table.insert(strTb, string.format("%s buffActId : %s", pre, actEffectData.buffActId))
	table.insert(strTb, string.format("%s reserveId : %s", pre, actEffectData.reserveId))
	table.insert(strTb, string.format("%s reserveStr : %s", pre, actEffectData.reserveStr))
	table.insert(strTb, string.format("%s teamType : %s", pre, actEffectData.teamType))
	table.insert(strTb, string.format("%s cardHeatValue : %s", pre, actEffectData.cardHeatValue))
	table.insert(strTb, FightLogHelper.getAssistBossInfoString(actEffectData.assistBossInfo, level))

	stack = FightLogProtobufHelper.getStack(stack, className)

	table.insert(strTb, FightLogHelper.getCardInfoListString(actEffectData.cardInfoList, level, stack))

	if actEffectData.cardInfo then
		table.insert(strTb, FightLogHelper.getCardInfoString(actEffectData.cardInfo, level))
	end

	if actEffectData.fightStep then
		table.insert(strTb, FightLogHelper.getFightStepString(actEffectData.fightStep, level))
	end

	if actEffectData.buff then
		table.insert(strTb, FightLogHelper.getFightBuffString(actEffectData.buff, level))
	end

	if actEffectData.entity then
		table.insert(strTb, FightLogHelper.getEntityMoString(actEffectData.entity, level))
	end

	if actEffectData.magicCircle then
		table.insert(strTb, FightLogHelper.getMagicCircleDataString(actEffectData.magicCircle, level))
	end

	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getMagicCircleDataString(magicCircleData, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("MagicCircle", index)

	if not magicCircleData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)
	local co = lua_magic_circle.configDict[magicCircleData.magicCircleId]

	table.insert(strTb, string.format("%s createUid : %s, 创建者: %s", pre, magicCircleData.createUid, FightLogHelper.getEntityName(magicCircleData.createUid)))
	table.insert(strTb, string.format("%s magicCircleId : %s %s", pre, magicCircleData.magicCircleId, co and co.name))
	table.insert(strTb, string.format("%s round : %s", pre, magicCircleData.round))
	table.insert(strTb, string.format("%s electricLevel : %s", pre, magicCircleData.electricLevel))
	table.insert(strTb, string.format("%s electricProgress : %s", pre, magicCircleData.electricProgress))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getAssistBossInfoString(assistBossInfo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("AssistBossInfo", index)

	if not assistBossInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s currCd : %s", pre, assistBossInfo.currCd))
	table.insert(strTb, string.format("%s cdCfg : %s", pre, assistBossInfo.cdCfg))
	table.insert(strTb, string.format("%s formId : %s", pre, assistBossInfo.formId))
	table.insert(strTb, FightLogHelper.getAssistBossSkillInfoString(assistBossInfo.skills, level))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getAssistBossSkillInfoString(assistBossSkillInfo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("AssistBossSkillInfo", index)

	if not assistBossSkillInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s skillId : %s", pre, assistBossSkillInfo.skillId))
	table.insert(strTb, string.format("%s needPower : %s", pre, assistBossSkillInfo.needPower))
	table.insert(strTb, string.format("%s powerLow : %s", pre, assistBossSkillInfo.powerLow))
	table.insert(strTb, string.format("%s powerHigh : %s", pre, assistBossSkillInfo.powerHigh))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getFightAssistBossSkillListString(assistBossSkillInfoList, level, name)
	name = name or "assistBossSkillInfoList"

	return FightLogHelper.getMoListString(assistBossSkillInfoList, FightLogHelper.getAssistBossSkillInfoString, name, level)
end

function FightLogHelper.getFightActEffectListString(effectDataList, level, name)
	name = name or "effectDataList"

	return FightLogHelper.getMoListString(effectDataList, FightLogHelper.getFightActEffectString, name, level)
end

function FightLogHelper.getFightBuffString(buffMo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightBuffInfoData", index)

	if not buffMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s time : %s", pre, buffMo.time))
	table.insert(strTb, string.format("%s entityId : %s %s", pre, buffMo.entityId, FightLogHelper.getEntityName(buffMo.entityId)))
	table.insert(strTb, string.format("%s id : %s", pre, buffMo.id))
	table.insert(strTb, string.format("%s uid : %s", pre, buffMo.uid))
	table.insert(strTb, string.format("%s buffId : %s %s", pre, buffMo.buffId, buffMo.name))
	table.insert(strTb, string.format("%s duration : %s", pre, buffMo.duration))
	table.insert(strTb, string.format("%s exInfo : %s", pre, buffMo.exInfo))
	table.insert(strTb, string.format("%s fromUid : %s", pre, buffMo.fromUid))
	table.insert(strTb, string.format("%s count : %s", pre, buffMo.count))
	table.insert(strTb, string.format("%s name : %s", pre, buffMo.name))
	table.insert(strTb, string.format("%s actCommonParams : %s", pre, buffMo.actCommonParams))
	table.insert(strTb, string.format("%s layer : %s", pre, buffMo.layer))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getFightBuffListString(buffMoList, level, name)
	name = name or "buffMoList"

	return FightLogHelper.getMoListString(buffMoList, FightLogHelper.getFightBuffString, name, level)
end

function FightLogHelper.getFightBuffDictString(buffMoDict, level, name)
	name = name or "buffMoDict"

	return FightLogHelper.getMoDictString(buffMoDict, FightLogHelper.getFightBuffString, name, level)
end

function FightLogHelper.getEntityMoString(entityMo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightEntityMO", index)

	if not entityMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s id : %s", pre, entityMo.id))
	table.insert(strTb, string.format("%s uid : %s", pre, entityMo.uid))
	table.insert(strTb, string.format("%s modelId : %s", pre, entityMo.modelId))
	table.insert(strTb, string.format("%s skin : %s", pre, entityMo.skin))
	table.insert(strTb, string.format("%s originSkin : %s", pre, entityMo.originSkin))
	table.insert(strTb, string.format("%s position : %s", pre, entityMo.position))
	table.insert(strTb, string.format("%s entityType : %s", pre, entityMo.entityType))
	table.insert(strTb, string.format("%s userId : %s", pre, entityMo.userId))
	table.insert(strTb, string.format("%s exPoint : %s", pre, entityMo.exPoint))
	table.insert(strTb, string.format("%s level : %s", pre, entityMo.level))
	table.insert(strTb, string.format("%s currentHp : %s", pre, entityMo.currentHp))
	table.insert(strTb, string.format("%s equipUid : %s", pre, entityMo.equipUid))
	table.insert(strTb, string.format("%s side : %s", pre, entityMo.side))
	table.insert(strTb, string.format("%s career : %s", pre, entityMo.career))
	table.insert(strTb, string.format("%s storedExPoint : %s", pre, entityMo.storedExPoint))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getFightEntityListString(entityMoList, level, name)
	name = name or "entityMoList"

	return FightLogHelper.getMoListString(entityMoList, FightLogHelper.getEntityMoString, name, level)
end

function FightLogHelper.getCardInfoString(cardInfo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightCardInfoMO", index)

	if not cardInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s uid : %s %s", pre, cardInfo.uid, FightLogHelper.getEntityName(cardInfo.uid)))
	table.insert(strTb, string.format("%s skillId : %s %s", pre, cardInfo.skillId, FightLogHelper.getSkillName(cardInfo.skillId)))
	table.insert(strTb, string.format("%s cardEffect : %s", pre, cardInfo.cardEffect))
	table.insert(strTb, string.format("%s tempCard : %s", pre, cardInfo.tempCard))
	table.insert(strTb, string.format("%s cardType : %s", pre, cardInfo.cardType))
	table.insert(strTb, string.format("%s heroId : %s", pre, cardInfo.heroId))
	table.insert(strTb, string.format("%s status : %s", pre, cardInfo.status))
	table.insert(strTb, string.format("%s targetUid : %s %s", pre, cardInfo.targetUid, FightLogHelper.getEntityName(cardInfo.targetUid)))
	table.insert(strTb, string.format("%s energy : %s", pre, cardInfo.energy))
	table.insert(strTb, string.format("%s areaRedOrBlue : %s", pre, cardInfo.areaRedOrBlue))
	table.insert(strTb, string.format("%s heatId : %s", pre, cardInfo.heatId))
	table.insert(strTb, FightLogHelper.getEnchantListString(cardInfo.enchants, level, "enchants"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getCardInfoListString(cardInfoList, level, name, stack)
	name = name or "cardInfoList"

	return FightLogHelper.getMoListString(cardInfoList, FightLogHelper.getCardInfoString, name, level, stack)
end

function FightLogHelper.getCardInfoEnchantString(enchant, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("CardEnchant", index)

	if not enchant then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s enchantId : %s", pre, enchant.enchantId))
	table.insert(strTb, string.format("%s duration : %s", pre, enchant.duration))
	table.insert(strTb, string.format("%s exInfo : %s", pre, table.concat(enchant.exInfo, ",")))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogHelper.getEnchantListString(enchantList, level, name, stack)
	name = name or "enchantList"

	return FightLogHelper.getMoListString(enchantList, FightLogHelper.getCardInfoEnchantString, name, level, stack)
end

FightLogHelper.ActTypeName = {
	[FightEnum.ActType.SKILL] = "技能",
	[FightEnum.ActType.BUFF] = "buff",
	[FightEnum.ActType.EFFECT] = "效果",
	[FightEnum.ActType.CHANGEHERO] = "换人",
	[FightEnum.ActType.CHANGEWAVE] = "换波次时机"
}

function FightLogHelper.getActTypeName(actType)
	return (actType or nil) and (FightLogHelper.ActTypeName[actType] or "")
end

function FightLogHelper.getEntityName(entityId)
	if entityId == FightEntityScene.MySideId then
		return "维尔汀"
	elseif entityId == FightEntityScene.EnemySideId then
		return "重塑之手"
	else
		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		if entityMo then
			return entityMo:getEntityName()
		end

		return ""
	end

	return ""
end

function FightLogHelper.getSkillName(skillId)
	local config = lua_skill.configDict[skillId]

	return (config or nil) and (config.name or "")
end

function FightLogHelper.getTimelineName(entityId, skillId)
	if entityId then
		::label_26_0::

		local entityMo = FightDataHelper.entityMgr:getById(entityId)
		local timeline = FightConfig.instance:getSkinSkillTimeline(entityMo and entityMo.skin, skillId)

		return string.nilorempty(timeline) and "nil" or timeline
	end
end

function FightLogHelper.getStack(stack, curName)
	return stack and string.format("%s.%s", stack, curName) or curName
end

function FightLogHelper.addStack(tb, pre, stack, curName)
	stack = FightLogHelper.getStack(stack, curName)

	if string.nilorempty(stack) then
		return
	end

	table.insert(tb, string.format("%s stack : %s", pre, stack))
end

FightLogHelper.EffectTypeNameDict = {
	[FightEnum.EffectType.NONE] = "无效果",
	[FightEnum.EffectType.MISS] = "闪避",
	[FightEnum.EffectType.DAMAGE] = "造成伤害",
	[FightEnum.EffectType.CRIT] = "造成暴击",
	[FightEnum.EffectType.HEAL] = "治疗",
	[FightEnum.EffectType.BUFFADD] = "附加Buff",
	[FightEnum.EffectType.BUFFDEL] = "移除Buff",
	[FightEnum.EffectType.BUFFUPDATE] = "变更Buff回合(对应效果数值为变动值)",
	[FightEnum.EffectType.BUFFEFFECT] = "触发Buff效果",
	[FightEnum.EffectType.DEAD] = "死亡",
	[FightEnum.EffectType.ATTACKALTER] = "攻击改动（单场战斗内一直存在效果）",
	[FightEnum.EffectType.DEFENSEALTER] = "防御改动（单场战斗内一直存在效果）",
	[FightEnum.EffectType.BLOODLUST] = "吸血",
	[FightEnum.EffectType.PURIFY] = "净化",
	[FightEnum.EffectType.DISPERSE] = "驱散",
	[FightEnum.EffectType.ADDACT] = "增加行动点",
	[FightEnum.EffectType.ADDCARD] = "增加手牌",
	[FightEnum.EffectType.ADDEXPOINT] = "增加大招点",
	[FightEnum.EffectType.DAMAGEEXTRA] = "额外伤害",
	[FightEnum.EffectType.BUFFREJECT] = "添加buff被抵抗",
	[FightEnum.EffectType.DIZZY] = "限制使用技能（被眩晕无法使用技能）",
	[FightEnum.EffectType.INVINCIBLE] = "无敌",
	[FightEnum.EffectType.PROTECT] = "保护",
	[FightEnum.EffectType.FROZEN] = "冰冻",
	[FightEnum.EffectType.SILENCE] = "限制使用技能（沉默）",
	[FightEnum.EffectType.SHIELD] = "护盾",
	[FightEnum.EffectType.ATTR] = "属性改动",
	[FightEnum.EffectType.CURE] = "回血",
	[FightEnum.EffectType.SEAL] = "封技（禁用大招）",
	[FightEnum.EffectType.DISARM] = "缴械（禁用物理技能）",
	[FightEnum.EffectType.FORBID] = "禁魔（禁用魔法技能）",
	[FightEnum.EffectType.SLEEP] = "睡眠",
	[FightEnum.EffectType.PERTRIFIED] = "石化",
	[FightEnum.EffectType.IMMUNITY] = "免疫",
	[FightEnum.EffectType.INJURY] = "重伤",
	[FightEnum.EffectType.DOT] = "持续伤害",
	[FightEnum.EffectType.REBOUND] = "反弹",
	[FightEnum.EffectType.TAUNT] = "嘲讽",
	[FightEnum.EffectType.BEATBACK] = "反击",
	[FightEnum.EffectType.EXPOINTFIX] = "怒气修正",
	[FightEnum.EffectType.AVERAGELIFE] = "平分生命",
	[FightEnum.EffectType.SHIELDCHANGE] = "护盾转换",
	[FightEnum.EffectType.ADDTOATTACKER] = "给攻击者加buff",
	[FightEnum.EffectType.CURE2] = "回血（基于上回合伤害）",
	[FightEnum.EffectType.FORBIDSPECEFFECT] = "禁止特定类型技能",
	[FightEnum.EffectType.CANTCRIT] = "不暴击",
	[FightEnum.EffectType.PETRIFIEDRESIST] = "石化抵抗",
	[FightEnum.EffectType.SLEEPRESIST] = "睡眠抵抗",
	[FightEnum.EffectType.FROZENRESIST] = "冰冻抵抗",
	[FightEnum.EffectType.DIZZYRESIST] = "眩晕抵抗",
	[FightEnum.EffectType.ADDTOTARGET] = "给目标加buff",
	[FightEnum.EffectType.CRITPILEUP] = "暴击累加",
	[FightEnum.EffectType.DODGESPECSKILL] = "闪避特定技能(攻击后消失)",
	[FightEnum.EffectType.DODGESPECSKILL2] = "闪避特定技能",
	[FightEnum.EffectType.REDEALCARD] = "洗牌",
	[FightEnum.EffectType.BUFFADDNOEFFECT] = "Buff增加到失效列表",
	[FightEnum.EffectType.BUFFDELNOEFFECT] = "Buff从失效列表删除",
	[FightEnum.EffectType.HEALCRIT] = "治疗暴击",
	[FightEnum.EffectType.UNIVERSALCARD] = "获得万能牌",
	[FightEnum.EffectType.DEALCARD1] = "发牌1",
	[FightEnum.EffectType.DEALCARD2] = "发牌2",
	[FightEnum.EffectType.ROUNDEND] = "回合结束",
	[FightEnum.EffectType.SHIELDDEL] = "盾牌删除",
	[FightEnum.EffectType.EXPOINTCANTADD] = "无法加怒气",
	[FightEnum.EffectType.ADDBUFFROUND] = "额外增加buff回合",
	[FightEnum.EffectType.CARDLEVELADD] = "卡牌等级提升",
	[FightEnum.EffectType.IMMUNITYEXPOINTCHANGE] = "免疫怒气改变",
	[FightEnum.EffectType.MONSTERCHANGE] = "怪物变幻",
	[FightEnum.EffectType.EXPOINTADD] = "增加大招点（buff表现用）",
	[FightEnum.EffectType.EXPOINTDEL] = "减少大招点（buff表现用）",
	[FightEnum.EffectType.DAMAGENOTMORETHAN] = "受到伤害不超过生命百分比",
	[FightEnum.EffectType.BUFFATTR] = "根据buff数量加属性",
	[FightEnum.EffectType.EXPOINTCARDMOVE] = "移动卡牌怒气修正",
	[FightEnum.EffectType.EXPOINTCARDUPGRADE] = "合成卡牌怒气修正",
	[FightEnum.EffectType.FIXEDHURT] = "固定伤害",
	[FightEnum.EffectType.CARDLEVELCHANGE] = "卡牌变化",
	[FightEnum.EffectType.BUFFREPLACE] = "buff替换",
	[FightEnum.EffectType.EXTRAMOVEACT] = "额外移牌次数",
	[FightEnum.EffectType.SPCARDADD] = "获得特殊牌（主角技能）",
	[FightEnum.EffectType.RIGID] = "僵硬",
	[FightEnum.EffectType.COLD] = "寒冷",
	[FightEnum.EffectType.PALSY] = "麻痹",
	[FightEnum.EffectType.ADDBUFFROUNDBYTYPEID] = "额外增加buff回合（根据buff的typeid）",
	[FightEnum.EffectType.EXSKILLNOCONSUMPTION] = "大招不消耗大招点",
	[FightEnum.EffectType.EXPOINTADDAFTERDELORABSORBEXPOINT] = "在减少敌人大招点后增加自己大招点",
	[FightEnum.EffectType.CARDEFFECTCHANGE] = "卡牌附魔改变",
	[FightEnum.EffectType.SUMMON] = "召唤",
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = "骰子技能选择",
	[FightEnum.EffectType.SKILLPOWERUP] = "技能提升",
	[FightEnum.EffectType.BUFFRATEUP] = "buff效果提升",
	[FightEnum.EffectType.SKILLRATEUP] = "技能倍率提升",
	[FightEnum.EffectType.EXPOINTMAXADD] = "增加大招点上限",
	[FightEnum.EffectType.HALOBASE] = "主光环效果",
	[FightEnum.EffectType.HALOSLAVE] = "附属光环效果",
	[FightEnum.EffectType.SELECTLAST] = "不被优先选中",
	[FightEnum.EffectType.CANTSELECT] = "不能被选中",
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = "清空万能卡",
	[FightEnum.EffectType.CHANGECAREER] = "改变系别",
	[FightEnum.EffectType.FIXEDDAMAGE] = "造成伤害固定",
	[FightEnum.EffectType.PASSIVESKILLINVALID] = "被动失效",
	[FightEnum.EffectType.HIDELIFE] = "隐藏血条",
	[FightEnum.EffectType.BUFFADDACT] = "buff额外增加的行动点（可能为负）",
	[FightEnum.EffectType.ADDCARDLIMIT] = "增加手牌上限",
	[FightEnum.EffectType.ADDBUFFROUNDBYTYPEGROUP] = "额外增加buff回合（根据buff的typeid）",
	[FightEnum.EffectType.FREEZE] = "休眠，显示用",
	[FightEnum.EffectType.CANTSELECTEX] = "不能被选中",
	[FightEnum.EffectType.CARDDISAPPEAR] = "卡牌消失",
	[FightEnum.EffectType.CHANGEHERO] = "替补上场",
	[FightEnum.EffectType.MAXHPCHANGE] = "最大生命变化",
	[FightEnum.EffectType.CURRENTHPCHANGE] = "当前生命变化",
	[FightEnum.EffectType.KILL] = "斩杀",
	[FightEnum.EffectType.EXPOINTCHANGE] = "大招点变化（所有变化都需要发）",
	[FightEnum.EffectType.MONSTERSPLIFE] = "怪物特殊血条",
	[FightEnum.EffectType.EXSKILLPOINTCHANGE] = "大招需求激情变化",
	[FightEnum.EffectType.HARMSTATISTIC] = "伤害统计用buff",
	[FightEnum.EffectType.OVERFLOWHEALTOSHIELD] = "溢出治疗转盾",
	[FightEnum.EffectType.ADDSKILLBUFFCOUNTANDDURATION] = "增加主动技能加的buff的生效次数和生效回合",
	[FightEnum.EffectType.INDICATORCHANGE] = "指示物变化",
	[FightEnum.EffectType.MULTIHPCHANGE] = "多血条切换",
	[FightEnum.EffectType.MONSTERLABELBUFF] = "怪物标签buff",
	[FightEnum.EffectType.POWERMAXADD] = "增加能量上限",
	[FightEnum.EffectType.POWERCHANGE] = "能量改变",
	[FightEnum.EffectType.CANTGETEXSKILL] = "不能获得大招卡",
	[FightEnum.EffectType.ORIGINDAMAGE] = "本源创伤",
	[FightEnum.EffectType.ORIGINCRIT] = "本源创伤暴击",
	[FightEnum.EffectType.SHIELDBROCKEN] = "破盾",
	[FightEnum.EffectType.CARDREMOVE] = "临时创造卡移除",
	[FightEnum.EffectType.SUMMONEDADD] = "召唤物挂件增加",
	[FightEnum.EffectType.SUMMONEDDELETE] = "召唤物挂件移除",
	[FightEnum.EffectType.SUMMONEDLEVELUP] = "召唤物挂件升级",
	[FightEnum.EffectType.BURN] = "燃烧",
	[FightEnum.EffectType.MAGICCIRCLEADD] = "法阵增加",
	[FightEnum.EffectType.MAGICCIRCLEDELETE] = "法阵移除",
	[FightEnum.EffectType.MAGICCIRCLEUPDATE] = "法阵更新",
	[FightEnum.EffectType.CHANGETOTEMPCARD] = "原来的卡转为临时创造卡",
	[FightEnum.EffectType.ROGUEHEARTCHANGE] = "肉鸽心跳变化",
	[FightEnum.EffectType.ROGUECOINCHANGE] = "肉鸽金币变化",
	[FightEnum.EffectType.ROGUESAVECOIN] = "肉鸽偷到的金币",
	[FightEnum.EffectType.ROGUEESCAPE] = "逃跑",
	[FightEnum.EffectType.REGAINPOWER] = "恢复灵光",
	[FightEnum.EffectType.ADDTOBUFFENTITY] = "增加buff给buff持有者",
	[FightEnum.EffectType.MASTERPOWERCHANGE] = "主角技能点改变",
	[FightEnum.EffectType.ADDHANDCARD] = "添加卡牌",
	[FightEnum.EffectType.OVERFLOWPOWERADDBUFF] = "溢出灵光为持有者加buff",
	[FightEnum.EffectType.POWERCANTDECR] = "不再失去灵光",
	[FightEnum.EffectType.REMOVEENTITYCARDS] = "移除角色卡牌",
	[FightEnum.EffectType.CARDSCOMPOSE] = "发起角色卡牌合成（不一定合成）",
	[FightEnum.EffectType.CARDSPUSH] = "卡牌推送",
	[FightEnum.EffectType.CARDREMOVE2] = "卡牌移除（不触发合牌）",
	[FightEnum.EffectType.BFSGCONVERTCARD] = "北方哨歌专用 卡牌转换",
	[FightEnum.EffectType.BFSGUSECARD] = "北方哨歌专用 出牌",
	[FightEnum.EffectType.BFSGSKILLEND] = "北方哨歌专用 技能end",
	[FightEnum.EffectType.USECARDS] = "使用牌组",
	[FightEnum.EffectType.CARDINVALID] = "卡牌失效",
	[FightEnum.EffectType.BFSGSKILLSTART] = "北方哨歌专用 技能start",
	[FightEnum.EffectType.FIGHTSTEP] = "新的步骤",
	[FightEnum.EffectType.IGNOREDODGESPECSKILL] = "无视闪避",
	[FightEnum.EffectType.IGNORECOUNTER] = "无视反制",
	[FightEnum.EffectType.IGNOREREBOUND] = "无视反弹",
	[FightEnum.EffectType.CAREERRESTRAINT] = "灵感克制",
	[FightEnum.EffectType.STORAGEINJURY] = "记录承伤",
	[FightEnum.EffectType.INJURYLOGBACK] = "记录阶段内承伤,对自身本源伤害",
	[FightEnum.EffectType.ABSORBHURT] = "给队友承受部分伤害",
	[FightEnum.EffectType.CARDACONVERTCARDB] = "卡a转卡b",
	[FightEnum.EffectType.HEROUPGRADE] = "角色升级",
	[FightEnum.EffectType.MASTERHALO] = "新主光环",
	[FightEnum.EffectType.SLAVEHALO] = "新从光环",
	[FightEnum.EffectType.NOTIFYUPGRADEHERO] = "通知可升级",
	[FightEnum.EffectType.POLARIZATIONADDLIMIT] = "偏振上限增加",
	[FightEnum.EffectType.POLARIZATIONDECCARD] = "偏振卡牌需求减少",
	[FightEnum.EffectType.POLARIZATIONADDLEVEL] = "偏振等级增加",
	[FightEnum.EffectType.POLARIZATIONEXSKILLADD] = "使用大招卡偏振等级增加",
	[FightEnum.EffectType.RESONANCEADDLIMIT] = "共振上限增加",
	[FightEnum.EffectType.RESONANCEDECCARD] = "共振卡牌需求减少",
	[FightEnum.EffectType.RESONANCEADDLEVEL] = "共振等级增加",
	[FightEnum.EffectType.RESONANCEEXSKILLADD] = "使用大招卡共振等级增加",
	[FightEnum.EffectType.POLARIZATIONLEVEL] = "偏振等级",
	[FightEnum.EffectType.RESONANCELEVEL] = "共振等级",
	[FightEnum.EffectType.POLARIZATIONACTIVE] = "启用偏振",
	[FightEnum.EffectType.RESONANCEACTIVE] = "启用共振",
	[FightEnum.EffectType.ROUGEREWARD] = "肉鸽奖励buff(弃用)",
	[FightEnum.EffectType.ROUGEPOWERLIMITCHANGE] = "肉鸽魔力上限改变",
	[FightEnum.EffectType.ROUGEPOWERCHANGE] = "肉鸽魔力改变",
	[FightEnum.EffectType.ROUGECOINCHANGE] = "肉鸽金币改变",
	[FightEnum.EffectType.ROUGESPCARDADD] = "获得肉鸽特殊牌（主角技能）",
	[FightEnum.EffectType.DAMAGEFROMABSORB] = "造成伤害",
	[FightEnum.EffectType.DAMAGEFROMLOSTHP] = "损血",
	[FightEnum.EffectType.RECORDTEAMINJURYCOUNT] = "记录友方损失生命次数",
	[FightEnum.EffectType.INJURYBANKHEAL] = "承伤触发治疗",
	[FightEnum.EffectType.MASTERCARDREMOVE] = "主角技能删牌",
	[FightEnum.EffectType.MASTERADDHANDCARD] = "主角技能加牌",
	[FightEnum.EffectType.FIGHTCOUNTER] = "战斗计数器",
	[FightEnum.EffectType.IGNOREBEATBACK] = "无视獠牙伙伴",
	[FightEnum.EffectType.ENTERTEAMSTAGE] = "进入队伍阶段",
	[FightEnum.EffectType.MOCKTAUNT] = "类嘲讽buff",
	[FightEnum.EffectType.ENCHANTBURNDAMAGE] = "附魔燃烧伤害",
	[FightEnum.EffectType.REALHURTFIXWITHLIMIT] = "本源创伤承受伤害修正, 且受到伤害不超过生命百分比(J新增)",
	[FightEnum.EffectType.BUFFTYPENUMLIMITUPDATE] = "buff类层数上限修正(J新增,修改燃烧层数上限)",
	[FightEnum.EffectType.LOCKHP] = "锁血",
	[FightEnum.EffectType.MOVE] = "位移",
	[FightEnum.EffectType.MOVEFRONT] = "前移",
	[FightEnum.EffectType.MOVEBACK] = "后移",
	[FightEnum.EffectType.SKILLLEVELJUDGEADD] = "技能阶数判定提升",
	[FightEnum.EffectType.TEAMMATEINJURYCOUNT] = "开始记录队友承伤次数的标记buff",
	[FightEnum.EffectType.SMALLROUNDEND] = "换出手方",
	[FightEnum.EffectType.CHANGEROUND] = "换回合",
	[FightEnum.EffectType.POISON] = "中毒",
	[FightEnum.EffectType.EXPOINTOVERFLOWBANK] = "怒气溢出存储",
	[FightEnum.EffectType.ADDUSECARD] = "加牌到出牌区",
	[FightEnum.EffectType.LOCKDOT] = "锁毒buff，不扣除",
	[FightEnum.EffectType.CATAPULTBUFF] = "弹射buff",
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = "出牌区卡牌升阶",
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = "出牌区卡牌降阶",
	[FightEnum.EffectType.PLAYSETGRAY] = "出牌区置灰",
	[FightEnum.EffectType.RESISTANCESATTR] = "抗性属性",
	[FightEnum.EffectType.RESISTANCES] = "产生抗性 加buff失败",
	[FightEnum.EffectType.ADDBUFFROUNDBYSKILL] = "技能增加buff次数和回合",
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = "出牌区卡牌变阶失败",
	[FightEnum.EffectType.COPYBUFFBYKILL] = "击杀时记录buff然后复制",
	[FightEnum.EffectType.POISONSETTLECANCRIT] = "中毒可暴击",
	[FightEnum.EffectType.CHANGEWAVE] = "换波",
	[FightEnum.EffectType.SHIELDVALUECHANGE] = "护盾值改变",
	[FightEnum.EffectType.BREAKSHIELD] = "破盾",
	[FightEnum.EffectType.STRESSTRIGGER] = "压力触发行为",
	[FightEnum.EffectType.LAYERMASTERHALO] = "可叠层的主光环",
	[FightEnum.EffectType.LAYERSLAVEHALO] = "可叠层附属光环效果",
	[FightEnum.EffectType.ENTERFIGHTDEAL] = "进入战斗发牌",
	[FightEnum.EffectType.LAYERHALOSYNC] = "叠层光环同步",
	[FightEnum.EffectType.SUBHEROLIFECHANGE] = "替补血量变化",
	[FightEnum.EffectType.GUARDCHANGE] = "格挡值变化",
	[FightEnum.EffectType.LOCKBULLETCOUNTDECR] = "锁定子弹减少 保留最后一层",
	[FightEnum.EffectType.ENTITYSYNC] = "实体消息同步",
	[FightEnum.EffectType.PRECISIONREGION] = "精准区域",
	[FightEnum.EffectType.TRANSFERADDEXPOINT] = "转移激情",
	[FightEnum.EffectType.NOTIFIYHEROCONTRACT] = "(娜娜)通知可发起契约",
	[FightEnum.EffectType.CONTRANCT] = "(娜娜)契约   242表示娜娜自己",
	[FightEnum.EffectType.BECONTRANCTED] = "(娜娜)被契约  243表示被契约的人",
	[FightEnum.EffectType.SPEXPOINTMAXADD] = "(特殊表现(娜娜))增加大招点上限",
	[FightEnum.EffectType.TRANSFERADDSTRESS] = "转移应激",
	[FightEnum.EffectType.GUARDBREAK] = "破盾",
	[FightEnum.EffectType.CARDDECKGENERATE] = "生成指定技能插入牌库",
	[FightEnum.EffectType.CARDDECKDELETE] = "删除指定技能牌库",
	[FightEnum.EffectType.DELCARDANDDAMAGE] = "删除卡牌并造成伤害",
	[FightEnum.EffectType.CHARM] = "魅惑（同眩晕效果一致）",
	[FightEnum.EffectType.PROGRESSCHANGE] = "战场进度变化",
	[FightEnum.EffectType.ASSISTBOSSSKILLCD] = "修改协助boss技能cd",
	[FightEnum.EffectType.DAMAGESHAREHP] = "共享血量扣血",
	[FightEnum.EffectType.USECARDFIXEXPOINT] = "使用卡牌修正大招点",
	[FightEnum.EffectType.DEADLYPOISON] = "剧毒",
	[FightEnum.EffectType.PROGRESSMAXCHANGE] = "战场进度最大值变化",
	[FightEnum.EffectType.DUDUBONECONTINUECHANNEL] = "笃笃骨吟诵",
	[FightEnum.EffectType.ZXQREMOVECARD] = "纸信圈专属移除卡牌，没有表现效果",
	[FightEnum.EffectType.CURECORRECT] = "治疗修正",
	[FightEnum.EffectType.ASSISTBOSSCHANGE] = "协助boss改变",
	[FightEnum.EffectType.CONFUSION] = "混乱效果",
	[FightEnum.EffectType.RETAINPERTRIFIED] = "攻击石化单位时不解除石化",
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = "剧毒本源创伤",
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = "剧毒本源创伤暴击",
	[FightEnum.EffectType.ASSISTBOSSSKILLCHANGE] = "协助boss技能改变",
	[FightEnum.EffectType.LOCKBURN] = "锁燃烧",
	[FightEnum.EffectType.ADDITIONALDAMAGE] = "附加伤害",
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = "附加伤害暴击",
	[FightEnum.EffectType.ACT174FIRST] = "活动174决定先后手",
	[FightEnum.EffectType.ACT174USECARD] = "活动174回合出牌",
	[FightEnum.EffectType.CHANGESHIELD] = "修改护盾值",
	[FightEnum.EffectType.TOWERSCORECHANGE] = "限时塔分数改变",
	[FightEnum.EffectType.ACT174MONSTERAICARD] = "敌方选牌列表",
	[FightEnum.EffectType.AFTERREDEALCARD] = "洗牌后",
	[FightEnum.EffectType.TEAMENERGYCHANGE] = "队伍灵能变化",
	[FightEnum.EffectType.ALLOCATECARDENERGY] = "分配手牌灵能",
	[FightEnum.EffectType.EMITTERENERGYCHANGE] = "发射器灵能变化",
	[FightEnum.EffectType.EMITTERSKILLEND] = "发射器技能结束",
	[FightEnum.EffectType.CARDDECKCLEAR] = "清空牌库",
	[FightEnum.EffectType.EMITTERCREATE] = "发射器实体创建",
	[FightEnum.EffectType.ADDONCECARD] = "加一张牌 新加效果详情请咨询 皓文大佬 and 森总",
	[FightEnum.EffectType.SHAREHURT] = "分摊伤害",
	[FightEnum.EffectType.PLAYERFINISHERSKILLCHANGE] = "玩家终结技能改变",
	[FightEnum.EffectType.EMITTERCAREERCHANGE] = "奥术飞弹发射器灵感变换",
	[FightEnum.EffectType.EMITTERNUMCHANGE] = "奥术飞弹发射器数量改变",
	[FightEnum.EffectType.EMITTERTAG] = "奥术飞弹发射器存在标记tag",
	[FightEnum.EffectType.EMITTERREMOVE] = "发射器实体移除",
	[FightEnum.EffectType.USESKILLTEAMADDEMITTERENERGY] = "行动全队特定buff提升奥术飞弹灵能值",
	[FightEnum.EffectType.FIXATTRTEAMENERGY] = "属性修正（根据队伍灵能值）",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONACTIVE] = "启用简振",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONLEVEL] = "简振等级",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLEVEL] = "添加简振等级",
	[FightEnum.EffectType.CALLMONSTERTOSUB] = "召唤小怪到后场",
	[FightEnum.EffectType.FIXATTRTEAMENERGYANDBUFF] = "属性修正（根据队伍灵能值和队友buff） value显示数值",
	[FightEnum.EffectType.POWERINFOCHANGE] = "能量信息变化",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLIMIT] = "简振上限增加",
	[FightEnum.EffectType.EMITTERMAINTARGET] = "奥术飞弹优先攻击目标",
	[FightEnum.EffectType.CONDITIONSPLITEMITTERNUM] = "奥术飞弹条件分裂",
	[FightEnum.EffectType.ADDSPLITEMITTERNUM] = "奥术飞弹额外分裂",
	[FightEnum.EffectType.EMITTERFIGHTNOTIFY] = "奥术飞弹放技能前通知",
	[FightEnum.EffectType.MUSTCRITBUFF] = "必定暴击buff",
	[FightEnum.EffectType.MUSTCRIT] = "触发必定暴击",
	[FightEnum.EffectType.CARDAREAREDORBLUE] = "(梁月大)手牌红蓝分区Buff",
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = "(梁月大)决定操作区手牌红蓝分区",
	[FightEnum.EffectType.REDORBLUECOUNT] = "(梁月大)红蓝区计数Buff",
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = "(梁月大)红蓝区计数变更",
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = "(梁月大)红蓝区计数触发阈值变更buff",
	[FightEnum.EffectType.CARDHEATINIT] = "卡牌热力初始化",
	[FightEnum.EffectType.CARDHEATVALUECHANGE] = "卡牌热力值变化",
	[FightEnum.EffectType.CARDDECKNUM] = "牌库数量",
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = "(梁月大)红蓝区队列满触发追击",
	[FightEnum.EffectType.STORAGEDAMAGE] = "存储伤害",
	[FightEnum.EffectType.ELUSIVE] = "场上有其他未携带该buff的友方时携带该buff的单位无法被选为主目标",
	[FightEnum.EffectType.ENCHANTDEPRESSEDAMAGE] = "附魔 气脉郁结 伤害",
	[FightEnum.EffectType.SAVEFIGHTRECORDSTART] = "战场回溯开始",
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = "战场回溯更新实体信息",
	[FightEnum.EffectType.SAVEFIGHTRECORDEND] = "战场回溯结束",
	[FightEnum.EffectType.ROUNDOFFSET] = "回合数偏移",
	[FightEnum.EffectType.SAVEFIGHTRECORD] = "战场回溯buff",
	[FightEnum.EffectType.ADDSPHANDCARD] = "添加SP手牌 78有问题 没有完整cardInfo 少用",
	[FightEnum.EffectType.NONCAREERRESTRAINT] = "非克制伤害",
	[FightEnum.EffectType.CLEARMONSTERSUB] = "清空怪物候场",
	[FightEnum.EffectType.FIGHTTASKUPDATE] = "战斗任务更新",
	[FightEnum.EffectType.RETAINSLEEP] = "攻击噩梦单位不解除噩梦",
	[FightEnum.EffectType.REMOVEMONSTERSUB] = "移除怪物候场",
	[FightEnum.EffectType.ADDCARDRECORDBYROUND] = "回合记忆卡牌数据更新",
	[FightEnum.EffectType.DIRECTUSEEXSKILL] = "直接释放大招",
	[FightEnum.EffectType.SPLITSTART] = "分割 开始 目前梦游2换人专用 要用要找皓文大佬说一下 必须要和SPLITEND配套使用",
	[FightEnum.EffectType.SPLITEND] = "分割 结束 目前梦游2换人专用 要用要找皓文大佬说一下 必须要和SPLITSTART配套使用",
	[FightEnum.EffectType.FIGHTPARAMCHANGE] = "FightParam变化",
	[FightEnum.EffectType.BLOODPOOLMAXCREATE] = "血池创建",
	[FightEnum.EffectType.BLOODPOOLMAXCHANGE] = "血池最大值变化",
	[FightEnum.EffectType.BLOODPOOLVALUECHANGE] = "血池当前值变化",
	[FightEnum.EffectType.COLDSATURDAYHURT] = "冷周六伤害特效",
	[FightEnum.EffectType.NEWCHANGEWAVE] = "新的切波次 原因：以前切波数据拆成两个协议发，很容易导致有问题，加一下新的切波并且将fight加到effect里面",
	[FightEnum.EffectType.CHANGECARDENERGY] = "修改卡牌灵能",
	[FightEnum.EffectType.CLIENTEFFECT] = "客户端表现",
	[FightEnum.EffectType.MAGICCIRCLEUPGRADE] = "法阵升级",
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = "诺谛卡仪式随机攻击",
	[FightEnum.EffectType.NUODIKATEAMATTACK] = "诺谛卡仪式群体攻击",
	[FightEnum.EffectType.TRIGGERANALYSIS] = "触发分析",
	[FightEnum.EffectType.GETSECRETKEY] = "获取秘钥",
	[FightEnum.EffectType.SURVIVALHEALTHCHANGE] = "探索健康度变化",
	[FightEnum.EffectType.LOCKHPMAX] = "锁定血量上限",
	[FightEnum.EffectType.CUREUPBYLOSTHP] = "治疗修正提升根据损失血量",
	[FightEnum.EffectType.NOUSECARDENERGYRECORDBYROUND] = "记录回合未使用卡牌最高灵能值",
	[FightEnum.EffectType.NUODIKARANDOMATTACKNUM] = "诺谛卡仪式群体攻击次数同步",
	[FightEnum.EffectType.BUFFACTINFOUPDATE] = "buffActInfo更新",
	[FightEnum.EffectType.REALDAMAGEKILL] = "斩杀伤害",
	[FightEnum.EffectType.BUFFDELREASON] = "buff删除原因",
	[FightEnum.EffectType.RANDOMDICEUSESKILL] = "骰子表现随机释放技能",
	[FightEnum.EffectType.TOWERDEEPCHANGE] = "爬塔深度变化",
	[FightEnum.EffectType.FIGHTHURTDETAIL] = "战斗伤害通用信息结构",
	[FightEnum.EffectType.ADDMAXROUND] = "加最大回合数",
	[FightEnum.EffectType.RADIANCE] = "辉耀",
	[FightEnum.EffectType.CRYSTALSELECT] = "选择水晶结果",
	[FightEnum.EffectType.CRYSTALADDCARD] = "贝丽尔水晶生成卡",
	[FightEnum.EffectType.ROUGE2MUSICCARDCHANGE] = "队伍手牌音符球变更",
	[FightEnum.EffectType.ROUGE2MUSICBALLCHANGE] = "队伍储存区音符球变更",
	[FightEnum.EffectType.ROUGE2CHECK] = "肉鸽2检定结果",
	[FightEnum.EffectType.INDICATORDIFFCHANGE] = "战场指示物差异变化",
	[FightEnum.EffectType.CHANGESCENE] = "切换场景",
	[FightEnum.EffectType.ANANFOCUSBUFF] = "(安安狂想)收集全场buff",
	[FightEnum.EffectType.EMITTEREXTRADEMAGE] = "飞弹额外伤害",
	[FightEnum.EffectType.EXTCAREERWEAK] = "弱点灵感",
	[FightEnum.EffectType.TOUGHNESSRECOVER] = "韧性恢复",
	[FightEnum.EffectType.TOUGHNESSCHANGE] = "韧性变化",
	[FightEnum.EffectType.BUFFERFLYADDHANDCARD] = "洛伦兹蝴蝶添加卡牌",
	[FightEnum.EffectType.INITDEVICE] = "初始化装置",
	[FightEnum.EffectType.DEVICESKILLINDEX] = "装置切换技能",
	[FightEnum.EffectType.DEVICEPOWERCHANGE] = "装置能量变化",
	[FightEnum.EffectType.TOUGHNESSRESET] = "韧性重置变化",
	[FightEnum.EffectType.MOVECARD] = "移动卡牌",
	[FightEnum.EffectType.UPDATECARDDATA] = "更新卡牌",
	[FightEnum.EffectType.INSERTHANDCARD] = "插入手牌区",
	[FightEnum.EffectType.DEVICERUNNING] = "装置是否运行",
	[FightEnum.EffectType.UNNAMEDSTRENGTHEN] = "无名者强化效果",
	[FightEnum.EffectType.COUNTERCHANGE] = "计数器变化(变化后的值)",
	[FightEnum.EffectType.DEVICEPOWERCLEAR] = "装置能量清空",
	[FightEnum.EffectType.DEVICESTOP] = "装置停止",
	[FightEnum.EffectType.TRIGGER] = "触发器",
	[FightEnum.EffectType.EZIOBIGSKILLDAMAGE] = "EZIO大招伤害",
	[FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE] = "EZIO大招本源创伤",
	[FightEnum.EffectType.UPDATEITEMPLAYERSKILL] = "更新道具主角技能",
	[FightEnum.EffectType.EZIOBIGSKILLEXIT] = "EZIO大招意外退出",
	[FightEnum.EffectType.TWINSPOWERUPCOUNT] = "TwinsPower双生计数",
	[FightEnum.EffectType.TWINSUPCOUNTER] = "TwinsUpByCounter双生提升"
}

function FightLogHelper.getEffectTypeName(effectType)
	return FightLogHelper.EffectTypeNameDict[effectType]
end

return FightLogHelper
