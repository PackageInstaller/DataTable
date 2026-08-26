-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookMonsterMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookMonsterMO", package.seeall)

local ArcadeHandBookMonsterMO = class("ArcadeHandBookMonsterMO", ArcadeHandBookMO)

function ArcadeHandBookMonsterMO:initAttribute()
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

function ArcadeHandBookMonsterMO:getAttack()
	return self.co.attack or 0
end

function ArcadeHandBookMonsterMO:getHp()
	return self.co.hpCap or 0
end

function ArcadeHandBookMonsterMO:getDefense()
	return self.co.defense or 0
end

function ArcadeHandBookMonsterMO:getBigIconTrans()
	if self.co then
		if not self.co.iconOffset2 then
			local icon2Offset2 = {}
			local anchorX = icon2Offset2[1] and tonumber(icon2Offset2[1]) or 0
			local anchorY = icon2Offset2[2] and tonumber(icon2Offset2[2]) or 0

			if self.co then
				if not self.co.iconScale2 then
					local iconScale2 = {}
					local scaleX = iconScale2[1] and tonumber(iconScale2[1]) or 1
					local scaleY = iconScale2[2] and tonumber(iconScale2[2]) or 1

					return anchorX, anchorY, scaleX, scaleY
				end
			end
		end
	end
end

return ArcadeHandBookMonsterMO
