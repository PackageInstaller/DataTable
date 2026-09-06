-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtDamage.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtDamage", package.seeall)

local HurtEvtDamage = class("HurtEvtDamage", HurtEvtBase)

function HurtEvtDamage:getEvtType()
	return HurtEvtType.EvtDamage
end

function HurtEvtDamage:handleEvt(hurtData)
	if self.damage < 0 then
		hurtData.target:onDamaged(self)

		if self.totalDamage then
			hurtData.target:onDamagedTotal(self)
		end
	elseif self.damage > 0 then
		hurtData.target:onTreated(self)

		if self.totalDamage then
			hurtData.target:onDamagedTotal(self, true)
		end
	elseif hurtData.skill then
		if hurtData.skill:skillType() == GameEnum.SkillFuncType.Treat then
			hurtData.target:onTreated(self)

			if self.totalDamage then
				hurtData.target:onDamagedTotal(self, true)
			end
		else
			hurtData.target:onDamaged(self)

			if self.totalDamage then
				hurtData.target:onDamagedTotal(self)
			end
		end
	end

	HurtEvtDamage.super.handleEvt(self, hurtData)
end

function HurtEvtDamage:getDesc(hurtData)
	if hurtData.target then
		local petCo = CharacterConfig.instance:getPetCo(hurtData.target.raceId)
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local targetName = petCo.name
		local attackerName, skillName, attackerColor

		if hurtData.attacker then
			local petCo = CharacterConfig.instance:getPetCo(hurtData.attacker.raceId)

			attackerName = petCo.name
			attackerColor = hurtData:getColorByTeamId(hurtData.attacker.teamId)
		end

		if hurtData.skill then
			skillName = hurtData.skill.skillCo.name
		end

		if self.damage < 0 then
			if skillName then
				return string.format(lang("battlerecord_damage"), attackerColor, attackerName, attackerColor, skillName, targetColor, targetName, targetColor, -self.damage)
			end
		elseif skillName then
			return string.format(lang("battlerecord_treat"), attackerColor, attackerName, attackerColor, skillName, targetColor, targetName, targetColor, self.damage)
		end
	end
end

return HurtEvtDamage
