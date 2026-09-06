-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompSkillList.lua

module("logicscene.scene.unit.component.battle.UnitCompSkillList", package.seeall)

local UnitCompSkillList = class("UnitCompSkillList", UnitComponentBase)

function UnitCompSkillList:ctor(unit)
	UnitCompSkillList.super.ctor(self, unit)

	self._skills = nil
	self._curSkill = nil
	self._soloSkills = nil
end

function UnitCompSkillList:initSkills()
	local unit = self._unit
	local teamId = unit.teamId
	local playerView = BattleModel.instance:getCharactorById(teamId, unit.id)
	local petCO = PetSkinConfig.instance:getPetSkinCfg(unit.modelId)

	self:clear()

	self.normalSkillId = playerView.normalSkillId
	self.ultimateSkillId = playerView.ultimateSkillId
	self.summonSkillId = petCO.summonSkillId
	self.passiveSkillId = playerView.passiveSkillId
	self.heroSkillId = petCO.heroSkillId
	self.circleSkillId = petCO.circleSkillId
	self.domainSkillId = petCO.domainSkillId
	self.contractSkillId = playerView.contractSkillId
	self.awakenSkillId = petCO.awakenSkillId
	self.shenyaoSkillId = petCO.shenyaoSkillId
	self.carriedSkillId = petCO.carriedSkillId
	self.oracleSkillId = petCO.oracleSkillId
	self.sourceSkillId = petCO.sourceSkillId
	self.heavenAwakenSkillId = petCO.heavenAwakenSkillId
	self.psychicedNormalSkillId = playerView.psychicedNormalSkillId
	self.psychicedUltimateSkillId = playerView.psychicedUltimateSkillId
	self.psychicSkillId = playerView.psychicSkillId
	self.yuanjiSkillId = petCO.yuanjiSkillId
	self.genesisSkillId = petCO.genesisSkillId
	self.spiritInvocationSkillId = petCO.spiritInvocationSkillId

	self:addSkill(playerView.normalSkillId)
	self:addSkill(playerView.ultimateSkillId)
	self:addSkill(petCO.summonSkillId)
	self:addSkill(playerView.passiveSkillId)
	self:addSkill(petCO.heroSkillId)
	self:addSkill(petCO.circleSkillId)
	self:addSkill(petCO.domainSkillId)
	self:addSkill(playerView.contractSkillId)
	self:addSkill(playerView.psychicedNormalSkillId)
	self:addSkill(playerView.psychicedUltimateSkillId)
	self:addSkill(playerView.psychicSkillId)
	self:addSkill(petCO.awakenSkillId)
	self:addSkill(petCO.shenyaoSkillId)
	self:addSkill(petCO.carriedSkillId)
	self:addSkill(petCO.oracleSkillId)
	self:addSkill(petCO.heavenAwakenSkillId)
	self:addSkill(petCO.yuanjiSkillId)
	self:addSkill(petCO.genesisSkillId)
	self:addSkill(petCO.spiritInvocationSkillId)
end

function UnitCompSkillList:update(deltaTime)
	if self._curSkill and self._curSkill:isPlaying() then
		self._curSkill:update(deltaTime)
	end
end

function UnitCompSkillList:useSkill(skill, skillExecuteState, isStrickBack, attackCount)
	self._curSkill = skill

	if not skill then
		return
	end

	return skill:useSkill(skillExecuteState, isStrickBack, attackCount)
end

function UnitCompSkillList:useSkillById(skillId)
	local skill = self:getSkill(skillId)

	return self:useSkill(skill)
end

function UnitCompSkillList:stopSkill()
	if self._curSkill then
		self._curSkill:breakSkill()

		self._curSkill = nil
	end
end

function UnitCompSkillList:addSkill(skillId)
	if skillId <= 0 then
		if skillId < 0 and enableLog then
			printError("技能id为：", skillId)
		end

		return
	end

	local skill = SkillBase.New(skillId, self._unit)

	self._skills = self._skills or {}
	self._skills[skillId] = skill

	local typeSkill = skill.skillCo.type

	self._soloSkills = self._soloSkills or {}
	self._soloSkills[typeSkill] = skill

	return skill
end

function UnitCompSkillList:replceNormalSkill(skillId)
	if self.normalSkillId then
		self._skills[self.normalSkillId] = nil
	end

	self.normalSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:replceUtlSkill(skillId)
	if self.ultimateSkillId then
		self._skills[self.ultimateSkillId] = nil
	end

	self.ultimateSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:replcePassiveSkill(skillId)
	if self.passiveSkillId then
		self._skills[self.passiveSkillId] = nil
	end

	self.passiveSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:replceHeroSkill(skillId)
	if self.heroSkillId then
		self._skills[self.heroSkillId] = nil
	end

	self.heroSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:replceCarriedSkill(skillId)
	if self.carriedSkillId then
		self._skills[self.carriedSkillId] = nil
	end

	self.carriedSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:replceOracleSkillId(skillId)
	if self.oracleSkillId then
		self._skills[self.oracleSkillId] = nil
	end

	self.oracleSkillId = skillId

	self:addSkill(skillId)
end

function UnitCompSkillList:getSkill(skillId)
	if self._skills then
		local skill = self._skills[skillId]

		skill = skill or self:addSkill(skillId)

		return skill
	end
end

function UnitCompSkillList:breakSkill()
	if self._curSkill then
		self._curSkill:breakSkill()
	end
end

function UnitCompSkillList:pause()
	if self._curSkill then
		self._curSkill:pause()
	end
end

function UnitCompSkillList:isPause()
	if self._curSkill then
		return self._curSkill:isPause()
	end
end

function UnitCompSkillList:resume()
	if self._curSkill then
		self._curSkill:resume()
	end
end

function UnitCompSkillList:getSoloTypeSkills()
	return self._soloSkills or {}
end

function UnitCompSkillList:getCurSkill()
	return self._curSkill
end

function UnitCompSkillList:clear()
	self._skills = nil
	self._soloSkills = nil
end

return UnitCompSkillList
