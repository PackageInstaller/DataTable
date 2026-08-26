-- chunkname: @modules/logic/rouge/model/RougeCollectionSlotMO.lua

module("modules.logic.rouge.model.RougeCollectionSlotMO", package.seeall)

local RougeCollectionSlotMO = pureTable("RougeCollectionSlotMO", RougeCollectionMO)
local RougeCollectionSlotMO = class("RougeCollectionSlotMO", RougeCollectionMO)

function RougeCollectionSlotMO:init(info)
	RougeCollectionSlotMO.super.init(self, info.item)
	self:updateRotation(info.rotation)
	self:updateBaseEffects(info.baseEffects)
	self:updateEffectRelations(info.relations)

	local leftTopPos = info.pos and Vector2(tonumber(info.pos.col), tonumber(info.pos.row)) or Vector2(0, 0)

	self:updateLeftTopPos(leftTopPos)
	self:updateAttrValues(info.attr)
end

function RougeCollectionSlotMO:updateInfo(info)
	self:initBaseInfo(info)
end

function RougeCollectionSlotMO:getCenterSlotPos()
	return self.centerSlotPos
end

function RougeCollectionSlotMO:getLeftTopPos()
	return self.pos or Vector2(0, 0)
end

function RougeCollectionSlotMO:getRotation()
	return self.rotation or RougeEnum.CollectionRotation.Rotation_0
end

function RougeCollectionSlotMO:updateLeftTopPos(pos)
	self.pos = pos or Vector2.zero
	self.centerSlotPos = RougeCollectionHelper.getCollectionCenterSlotPos(self.cfgId, self.rotation, self.pos)
end

function RougeCollectionSlotMO:updateRotation(newRotation)
	self.rotation = newRotation or RougeEnum.CollectionRotation.Rotation_0

	if self.centerSlotPos then
		local pos = RougeCollectionHelper.getCollectionTopLeftSlotPos(self.cfgId, self.centerSlotPos, self.rotation)

		self:updateLeftTopPos(pos)
	end
end

function RougeCollectionSlotMO:copyOtherMO(mo)
	if not mo then
		return
	end

	self:copyOtherCollectionMO(mo)

	self.centerSlotPos = mo.getCenterSlotPos and mo:getCenterSlotPos() or Vector2.zero
	self.pos = mo.getLeftTopPos and mo:getLeftTopPos() or Vector2.zero
	self.rotation = mo:getRotation()
end

function RougeCollectionSlotMO:updateBaseEffects(baseEffects)
	self.baseEffects = {}

	if baseEffects then
		for _, effectId in ipairs(baseEffects) do
			table.insert(self.baseEffects, effectId)
		end
	end
end

function RougeCollectionSlotMO:getBaseEffects()
	return self.baseEffects
end

function RougeCollectionSlotMO:getBaseEffectCount()
	return self.baseEffects and #self.baseEffects
end

function RougeCollectionSlotMO:updateEffectRelations(relations)
	self.effectRelations = {}
	self.effectRelationMap = {}

	if relations then
		for _, relationInfo in ipairs(relations) do
			local relationMO = RougeCollectionRelationMO.New()

			relationMO:init(relationInfo)
			table.insert(self.effectRelations, relationMO)

			local effectShowType = relationMO.showType

			self.effectRelationMap[effectShowType] = self.effectRelationMap[effectShowType] or {}

			table.insert(self.effectRelationMap[effectShowType], relationMO)
		end
	end
end

function RougeCollectionSlotMO:getEffectShowTypeRelations(effectShowType)
	return self.effectRelationMap and self.effectRelationMap[effectShowType]
end

function RougeCollectionSlotMO:isEffectActive(effectShowType)
	local relations = self:getEffectShowTypeRelations(effectShowType)

	if relations then
		for _, relation in ipairs(relations) do
			local index = tabletool.indexOf(self.baseEffects, relation.effectIndex)

			if index and index > 0 then
				return true
			end
		end
	end

	return false
end

function RougeCollectionSlotMO:reset()
	self.id = 0
	self.rotation = RougeEnum.CollectionRotation.Rotation_0
end

return RougeCollectionSlotMO
