-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaMapModel.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapModel", package.seeall)

local NuoDiKaMapModel = class("NuoDiKaMapModel", BaseModel)

function NuoDiKaMapModel:onInit()
	self:reInit()
end

function NuoDiKaMapModel:reInit()
	self._mapDict = {}
	self._curMapId = 0
	self._curSelectNode = 0
end

function NuoDiKaMapModel:setCurSelectNode(nodeId)
	self._curSelectNode = nodeId
end

function NuoDiKaMapModel:isNodeSelected(nodeId)
	return self._curSelectNode == nodeId
end

function NuoDiKaMapModel:getCurSelectNode()
	return self._curSelectNode
end

function NuoDiKaMapModel:initMap(mapId)
	self._curMapId = mapId
	self._mapDict[mapId] = self._mapDict[mapId] or NuoDiKaMapMo.New()

	local mapCo = NuoDiKaConfig.instance:getMapCo(mapId)

	self._mapDict[mapId]:init(mapCo)
end

function NuoDiKaMapModel:resetMap(mapId)
	self:reInit()
	self:initMap(mapId)
end

function NuoDiKaMapModel:getMap(mapId)
	mapId = mapId or self._curMapId

	if not self._mapDict[mapId] then
		self:initMap(mapId)
	end

	return self._mapDict[mapId]
end

function NuoDiKaMapModel:setCurMapId(mapId)
	self._curMapId = mapId
end

function NuoDiKaMapModel:getCurMapId()
	return self._curMapId
end

function NuoDiKaMapModel:getMapNodes(mapId)
	mapId = mapId or self._curMapId

	local dict = {}

	for _, node in pairs(self._mapDict[mapId].nodeDict) do
		table.insert(dict, node)
	end

	table.sort(dict, function(a, b)
		if a.y ~= b.y then
			return a.y < b.y
		else
			return a.x < b.x
		end
	end)

	return dict
end

function NuoDiKaMapModel:getMapNode(nodeId, mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].nodeDict[nodeId]
end

function NuoDiKaMapModel:getMapLineCount(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].lineCount
end

function NuoDiKaMapModel:getMapRowCount(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].rowCount
end

function NuoDiKaMapModel:getAllEmptyNodes(mapId)
	mapId = mapId or self._curMapId

	local nodeMos = {}

	for _, nodeMo in pairs(self._mapDict[mapId].nodeDict) do
		if not nodeMo:getEvent() then
			table.insert(nodeMos, nodeMo)
		end
	end

	return nodeMos
end

function NuoDiKaMapModel:getAllUnlockEnemyNodes(mapId)
	mapId = mapId or self._curMapId

	local nodeMos = {}

	for _, nodeMo in pairs(self._mapDict[mapId].nodeDict) do
		if nodeMo:isNodeUnlock() and nodeMo:isNodeHasEnemy() then
			table.insert(nodeMos, nodeMo)
		end
	end

	return nodeMos
end

function NuoDiKaMapModel:isAllEnemyDead(mapId)
	mapId = mapId or self._curMapId

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v:isNodeUnlock() then
			local eventCo = v:getEvent()

			if eventCo and eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				return false
			end
		else
			local eventCo = v:getInitEvent()

			if eventCo and eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				return false
			end
		end
	end

	return true
end

function NuoDiKaMapModel:isSpEventUnlock(mapId)
	mapId = mapId or self._curMapId

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v:isNodeHasItem() then
			local eventCo = v:getEvent()

			if eventCo.eventId == NuoDiKaEnum.UnlockEventId and v:isNodeUnlock() then
				return v
			end
		else
			local eventCo = v:getInitEvent()

			if eventCo then
				local enemyCo = NuoDiKaConfig.instance:getEnemyCo(eventCo.eventParam)

				if enemyCo and enemyCo.eventID > 0 and not v:getEvent() then
					return v
				end
			end
		end
	end

	return false
end

function NuoDiKaMapModel:getMapEnemys(mapId)
	mapId = mapId or self._curMapId

	local enemyList = {}

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v:isNodeHasEnemy() then
			local itemCo = NuoDiKaConfig.instance:getEnemyCo(v:getEvent().eventParam)

			table.insert(enemyList, itemCo)
		end
	end

	return enemyList
end

function NuoDiKaMapModel:getMapItems(mapId)
	mapId = mapId or self._curMapId

	local itemList = {}

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v:isNodeHasItem() then
			local itemCo = NuoDiKaConfig.instance:getItemCo(v:getEvent().eventParam)

			table.insert(itemList, itemCo)
		end
	end

	return itemList
end

function NuoDiKaMapModel:setNodeUnlock(id, mapId)
	mapId = mapId or self._curMapId

	self._mapDict[mapId].nodeDict[id]:setNodeUnlock(true)
end

function NuoDiKaMapModel:resetNode(mapId)
	mapId = mapId or self._curMapId

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		return v:resetNode()
	end
end

function NuoDiKaMapModel:isNodeUnlock(id, mapId)
	mapId = mapId or self._curMapId

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v.id == id then
			return v:isNodeUnlock()
		end
	end

	return false
end

function NuoDiKaMapModel:isNodeEnemyLock(id, mapId)
	mapId = mapId or self._curMapId

	local nodeMo = self._mapDict[mapId].nodeDict[id]

	if nodeMo:isNodeUnlock() then
		return false
	end

	for x = nodeMo.x - 1, nodeMo.x + 1 do
		for y = nodeMo.y - 1, nodeMo.y + 1 do
			if x ~= nodeMo.x or y ~= nodeMo.y then
				local nodeId = 100 * x + y
				local targetNodeMo = self._mapDict[mapId].nodeDict[nodeId]

				if targetNodeMo and targetNodeMo:isNodeUnlock() and targetNodeMo:isNodeHasEnemy() then
					return true
				end
			end
		end
	end
end

function NuoDiKaMapModel:isNodeCouldUnlock(id, mapId)
	mapId = mapId or self._curMapId

	local nodeMo = self._mapDict[mapId].nodeDict[id]

	if nodeMo:isNodeUnlock() then
		return false
	end

	if nodeMo.x > 1 then
		local leftId = 100 * (nodeMo.x - 1) + nodeMo.y

		if self._mapDict[mapId].nodeDict[leftId]:isNodeUnlock() then
			return true
		end
	end

	if nodeMo.x < self._mapDict[mapId].rowCount then
		local rightId = 100 * (nodeMo.x + 1) + nodeMo.y

		if self._mapDict[mapId].nodeDict[rightId]:isNodeUnlock() then
			return true
		end
	end

	if nodeMo.y > 1 then
		local upId = 100 * nodeMo.x + (nodeMo.y - 1)

		if self._mapDict[mapId].nodeDict[upId]:isNodeUnlock() then
			return true
		end
	end

	if nodeMo.y < self._mapDict[mapId].lineCount then
		local downId = 100 * nodeMo.x + (nodeMo.y + 1)

		if self._mapDict[mapId].nodeDict[downId]:isNodeUnlock() then
			return true
		end
	end

	return false
end

function NuoDiKaMapModel:getAllGetItems(mapId)
	mapId = mapId or self._curMapId

	local items = {}

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		if v:isNodeUnlock() and v:isNodeItemGet() then
			table.insert(items, v:getNodeItem())
		end
	end

	return items
end

function NuoDiKaMapModel:getMaxHpNode(mapId)
	mapId = mapId or self._curMapId

	local allEnemyNodes = self:getAllUnlockEnemyNodes(mapId)

	if #allEnemyNodes < 1 then
		return
	end

	local maxNode

	for _, enemyNode in pairs(allEnemyNodes) do
		local itemCo = NuoDiKaConfig.instance:getEnemyCo(enemyNode:getEvent().eventParam)
		local skillCo = NuoDiKaConfig.instance:getSkillCo(itemCo.skillID)

		if skillCo.effect ~= NuoDiKaEnum.SkillType.Halo then
			if maxNode then
				if maxNode.hp < enemyNode.hp then
					maxNode = enemyNode or maxNode
				end
			else
				maxNode = enemyNode
			end
		end
	end

	return maxNode
end

function NuoDiKaMapModel:getStartNodes(mapId)
	mapId = mapId or self._curMapId

	local nodes = {}

	for _, v in pairs(self._mapDict[mapId].nodeDict) do
		local eventCo = v:getEvent()

		if eventCo and eventCo.initVisible > 0 then
			table.insert(nodes, v)
		end
	end

	return nodes
end

function NuoDiKaMapModel:getMapMainRole(mapId)
	mapId = mapId or self._curMapId

	local roleList = NuoDiKaConfig.instance:getMainRoleList()

	for _, role in pairs(roleList) do
		if role.mapID == mapId then
			return role
		end
	end
end

function NuoDiKaMapModel:getMainRoleBuffCos(roleId, mapId)
	mapId = mapId or self._curMapId

	return {}
end

NuoDiKaMapModel.instance = NuoDiKaMapModel.New()

return NuoDiKaMapModel
