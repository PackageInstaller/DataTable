-- chunkname: @modules/logic/character/model/extra/CharacterWeaponShowMO.lua

module("modules.logic.character.model.extra.CharacterWeaponShowMO", package.seeall)

local CharacterWeaponShowMO = class("CharacterWeaponShowMO")

function CharacterWeaponShowMO:initMo(heroId, co)
	self.heroId = heroId
	self.weaponId = co.weaponId
	self.type = co.type
	self.co = co

	if self:isEquip() then
		self:cancelNew()
	end
end

function CharacterWeaponShowMO:setStatus(status)
	self.status = status
end

function CharacterWeaponShowMO:isEquip()
	return self.status == CharacterExtraEnum.WeaponStatus.Equip
end

function CharacterWeaponShowMO:isLock()
	return self.status == CharacterExtraEnum.WeaponStatus.Lock
end

function CharacterWeaponShowMO:isNormal()
	return self.status == CharacterExtraEnum.WeaponStatus.Normal
end

function CharacterWeaponShowMO:isNew()
	local key = self:_getReddotKey()

	self._isNew = self:isNormal() and GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0

	return self._isNew
end

function CharacterWeaponShowMO:cancelNew()
	if self._isNew then
		local key = self:_getReddotKey()

		GameUtil.playerPrefsSetNumberByUserId(key, 1)

		self._isNew = false
	end
end

function CharacterWeaponShowMO:_getReddotKey()
	return (string.format("%s_%s_%s", CharacterExtraEnum.WeaponReddot, self.heroId, self.weaponId))
end

return CharacterWeaponShowMO
