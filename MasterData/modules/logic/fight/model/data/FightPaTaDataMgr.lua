-- chunkname: @modules/logic/fight/model/data/FightPaTaDataMgr.lua

module("modules.logic.fight.model.data.FightPaTaDataMgr", package.seeall)

local FightPaTaDataMgr = FightDataClass("FightPaTaDataMgr", FightDataMgrBase)

function FightPaTaDataMgr:onConstructor()
	self.bossInfoList = {}
end

function FightPaTaDataMgr.sortSkillInfo(skillInfoA, skillInfoB)
	return skillInfoA.powerLow < skillInfoB.powerLow
end

function FightPaTaDataMgr:updateData(fightData)
	if not fightData.attacker.assistBossInfo then
		return
	end

	local assistBossInfo = fightData.attacker.assistBossInfo

	self.currCd = assistBossInfo.currCd
	self.cfgCd = assistBossInfo.cdCfg
	self.formId = assistBossInfo.formId
	self.roundUseLimit = assistBossInfo.roundUseLimit
	self.exceedUseFree = assistBossInfo.exceedUseFree
	self.params = assistBossInfo.params
	self.type = assistBossInfo.type
	self.preUsePower = 0
	self.preCostCd = 0
	self.useCardCount = 0

	self:updateSkill(assistBossInfo.skills)
end

function FightPaTaDataMgr:switchBossSkill(assistBossInfo)
	if not assistBossInfo then
		return
	end

	self.currCd = assistBossInfo.currCd
	self.cfgCd = assistBossInfo.cdCfg
	self.formId = assistBossInfo.formId

	self:updateSkill(assistBossInfo.skills)
end

function FightPaTaDataMgr:updateSkill(skillList)
	tabletool.clear(self.bossInfoList)

	for _, skillInfo in ipairs(skillList) do
		local mo = FightAssistBossSkillInfoMo.New()

		mo:init(skillInfo)
		table.insert(self.bossInfoList, mo)
	end

	table.sort(self.bossInfoList, FightPaTaDataMgr.sortSkillInfo)
end

function FightPaTaDataMgr:changeScore(offsetScore)
	if self.score then
		self.score = self.score + offsetScore or offsetScore
	end
end

function FightPaTaDataMgr:getScore()
	return self.score
end

function FightPaTaDataMgr:hadCD()
	return self.cfgCd and self.cfgCd > 0
end

function FightPaTaDataMgr:getCurCD()
	return self.currCd + self.preCostCd
end

function FightPaTaDataMgr:setCurrCD(cd)
	self.currCd = tonumber(cd)
end

function FightPaTaDataMgr:getFromId()
	return self.formId + 1
end

function FightPaTaDataMgr:getAssistBossPower()
	local assistBossMo = self:getAssistBossMo()
	local powerInfo = assistBossMo and assistBossMo:getPowerInfo(FightEnum.PowerType.AssistBoss)

	if powerInfo then
		if not powerInfo.num then
			local power = 0

			if powerInfo then
				if not powerInfo.max then
					local powerMax = 0

					return power - self.preUsePower, powerMax
				end
			end
		end
	end
end

function FightPaTaDataMgr:getAssistBossServerPower()
	local assistBossMo = self:getAssistBossMo()
	local powerInfo = assistBossMo and assistBossMo:getPowerInfo(FightEnum.PowerType.AssistBoss)

	if powerInfo then
		if not powerInfo.num then
			local power = 0

			if powerInfo then
				if not powerInfo.max then
					local powerMax = 0

					return power, powerMax
				end
			end
		end
	end
end

function FightPaTaDataMgr:getAssistBossMo()
	return self.dataMgr.entityMgr:getAssistBoss()
end

function FightPaTaDataMgr:playAssistBossSkill(skillInfo)
	self.preUsePower = self.preUsePower + self:getNeedPower(skillInfo)
	self.useCardCount = self.useCardCount + 1
	self.preCostCd = self.preCostCd + self.cfgCd
end

function FightPaTaDataMgr:getNeedPower(skillInfo)
	if self.exceedUseFree ~= 0 and self.useCardCount >= self.exceedUseFree then
		return 0
	end

	return skillInfo.needPower
end

function FightPaTaDataMgr:playAssistBossSkillBySkillId(skillId)
	for i = #self.bossInfoList, 1, -1 do
		local skillInfo = self.bossInfoList[i]

		if skillInfo.skillId == skillId then
			self:playAssistBossSkill(skillInfo)

			return
		end
	end
end

function FightPaTaDataMgr:resetOp()
	self.preUsePower = 0
	self.useCardCount = 0
	self.preCostCd = 0
end

function FightPaTaDataMgr:canUseSkill()
	if self.roundUseLimit ~= 0 then
		return self.useCardCount < self.roundUseLimit
	end

	local co = lua_tower_const.configDict[115]
	local maxCount = co and tonumber(co.value) or 20

	return maxCount > self.useCardCount
end

function FightPaTaDataMgr:getCurUseSkillInfo()
	local power = self:getAssistBossPower()

	for i = #self.bossInfoList, 1, -1 do
		local skillInfo = self.bossInfoList[i]

		if power >= skillInfo.powerLow and power >= self:getNeedPower(skillInfo) then
			return skillInfo
		end
	end
end

function FightPaTaDataMgr:getCurAreaSkillInfo()
	local power = self:getAssistBossPower()

	for i = #self.bossInfoList, 1, -1 do
		local skillInfo = self.bossInfoList[i]

		if power >= skillInfo.powerLow and power <= skillInfo.powerHigh then
			return skillInfo
		end
	end
end

function FightPaTaDataMgr:getUseCardCount()
	return self.useCardCount
end

function FightPaTaDataMgr:getBossSkillInfoList()
	return self.bossInfoList
end

function FightPaTaDataMgr:checkIsNormal()
	return self.type == FightEnum.AssistBossType.Normal
end

function FightPaTaDataMgr:checkIsAssistRole()
	return self.type == FightEnum.AssistBossType.CombineBoss3_3
end

function FightPaTaDataMgr:checkIsRouge3_3()
	return self.type == FightEnum.AssistBossType.Rouge3_3
end

return FightPaTaDataMgr
