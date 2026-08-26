-- chunkname: @modules/logic/explore/map/node/ExploreNode.lua

module("modules.logic.explore.map.node.ExploreNode", package.seeall)

local ExploreNode = class("ExploreNode")

function ExploreNode:ctor(data)
	self.open = true
	self.pos = Vector3.zero
	self.openKeyDic = {}
	self.keyOpen = true

	local walkableKey = ExploreHelper.getKeyXY(data[1], data[2])

	self.height = data[3] or 0
	self.areaId = data[4] or 0
	self.cameraId = data[5] or 0
	self.nodeType = ExploreEnum.NodeType.Normal
	self.rawHeight = self.height
	self._canPassItem = true

	self:setWalkableKey(walkableKey)
end

function ExploreNode:setNodeType(nodeType)
	self.nodeType = nodeType
end

function ExploreNode:isWalkable(height, noCheckUseItem)
	if not ExploreModel.instance:isAreaShow(self.areaId) then
		return false
	end

	if not noCheckUseItem and not self._canPassItem and self:isRoleUseItem() then
		return false
	end

	height = height or self.height

	return (false or nil) and true
end

function ExploreNode:isRoleUseItem()
	local map = ExploreController.instance:getMap()
	local state = map:getNowStatus()

	if state == ExploreEnum.MapStatus.MoveUnit then
		return true
	end

	local useItemUid = ExploreModel.instance:getUseItemUid()
	local itemMo = ExploreBackpackModel.instance:getById(useItemUid)

	if itemMo and itemMo.itemEffect == ExploreEnum.ItemEffect.Active then
		return true
	end

	local unit = map:getUnit(tonumber(useItemUid), true)

	if unit and unit:getUnitType() == ExploreEnum.ItemType.PipePot then
		return true
	end

	return false
end

function ExploreNode:setWalkableKey(walkableKey)
	local x, y = ExploreHelper.getXYByKey(walkableKey)

	self.walkableKey = walkableKey
	self.pos.x = x
	self.pos.y = y
end

function ExploreNode:setCanPassItem(canPass)
	self._canPassItem = canPass
end

function ExploreNode:updateOpenKey(key, isOpen)
	if isOpen then
		self.openKeyDic[key] = nil
	else
		self.openKeyDic[key] = isOpen
	end

	self.keyOpen = true

	for i, v in pairs(self.openKeyDic) do
		self.keyOpen = false

		break
	end
end

return ExploreNode
