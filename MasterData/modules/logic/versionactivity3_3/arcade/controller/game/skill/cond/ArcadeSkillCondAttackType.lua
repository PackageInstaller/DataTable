-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondAttackType.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondAttackType", package.seeall)

local ArcadeSkillCondAttackType = class("ArcadeSkillCondAttackType", ArcadeSkillCondBase)
local _atkStr2AtttackType_Dict = {
	normal = {
		[ArcadeGameEnum.AttackType.Normal] = true,
		[ArcadeGameEnum.AttackType.Link] = true
	},
	skill = {
		[ArcadeGameEnum.AttackType.Skill] = true
	},
	chain = {
		[ArcadeGameEnum.AttackType.Link] = true
	}
}

function ArcadeSkillCondAttackType:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._attackStr = params[2]
end

function ArcadeSkillCondAttackType:onIsCondSuccess()
	logNormal("ArcadeSkillCondAttackType:isCondSuccess() == > 攻击类型:%s", self._attackStr)

	local atkTypeDict = _atkStr2AtttackType_Dict[self._attackStr]

	if atkTypeDict and atkTypeDict[self._context.attackType] then
		return true
	end

	return false
end

return ArcadeSkillCondAttackType
