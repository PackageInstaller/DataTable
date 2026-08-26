-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitLostWeapon.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitLostWeapon", package.seeall)

local ArcadeSkillHitLostWeapon = class("ArcadeSkillHitLostWeapon", ArcadeSkillHitBase)

function ArcadeSkillHitLostWeapon:onCtor()
	self._weaponUIdList = {}
end

function ArcadeSkillHitLostWeapon:onHit()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local weaponList = characterMO and characterMO:getCollectionUidListWithType(ArcadeGameEnum.CollectionType.Weapon)

	self:clearList(self._weaponUIdList)

	if weaponList and #weaponList > 0 then
		tabletool.addValues(self._weaponUIdList, weaponList)

		for _, uid in ipairs(self._weaponUIdList) do
			ArcadeGameController.instance:lossCollection(uid)
		end

		self:addHiter(characterMO)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnCollectionChange)
	end
end

function ArcadeSkillHitLostWeapon:onHitPrintLog()
	if #self._weaponUIdList > 0 then
		logNormal(string.format("%s ==> 失去当前持有的武器【%s】", self:getLogPrefixStr(), table.concat(self._weaponUIdList, ",")))
	end
end

return ArcadeSkillHitLostWeapon
