-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBuffDamage.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBuffDamage", package.seeall)

local HurtEvtBuffDamage = class("HurtEvtBuffDamage", HurtEvtBase)

function HurtEvtBuffDamage:getEvtType()
	return HurtEvtType.EvtBuffDamage
end

function HurtEvtBuffDamage:handleEvt(hurtData)
	hurtData.target:onBuffDamage(self.buffId, self.damage)
	HurtEvtBuffDamage.super.handleEvt(self, hurtData)
end

function HurtEvtBuffDamage:getDesc(hurtData)
	if hurtData.target then
		local petCo = CharacterConfig.instance:getPetCo(hurtData.target.raceId)
		local targetName = petCo.name
		local buffCo = BattleConfig.instance:getBuffCo(self.buffId)

		if not buffCo then
			printInfo("buff 不存在，检查客户端是不是没导表，ID=" .. self.buffId)

			return
		end

		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local attackerColor

		if hurtData.attacker then
			attackerColor = hurtData:getColorByTeamId(hurtData.attacker.teamId)
		end

		attackerColor = attackerColor or targetColor

		if self.damage < 0 then
			return string.format(lang("battlerecord_buff_damage"), attackerColor, buffCo.name, targetColor, targetName, targetColor, -self.damage)
		else
			return string.format(lang("battlerecord_buff_treat"), attackerColor, buffCo.name, targetColor, targetName, targetColor, self.damage)
		end
	end
end

return HurtEvtBuffDamage
