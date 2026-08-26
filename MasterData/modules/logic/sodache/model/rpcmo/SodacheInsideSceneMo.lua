-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheInsideSceneMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheInsideSceneMo", package.seeall)

local SodacheInsideSceneMo = pureTable("SodacheInsideSceneMo")

function SodacheInsideSceneMo:init(data)
	self.prop = GameUtil.rpcInfoToMo(data.prop, SodacheInsidePropMo, self.prop)
	self.player = GameUtil.rpcInfoToMo(data.player, SodacheUnitMo, self.player)
	self.unitBox = GameUtil.rpcInfoToMo(data.unitBox, SodacheUnitBoxMo, self.unitBox)
	self.panelBox = GameUtil.rpcInfoToMo(data.panelBox, SodachePanelBoxMo, self.panelBox)
	self.patrolBox = data.patrolBox
	self.mapCo = SodacheConfig.instance:getMapCo(self.prop.mapId)
	self.copyCo = lua_sodache_copy.configDict[self.prop.copyId]
	self.unitDirty = true
	self.nodeIdToUnitMos = {}
	self.allShowNodes = {}
	self.allShowLines = {}

	self:addNodeVision(data.visionBox.id)
end

function SodacheInsideSceneMo:addNodeVision(nodeIds)
	for k, v in pairs(nodeIds) do
		self.allShowNodes[v] = true
	end

	for k, v in pairs(nodeIds) do
		local dict = self.mapCo.lineDict[v]

		if dict then
			for nodeId, lineId in pairs(dict) do
				if self.allShowNodes[nodeId] then
					self.allShowLines[lineId] = true
				end
			end
		end
	end
end

function SodacheInsideSceneMo:updateUnitCache()
	if self.unitDirty then
		self.nodeIdToUnitMos = {}
		self.unitDirty = false

		for k, v in pairs(self.unitBox.units) do
			self:_processMo(v)
		end
	end
end

function SodacheInsideSceneMo:getUnitsByNodeId(nodeId)
	self:updateUnitCache()

	return self.nodeIdToUnitMos[nodeId] or {}
end

function SodacheInsideSceneMo:getUnitByType(nodeId, unitType)
	nodeId = nodeId or self.player.locationId

	for k, v in pairs(self:getUnitsByNodeId(nodeId)) do
		if v.type == unitType then
			return v
		end
	end
end

function SodacheInsideSceneMo:getUnitsByType(nodeId, unitType)
	nodeId = nodeId or self.player.locationId

	local list = {}

	for k, v in pairs(self:getUnitsByNodeId(nodeId)) do
		if v.type == unitType then
			table.insert(list, v)
		end
	end

	return list
end

function SodacheInsideSceneMo:getTopUnitId(nodeId)
	local moList = self:getUnitsByNodeId(nodeId)
	local selectMo

	for uid, unitMo in pairs(moList) do
		if unitMo:isHide() and not unitMo.isMove then
			selectMo = unitMo:compareOrder(selectMo)
		end
	end

	return selectMo and selectMo.uid
end

function SodacheInsideSceneMo:_processMo(unitMo)
	GameUtil.setTbValue(self.nodeIdToUnitMos, unitMo.locationId, unitMo.uid, unitMo)
end

return SodacheInsideSceneMo
