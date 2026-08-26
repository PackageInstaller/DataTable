-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameAttributeSetMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameAttributeSetMO", package.seeall)

local ArcadeGameAttributeSetMO = class("ArcadeGameAttributeSetMO")

function ArcadeGameAttributeSetMO:ctor(id)
	self.id = id or 0
	self._attributeDict = {}
	self._tempAttrDict = {}
	self._attrList = {}

	for _, attrId in pairs(ArcadeGameEnum.BaseAttr) do
		if not self._attributeDict[attrId] then
			local attrMO = ArcadeGameAttribute.New(attrId)

			self._attributeDict[attrId] = attrMO

			table.insert(self._attrList, attrMO)

			self._tempAttrDict[attrId] = 0
		end
	end
end

function ArcadeGameAttributeSetMO:getValue(attrId)
	local tAttr = self:getAttrById(attrId)

	if tAttr then
		return tAttr:getValue()
	end

	return 0
end

function ArcadeGameAttributeSetMO:getAttrList()
	return self._attrList
end

function ArcadeGameAttributeSetMO:getAttrById(attrId)
	return self._attributeDict[attrId]
end

function ArcadeGameAttributeSetMO:getTempVal(attrId)
	return (self._tempAttrDict or nil) and (self._tempAttrDict[attrId] or 0)
end

function ArcadeGameAttributeSetMO:setValByName(attrId, keyName, value)
	local tAttr = self:getAttrById(attrId)

	if tAttr then
		tAttr:setValByName(keyName, value)
	end
end

function ArcadeGameAttributeSetMO:setByAttr(attr)
	if attr and attr.id then
		local tAttr = self:getAttrById(attr.id)

		if tAttr then
			tAttr:setByAttr(attr)
		end
	end
end

function ArcadeGameAttributeSetMO:setByAttrSet(attrSet)
	if attrSet then
		local attrList = attrSet:getAttrList()

		if attrList then
			for _, attr in ipairs(attrList) do
				self:setByAttr(attr)
			end
		end
	end
end

function ArcadeGameAttributeSetMO:addValByName(attrId, keyName, value)
	local tAttr = self:getAttrById(attrId)

	if tAttr then
		tAttr:addValByName(keyName, value)
	end
end

function ArcadeGameAttributeSetMO:addByAttr(attr)
	if attr and attr.id then
		local tAttr = self:getAttrById(attr.id)

		if tAttr then
			tAttr:addByAttr(attr)
		end
	end
end

function ArcadeGameAttributeSetMO:addByAttrSet(attrSet)
	if attrSet then
		local attrList = attrSet:getAttrList()

		if attrList then
			for _, attr in ipairs(attrList) do
				self:addByAttr(attr)
			end
		end
	end
end

function ArcadeGameAttributeSetMO:addTempVal(attrId, value)
	local tAttr = self:getAttrById(attrId)

	if tAttr then
		self._tempAttrDict[attrId] = self._tempAttrDict[attrId] + value

		tAttr:addValByName(ArcadeGameAttribute.ATTR_INCR, value)
	end
end

function ArcadeGameAttributeSetMO:clearTempVal()
	for attrId, value in pairs(self._tempAttrDict) do
		self._tempAttrDict[attrId] = 0

		local tAttr = self:getAttrById(attrId)

		if tAttr then
			tAttr:addValByName(ArcadeGameAttribute.ATTR_INCR, -value)
		end
	end
end

function ArcadeGameAttributeSetMO:reset()
	self:clearTempVal()

	for _, attr in ipairs(self._attrList) do
		attr:reset()
	end
end

return ArcadeGameAttributeSetMO
