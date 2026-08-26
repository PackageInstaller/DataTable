-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondMonsterKills.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondMonsterKills", package.seeall)

local ArcadeSkillCondMonsterKills = class("ArcadeSkillCondMonsterKills", ArcadeSkillCondBase)
local Filter = {
	Buff = "buff"
}
local Filter2Counter = {
	[Filter.Buff] = ArcadeGameEnum.GameCounter.SpecBuffMonsterKillsSinceAddSkill
}

function ArcadeSkillCondMonsterKills:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._targetMonsterKills = tonumber(params[2])
	self.counterName = ArcadeGameEnum.GameCounter.MonsterKillsSinceAddSkill
	self.counterParam = nil

	local strFilter = params[3]

	if not string.nilorempty(strFilter) then
		local filterArr = string.split(strFilter, ":")
		local counter = Filter2Counter[filterArr[1]]

		if counter then
			self.counterName = counter
			self.counterParam = filterArr[2]
		end
	end
end

function ArcadeSkillCondMonsterKills:getCondNeedCounter()
	return self.counterName, self.counterParam
end

function ArcadeSkillCondMonsterKills:onIsCondSuccess()
	if not self._targetMonsterKills then
		return
	end

	local skillSetMO = self:getBelongSkillSetMO()

	if not skillSetMO then
		return
	end

	local skillId = self:getSkillId()
	local curMonsterKills = skillSetMO:getSkillCounterRecord(skillId, self.counterName, self.counterParam)

	return curMonsterKills >= self._targetMonsterKills
end

return ArcadeSkillCondMonsterKills
