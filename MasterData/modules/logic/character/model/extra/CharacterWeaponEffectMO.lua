-- chunkname: @modules/logic/character/model/extra/CharacterWeaponEffectMO.lua

module("modules.logic.character.model.extra.CharacterWeaponEffectMO", package.seeall)

local CharacterWeaponEffectMO = class("CharacterWeaponEffectMO")

function CharacterWeaponEffectMO:initMo(co)
	self.co = co
	self.firstId = co.firstId
	self.secondId = co.secondId
end

function CharacterWeaponEffectMO:getSecondDesc()
	return (self.co or nil) and (self.co.secondDesc or "")
end

return CharacterWeaponEffectMO
