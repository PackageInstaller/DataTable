-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtShieldChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtShieldChange", package.seeall)

local HurtEvtShieldChange = class("HurtEvtShieldChange", HurtEvtBase)

function HurtEvtShieldChange:getEvtType()
	return HurtEvtType.ShieldChange
end

function HurtEvtShieldChange:handleEvt(hurtData)
	print("handle shield hurt evt")
	hurtData.target:onShieldChange(self.changeValue, self.isAttack, self.isShow)
	HurtEvtShieldChange.super.handleEvt(self, hurtData)
end

function HurtEvtShieldChange:getDesc(hurtData)
	print("shield hurt evt getDesc")

	local target = hurtData.target

	if target and self.changeValue ~= 0 then
		local petCo = CharacterConfig.instance:getPetCo(target.raceId)
		local targetName = petCo.name
		local targetColor = hurtData:getColorByTeamId(target.teamId)

		if self.changeValue < 0 then
			return string.format(lang("<color=#%s>[%s]</color>减少了<color=#%s>%d</color>点护盾值"), targetColor, targetName, targetColor, -self.changeValue)
		else
			return string.format(lang("<color=#%s>[%s]</color>增加了<color=#%s>%d</color>点护盾值"), targetColor, targetName, targetColor, self.changeValue)
		end
	end
end

return HurtEvtShieldChange
