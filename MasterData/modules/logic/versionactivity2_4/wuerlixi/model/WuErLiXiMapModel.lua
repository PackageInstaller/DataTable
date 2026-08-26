-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapModel.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapModel", package.seeall)

local WuErLiXiMapModel = class("WuErLiXiMapModel", BaseModel)

function WuErLiXiMapModel:onInit()
	self:reInit()
end

function WuErLiXiMapModel:reInit()
	self._mapDict = {}
	self._curMapId = 0
	self._curSelectNode = {}
	self._unlockElements = {}
end

function WuErLiXiMapModel:_initUnlockElements()
	local unlockStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, "")

	self._unlockElements = string.splitToNumber(unlockStr, "#") or {}
end

function WuErLiXiMapModel:initMap(mapId)
	mapId = mapId or self._curMapId
	self._mapDict[mapId] = self._mapDict[mapId] or WuErLiXiMapMo.New()

	local mapCo = WuErLiXiConfig.instance:getMapCo(mapId)

	self._mapDict[mapId]:init(mapCo)
end

function WuErLiXiMapModel:resetMap(mapId)
	mapId = mapId or self._curMapId

	self:initMap(mapId)
end

function WuErLiXiMapModel:getMap(mapId)
	mapId = mapId or self._curMapId

	if not self._mapDict[mapId] then
		self:initMap(mapId)
	end

	return self._mapDict[mapId]
end

function WuErLiXiMapModel:setCurMapId(mapId)
	self._curMapId = mapId
end

function WuErLiXiMapModel:getCurMapId()
	return self._curMapId
end

function WuErLiXiMapModel:getMapLimitActUnits(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].actUnitDict
end

function WuErLiXiMapModel:getMapNodes(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].nodeDict
end

function WuErLiXiMapModel:getMapLineCount(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].lineCount
end

function WuErLiXiMapModel:getMapRowCount(mapId)
	mapId = mapId or self._curMapId

	return self._mapDict[mapId].rowCount
end

function WuErLiXiMapModel:setUnitDir(nodeMo, dir, fromDir)
	local unitMo = nodeMo:getNodeUnit()

	if not unitMo then
		return
	end

	local nodeDict = self:getMapNodes()

	if unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if dir == WuErLiXiEnum.Dir.Up or dir == WuErLiXiEnum.Dir.Down then
			if nodeDict[nodeMo.y][nodeMo.x - 1] then
				local nodeUnit = nodeDict[nodeMo.y][nodeMo.x - 1]:getNodeUnit()

				if nodeUnit then
					return
				end
			else
				return
			end

			if nodeDict[nodeMo.y][nodeMo.x + 1] then
				local nodeUnit = nodeDict[nodeMo.y][nodeMo.x + 1]:getNodeUnit()

				if nodeUnit then
					return
				end
			else
				return
			end
		else
			if nodeDict[nodeMo.y - 1] then
				local nodeUnit = nodeDict[nodeMo.y - 1][nodeMo.x]:getNodeUnit()

				if nodeUnit then
					return
				end
			else
				return
			end

			if nodeDict[nodeMo.y + 1] then
				local nodeUnit = nodeDict[nodeMo.y + 1][nodeMo.x]:getNodeUnit()

				if nodeUnit then
					return
				end
			else
				return
			end
		end
	end

	if unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if fromDir == WuErLiXiEnum.Dir.Up or fromDir == WuErLiXiEnum.Dir.Down then
			if nodeDict[nodeMo.y][nodeMo.x - 1] then
				nodeDict[nodeMo.y][nodeMo.x - 1]:clearUnit()
				self:clearNodesRay(nodeDict[nodeMo.y][nodeMo.x - 1], nodeDict[nodeMo.y][nodeMo.x - 1].id, nodeMo:getUnitSignalOutDir(), true)
			end

			if nodeDict[nodeMo.y][nodeMo.x + 1] then
				nodeDict[nodeMo.y][nodeMo.x + 1]:clearUnit()
				self:clearNodesRay(nodeDict[nodeMo.y][nodeMo.x + 1], nodeDict[nodeMo.y][nodeMo.x + 1].id, nodeMo:getUnitSignalOutDir(), true)
			end
		else
			if nodeDict[nodeMo.y - 1] then
				nodeDict[nodeMo.y - 1][nodeMo.x]:clearUnit()
				self:clearNodesRay(nodeDict[nodeMo.y - 1][nodeMo.x], nodeDict[nodeMo.y - 1][nodeMo.x].id, nodeMo:getUnitSignalOutDir(), true)
			end

			if nodeDict[nodeMo.y + 1] then
				nodeDict[nodeMo.y + 1][nodeMo.x]:clearUnit()
				self:clearNodesRay(nodeDict[nodeMo.y + 1][nodeMo.x], nodeDict[nodeMo.y + 1][nodeMo.x].id, nodeMo:getUnitSignalOutDir(), true)
			end
		end
	end

	local rayMo = nodeMo:getNodeRay()

	if not rayMo then
		nodeMo:setDir(dir)
		self:setNodeUnitByUnitMo(nodeMo, unitMo)

		return
	end

	if unitMo.unitType ~= WuErLiXiEnum.UnitType.Key then
		self:clearNodesRay(nodeMo, nodeMo.id, nodeMo:getUnitSignalOutDir(), true)
	end

	nodeMo:setDir(dir, rayMo.rayDir)
	self:setNodeUnitByUnitMo(nodeMo, unitMo)
end

function WuErLiXiMapModel:clearNodeUnit(nodeMo, skipKey)
	local clearUnit = nodeMo:getNodeUnit()

	if not clearUnit then
		return
	end

	local targetRay
	local nodeDict = self:getMapNodes()

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()
			local nodeRay = node:getNodeRay()

			if nodeUnit and nodeUnit.x == clearUnit.x and nodeUnit.y == clearUnit.y then
				if nodeUnit.unitType == WuErLiXiEnum.UnitType.Key and not skipKey then
					self:setSwitchActive(nodeUnit.id, false)
				end

				self:clearNodesRay(node, node.id, nodeMo:getUnitSignalOutDir(), true)

				if nodeRay then
					targetRay = nodeRay
				end
			end
		end
	end

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()

			if nodeUnit and nodeUnit.x == clearUnit.x and nodeUnit.y == clearUnit.y then
				nodeDict[node.y][node.x]:clearUnit()
			end
		end
	end

	if targetRay then
		local targetX = math.floor(targetRay.rayId / 100)
		local targetY = targetRay.rayId % 100
		local targetNode = nodeDict[targetY][targetX]

		self:fillNodeRay(targetNode, targetRay.rayType, targetRay.rayDir, true, targetRay.rayParent)
	end
end

function WuErLiXiMapModel:setNodeUnitByUnitMo(nodeMo, unitMo, skipKey)
	local nodeDict = self:getMapNodes()
	local setNodes = {}

	table.insert(setNodes, nodeMo)

	if unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if unitMo.dir == WuErLiXiEnum.Dir.Up or unitMo.dir == WuErLiXiEnum.Dir.Down then
			table.insert(setNodes, nodeDict[nodeMo.y][nodeMo.x - 1])
			table.insert(setNodes, nodeDict[nodeMo.y][nodeMo.x + 1])
		else
			table.insert(setNodes, nodeDict[nodeMo.y - 1][nodeMo.x])
			table.insert(setNodes, nodeDict[nodeMo.y + 1][nodeMo.x])
		end
	end

	for _, setNode in pairs(setNodes) do
		local rayMo = setNode:getNodeRay()

		if rayMo then
			if unitMo.unitType == WuErLiXiEnum.UnitType.Key and not skipKey then
				self:setSwitchActive(unitMo.id, rayMo.rayType == rayMo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			self:clearNodesRay(setNode, rayMo.rayId, rayMo.rayDir, false)
		end

		setNode:setUnitByUnitMo(unitMo, nodeMo.x, nodeMo.y)
	end
end

function WuErLiXiMapModel:setNodeUnitByActUnitMo(nodeMo, actUnitMo)
	local nodeDict = self:getMapNodes()
	local setNodes = {}

	table.insert(setNodes, nodeMo)

	if actUnitMo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if actUnitMo.dir == WuErLiXiEnum.Dir.Up or actUnitMo.dir == WuErLiXiEnum.Dir.Down then
			table.insert(setNodes, nodeDict[nodeMo.y][nodeMo.x - 1])
			table.insert(setNodes, nodeDict[nodeMo.y][nodeMo.x + 1])
		else
			table.insert(setNodes, nodeDict[nodeMo.y - 1][nodeMo.x])
			table.insert(setNodes, nodeDict[nodeMo.y + 1][nodeMo.x])
		end
	end

	for _, setNode in pairs(setNodes) do
		local rayMo = setNode:getNodeRay()

		if rayMo then
			if actUnitMo.type == WuErLiXiEnum.UnitType.Key then
				self:setSwitchActive(actUnitMo.id, rayMo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			self:clearNodesRay(setNode, rayMo.rayId, rayMo.rayDir, false)
		end

		setNode:setUnitByActUnitMo(actUnitMo, nodeMo.x, nodeMo.y)
	end
end

function WuErLiXiMapModel:setMapData()
	local nodeDict = self:getMapNodes()
	local lineCount = self:getMapLineCount()
	local rowCount = self:getMapRowCount()

	for x = 1, rowCount do
		for y = 1, lineCount do
			local unitMo = nodeDict[y][x]:getNodeUnit()

			if unitMo then
				if unitMo.unitType == WuErLiXiEnum.UnitType.SignalStart then
					self:setMapSignalData(nodeDict[y][x], WuErLiXiEnum.RayType.NormalSignal)
				elseif unitMo.unitType == WuErLiXiEnum.UnitType.KeyStart then
					self:setMapSignalData(nodeDict[y][x], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end
end

function WuErLiXiMapModel:setMapSignalData(signalNodeMo, rayType)
	local unitMo = signalNodeMo:getNodeUnit()

	if not unitMo then
		return
	end

	local outDir = unitMo:getUnitSignalOutDir()

	if not outDir then
		return
	end

	self:setUnitActive(signalNodeMo, true, rayType, outDir)

	local nodeDict = self:getMapNodes()
	local signals = unitMo:getUnitSignals(outDir)

	for _, signal in pairs(signals) do
		self:fillNodeRay(nodeDict[signal[2]][signal[1]], rayType, unitMo:getUnitSignalOutDir())
	end
end

function WuErLiXiMapModel:fillNodeRay(nodeMo, rayType, rayDir, fillCurNode, rayParent)
	local nodeDict = self:getMapNodes()
	local lineCount = self:getMapLineCount()
	local rowCount = self:getMapRowCount()

	if rayDir == WuErLiXiEnum.Dir.Up then
		if nodeMo.y > 1 then
			for i = nodeMo.y - 1, 1, -1 do
				local couldSet = nodeDict[i][nodeMo.x]:couldSetRay(rayType)

				if not couldSet then
					return
				end

				local unitMo = nodeDict[i][nodeMo.x]:getNodeUnit()

				if unitMo then
					local isUnitBlock = unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not unitMo:isUnitActive()

					if isUnitBlock then
						self:setUnitActive(nodeDict[i][nodeMo.x], true, rayType, rayDir)

						if nodeDict[i][nodeMo.x]:isUnitActive(rayDir) then
							nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
							nodeDict[i][nodeMo.x]:setUnitOutDirByRayDir(rayDir)

							local signals = unitMo:getUnitSignals(rayDir)

							for _, signal in pairs(signals) do
								self:fillNodeRay(nodeDict[i][signal[1]], rayType, unitMo:getUnitSignalOutDir(), false, nodeMo.id)
							end

							if unitMo.unitType == WuErLiXiEnum.UnitType.Key then
								self:setSwitchActive(unitMo.id, true)
							end
						end

						return
					elseif unitMo.unitType == WuErLiXiEnum.UnitType.Switch then
						self:setUnitActive(nodeDict[i][nodeMo.x], true, rayType, rayDir)
					end
				end

				local nodeRay = nodeDict[i][nodeMo.x]:getNodeRay()

				if not nodeRay then
					nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				elseif rayDir == WuErLiXiHelper.getOppositeDir(nodeRay.rayDir) then
					return
				elseif nodeRay.rayId == nodeMo.id then
					nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				else
					local curRayLength = nodeMo.y - i
					local lastRayLength = math.abs(nodeMo.x + i - nodeRay.rayId % 100 - math.floor(nodeRay.rayId / 100))

					if ServerTime.now() - nodeRay.rayTime > 0.1 then
						return
					end

					if curRayLength < lastRayLength then
						local isRayParent = self:isRayParent(nodeRay.rayId, nodeMo.id)

						if isRayParent then
							return
						end

						self:clearNodesRay(nodeDict[i][nodeMo.x], nodeRay.rayId, nodeRay.rayDir, false)
						nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
						nodeDict[i][nodeMo.x]:setUnitOutDirByRayDir(rayDir)
					elseif curRayLength == lastRayLength then
						self:clearNodesRay(nodeDict[i][nodeMo.x], nodeMo.id, nodeRay.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Down then
		if lineCount > nodeMo.y then
			for i = nodeMo.y + 1, lineCount do
				local couldSet = nodeDict[i][nodeMo.x]:couldSetRay(rayType)

				if not couldSet then
					return
				end

				local unitMo = nodeDict[i][nodeMo.x]:getNodeUnit()

				if unitMo then
					local isUnitBlock = unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not unitMo:isUnitActive()

					if isUnitBlock then
						self:setUnitActive(nodeDict[i][nodeMo.x], true, rayType, rayDir)

						if nodeDict[i][nodeMo.x]:isUnitActive(rayDir) then
							nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
							nodeDict[i][nodeMo.x]:setUnitOutDirByRayDir(rayDir)

							local signals = unitMo:getUnitSignals(rayDir)

							for _, signal in pairs(signals) do
								self:fillNodeRay(nodeDict[i][signal[1]], rayType, unitMo:getUnitSignalOutDir(), false, nodeMo.id)
							end

							if unitMo.unitType == WuErLiXiEnum.UnitType.Key then
								self:setSwitchActive(unitMo.id, true)
							end
						end

						return
					end
				end

				local nodeRay = nodeDict[i][nodeMo.x]:getNodeRay()

				if not nodeRay then
					nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				elseif rayDir == WuErLiXiHelper.getOppositeDir(nodeRay.rayDir) then
					return
				elseif nodeRay.rayId == nodeMo.id then
					nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				else
					local curRayLength = math.abs(nodeMo.y - i)
					local lastRayLength = math.abs(nodeMo.x + i - nodeRay.rayId % 100 - math.floor(nodeRay.rayId / 100))

					if ServerTime.now() - nodeRay.rayTime > 0.1 then
						return
					end

					if curRayLength < lastRayLength then
						local isRayParent = self:isRayParent(nodeRay.rayId, nodeMo.id)

						if isRayParent then
							return
						end

						self:clearNodesRay(nodeDict[i][nodeMo.x], nodeRay.rayId, nodeRay.rayDir, false)
						nodeDict[i][nodeMo.x]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
						nodeDict[i][nodeMo.x]:setUnitOutDirByRayDir(rayDir)
					elseif curRayLength == lastRayLength then
						self:clearNodesRay(nodeDict[i][nodeMo.x], nodeMo.id, nodeRay.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Left then
		if nodeMo.x > 1 then
			for i = nodeMo.x - 1, 1, -1 do
				local couldSet = nodeDict[nodeMo.y][i]:couldSetRay(rayType)

				if not couldSet then
					return
				end

				local unitMo = nodeDict[nodeMo.y][i]:getNodeUnit()

				if unitMo then
					local isUnitBlock = unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not unitMo:isUnitActive()

					if isUnitBlock then
						self:setUnitActive(nodeDict[nodeMo.y][i], true, rayType, rayDir)

						if nodeDict[nodeMo.y][i]:isUnitActive(rayDir) then
							nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
							nodeDict[nodeMo.y][i]:setUnitOutDirByRayDir(rayDir)

							local signals = unitMo:getUnitSignals(rayDir)

							for _, signal in pairs(signals) do
								self:fillNodeRay(nodeDict[signal[2]][i], rayType, unitMo:getUnitSignalOutDir(), false, nodeMo.id)
							end

							if unitMo.unitType == WuErLiXiEnum.UnitType.Key then
								self:setSwitchActive(unitMo.id, true)
							end

							return
						end

						return
					end
				end

				local nodeRay = nodeDict[nodeMo.y][i]:getNodeRay()

				if not nodeRay then
					nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				elseif rayDir == WuErLiXiHelper.getOppositeDir(nodeRay.rayDir) then
					return
				elseif nodeRay.rayId == nodeMo.id then
					nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
				else
					local curRayLength = math.abs(nodeMo.x - i)
					local lastRayLength = math.abs(i + nodeMo.y - nodeRay.rayId % 100 - math.floor(nodeRay.rayId / 100))

					if ServerTime.now() - nodeRay.rayTime > 0.1 then
						return
					end

					if curRayLength < lastRayLength then
						if self._curMapId == 105 and nodeMo.id == 902 and nodeRay.rayId == 409 then
							return
						end

						local isRayParent = self:isRayParent(nodeRay.rayId, nodeMo.id)

						if isRayParent then
							return
						end

						self:clearNodesRay(nodeDict[nodeMo.y][i], nodeRay.rayId, nodeRay.rayDir, false)
						nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
						nodeDict[nodeMo.y][i]:setUnitOutDirByRayDir(rayDir)
					elseif curRayLength == lastRayLength then
						self:clearNodesRay(nodeDict[nodeMo.y][i], nodeMo.id, nodeRay.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Right and rowCount > nodeMo.x then
		for i = nodeMo.x + 1, rowCount do
			local couldSet = nodeDict[nodeMo.y][i]:couldSetRay(rayType)

			if not couldSet then
				return
			end

			local unitMo = nodeDict[nodeMo.y][i]:getNodeUnit()

			if unitMo then
				local isUnitBlock = unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not unitMo:isUnitActive()

				if isUnitBlock then
					self:setUnitActive(nodeDict[nodeMo.y][i], true, rayType, rayDir)

					if nodeDict[nodeMo.y][i]:isUnitActive(rayDir) then
						nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
						nodeDict[nodeMo.y][i]:setUnitOutDirByRayDir(rayDir)

						local signals = unitMo:getUnitSignals(rayDir)

						for _, signal in pairs(signals) do
							self:fillNodeRay(nodeDict[signal[2]][i], rayType, unitMo:getUnitSignalOutDir(), false, nodeMo.id)
						end

						if unitMo.unitType == WuErLiXiEnum.UnitType.Key then
							self:setSwitchActive(unitMo.id, true)
						end
					end

					return
				end
			end

			local nodeRay = nodeDict[nodeMo.y][i]:getNodeRay()

			if not nodeRay then
				nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
			elseif rayDir == WuErLiXiHelper.getOppositeDir(nodeRay.rayDir) then
				return
			elseif nodeRay.rayId == nodeMo.id then
				nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
			else
				local curRayLength = math.abs(nodeMo.x - i)
				local lastRayLength = math.abs(i + nodeMo.y - nodeRay.rayId % 100 - math.floor(nodeRay.rayId / 100))

				if ServerTime.now() - nodeRay.rayTime > 0.1 then
					return
				end

				if curRayLength < lastRayLength then
					local isRayParent = self:isRayParent(nodeRay.rayId, nodeMo.id)

					if isRayParent then
						return
					end

					self:clearNodesRay(nodeDict[nodeMo.y][i], nodeRay.rayId, nodeRay.rayDir, false)
					nodeDict[nodeMo.y][i]:setNodeRay(nodeMo.id, rayType, rayDir, rayParent)
					nodeDict[nodeMo.y][i]:setUnitOutDirByRayDir(rayDir)
				elseif curRayLength == lastRayLength then
					self:clearNodesRay(nodeDict[nodeMo.y][i], nodeMo.id, nodeRay.rayDir, false)

					return
				else
					return
				end
			end
		end
	end
end

function WuErLiXiMapModel:isRayParent(rayParent, rayId)
	local nodeDict = self:getMapNodes()
	local nodeX = math.floor(rayId / 100)
	local nodeY = rayId % 100
	local unitMo = nodeDict[nodeY][nodeX]:getNodeUnit()

	if not unitMo then
		return false
	end

	local rayMo = nodeDict[unitMo.y][unitMo.x]:getNodeRay()

	if not rayMo then
		return false
	end

	if rayMo.rayParent == rayParent then
		return true
	end

	if not rayMo.rayParent or rayMo.rayParent <= 0 then
		return false
	end

	local nodePX = math.floor(rayMo.rayParent / 100)
	local nodePY = rayMo.rayParent % 100
	local pRayMo = nodeDict[nodePY][nodePX]:getNodeRay()

	if not pRayMo then
		return false
	end

	return self:isRayParent(pRayMo.rayParent, rayMo.rayParent)
end

function WuErLiXiMapModel:hasBlockRayUnit(startNode, endNode, rayType, rayDir)
	if startNode.x == endNode.x and startNode.y == endNode.y then
		return false
	end

	local endNodeUnit = endNode:getNodeUnit()

	if endNodeUnit then
		return false
	end

	local nodeDict = self:getMapNodes()

	if rayDir == WuErLiXiEnum.Dir.Up then
		if startNode.x ~= endNode.x then
			return false
		end

		if endNode.y >= startNode.y then
			return false
		end

		for i = startNode.y, endNode.y + 1, -1 do
			local nodeUnit = nodeDict[i][startNode.x]:getNodeUnit()

			if nodeUnit and (nodeUnit.unitType ~= WuErLiXiEnum.UnitType.Switch or rayType ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Down then
		if startNode.x ~= endNode.x then
			return false
		end

		if endNode.y <= startNode.y then
			return false
		end

		for i = startNode.y, endNode.y - 1 do
			local nodeUnit = nodeDict[i][startNode.x]:getNodeUnit()

			if nodeUnit and (nodeUnit.unitType ~= WuErLiXiEnum.UnitType.Switch or rayType ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Left then
		if startNode.y ~= endNode.y then
			return false
		end

		if endNode.x >= startNode.x then
			return false
		end

		for i = startNode.x, endNode.x + 1, -1 do
			local nodeUnit = nodeDict[startNode.y][i]:getNodeUnit()

			if nodeUnit and (nodeUnit.unitType ~= WuErLiXiEnum.UnitType.Switch or rayType ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Right then
		if startNode.y ~= endNode.y then
			return false
		end

		if endNode.x <= startNode.x then
			return false
		end

		for i = startNode.x, endNode.x - 1 do
			local nodeUnit = nodeDict[startNode.y][i]:getNodeUnit()

			if nodeUnit and (nodeUnit.unitType ~= WuErLiXiEnum.UnitType.Switch or rayType ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	end

	return false
end

function WuErLiXiMapModel:setUnitActive(nodeMo, active, signalType, inDir)
	local unitMo = nodeMo:getNodeUnit()

	if not unitMo then
		return
	end

	local rayMo = nodeMo:getNodeRay()

	if active and rayMo then
		return
	end

	local nodeDict = self:getMapNodes()

	nodeMo:setUnitActive(active, signalType, inDir)

	if unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if unitMo.dir == WuErLiXiEnum.Dir.Up or unitMo.dir == WuErLiXiEnum.Dir.Down then
			if nodeDict[nodeMo.y][nodeMo.x - 1] then
				nodeDict[nodeMo.y][nodeMo.x - 1]:setUnitActive(nodeMo:isUnitActive())
			end

			if nodeDict[nodeMo.y][nodeMo.x + 1] then
				nodeDict[nodeMo.y][nodeMo.x + 1]:setUnitActive(nodeMo:isUnitActive())
			end
		else
			if nodeDict[nodeMo.y - 1] then
				nodeDict[nodeMo.y - 1][nodeMo.x]:setUnitActive(nodeMo:isUnitActive())
			end

			if nodeDict[nodeMo.y + 1] then
				nodeDict[nodeMo.y + 1][nodeMo.x]:setUnitActive(nodeMo:isUnitActive())
			end
		end
	end
end

function WuErLiXiMapModel:setSwitchActive(unitId, active)
	local nodeDict = self:getMapNodes()

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()

			if nodeUnit and nodeUnit.id == unitId and nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch then
				if nodeUnit:isUnitActive() == active then
					return
				end

				nodeUnit:setUnitActive(active)

				if active then
					if nodeDict[node.y + 1] and nodeDict[node.y + 1][node.x] then
						local nodeRay = nodeDict[node.y + 1][node.x]:getNodeRay()

						if nodeRay and nodeRay.rayDir == WuErLiXiEnum.Dir.Up then
							local x = math.floor(nodeRay.rayId / 100)
							local y = math.floor(nodeRay.rayId % 100)

							self:fillNodeRay(nodeDict[y][x], nodeRay.rayType, nodeRay.rayDir, true, nodeRay.rayParent)
						end
					end

					if nodeDict[node.y - 1] and nodeDict[node.y - 1][node.x] then
						local nodeRay = nodeDict[node.y - 1][node.x]:getNodeRay()

						if nodeRay and nodeRay.rayDir == WuErLiXiEnum.Dir.Down then
							local x = math.floor(nodeRay.rayId / 100)
							local y = math.floor(nodeRay.rayId % 100)

							self:fillNodeRay(nodeDict[y][x], nodeRay.rayType, nodeRay.rayDir, true, nodeRay.rayParent)
						end
					end

					if nodeDict[node.y][node.x + 1] then
						local nodeRay = nodeDict[node.y][node.x + 1]:getNodeRay()

						if nodeRay and nodeRay.rayDir == WuErLiXiEnum.Dir.Left then
							local x = math.floor(nodeRay.rayId / 100)
							local y = math.floor(nodeRay.rayId % 100)

							self:fillNodeRay(nodeDict[y][x], nodeRay.rayType, nodeRay.rayDir, true, nodeRay.rayParent)
						end
					end

					if nodeDict[node.y][node.x - 1] then
						local nodeRay = nodeDict[node.y][node.x - 1]:getNodeRay()

						if nodeRay and nodeRay.rayDir == WuErLiXiEnum.Dir.Right then
							local x = math.floor(nodeRay.rayId / 100)
							local y = math.floor(nodeRay.rayId % 100)

							self:fillNodeRay(nodeDict[y][x], nodeRay.rayType, nodeRay.rayDir, true, nodeRay.rayParent)
						end
					end
				else
					local nodeRay = node:getNodeRay()

					if nodeRay then
						self:clearNodesRay(node, nodeRay.rayId, nodeRay.rayDir, false)
					end
				end
			end
		end
	end
end

function WuErLiXiMapModel:clearNodesRay(nodeMo, rayId, rayDir, notClearCur)
	local nodeDict = self:getMapNodes()
	local lineCount = self:getMapLineCount()
	local rowCount = self:getMapRowCount()
	local clearNodeRay = nodeMo:getNodeRay()
	local offsetValue = notClearCur and 1 or 0

	if rayDir == WuErLiXiEnum.Dir.Up then
		if nodeMo.y - offsetValue >= 1 then
			for i = nodeMo.y - offsetValue, 1, -1 do
				local nodeUnit = nodeDict[i][nodeMo.x]:getNodeUnit()
				local nodeRay = nodeDict[i][nodeMo.x]:getNodeRay()

				if nodeUnit then
					if nodeUnit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						nodeDict[i][nodeMo.x]:clearNodeRay(rayId)
						self:setUnitActive(nodeDict[i][nodeMo.x], false)

						return
					end

					if clearNodeRay then
						if clearNodeRay.rayType == WuErLiXiEnum.RayType.SwitchSignal and (nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key) then
							self:setUnitActive(nodeDict[i][nodeMo.x], false)
							self:setSwitchActive(nodeUnit.id, false)
						end
					elseif nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key then
						self:setUnitActive(nodeDict[i][nodeMo.x], false)
						self:setSwitchActive(nodeUnit.id, false)
					end

					if nodeRay and nodeRay.rayId == rayId then
						local signals = nodeUnit:getUnitSignals(rayDir)

						for _, signal in pairs(signals) do
							self:clearNodesRay(nodeDict[i][signal[1]], nodeDict[i][signal[1]].id, nodeUnit:getUnitSignalOutDir(), true)
						end
					end
				end

				nodeDict[i][nodeMo.x]:clearNodeRay(rayId)
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Down then
		if lineCount >= nodeMo.y + offsetValue then
			for i = nodeMo.y + offsetValue, lineCount do
				local nodeUnit = nodeDict[i][nodeMo.x]:getNodeUnit()
				local nodeRay = nodeDict[i][nodeMo.x]:getNodeRay()

				if nodeUnit then
					if nodeUnit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						nodeDict[i][nodeMo.x]:clearNodeRay(rayId)
						self:setUnitActive(nodeDict[i][nodeMo.x], false)

						return
					end

					if clearNodeRay then
						if clearNodeRay.rayType == WuErLiXiEnum.RayType.SwitchSignal and (nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key) then
							self:setUnitActive(nodeDict[i][nodeMo.x], false)
							self:setSwitchActive(nodeUnit.id, false)
						end
					elseif nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key then
						self:setUnitActive(nodeDict[i][nodeMo.x], false)
						self:setSwitchActive(nodeUnit.id, false)
					end

					if nodeRay and nodeRay.rayId == rayId then
						local signals = nodeUnit:getUnitSignals(rayDir)

						for _, signal in pairs(signals) do
							self:clearNodesRay(nodeDict[i][signal[1]], nodeDict[i][signal[1]].id, nodeUnit:getUnitSignalOutDir(), true)
						end
					end
				end

				nodeDict[i][nodeMo.x]:clearNodeRay(rayId)
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Left then
		if nodeMo.x - offsetValue >= 1 then
			for i = nodeMo.x - offsetValue, 1, -1 do
				local nodeUnit = nodeDict[nodeMo.y][i]:getNodeUnit()
				local nodeRay = nodeDict[nodeMo.y][i]:getNodeRay()

				if nodeUnit then
					if nodeUnit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						nodeDict[nodeMo.y][i]:clearNodeRay(rayId)
						self:setUnitActive(nodeDict[nodeMo.y][i], false)

						return
					end

					if clearNodeRay then
						if clearNodeRay.rayType == WuErLiXiEnum.RayType.SwitchSignal and (nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key) then
							self:setUnitActive(nodeDict[nodeMo.y][i], false)
							self:setSwitchActive(nodeUnit.id, false)
						end
					elseif nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key then
						self:setUnitActive(nodeDict[nodeMo.y][i], false)
						self:setSwitchActive(nodeUnit.id, false)
					end

					if nodeRay and nodeRay.rayId == rayId then
						local signals = nodeUnit:getUnitSignals(rayDir)

						for _, signal in pairs(signals) do
							self:clearNodesRay(nodeDict[signal[2]][i], nodeDict[signal[2]][i].id, nodeUnit:getUnitSignalOutDir(), true)
						end
					end
				end

				nodeDict[nodeMo.y][i]:clearNodeRay(rayId)
			end
		end
	elseif rayDir == WuErLiXiEnum.Dir.Right and rowCount >= nodeMo.x + offsetValue then
		for i = nodeMo.x + offsetValue, rowCount do
			local nodeUnit = nodeDict[nodeMo.y][i]:getNodeUnit()
			local nodeRay = nodeDict[nodeMo.y][i]:getNodeRay()

			if nodeUnit then
				if nodeUnit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
					nodeDict[nodeMo.y][i]:clearNodeRay(rayId)
					self:setUnitActive(nodeDict[nodeMo.y][i], false)

					return
				end

				if clearNodeRay then
					if clearNodeRay.rayType == WuErLiXiEnum.RayType.SwitchSignal and (nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key) then
						self:setUnitActive(nodeDict[nodeMo.y][i], false)
						self:setSwitchActive(nodeUnit.id, false)
					end
				elseif nodeUnit.unitType == WuErLiXiEnum.UnitType.Switch or nodeUnit.unitType == WuErLiXiEnum.UnitType.Key then
					self:setUnitActive(nodeDict[nodeMo.y][i], false)
					self:setSwitchActive(nodeUnit.id, false)
				end

				if nodeRay and nodeRay.rayId == rayId then
					local signals = nodeUnit:getUnitSignals(rayDir)

					for _, signal in pairs(signals) do
						self:clearNodesRay(nodeDict[signal[2]][i], nodeDict[signal[2]][i].id, nodeUnit:getUnitSignalOutDir(), true)
					end
				end
			end

			nodeDict[nodeMo.y][i]:clearNodeRay(rayId)
		end
	end
end

function WuErLiXiMapModel:getMapRays(mapId)
	self._signalDict = {}

	local nodeDict = self:getMapNodes(mapId)
	local lineCount = self:getMapLineCount(mapId)
	local rowCount = self:getMapRowCount(mapId)

	local function getSignalRays(signalNodeMo, type, inDir)
		local unitMo = signalNodeMo:getNodeUnit()

		if not unitMo then
			return
		end

		local outDir = signalNodeMo:getUnitSignalOutDir()

		if not outDir then
			return
		end

		if outDir == WuErLiXiEnum.Dir.Up then
			local signals = unitMo:getUnitSignals(inDir)

			for _, signal in pairs(signals) do
				if signal[2] > 1 then
					for i = signal[2] - 1, 1, -1 do
						local rayId = nodeDict[signal[2]][signal[1]].id
						local curUnitMo = nodeDict[i][signal[1]]:getNodeUnit()

						if curUnitMo then
							if #curUnitMo:getUnitSignals(unitMo:getUnitSignalOutDir()) > 0 then
								local key = signal[1] .. "_" .. i

								if self._signalDict[key] then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i + 1][signal[1]])

									break
								end

								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i][signal[1]])
								getSignalRays(nodeDict[i][signal[1]], type, outDir)

								break
							elseif curUnitMo:isUnitActive(unitMo:getUnitSignalOutDir()) then
								if not curUnitMo:isIgnoreSignal() then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i][signal[1]])

									break
								end
							else
								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i + 1][signal[1]])

								break
							end
						end

						local curRay = nodeDict[i][signal[1]]:getNodeRay()

						if not curRay or curRay.rayId ~= rayId or curRay.rayType ~= type then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i + 1][signal[1]])

							break
						end

						if i == 1 then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[1][signal[1]])
						end
					end
				end
			end
		elseif unitMo.outDir == WuErLiXiEnum.Dir.Down then
			local signals = unitMo:getUnitSignals(inDir)

			for _, signal in pairs(signals) do
				if signal[2] < lineCount then
					for i = signal[2] + 1, lineCount do
						local rayId = nodeDict[signal[2]][signal[1]].id
						local curUnitMo = nodeDict[i][signal[1]]:getNodeUnit()

						if curUnitMo then
							if #curUnitMo:getUnitSignals(unitMo:getUnitSignalOutDir()) > 0 then
								local key = signal[1] .. "_" .. i

								if self._signalDict[key] then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i - 1][signal[1]])

									break
								end

								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i][signal[1]])
								getSignalRays(nodeDict[i][signal[1]], type, outDir)

								break
							elseif curUnitMo:isUnitActive(unitMo:getUnitSignalOutDir()) then
								if not curUnitMo:isIgnoreSignal() then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i][signal[1]])

									break
								end
							else
								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i - 1][signal[1]])

								break
							end
						end

						local curRay = nodeDict[i][signal[1]]:getNodeRay()

						if not curRay or curRay.rayId ~= rayId or curRay.rayType ~= type then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[i - 1][signal[1]])

							break
						end

						if i == lineCount then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[lineCount][signal[1]])
						end
					end
				end
			end
		elseif unitMo.outDir == WuErLiXiEnum.Dir.Left then
			local signals = unitMo:getUnitSignals(inDir)

			for _, signal in pairs(signals) do
				if signal[1] > 1 then
					for i = signal[1] - 1, 1, -1 do
						local rayId = nodeDict[signal[2]][signal[1]].id
						local curUnitMo = nodeDict[signal[2]][i]:getNodeUnit()

						if curUnitMo then
							if #curUnitMo:getUnitSignals(unitMo:getUnitSignalOutDir()) > 0 then
								local key = i .. "_" .. signal[2]

								if self._signalDict[key] then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i + 1])

									break
								end

								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i])
								getSignalRays(nodeDict[signal[2]][i], type, outDir)

								break
							elseif curUnitMo:isUnitActive(unitMo:getUnitSignalOutDir()) then
								if not curUnitMo:isIgnoreSignal() then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i])

									break
								end
							else
								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i + 1])

								break
							end
						end

						local curRay = nodeDict[signal[2]][i]:getNodeRay()

						if not curRay or curRay.rayId ~= rayId or curRay.rayType ~= type then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i + 1])

							break
						end

						if i == 1 then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][1])
						end
					end
				end
			end
		elseif unitMo.outDir == WuErLiXiEnum.Dir.Right then
			local signals = unitMo:getUnitSignals(inDir)

			for _, signal in pairs(signals) do
				if signal[1] < rowCount then
					for i = signal[1] + 1, rowCount do
						local rayId = nodeDict[signal[2]][signal[1]].id
						local curUnitMo = nodeDict[signal[2]][i]:getNodeUnit()

						if curUnitMo then
							if #curUnitMo:getUnitSignals(unitMo:getUnitSignalOutDir()) > 0 then
								local key = i .. "_" .. signal[2]

								if self._signalDict[key] then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i - 1])

									break
								end

								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i])
								getSignalRays(nodeDict[signal[2]][i], type, outDir)

								break
							elseif curUnitMo:isUnitActive(unitMo:getUnitSignalOutDir()) then
								if not curUnitMo:isIgnoreSignal() then
									self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i])

									break
								end
							else
								self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i - 1])

								break
							end
						end

						local curRay = nodeDict[signal[2]][i]:getNodeRay()

						if not curRay or curRay.rayId ~= rayId or curRay.rayType ~= type then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][i - 1])

							break
						end

						if i == rowCount then
							self:_addRayDict(rayId, type, outDir, nodeDict[signal[2]][signal[1]], nodeDict[signal[2]][rowCount])
						end
					end
				end
			end
		end
	end

	for x = 1, rowCount do
		for y = 1, lineCount do
			local unitMo = nodeDict[y][x]:getNodeUnit()

			if unitMo then
				if unitMo.unitType == WuErLiXiEnum.UnitType.SignalStart then
					getSignalRays(nodeDict[y][x], WuErLiXiEnum.RayType.NormalSignal)
				elseif unitMo.unitType == WuErLiXiEnum.UnitType.KeyStart then
					getSignalRays(nodeDict[y][x], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end

	return self._signalDict
end

function WuErLiXiMapModel:_addRayDict(rayId, rayType, rayDir, startNodeMo, endNodeMo)
	local key = startNodeMo.x .. "_" .. startNodeMo.y

	if startNodeMo.x == endNodeMo.x and startNodeMo.y == endNodeMo.y then
		self._signalDict[key] = nil

		return
	end

	if not self._signalDict[key] then
		self._signalDict[key] = WuErLiXiMapSignalItemMo.New()

		self._signalDict[key]:init(rayId, rayType, rayDir, startNodeMo, endNodeMo)
	else
		self._signalDict[key]:reset(rayId, rayType, rayDir, endNodeMo)
	end
end

function WuErLiXiMapModel:isKeyActiveSelf(unitId, nodeMo)
	local nodeDict = self:getMapNodes()
	local rayMo = nodeMo:getNodeRay()

	if rayMo then
		local hasInteractActive = self:hasInteractActive(unitId, nodeMo)

		if hasInteractActive then
			return true
		end

		local startX = math.floor(rayMo.rayId / 100)
		local startY = rayMo.rayId % 100
		local hasKeyUnit = self:isHasIngnoreUnit(nodeDict[startY][startX], nodeMo, unitId)

		if hasKeyUnit then
			return true
		elseif rayMo.rayParent and rayMo.rayParent > 0 then
			local startPX = math.floor(rayMo.rayParent / 100)
			local startPY = rayMo.rayParent % 100
			local unitMo = nodeDict[startY][startX]:getNodeUnit()
			local endPMo = nodeDict[unitMo.y][unitMo.x]

			return self:isHasIngnoreUnit(nodeDict[startPY][startPX], endPMo, unitId)
		end
	end

	return false
end

function WuErLiXiMapModel:hasInteractActive(unitId, nodeMo)
	local rayMo = nodeMo:getNodeRay()

	if not rayMo then
		return false
	end

	local nodeDict = self:getMapNodes()
	local startX = math.floor(rayMo.rayId / 100)
	local startY = rayMo.rayId % 100
	local ignoreUnits = self:getIgnoreUnits(nodeDict[startY][startX], nodeMo)

	for _, ignoreUnit in pairs(ignoreUnits) do
		local node = self:getKeyNodeByUnitId(ignoreUnit)
		local interactRayMo = node:getNodeRay()

		if not interactRayMo then
			return false
		end

		local startInteractX = math.floor(interactRayMo.rayId / 100)
		local startInteractY = interactRayMo.rayId % 100
		local interactIgnoreUnits = self:getIgnoreUnits(nodeDict[startInteractY][startInteractX], node)

		for _, id in pairs(interactIgnoreUnits) do
			if id == unitId then
				return true
			end
		end
	end

	return false
end

function WuErLiXiMapModel:getKeyNodeByUnitId(unitId)
	local nodeDict = self:getMapNodes()

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()

			if nodeUnit and nodeUnit.unitType == WuErLiXiEnum.UnitType.Key and nodeUnit.id == unitId then
				return node
			end
		end
	end
end

function WuErLiXiMapModel:isKeyActive(unitId)
	local nodeDict = self:getMapNodes()

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()

			if nodeUnit and nodeUnit.unitType == WuErLiXiEnum.UnitType.Key and nodeUnit.id == unitId then
				return nodeUnit.isActive
			end
		end
	end

	return false
end

function WuErLiXiMapModel:getIgnoreUnits(startNode, endNode)
	local units = {}
	local nodeDict = self:getMapNodes()

	local function getIgnores(sNode, eNode)
		if sNode.x == eNode.x then
			if eNode.y > sNode.y then
				for i = sNode.y + 1, eNode.y - 1 do
					local unitMo = nodeDict[i][sNode.x]:getNodeUnit()

					if unitMo then
						table.insert(units, unitMo.id)
					end
				end

				local unitPMo = sNode:getNodeUnit()
				local endPMo = nodeDict[unitPMo.y][unitPMo.x]
				local rayMo = endPMo:getNodeRay()

				if unitPMo and rayMo and rayMo.rayId and rayMo.rayId > 0 then
					local startPX = math.floor(rayMo.rayId / 100)
					local startPY = rayMo.rayId % 100

					getIgnores(nodeDict[startPY][startPX], endPMo)
				end
			elseif eNode.y < sNode.y then
				for i = sNode.y - 1, eNode.y + 1, -1 do
					local unitMo = nodeDict[i][sNode.x]:getNodeUnit()

					if unitMo then
						table.insert(units, unitMo.id)
					end
				end

				local unitPMo = sNode:getNodeUnit()
				local endPMo = nodeDict[unitPMo.y][unitPMo.x]
				local rayMo = endPMo:getNodeRay()

				if unitPMo and rayMo and rayMo.rayId and rayMo.rayId > 0 then
					local startPX = math.floor(rayMo.rayId / 100)
					local startPY = rayMo.rayId % 100

					getIgnores(nodeDict[startPY][startPX], endPMo)
				end
			end
		elseif sNode.y == eNode.y then
			if eNode.x > sNode.x then
				for i = sNode.x + 1, eNode.x - 1 do
					local unitMo = nodeDict[sNode.y][i]:getNodeUnit()

					if unitMo then
						table.insert(units, unitMo.id)
					end
				end

				local unitPMo = sNode:getNodeUnit()
				local endPMo = nodeDict[unitPMo.y][unitPMo.x]
				local rayMo = endPMo:getNodeRay()

				if unitPMo and rayMo and rayMo.rayId and rayMo.rayId > 0 then
					local startPX = math.floor(rayMo.rayId / 100)
					local startPY = rayMo.rayId % 100

					getIgnores(nodeDict[startPY][startPX], endPMo)
				end
			elseif eNode.x < sNode.x then
				for i = sNode.x - 1, eNode.x + 1, -1 do
					local unitMo = nodeDict[sNode.y][i]:getNodeUnit()

					if unitMo then
						table.insert(units, unitMo.id)
					end
				end

				local unitPMo = sNode:getNodeUnit()
				local endPMo = nodeDict[unitPMo.y][unitPMo.x]
				local rayMo = endPMo:getNodeRay()

				if unitPMo and rayMo and rayMo.rayId and rayMo.rayId > 0 then
					local startPX = math.floor(rayMo.rayId / 100)
					local startPY = rayMo.rayId % 100

					getIgnores(nodeDict[startPY][startPX], endPMo)
				end
			end
		end
	end

	getIgnores(startNode, endNode)

	return units
end

function WuErLiXiMapModel:isHasIngnoreUnit(startNode, endNode, unitId)
	local nodeDict = self:getMapNodes()

	if startNode.x == endNode.x then
		if endNode.y > startNode.y then
			for i = startNode.y, endNode.y - 1 do
				local unitMo = nodeDict[i][startNode.x]:getNodeUnit()

				if unitMo and unitMo.id == unitId then
					return true
				end
			end
		elseif endNode.y < startNode.y then
			for i = startNode.y, endNode.y + 1, -1 do
				local unitMo = nodeDict[i][startNode.x]:getNodeUnit()

				if unitMo and unitMo.id == unitId then
					return true
				end
			end
		end
	elseif startNode.y == endNode.y then
		if endNode.x > startNode.x then
			for i = startNode.x, endNode.x - 1 do
				local unitMo = nodeDict[startNode.y][i]:getNodeUnit()

				if unitMo and unitMo.id == unitId then
					return true
				end
			end
		elseif endNode.x < startNode.x then
			for i = startNode.x, endNode.x + 1, -1 do
				local unitMo = nodeDict[startNode.y][i]:getNodeUnit()

				if unitMo and unitMo.id == unitId then
					return true
				end
			end
		end
	end

	return false
end

function WuErLiXiMapModel:isNodeHasUnit(nodeMo)
	local unitMo = nodeMo:getNodeUnit()

	if unitMo then
		return true
	end

	return false
end

function WuErLiXiMapModel:isNodeHasInitUnit(nodeMo)
	local unitMo = nodeMo:getNodeUnit()

	if unitMo then
		return nodeMo.initUnit > 0
	end

	return false
end

function WuErLiXiMapModel:isAllSignalEndActive(mapId)
	mapId = mapId or self._curMapId

	local nodeDict = self:getMapNodes(mapId)

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()
			local nodeRay = node:getNodeRay()

			if nodeUnit and nodeUnit.unitType == WuErLiXiEnum.UnitType.SignalEnd and (not nodeUnit.isActive or not nodeRay) then
				return false
			end
		end
	end

	return true
end

function WuErLiXiMapModel:getLimitSelectUnitCount(actUnitMo)
	local count = actUnitMo.count
	local nodeDict = self:getMapNodes(self._curMapId)

	for _, nodes in pairs(nodeDict) do
		for _, node in pairs(nodes) do
			if node.initUnit == 0 and node.unit and node.unit.id == actUnitMo.id and node.x == node.unit.x and node.y == node.unit.y then
				count = count - 1
			end
		end
	end

	return count
end

function WuErLiXiMapModel:getKeyAndSwitchTagById(id)
	local mapMo = self:getMap(self._curMapId)
	local tag = {
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"B",
		"Q",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z"
	}
	local ids = {}

	for _, nodes in pairs(mapMo.nodeDict) do
		for _, node in pairs(nodes) do
			if node.unit and (node.unit.unitType == WuErLiXiEnum.UnitType.Key or node.unit.unitType == WuErLiXiEnum.UnitType.Switch) then
				ids[node.unit.id] = node.unit.id
			end
		end
	end

	for _, actUnit in pairs(mapMo.actUnitDict) do
		if actUnit.type == WuErLiXiEnum.UnitType.Key or actUnit.type == WuErLiXiEnum.UnitType.Switch then
			ids[actUnit.id] = actUnit.id
		end
	end

	local results = {}

	for _, result in pairs(ids) do
		table.insert(results, result)
	end

	table.sort(results)

	local index = 0

	for k, v in ipairs(results) do
		if v == id then
			index = k
		end
	end

	return index == 0 and "" or tag[index]
end

function WuErLiXiMapModel:isUnitActive(unitId)
	local mapMo = self:getMap(self._curMapId)

	for _, nodes in pairs(mapMo.nodeDict) do
		for _, node in pairs(nodes) do
			if node.unit and node.unit.id == unitId then
				return node.unit.isActive
			end
		end
	end

	return false
end

function WuErLiXiMapModel:isSetDirEnable(unitType, dir, x, y)
	local nodeDict = self:getMapNodes()
	local lineCount = self:getMapLineCount()
	local rowCount = self:getMapRowCount()

	if unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if dir == WuErLiXiEnum.Dir.Up or dir == WuErLiXiEnum.Dir.Down then
			if x <= 1 or rowCount <= x then
				return false
			end

			return not nodeDict[y][x - 1].unit and not nodeDict[y][x - 1].unit
		else
			if y <= 1 or lineCount <= y then
				return false
			end

			return not nodeDict[y - 1][x].unit and not nodeDict[y + 1][x].unit
		end
	end

	return true
end

function WuErLiXiMapModel:setCurSelectUnit(x, y)
	self._curSelectNode = {
		x,
		y
	}
end

function WuErLiXiMapModel:getCurSelectUnit()
	return self._curSelectNode
end

function WuErLiXiMapModel:clearSelectUnit()
	self._curSelectNode = {}
end

function WuErLiXiMapModel:getUnlockElements()
	local elements = {}
	local tipCos = WuErLiXiConfig.instance:getElementList()

	for _, v in ipairs(tipCos) do
		if v.episodeId == 0 or WuErLiXiModel.instance:isEpisodeUnlock(v.episodeId) then
			table.insert(elements, v)
		end
	end

	table.sort(elements, function(a, b)
		return a.sequence < b.sequence
	end)

	return elements
end

function WuErLiXiMapModel:hasElementNew()
	local unlockElements = self:getUnlockElements()

	return #unlockElements > #self._unlockElements
end

function WuErLiXiMapModel:setReadNewElement()
	self._unlockElements = {}

	local elements = self:getUnlockElements()
	local elementStr = ""

	if #elements > 0 then
		elementStr = tostring(elements[1].id)

		table.insert(self._unlockElements, elements[1].id)

		if #elements > 1 then
			for i = 1, #elements do
				elementStr = elementStr .. "#" .. elements[i].id

				table.insert(self._unlockElements, elements[i].id)
			end
		end
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, elementStr)
end

function WuErLiXiMapModel:setMapStartTime()
	self._mapStartTime = ServerTime.now()
end

function WuErLiXiMapModel:getMapStartTime()
	return self._mapStartTime
end

function WuErLiXiMapModel:clearOperations()
	self._operations = {}
end

function WuErLiXiMapModel:addOperation(unitId, unitType, startX, startY, endX, endY)
	local lastOperTime = self:getMapStartTime()

	for _, operation in ipairs(self._operations) do
		lastOperTime = operation.secs + lastOperTime
	end

	local operation = {}

	operation.step = #self._operations + 1
	operation.secs = ServerTime.now() - lastOperTime
	operation.id = unitId
	operation.type = unitType
	operation.from_x = tostring(startX)
	operation.from_y = tostring(startY)
	operation.to_x = tostring(endX)
	operation.to_y = tostring(endY)

	table.insert(self._operations, operation)
end

function WuErLiXiMapModel:getStatOperationInfos()
	return self._operations
end

function WuErLiXiMapModel:getStatMapInfos()
	local nodeDicts = self:getMapNodes()
	local infos = {}

	for _, nodes in pairs(nodeDicts) do
		for _, node in pairs(nodes) do
			local nodeUnit = node:getNodeUnit()

			if nodeUnit then
				local info = {}

				info.id = nodeUnit.id
				info.x = node.x
				info.y = node.y
				info.type = nodeUnit.unitType
				info.dir = nodeUnit.dir

				table.insert(infos, info)
			end
		end
	end

	return infos
end

WuErLiXiMapModel.instance = WuErLiXiMapModel.New()

return WuErLiXiMapModel
