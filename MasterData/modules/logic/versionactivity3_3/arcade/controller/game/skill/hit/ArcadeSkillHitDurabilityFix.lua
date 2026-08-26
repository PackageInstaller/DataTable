-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDurabilityFix.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDurabilityFix", package.seeall)

local ArcadeSkillHitDurabilityFix = class("ArcadeSkillHitDurabilityFix", ArcadeSkillHitBase)

function ArcadeSkillHitDurabilityFix:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._durValue = tonumber(params[2])
	self._weaponUIdList = {}
end

function ArcadeSkillHitDurabilityFix:onHit()
	self:clearList(self._weaponUIdList)

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local contextCollectionMO = self._context.collectionMO

	if contextCollectionMO then
		self._weaponUIdList[#self._weaponUIdList + 1] = contextCollectionMO:getUid()

		contextCollectionMO:addDurability(self._durValue)
		self:addHiter(characterMO)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnWeaponDurabilityChange)

		return
	end

	characterMO:findUseWeaponUid(self._weaponUIdList)

	if #self._weaponUIdList <= 0 then
		return
	end

	for _, uid in ipairs(self._weaponUIdList) do
		local collectionMO = characterMO:getCollectionMO(uid)

		if collectionMO then
			collectionMO:addDurability(self._durValue)
		end
	end

	self:addHiter(characterMO)
	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnWeaponDurabilityChange)
end

function ArcadeSkillHitDurabilityFix:onHitPrintLog()
	logNormal(string.format("%s ==> 对自身持有的武器类藏品耐久度进行修正 => UIds:[%s]", self:getLogPrefixStr(), table.concat(self._weaponUIdList, ",")))
end

return ArcadeSkillHitDurabilityFix
