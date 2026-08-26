-- chunkname: @modules/logic/explore/model/ExploreMapModel.lua

module("modules.logic.explore.model.ExploreMapModel", package.seeall)

local ExploreMapModel = class("ExploreMapModel", BaseModel)
local _NameToCls = {}

function ExploreMapModel:createUnitMO(data)
	local cls
	local unitType = data[2]

	if not _NameToCls[unitType] then
		if ExploreEnum.ItemTypeToName[unitType] then
			cls = _G[string.format("Explore%sUnitMO", ExploreEnum.ItemTypeToName[unitType])] or _G[string.format("Explore%sMO", ExploreEnum.ItemTypeToName[unitType])]
		end

		cls = cls or ExploreBaseUnitMO
		_NameToCls[unitType] = cls
	else
		cls = _NameToCls[unitType]
	end

	local mo = cls.New()

	mo:init(data)

	return mo
end

function ExploreMapModel:onInit()
	return
end

function ExploreMapModel:reInit()
	return
end

function ExploreMapModel:updatHeroPos(posx, posy, dir)
	self.posx = posx
	self.posy = posy
	self.dir = dir
end

function ExploreMapModel:getHeroPos()
	return self.posx or 0, self.posy or 0
end

function ExploreMapModel:getHeroDir()
	return self.dir or 0
end

function ExploreMapModel:initMapData(data, mapId)
	self._lightNodeDic = {}
	self._lightNodeShowDic = {}
	self._boundNodeShowDic = {}
	self._nodeDic = {}
	self._mapAreaDic = {}
	self._unitDic = {}
	self._areaUnitDic = {}
	self._mapIconDict = {}
	self._mapIconDictById = {}
	self.outLineCount = 0
	self.nowMapRotate = 0
	self._isShowReset = false

	local minX, maxX, minY, maxY

	for i, data in ipairs(data[1]) do
		local node = ExploreNode.New(data)

		minX = minX and math.min(minX, data[1]) or data[1]
		maxX = maxX and math.max(maxX, data[1]) or data[1]
		minY = minY and math.min(minY, data[2]) or data[2]
		maxY = maxY and math.max(maxY, data[2]) or data[2]
		self._nodeDic[node.walkableKey] = node
	end

	self.mapBound = Vector4(minX, maxX, minY, maxY)

	for i, v in ipairs(data) do
		if i > 1 then
			local areaMO = ExploreMapAreaMO.New()

			areaMO:init(v)

			self._mapAreaDic[areaMO.id] = areaMO
		end
	end

	if not self.moveNodes then
		local pattern = "(-?%d+)#(-?%d+)"

		for x, y in string.gmatch(self.moveNodes, pattern) do
			x = tonumber(x)
			y = tonumber(y)

			self:setNodeLightXY(x, y)
		end

		self:_checkNodeBound()

		for areaId, areaMO in pairs(self._mapAreaDic) do
			self:updateAreaInfo(areaMO)
		end
	end
end

function ExploreMapModel:updateAreaInfo(areaMO)
	for i, unitMO in ipairs(areaMO.unitList) do
		self:addUnitMO(unitMO)

		if unitMO.type == ExploreEnum.ItemType.Ice or unitMO.type == ExploreEnum.ItemType.Obstacle then
			local nodeKey = ExploreHelper.getKey(unitMO.nodePos)
			local node = self._nodeDic[nodeKey]

			if node then
				if unitMO.type == ExploreEnum.ItemType.Ice then
					node:setNodeType(ExploreEnum.NodeType.Ice)
				elseif unitMO.type == ExploreEnum.ItemType.Obstacle then
					node:setNodeType(ExploreEnum.NodeType.Obstacle)
				end
			end
		end
	end
end

function ExploreMapModel:setSmallMapIconById(id, nodeKey, icon)
	if self._mapIconDictById[id] == icon then
		return
	end

	self._mapIconDictById[id] = icon

	self:setSmallMapIcon(nodeKey, icon)
end

function ExploreMapModel:setSmallMapIcon(nodeKey, icon)
	if self._mapIconDict[nodeKey] == icon then
		return
	end

	self._mapIconDict[nodeKey] = icon

	ExploreController.instance:dispatchEvent(ExploreEvent.UnitOutlineChange, nodeKey)
end

function ExploreMapModel:getSmallMapIcon(nodeKey)
	return self._mapIconDict[nodeKey]
end

function ExploreMapModel:getNodeDic()
	return self._nodeDic
end

function ExploreMapModel:getNode(nodeKey)
	if not self._nodeDic then
		return
	end

	return self._nodeDic[nodeKey]
end

function ExploreMapModel:getNodeIsShow(nodeKey)
	return self._lightNodeShowDic[nodeKey] and self:getNodeIsOpen(nodeKey)
end

function ExploreMapModel:getNodeIsBound(nodeKey)
	return self:getNodeBoundType(nodeKey) and self:getNodeIsOpen(nodeKey)
end

function ExploreMapModel:getNodeBoundType(nodeKey)
	return self._boundNodeShowDic[nodeKey]
end

function ExploreMapModel:getNodeIsOpen(nodeKey)
	local node = self:getNode(nodeKey)

	if node and ExploreModel.instance:isAreaShow(node.areaId) then
		return true
	else
		return false
	end
end

function ExploreMapModel:getNodeCanWalk(nodeKey)
	local node = self:getNode(nodeKey)

	if node and ExploreModel.instance:isAreaShow(node.areaId) and node:isWalkable() then
		return true
	else
		return false
	end
end

function ExploreMapModel:setIsShowResetBtn(isShow)
	if self._isShowReset ~= isShow then
		self._isShowReset = isShow

		ExploreController.instance:dispatchEvent(ExploreEvent.ShowResetChange)

		if not isShow and ExploreModel.instance.isShowingResetBoxMessage then
			ExploreModel.instance.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function ExploreMapModel:getIsShowResetBtn()
	return self._isShowReset
end

function ExploreMapModel:updateNodeHeight(nodeKey, height)
	local node = self:getNode(nodeKey)

	if node then
		node.height = height
	end
end

function ExploreMapModel:updateNodeOpenKey(nodeKey, key, isOpen, dispatchEvent)
	local node = self:getNode(nodeKey)

	if node then
		local isWalkableOld = node:isWalkable()

		node:updateOpenKey(key, isOpen)

		local isWalkableNew = node:isWalkable()

		if dispatchEvent and isWalkableOld ~= isWalkableNew then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnNodeChange)
		end
	else
		logError("nodeKey not find:" .. nodeKey)
	end
end

function ExploreMapModel:updateNodeCanPassItem(nodeKey, canPass)
	local node = self:getNode(nodeKey)

	if node then
		node:setCanPassItem(canPass)
	else
		logError("nodeKey not find:" .. nodeKey)
	end
end

function ExploreMapModel:getUnitDic()
	return self._unitDic
end

function ExploreMapModel:getMapAreaDic()
	return self._mapAreaDic
end

function ExploreMapModel:getAreaAllUnit(areaId)
	local areaMO = self:getMapAreaMO(areaId)

	return (areaMO or nil) and (areaMO.unitList or {})
end

function ExploreMapModel:getMapAreaMO(areaId)
	return self._mapAreaDic[areaId]
end

function ExploreMapModel:addUnitMO(unitMO)
	self._unitDic[unitMO.id] = unitMO
end

function ExploreMapModel:getUnitMO(id)
	return self._unitDic[id]
end

function ExploreMapModel:removeUnit(id)
	return
end

function ExploreMapModel:getExploreProgress()
	local doneDic = {}
	local dic = {}
	local allNum = 0
	local doneNum = 0

	for type, v in pairs(ExploreEnum.ProgressType) do
		dic[type] = 0
		doneDic[type] = 0
	end

	for id, unitMO in pairs(self._unitDic) do
		local type = unitMO.type

		if ExploreEnum.ProgressType[type] then
			if unitMO:isInteractDone() then
				doneDic[type] = doneDic[type] + 1
				doneNum = doneNum + 1
			end

			dic[type] = dic[type] + 1
			allNum = allNum + 1
		end
	end

	return dic, doneDic, allNum, doneNum
end

function ExploreMapModel:setNodeLightXY(x, y, isCheckBound)
	local nodeKey = ExploreHelper.getKeyXY(x, y)

	if self._lightNodeDic[nodeKey] then
		return
	end

	self._lightNodeDic[nodeKey] = true

	for i = -4, 4 do
		for j = -4, 4 do
			local nodeKey2 = ExploreHelper.getKeyXY(x + i, y + j)

			self._boundNodeShowDic[nodeKey2] = nil
			self._lightNodeShowDic[nodeKey2] = true
		end
	end

	if isCheckBound then
		self:_checkNodeBound()
	end
end

function ExploreMapModel:_checkNodeBound()
	local isAddLightNode = false

	for nodeKey, node in pairs(self._nodeDic) do
		if not self._lightNodeShowDic[nodeKey] then
			local leftNode = ExploreHelper.getKeyXY(node.pos.x - 1, node.pos.y)
			local rightNode = ExploreHelper.getKeyXY(node.pos.x + 1, node.pos.y)
			local upNode = ExploreHelper.getKeyXY(node.pos.x, node.pos.y + 1)
			local downNode = ExploreHelper.getKeyXY(node.pos.x, node.pos.y - 1)
			local isLeftShow = self:getNodeIsShow(leftNode)
			local isRightShow = self:getNodeIsShow(rightNode)
			local isUpShow = self:getNodeIsShow(upNode)
			local isDownShow = self:getNodeIsShow(downNode)

			if isLeftShow and isRightShow or isUpShow and isDownShow then
				isAddLightNode = true
				self._lightNodeShowDic[nodeKey] = true
				self._boundNodeShowDic[nodeKey] = nil

				break
			elseif isLeftShow or isRightShow or isUpShow or isDownShow then
				self._boundNodeShowDic[nodeKey] = nil

				local type = 0

				if isLeftShow and isUpShow then
					type = 1
				elseif isLeftShow and isDownShow then
					type = 2
				elseif isRightShow and isUpShow then
					type = 3
				elseif isRightShow and isDownShow then
					type = 4
				elseif isLeftShow then
					type = 5
				elseif isRightShow then
					type = 6
				elseif isUpShow then
					type = 7
				elseif isDownShow then
					type = 8
				end

				self._boundNodeShowDic[nodeKey] = type
			end
		end
	end

	if isAddLightNode then
		self:_checkNodeBound()
	end
end

function ExploreMapModel:setNodeLight(pos)
	self:setNodeLightXY(pos.x, pos.y, true)
end

function ExploreMapModel:changeOutlineNum(num)
	self.outLineCount = self.outLineCount + num
	RenderPipelineSetting.selectedOutlineToggle = self.outLineCount > 0
end

function ExploreMapModel:clear()
	self._nodeDic = nil
	self._unitDic = nil
	self._mapAreaDic = nil
	self._lightNodeDic = nil
	self._lightNodeShowDic = nil
	self._boundNodeShowDic = nil
	self.moveNodes = nil
	self.outLineCount = 0
end

ExploreMapModel.instance = ExploreMapModel.New()

return ExploreMapModel
