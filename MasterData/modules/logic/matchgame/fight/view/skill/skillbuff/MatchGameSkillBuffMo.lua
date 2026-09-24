-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameSkillBuffMo.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameSkillBuffMo", package.seeall)

local MatchGameSkillBuffMo = class("MatchGameSkillBuffMo")
local buffUidSeq = 0

function MatchGameSkillBuffMo:init(initData)
	self.skillUserType = initData.skillUserType
	self.skillUserId = initData.skillUserId
	self.skillId = initData.skillId
	self.buffId = initData.buffId
	self.buffConfig = nil

	if self.skillUserType == MatchGameFightEnum.SkillUserType.Hero then
		self.buffConfig = MatchGameFightConfig.instance:getHeroBuffConfig(self.buffId)
	elseif self.skillUserType == MatchGameFightEnum.SkillUserType.Enemy then
		self.buffConfig = MatchGameFightConfig.instance:getMonsterBuffConfig(self.buffId)
	end

	self.buffType = self.buffConfig.buffType
	self.buffEffectId = string.splitToNumber(self.buffConfig.buffEffect, "#")[1]
	self.buffEffectType = MatchGameFightConfig.instance:getSkillBuffConfig(self.buffEffectId).buffEffectType

	local durationData = string.splitToNumber(self.buffConfig.durationType, "#")

	self.durationType = durationData[1]
	self.durationParam = durationData[2]
	self.isTimeStart = false
	self.holdCount = 0
	self.isRemoving = false
	self.effectData = {}
	buffUidSeq = buffUidSeq + 1
	self.buffUidSeq = buffUidSeq
	self.buffUid = string.format("%s_%s_%s", self.skillId, self.buffId, buffUidSeq)
end

function MatchGameSkillBuffMo:addHoldCount()
	self.holdCount = self.holdCount + 1

	return self.holdCount
end

function MatchGameSkillBuffMo:subHoldCount()
	self.holdCount = self.holdCount - 1

	return self.holdCount
end

function MatchGameSkillBuffMo:getBuffUid()
	return self.buffUid
end

function MatchGameSkillBuffMo:setBuffDurationData(durationType, removeEnemyRoundBuffAtZero)
	if durationType ~= self.durationType then
		return
	end

	if self.durationType == MatchGameFightEnum.BuffDurationType.Second then
		if not self.isTimeStart then
			self.startGameTime = MatchGameFightModel.instance:getCurGameTime()
			self.isTimeStart = true

			return
		end

		local passTime = MatchGameFightModel.instance:getCurGameTime() - self.startGameTime

		if passTime >= self.durationParam then
			self:removeBuff()
		end

		return
	elseif self.durationType == MatchGameFightEnum.BuffDurationType.Round then
		self.durationParam = self.durationParam - 1
	elseif self.durationType == MatchGameFightEnum.BuffDurationType.Match then
		self.durationParam = self.durationParam - 1
	end

	if self.durationType == MatchGameFightEnum.BuffDurationType.Round and self.skillUserType == MatchGameFightEnum.SkillUserType.Enemy and not removeEnemyRoundBuffAtZero then
		if self.durationParam < 0 then
			self:removeBuff()
		end
	elseif self.durationParam <= 0 then
		self:removeBuff()
	end
end

function MatchGameSkillBuffMo:removeBuff()
	if self.isRemoving then
		return
	end

	self.isRemoving = true

	local param = {
		buffUid = self:getBuffUid()
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnRemoveSkillBuff, param)
end

function MatchGameSkillBuffMo:onDestroy()
	return
end

return MatchGameSkillBuffMo
