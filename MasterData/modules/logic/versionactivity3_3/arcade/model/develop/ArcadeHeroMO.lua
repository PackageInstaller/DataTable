-- chunkname: @modules/logic/versionactivity3_3/arcade/model/develop/ArcadeHeroMO.lua

module("modules.logic.versionactivity3_3.arcade.model.develop.ArcadeHeroMO", package.seeall)

local ArcadeHeroMO = class("ArcadeHeroMO")

function ArcadeHeroMO:ctor(handbookMo)
	self.handbookMo = handbookMo
	self.co = handbookMo:getConfig()
	self.id = self.co.id
	self._attributeDict = {}

	local attrList = handbookMo:getAttribute()

	for attrId, info in pairs(attrList) do
		self._attributeDict[attrId] = ArcadeGameAttribute.New(attrId, info.value)
	end

	self._weaponMo = ArcadeHeroWeaponMO.New()
end

function ArcadeHeroMO:getId()
	return self.id
end

function ArcadeHeroMO:getAttrMO(attrId)
	return self._attributeDict and self._attributeDict[attrId]
end

function ArcadeHeroMO:checkSelect(selectId)
	self._isSelect = selectId == self.id
end

function ArcadeHeroMO:setSelect(isSelect)
	self._isSelect = isSelect
end

function ArcadeHeroMO:isSelect()
	return self._isSelect
end

function ArcadeHeroMO:checkEquip(equipId)
	self._isEquip = equipId == self.id
end

function ArcadeHeroMO:setEquip(isEquip)
	self._isEquip = isEquip
end

function ArcadeHeroMO:isEquip()
	return self._isEquip
end

function ArcadeHeroMO:setNew(isNew)
	self._isNew = isNew
end

function ArcadeHeroMO:isNew()
	return self._isNew
end

function ArcadeHeroMO:isLock()
	return self.handbookMo:isLock()
end

function ArcadeHeroMO:getAttribute()
	return self._attributeDict
end

function ArcadeHeroMO:getEffect()
	return self.handbookMo:getEffect()
end

function ArcadeHeroMO:getWeaponMo()
	return self._weaponMo
end

function ArcadeHeroMO:getReddotKey()
	return ArcadeEnum.PlayerPrefsKey.DevolopHeroNew, self.id
end

function ArcadeHeroMO:getPlayUnlockAnimKey()
	return ArcadeEnum.PlayerPrefsKey.DevolopHeroPlayUnlockAnim, self.id
end

return ArcadeHeroMO
