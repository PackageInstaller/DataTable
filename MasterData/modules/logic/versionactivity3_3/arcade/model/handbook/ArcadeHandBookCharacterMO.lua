-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookCharacterMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookCharacterMO", package.seeall)

local ArcadeHandBookCharacterMO = class("ArcadeHandBookCharacterMO", ArcadeHandBookMO)

function ArcadeHandBookCharacterMO:initAttribute()
	self._attributeList = {}
	self._attributeList[ArcadeEnum.AttributeType.Attack] = {
		value = self:getAttack()
	}
	self._attributeList[ArcadeEnum.AttributeType.Defense] = {
		value = self:getDefense()
	}
	self._attributeList[ArcadeEnum.AttributeType.Hp] = {
		value = self:getHp()
	}
end

function ArcadeHandBookCharacterMO:initEffect()
	self._effectList = {}
	self._effectList[ArcadeEnum.EffectType.Skill] = ArcadeHandBookSkillMO.New(self.co.skill)
	self._effectList[ArcadeEnum.EffectType.Bomb] = ArcadeHandBookBombMO.New(self.co.bomb)
	self._effectList[ArcadeEnum.EffectType.Collection] = ArcadeHandBookCollectionMO.New(self.co.collection)
end

function ArcadeHandBookCharacterMO:getAttack()
	return self.co.attack or 0
end

function ArcadeHandBookCharacterMO:getHp()
	return self.co.hpCap or 0
end

function ArcadeHandBookCharacterMO:getDefense()
	return self.co.defense or 0
end

function ArcadeHandBookCharacterMO:getBigIcon()
	return self.co.icon2
end

function ArcadeHandBookCharacterMO:getBigIconTrans()
	if self.co then
		if not self.co.icon2Offset2 then
			local icon2Offset2 = {}
			local anchorX = icon2Offset2[1] and tonumber(icon2Offset2[1]) or 0
			local anchorY = icon2Offset2[2] and tonumber(icon2Offset2[2]) or 0
			local scaleX, scaleY = 1, 1

			return anchorX, anchorY, scaleX, scaleY
		end
	end
end

function ArcadeHandBookCharacterMO:getLockTip()
	local lockTip = ArcadeConfig.instance:getCharacterLockTip(self.id)

	if string.nilorempty(lockTip) then
		lockTip = ArcadeHandBookCharacterMO.super.getLockTip()
	end

	return lockTip
end

return ArcadeHandBookCharacterMO
