-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondWeaponNotFully.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondWeaponNotFully", package.seeall)

local ArcadeSkillCondWeaponNotFully = class("ArcadeSkillCondWeaponNotFully", ArcadeSkillCondBase)

function ArcadeSkillCondWeaponNotFully:onCtor()
	local params = self._params

	self._changeName = params[1]
end

function ArcadeSkillCondWeaponNotFully:onIsCondSuccess()
	local maxNum = 1
	local weaponNum = 0
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		weaponNum = characterMO:getCollectionCountWithType(ArcadeEnum.CollectionType.Weapon)
		maxNum = characterMO:getCanCarryWeaponNum()
	end

	if weaponNum < maxNum then
		return true
	end

	return false
end

function ArcadeSkillCondWeaponNotFully:_checkAtkType(atkType)
	if not atkType then
		return false
	end
end

return ArcadeSkillCondWeaponNotFully
