-- chunkname: @modules/logic/fight/controller/log/FightLogProtobufHelper.lua

module("modules.logic.fight.controller.log.FightLogProtobufHelper", package.seeall)

local FightLogProtobufHelper = _M

function FightLogProtobufHelper.getPrefix(level)
	return string.rep("\t", level)
end

function FightLogProtobufHelper.getMoListString(moList, singleMoLogFunc, name, level, stack)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)

	if not moList then
		return string.format("%s %s : nil", initPre, name)
	end

	if #moList == 0 then
		return string.format("%s %s : []", initPre, name)
	end

	local strTb = {
		string.format("%s %s : [", initPre, name)
	}

	FightLogProtobufHelper.addStack(strTb, FightLogProtobufHelper.getPrefix(level + 1), stack, name)

	stack = FightLogProtobufHelper.getStack(stack, name)

	for index, mo in ipairs(moList) do
		table.insert(strTb, singleMoLogFunc(mo, level + 1, index, stack))
	end

	table.insert(strTb, initPre .. "]")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.buildClassNameByIndex(className, index)
	if index and index ~= 0 then
		return className .. "_" .. tostring(index)
	end

	return className
end

function FightLogProtobufHelper.getFightRoundString(roundMo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightRound", index)

	if not roundMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {}

	table.insert(strTb, string.format("%s %s {", initPre, className))

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s actPoint : %s", pre, roundMo.actPoint))
	table.insert(strTb, string.format("%s isFinish : %s", pre, roundMo.isFinish))
	table.insert(strTb, string.format("%s moveNum : %s", pre, roundMo.moveNum))
	table.insert(strTb, string.format("%s power : %s", pre, roundMo.power))
	table.insert(strTb, FightLogProtobufHelper.getFightStepListString(roundMo.fightStep, level, "fightStep", "FightRound"))
	table.insert(strTb, FightLogProtobufHelper.getFightStepListString(roundMo.nextRoundBeginStep, level, "nextRoundBeginStep", "FightRound"))
	table.insert(strTb, FightLogProtobufHelper.getCardInfoListString(roundMo.aiUseCards, level, "aiUseCards", "FightRound"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getFightStepString(fightStepData, level, index, stack)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightStep", index)

	if not fightStepData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {}
	local initStr = string.format("%s %s {", initPre, className)

	if FightHelper.needAddRoundStep(fightStepData) then
		initStr = initStr .. "会被添加为新的步骤"
	end

	table.insert(strTb, initStr)

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	FightLogProtobufHelper.addStack(strTb, pre, stack, className)
	table.insert(strTb, string.format("%s actType : %s %s", pre, fightStepData.actType, FightLogProtobufHelper.getActTypeName(fightStepData.actType)))

	if fightStepData.actType == FightEnum.ActTySKILL or fightStepData.actType == FightEnum.ActType.DEVICE then
		table.insert(strTb, string.format("%s fromId : %s 技能发起者:%s", pre, fightStepData.fromId, FightLogProtobufHelper.getEntityName(fightStepData.fromId)))
		table.insert(strTb, string.format("%s toId : %s 技能承受者:%s", pre, fightStepData.toId, FightLogProtobufHelper.getEntityName(fightStepData.toId)))
		table.insert(strTb, string.format("%s actId : %s 技能名字:%s timeline : %s", pre, fightStepData.actId, FightLogProtobufHelper.getSkillName(fightStepData.actId), FightLogProtobufHelper.getTimelineName(fightStepData.fromId, fightStepData.actId)))
	else
		table.insert(strTb, string.format("%s fromId : %s", pre, fightStepData.fromId))
		table.insert(strTb, string.format("%s toId : %s", pre, fightStepData.toId))
		table.insert(strTb, string.format("%s actId : %s", pre, fightStepData.actId))
	end

	table.insert(strTb, string.format("%s cardIndex : %s", pre, fightStepData.cardIndex))
	table.insert(strTb, string.format("%s supportHeroId : %s", pre, fightStepData.supportHeroId))
	table.insert(strTb, string.format("%s fakeTimeline : %s", pre, fightStepData.fakeTimeline))
	table.insert(strTb, string.format("%s realSkillType : %s", pre, fightStepData.realSkillType))
	table.insert(strTb, string.format("%s realSkinId : %s", pre, fightStepData.realSkinId))

	stack = FightLogProtobufHelper.getStack(stack, className)

	table.insert(strTb, FightLogProtobufHelper.getFightActEffectListString(fightStepData.actEffect, level, "actEffect", stack))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getFightStepListString(fightStepDataList, level, name, stack)
	name = name or "fightStepDataList"

	return FightLogProtobufHelper.getMoListString(fightStepDataList, FightLogProtobufHelper.getFightStepString, name, level, stack)
end

function FightLogProtobufHelper.getFightActEffectString(actEffectData, level, index, stack)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("ActEffect", index)

	if not actEffectData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	FightLogProtobufHelper.addStack(strTb, pre, stack, className)
	table.insert(strTb, string.format("%s clientId : %s", pre, actEffectData.clientId))
	table.insert(strTb, string.format("%s targetId : %s 作用对象:%s", pre, actEffectData.targetId, FightLogProtobufHelper.getEntityName(actEffectData.targetId)))
	table.insert(strTb, string.format("%s effectType : %s 效果类型:%s", pre, actEffectData.effectType, FightLogHelper.getEffectTypeName(actEffectData.effectType)))
	table.insert(strTb, string.format("%s effectNum : %s", pre, actEffectData.effectNum))
	table.insert(strTb, string.format("%s effectNum1 : %s", pre, actEffectData.effectNum1))

	if actEffectData.buff then
		table.insert(strTb, FightLogProtobufHelper.getFightBuffString(actEffectData.buff, level))
	end

	if actEffectData.entity then
		table.insert(strTb, FightLogProtobufHelper.getEntityMoString(actEffectData.entity, level))
	end

	table.insert(strTb, string.format("%s configEffect : %s", pre, actEffectData.configEffect))
	table.insert(strTb, string.format("%s buffActId : %s", pre, actEffectData.buffActId))
	table.insert(strTb, string.format("%s reserveId : %s", pre, actEffectData.reserveId))
	table.insert(strTb, string.format("%s reserveStr : %s", pre, actEffectData.reserveStr))
	table.insert(strTb, string.format("%s teamType : %s", pre, actEffectData.teamType))

	if actEffectData.cardInfo then
		table.insert(strTb, FightLogProtobufHelper.getCardInfoString(actEffectData.cardInfo, level))
	end

	stack = FightLogProtobufHelper.getStack(stack, className)

	table.insert(strTb, FightLogProtobufHelper.getCardInfoListString(actEffectData.cardInfoList, level, "cardInfoList", stack))

	if actEffectData.fightStep then
		table.insert(strTb, FightLogProtobufHelper.getFightStepString(actEffectData.fightStep, level, nil, stack))
	end

	if actEffectData.assistBossInfo then
		table.insert(strTb, FightLogProtobufHelper.getAssistBossInfoString(actEffectData.assistBossInfo, level))
	end

	if actEffectData.magicCircle then
		table.insert(strTb, FightLogProtobufHelper.getMagicCircleInfoString(actEffectData.magicCircle, level))
	end

	if actEffectData.buffActInfo then
		table.insert(strTb, FightLogProtobufHelper.getBuffActInfoString(actEffectData.buffActInfo, level))
	end

	if actEffectData.rouge2MusicInfo then
		table.insert(strTb, FightLogProtobufHelper.getRouge2MusicInfoString(actEffectData.rouge2MusicInfo, level))
	end

	if actEffectData.hurtInfo then
		table.insert(strTb, FightLogProtobufHelper.getHurtInfoString(actEffectData.hurtInfo, level))
	end

	if actEffectData.deviceAreaInfo then
		table.insert(strTb, FightLogProtobufHelper.getDeviceAreaInfoString(actEffectData.deviceAreaInfo, level))
	end

	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getDeviceAreaInfoString(deviceAreaInfo, level)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("deviceAreaInfo")

	if not deviceAreaInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	table.insert(strTb, FightLogProtobufHelper.getDeviceInfoListString(deviceAreaInfo:getServerDeviceList(), level, "devices"))
	table.insert(strTb, FightLogProtobufHelper.getDevicePowerListString(deviceAreaInfo.powers, level, "powers"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getDeviceInfoListString(deviceList, level, name, stack)
	name = name or "deviceList"

	return FightLogProtobufHelper.getMoListString(deviceList, FightLogProtobufHelper.getDeviceInfoString, name, level, stack)
end

function FightLogProtobufHelper.getDevicePowerListString(powerList, level, name, stack)
	name = name or "powerList"

	return FightLogProtobufHelper.getMoListString(powerList, FightLogProtobufHelper.getDevicePowerString, name, level, stack)
end

function FightLogProtobufHelper.getDeviceSkillGroupListString(skillGroupInfoList, level, name, stack)
	name = name or "skillGroupInfoList"

	return FightLogProtobufHelper.getMoListString(skillGroupInfoList, FightLogProtobufHelper.getDeviceSkillGroupString, name, level, stack)
end

function FightLogProtobufHelper.getDeviceSkillInfoListString(skillInfoList, level, name, stack)
	name = name or "skillInfoList"

	return FightLogProtobufHelper.getMoListString(skillInfoList, FightLogProtobufHelper.getDeviceSkillInfoString, name, level, stack)
end

function FightLogProtobufHelper.getDeviceInfoString(deviceInfo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("deviceInfo", index)

	if not deviceInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s index : %s", pre, deviceInfo.index))
	table.insert(strTb, FightLogProtobufHelper.getDeviceSkillGroupListString(deviceInfo.skills, level, "skills"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getDevicePowerString(power, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("devicePower", index)

	if not power then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s id : %s", pre, power.id))
	table.insert(strTb, string.format("%s power : %s", pre, power.power))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getDeviceSkillGroupString(skillGroup, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("deviceSkillGroup", index)

	if not skillGroup then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, FightLogProtobufHelper.getDeviceSkillInfoListString(skillGroup.skills, level, "skills"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getDeviceSkillInfoString(skillInfo, level, index)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("deviceSkillInfo", index)

	if not skillInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)
	local skillCo = lua_skill.configDict[skillInfo.skillId]
	local skillName = skillCo and skillCo.name

	table.insert(strTb, string.format("%s skillId : %s %s", pre, skillInfo.skillId, skillName))
	table.insert(strTb, string.format("%s costType : %s", pre, skillInfo.costType))
	table.insert(strTb, string.format("%s costValue : %s", pre, skillInfo.costValue))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getHurtInfoString(hurtInfo, level)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("hurtInfo")

	if not hurtInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	if hurtInfo.damage ~= 0 then
		table.insert(strTb, string.format("%s damage : %s", pre, hurtInfo.damage))
	end

	if hurtInfo.reduceHp ~= 0 then
		table.insert(strTb, string.format("%s reduceHp : %s", pre, hurtInfo.reduceHp))
	end

	if hurtInfo.reduceShield ~= 0 then
		table.insert(strTb, string.format("%s reduceShield : %s", pre, hurtInfo.reduceShield))
	end

	table.insert(strTb, string.format("%s careerRestraint : %s", pre, hurtInfo.careerRestraint))
	table.insert(strTb, string.format("%s critical : %s", pre, hurtInfo.critical))
	table.insert(strTb, string.format("%s assassinate : %s", pre, hurtInfo.assassinate))

	if hurtInfo.reduceShield ~= 0 then
		table.insert(strTb, string.format("%s hurtEffect : %s", pre, hurtInfo.hurtEffect))
	end

	table.insert(strTb, string.format("%s damageFromType : %s", pre, hurtInfo.damageFromType))

	if hurtInfo.configEffect ~= 0 then
		table.insert(strTb, string.format("%s configEffect : %s", pre, hurtInfo.configEffect))
	end

	if hurtInfo.buffActId ~= 0 then
		table.insert(strTb, string.format("%s buffActId : %s", pre, hurtInfo.buffActId))
	end

	if hurtInfo.buffUid ~= 0 then
		table.insert(strTb, string.format("%s buffUid : %s", pre, hurtInfo.buffUid))
	end

	if hurtInfo.effectId ~= 0 then
		table.insert(strTb, string.format("%s effectId : %s", pre, hurtInfo.effectId))
	end

	if hurtInfo.skillId ~= 0 then
		table.insert(strTb, string.format("%s skillId : %s", pre, hurtInfo.skillId))
	end

	table.insert(strTb, string.format("%s fromUid : %s", pre, hurtInfo.fromUid))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getMagicCircleInfoString(magicCircleMo, level)
	level = level or 0

	local initPre = FightLogHelper.getPrefix(level)
	local className = FightLogHelper.buildClassNameByIndex("FightMagicCircleInfoData")

	if not magicCircleMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogHelper.getPrefix(level)

	table.insert(strTb, string.format("%s magicCircleId : %s", pre, magicCircleMo.magicCircleId))
	table.insert(strTb, string.format("%s round : %s", pre, magicCircleMo.round))
	table.insert(strTb, string.format("%s createUid : %s %s", pre, magicCircleMo.createUid, FightLogProtobufHelper.getEntityName(magicCircleMo.createUid)))
	table.insert(strTb, string.format("%s electricLevel : %s", pre, magicCircleMo.electricLevel))
	table.insert(strTb, string.format("%s electricProgress : %s", pre, magicCircleMo.electricProgress))
	table.insert(strTb, string.format("%s maxElectricProgress : %s", pre, magicCircleMo.maxElectricProgress))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getAssistBossInfoString(assistBossInfo, level, index)
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
	table.insert(strTb, FightLogHelper.getFightAssistBossSkillListString(assistBossInfo.skills, level))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getAssistBossSkillInfoString(assistBossSkillInfo, level, index)
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

function FightLogProtobufHelper.getFightAssistBossSkillListString(assistBossSkillInfoList, level, name)
	name = name or "assistBossSkillInfoList"

	return FightLogHelper.getMoListString(assistBossSkillInfoList, FightLogHelper.getAssistBossSkillInfoString, name, level)
end

function FightLogProtobufHelper.getFightActEffectListString(effectDataList, level, name, stack)
	name = name or "effectDataList"

	return FightLogProtobufHelper.getMoListString(effectDataList, FightLogProtobufHelper.getFightActEffectString, name, level, stack)
end

function FightLogProtobufHelper.getFightBuffString(buffMo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("BuffInfo", index)

	if not buffMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)
	local buffCo = lua_skill_buff.configDict[buffMo.buffId]
	local name = buffCo and buffCo.name

	table.insert(strTb, string.format("%s buffId : %s %s", pre, buffMo.buffId, name))
	table.insert(strTb, string.format("%s duration : %s", pre, buffMo.duration))
	table.insert(strTb, string.format("%s uid : %s", pre, buffMo.uid))
	table.insert(strTb, string.format("%s exInfo : %s", pre, buffMo.exInfo))
	table.insert(strTb, string.format("%s fromUid : %s", pre, buffMo.fromUid))
	table.insert(strTb, string.format("%s count : %s", pre, buffMo.count))
	table.insert(strTb, string.format("%s actCommonParams : %s", pre, buffMo.actCommonParams))
	table.insert(strTb, string.format("%s layer : %s", pre, buffMo.layer))
	table.insert(strTb, FightLogProtobufHelper.getFightBuffActInfoListString(buffMo.actInfo, level, "buffActInfoList"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getBuffActInfoString(buffActInfo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightBuffActInfoData", index)

	if not buffActInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)
	local buffActCo = lua_buff_act.configDict[buffActInfo.actId]

	table.insert(strTb, string.format("%s actId : %s", pre, buffActCo.id))
	table.insert(strTb, string.format("%s actType : %s", pre, buffActCo.type))
	table.insert(strTb, string.format("%s strParam : %s", pre, buffActInfo.strParam))
	table.insert(strTb, string.format("%s param : [%s]", pre, table.concat(buffActInfo.param, ",")))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getRouge2MusicInfoString(musicInfo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightRouge2MusicInfo", index)

	if not musicInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s queueMax : %s", pre, musicInfo.queueMax))
	table.insert(strTb, string.format("%s type2SkillStr : %s", pre, musicInfo.type2SkillIdStr))
	table.insert(strTb, FightLogProtobufHelper.getFightRouge2MusicNoteListString(musicInfo.musicNotes, level, "musicNotes"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getRouge2MusicNoteString(musicNote, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightRouge2MusicNote", index)

	if not musicNote then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s type : %s", pre, musicNote.type))
	table.insert(strTb, string.format("%s blueValue : %s", pre, musicNote.blueValue))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getFightRouge2MusicNoteListString(musicNoteList, level, name)
	name = name or "musicNotes"

	return FightLogProtobufHelper.getMoListString(musicNoteList, FightLogProtobufHelper.getRouge2MusicNoteString, name, level)
end

function FightLogProtobufHelper.getFightBuffActInfoListString(buffActInfoList, level, name)
	name = name or "buffActInfoList"

	return FightLogProtobufHelper.getMoListString(buffActInfoList, FightLogProtobufHelper.getBuffActInfoString, name, level)
end

function FightLogProtobufHelper.getFightBuffListString(buffMoList, level, name)
	name = name or "buffMoList"

	return FightLogProtobufHelper.getMoListString(buffMoList, FightLogProtobufHelper.getFightBuffString, name, level)
end

function FightLogProtobufHelper.getEntityMoString(entityMo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightEntityInfo", index)

	if not entityMo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s uid : %s", pre, entityMo.uid))
	table.insert(strTb, string.format("%s modelId : %s", pre, entityMo.modelId))
	table.insert(strTb, string.format("%s skin : %s", pre, entityMo.skin))
	table.insert(strTb, string.format("%s position : %s", pre, entityMo.position))
	table.insert(strTb, string.format("%s entityType : %s", pre, entityMo.entityType))
	table.insert(strTb, string.format("%s userId : %s", pre, entityMo.userId))
	table.insert(strTb, string.format("%s exPoint : %s", pre, entityMo.exPoint))
	table.insert(strTb, string.format("%s level : %s", pre, entityMo.level))
	table.insert(strTb, string.format("%s currentHp : %s", pre, entityMo.currentHp))

	if entityMo.buffs then
		table.insert(strTb, FightLogProtobufHelper.getFightBuffListString(entityMo.buffs, level, "buffs"))
	end

	table.insert(strTb, string.format("%s skillGroup1 : %s", pre, entityMo.skillGroup1))
	table.insert(strTb, string.format("%s skillGroup2 : %s", pre, entityMo.skillGroup2))
	table.insert(strTb, string.format("%s passiveSkill : %s", pre, entityMo.passiveSkill))
	table.insert(strTb, string.format("%s exSkill : %s", pre, entityMo.exSkill))
	table.insert(strTb, string.format("%s shieldValue : %s", pre, entityMo.shieldValue))
	table.insert(strTb, string.format("%s shieldValue : %s", pre, entityMo.shieldValue))

	if entityMo.noEffectBuffs then
		table.insert(strTb, FightLogProtobufHelper.getFightBuffListString(entityMo.noEffectBuffs, level, "noEffectBuffs"))
	end

	table.insert(strTb, string.format("%s expointMaxAdd : %s", pre, entityMo.expointMaxAdd))
	table.insert(strTb, string.format("%s buffHarmStatistic : %s", pre, entityMo.buffHarmStatistic))
	table.insert(strTb, string.format("%s equipUid : %s", pre, entityMo.equipUid))
	table.insert(strTb, string.format("%s exSkillLevel : %s", pre, entityMo.exSkillLevel))

	if entityMo.noEffectBuffs then
		table.insert(strTb, FightLogProtobufHelper.getNormalTypeListString(entityMo.act104EquipUids, "act104EquipUids", level))
	end

	table.insert(strTb, string.format("%s exSkillPointChange : %s", pre, entityMo.exSkillPointChange))
	table.insert(strTb, string.format("%s teamType : %s", pre, entityMo.teamType))
	table.insert(strTb, string.format("%s career : %s", pre, entityMo.career))
	table.insert(strTb, string.format("%s status : %s", pre, entityMo.status))
	table.insert(strTb, string.format("%s guard : %s", pre, entityMo.guard))
	table.insert(strTb, string.format("%s powerInfo : %s", pre, cjson.encode(entityMo.powerInfos)))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getFightEntityListString(entityMoList, level, name)
	name = name or "entityMoList"

	return FightLogProtobufHelper.getMoListString(entityMoList, FightLogProtobufHelper.getEntityMoString, name, level)
end

function FightLogProtobufHelper.getCardInfoString(cardInfo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("FightCardInfoMO", index)

	if not cardInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s uid : %s %s", pre, cardInfo.uid, FightLogProtobufHelper.getEntityName(cardInfo.uid)))
	table.insert(strTb, string.format("%s skillId : %s %s", pre, cardInfo.skillId, FightLogProtobufHelper.getSkillName(cardInfo.skillId)))
	table.insert(strTb, string.format("%s cardEffect : %s", pre, cardInfo.cardEffect))
	table.insert(strTb, string.format("%s tempCard : %s", pre, cardInfo.tempCard))
	table.insert(strTb, string.format("%s cardType : %s", pre, cardInfo.cardType))
	table.insert(strTb, string.format("%s heroId : %s", pre, cardInfo.heroId))
	table.insert(strTb, string.format("%s status : %s", pre, cardInfo.status))
	table.insert(strTb, string.format("%s targetUid : %s %s", pre, cardInfo.targetUid, FightLogProtobufHelper.getEntityName(cardInfo.targetUid)))
	table.insert(strTb, string.format("%s energy : %s", pre, cardInfo.energy))
	table.insert(strTb, string.format("%s areaRedOrBlue : %s", pre, cardInfo.areaRedOrBlue))
	table.insert(strTb, string.format("%s heatId : %s", pre, cardInfo.heatId))
	table.insert(strTb, FightLogProtobufHelper.getRouge2MusicNoteString(cardInfo.musicNote, level))
	table.insert(strTb, FightLogProtobufHelper.getCardExtraInfoDataListString(cardInfo.extraInfos, level))
	table.insert(strTb, FightLogProtobufHelper.getEnchantListString(cardInfo.enchants, level, "enchants"))
	table.insert(strTb, FightLogProtobufHelper.getFightCardInfo_CardDataListString(cardInfo.cardDataes, level, "cardDataList"))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getCardInfoListString(cardInfoList, level, name, stack)
	name = name or "cardInfoList"

	return FightLogProtobufHelper.getMoListString(cardInfoList, FightLogProtobufHelper.getCardInfoString, name, level, stack)
end

function FightLogProtobufHelper.getCardInfoEnchantString(enchant, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("CardEnchant", index)

	if not enchant then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s enchantId : %s", pre, enchant.enchantId))
	table.insert(strTb, string.format("%s duration : %s", pre, enchant.duration))
	table.insert(strTb, string.format("%s exInfo : %s", pre, table.concat(enchant.exInfo, ",")))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getEnchantListString(enchantList, level, name, stack)
	name = name or "enchantList"

	return FightLogProtobufHelper.getMoListString(enchantList, FightLogProtobufHelper.getCardInfoEnchantString, name, level, stack)
end

function FightLogProtobufHelper.getFightCardInfo_CardDataString(cardData, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("cardData", index)

	if not cardData then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s key : %s", pre, cardData.key))
	table.insert(strTb, string.format("%s value : %s", pre, cardData.value))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getFightCardInfo_CardDataListString(cardDataList, level, name, stack)
	name = name or "cardDataList"

	return FightLogProtobufHelper.getMoListString(cardDataList, FightLogProtobufHelper.getFightCardInfo_CardDataString, name, level, stack)
end

function FightLogProtobufHelper.getCardExtraInfoDataString(extraInfo, level, index)
	level = level or 0

	local initPre = FightLogProtobufHelper.getPrefix(level)
	local className = FightLogProtobufHelper.buildClassNameByIndex("extraInfo", index)

	if not extraInfo then
		return string.format("%s %s : nil", initPre, className)
	end

	local strTb = {
		string.format("%s %s {", initPre, className)
	}

	level = level + 1

	local pre = FightLogProtobufHelper.getPrefix(level)

	table.insert(strTb, string.format("%s key : %s %s", pre, extraInfo.key, FightCardExtraInfoData.ExtraKey2Name[extraInfo.key]))
	table.insert(strTb, string.format("%s value : {%s}", pre, table.concat(extraInfo.values)))
	table.insert(strTb, initPre .. "}")

	return table.concat(strTb, "\n")
end

function FightLogProtobufHelper.getCardExtraInfoDataListString(extraInfoList, level, name, stack)
	name = name or "extraInfoList"

	return FightLogProtobufHelper.getMoListString(extraInfoList, FightLogProtobufHelper.getCardExtraInfoDataString, name, level, stack)
end

function FightLogProtobufHelper.getNormalTypeListString(list, name, level)
	return FightLogProtobufHelper.getMoListString(list, tostring, name, level)
end

FightLogProtobufHelper.ActTypeName = {
	[FightEnum.ActType.SKILL] = "技能",
	[FightEnum.ActType.BUFF] = "buff",
	[FightEnum.ActType.EFFECT] = "效果",
	[FightEnum.ActType.CHANGEHERO] = "换人",
	[FightEnum.ActType.CHANGEWAVE] = "换波次时机"
}

function FightLogProtobufHelper.getActTypeName(actType)
	return (actType or nil) and (FightLogProtobufHelper.ActTypeName[actType] or "")
end

function FightLogProtobufHelper.getEntityName(entityId)
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

function FightLogProtobufHelper.getSkillName(skillId)
	local config = lua_skill.configDict[skillId]

	return (config or nil) and (config.name or "")
end

function FightLogProtobufHelper.getTimelineName(entityId, skillId)
	if entityId then
		::label_44_0::

		local entityMo = FightDataHelper.entityMgr:getById(entityId)
		local timeline = FightConfig.instance:getSkinSkillTimeline(entityMo and entityMo.skin, skillId)

		return string.nilorempty(timeline) and "nil" or timeline
	end
end

function FightLogProtobufHelper.getStack(stack, curName)
	return stack and string.format("%s.%s", stack, curName) or curName
end

function FightLogProtobufHelper.addStack(tb, pre, stack, curName)
	stack = FightLogProtobufHelper.getStack(stack, curName)

	if string.nilorempty(stack) then
		return
	end

	table.insert(tb, string.format("%s stack : %s", pre, stack))
end

return FightLogProtobufHelper
