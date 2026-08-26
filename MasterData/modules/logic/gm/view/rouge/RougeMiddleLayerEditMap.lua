-- chunkname: @modules/logic/gm/view/rouge/RougeMiddleLayerEditMap.lua

module("modules.logic.gm.view.rouge.RougeMiddleLayerEditMap", package.seeall)

local RougeMiddleLayerEditMap = class("RougeMiddleLayerEditMap", RougeBaseMap)

function RougeMiddleLayerEditMap:init(mapGo)
	RougeMiddleLayerEditMap.super.init(self, mapGo)

	self.tempVector1 = Vector3.New(0, 0, 0)
	self.tempVector2 = Vector3.New(0, 0, 0)

	self:initReflection()
end

function RougeMiddleLayerEditMap:initReflection()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype("UnityEngine.LineRenderer")

	self.lineCompProperty = tolua.getproperty(type, "positionCount")
	self.lineCompMethod = tolua.getmethod(type, "SetPosition", typeof("System.Int32"), typeof(Vector3))
end

function RougeMiddleLayerEditMap:initMap()
	RougeMiddleLayerEditMap.super.initMap(self)

	local mapSize = RougeMapModel.instance:getMapSize()

	RougeMapModel.instance:setCameraSize(mapSize.y / 2)
	transformhelper.setLocalPos(self.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
end

function RougeMiddleLayerEditMap:createMapNodeContainer()
	self.layerPointContainer = gohelper.create3d(self.mapGo, "layerPointContainer")
	self.goLayerLinePathContainer = gohelper.create3d(self.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(self.layerPointContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(self.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)
	RougeMiddleLayerEditMap.super.createMapNodeContainer(self)
end

function RougeMiddleLayerEditMap:handleOtherRes(loader)
	local nodePrefab = loader:getAssetItem(RougeMapEnum.RedNodeResPath):GetResource()
	local greenPointPrefab = loader:getAssetItem(RougeMapEnum.GreenNodeResPath):GetResource()

	self.linePrefab = loader:getAssetItem(RougeMapEnum.LineResPath):GetResource()
	self.pointPrefab = nodePrefab
	self.pathPointPrefab = greenPointPrefab
	self.leavePrefab = loader:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
end

function RougeMiddleLayerEditMap:createMap()
	self:initPoints()
	self:initPathPoints()
	self:initLeavePoint()
	self:initLines()
	self:initMapLine()
end

function RougeMiddleLayerEditMap:initPoints()
	self.pointItemDict = {}

	local pointDict = RougeMapEditModel.instance:getPointsDict()

	for id, pos in pairs(pointDict) do
		self:createPoint(id, pos, RougeMapEnum.MiddleLayerPointType.Pieces)
	end
end

function RougeMiddleLayerEditMap:initPathPoints()
	self.pathPointItemDict = {}

	local pointDict = RougeMapEditModel.instance:getPathPointsDict()

	for id, pos in pairs(pointDict) do
		self:createPoint(id, pos, RougeMapEnum.MiddleLayerPointType.Path)
	end
end

function RougeMiddleLayerEditMap:initLeavePoint()
	local leavePos = RougeMapEditModel.instance:getLeavePos()

	if not leavePos then
		return
	end

	self:createLeavePoint(leavePos)
end

function RougeMiddleLayerEditMap:initLines()
	self.lineList = {}

	local lineList = RougeMapEditModel.instance:getLineList()

	for _, line in ipairs(lineList) do
		local lineItem = self:createLine(RougeMapEnum.MiddleLayerPointType.Path, line.startId, RougeMapEnum.MiddleLayerPointType.Path, line.endId, "path")

		table.insert(self.lineList, lineItem)
	end
end

function RougeMiddleLayerEditMap:initMapLine()
	self.mapLineList = {}

	local lineList = RougeMapEditModel.instance:getMapLineList()

	for _, line in ipairs(lineList) do
		local lineItem = self:createLine((line.startId == RougeMapEnum.LeaveId or nil) and RougeMapEnum.MiddleLayerPointType.Leave, line.startId, RougeMapEnum.MiddleLayerPointType.Path, line.endId, "map")

		table.insert(self.mapLineList, lineItem)
	end
end

function RougeMiddleLayerEditMap:createLeavePoint(pos)
	self.goLeave = self.goLeave or gohelper.clone(self.leavePrefab, self.layerPointContainer)
	self.trLeave = self.goLeave.transform

	gohelper.setActive(self.goLeave, true)
	transformhelper.setLocalPos(self.trLeave, pos.x, pos.y, 0)
	transformhelper.setLocalScale(self.trLeave, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function RougeMiddleLayerEditMap:createPoint(id, pos, type)
	local pointItem = self:getUserDataTb_()

	if type == RougeMapEnum.MiddleLayerPointType.Pieces then
		pointItem.go = gohelper.clone(self.pointPrefab, self.layerPointContainer)
		self.pointItemDict[id] = pointItem
	else
		pointItem.go = gohelper.clone(self.pathPointPrefab, self.layerPointContainer)
		self.pathPointItemDict[id] = pointItem
	end

	gohelper.setActive(pointItem.go, true)

	pointItem.go.name = string.format("%s_%s", type, id)
	pointItem.scenePos = pos
	pointItem.transform = pointItem.go.transform
	pointItem.id = id

	transformhelper.setLocalPos(pointItem.transform, pos.x, pos.y, 0)
	transformhelper.setLocalScale(pointItem.transform, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function RougeMiddleLayerEditMap:createLine(startType, startId, endType, endId, lineNamePre)
	local lineItem = self:getUserDataTb_()
	local name = string.format("%s___%s_%s", lineNamePre, startId, endId)
	local go = gohelper.clone(self.linePrefab, self.goLayerLinePathContainer, name)

	gohelper.setActive(go, true)

	lineItem.lineGo = go
	lineItem.startId = startId
	lineItem.endId = endId

	self:drawLineById(lineItem.lineGo, startType, startId, endType, endId)

	return lineItem
end

function RougeMiddleLayerEditMap:drawLineById(go, startType, startId, endType, endId)
	local pos1 = self:getPointPos(startType, startId)
	local pos2 = self:getPointPos(endType, endId)

	self:drawLine(go, pos1, pos2)
end

function RougeMiddleLayerEditMap:drawLine(go, startPos, endPos)
	self.tempVector1:Set(startPos.x, startPos.y, startPos.z)
	self.tempVector2:Set(endPos.x, endPos.y, endPos.z)

	local lineComp = go:GetComponent("LineRenderer")

	self.lineCompProperty:Set(lineComp, 2, nil)
	self.lineCompMethod:Call(lineComp, 0, self.tempVector1)
	self.lineCompMethod:Call(lineComp, 1, self.tempVector2)
end

function RougeMiddleLayerEditMap:getPointPos(type, id)
	if type == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif type == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(id)
	elseif type == RougeMapEnum.MiddleLayerPointType.Path then
		return RougeMapEditModel.instance:getPathPointPos(id)
	end
end

function RougeMiddleLayerEditMap:addPoint(scenePos)
	scenePos.z = 0

	local id = RougeMapEditModel.instance:addPoint(scenePos)

	self:createPoint(id, scenePos, RougeMapEnum.MiddleLayerPointType.Pieces)
end

function RougeMiddleLayerEditMap:addPathPoint(scenePos)
	scenePos.z = 0

	local id = RougeMapEditModel.instance:addPathPoint(scenePos)

	self:createPoint(id, scenePos, RougeMapEnum.MiddleLayerPointType.Path)
end

function RougeMiddleLayerEditMap:addLeavePoint(scenePos)
	local leavePos = RougeMapEditModel.instance:getLeavePos()

	if leavePos then
		GameFacade.showToastString("离开点只能有一个。")

		return
	end

	scenePos.z = 0

	RougeMapEditModel.instance:setLeavePoint(scenePos)
	self:createLeavePoint(scenePos)
end

function RougeMiddleLayerEditMap:deletePoint(type, id)
	if type == RougeMapEnum.MiddleLayerPointType.Leave then
		RougeMapEditModel.instance:deleteLeavePoint()
		gohelper.setActive(self.goLeave, false)

		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.startId == id then
				RougeMapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end

		return
	end

	local itemDict = type == RougeMapEnum.MiddleLayerPointType.Pieces and self.pointItemDict or self.pathPointItemDict
	local pointItem = itemDict[id]

	if not pointItem then
		return
	end

	RougeMapEditModel.instance:deletePoint(id, type)

	itemDict[id] = nil

	gohelper.destroy(pointItem.go)

	if type == RougeMapEnum.MiddleLayerPointType.Pieces then
		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.startId == id then
				RougeMapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end
	else
		for index = #self.lineList, 1, -1 do
			local line = self.lineList[index]

			if line.startId == id or line.endId == id then
				RougeMapEditModel.instance:removeLine(index)
				table.remove(self.lineList, index)
				gohelper.destroy(line.lineGo)
			end
		end

		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.endId == id then
				RougeMapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end
	end
end

function RougeMiddleLayerEditMap:setPointPos(id, type, x, y)
	local pointItem = type == RougeMapEnum.MiddleLayerPointType.Pieces and self.pointItemDict[id] or self.pathPointItemDict[id]

	if not pointItem then
		return
	end

	transformhelper.setLocalPos(pointItem.transform, x, y, 0)
	pointItem.scenePos:Set(x, y)

	if type == RougeMapEnum.MiddleLayerPointType.Pieces then
		for _, lineItem in ipairs(self.mapLineList) do
			if lineItem.startId == id then
				self:drawLineById(lineItem.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, lineItem.startId, RougeMapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end
	else
		for _, lineItem in ipairs(self.mapLineList) do
			if lineItem.endId == id then
				self:drawLineById(lineItem.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, lineItem.startId, RougeMapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end

		for _, lineItem in ipairs(self.lineList) do
			if lineItem.startId == id or lineItem.endId == id then
				self:drawLineById(lineItem.lineGo, RougeMapEnum.MiddleLayerPointType.Path, lineItem.startId, RougeMapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end
	end
end

function RougeMiddleLayerEditMap:createEditingLine(startId, type)
	local name = string.format("%s_%s_edit", type, startId)

	self.editLineGo = gohelper.clone(self.linePrefab, self.goLayerLinePathContainer, name)

	gohelper.setActive(self.editLineGo, true)

	self.startPos = self:getPos(startId, type)
end

function RougeMiddleLayerEditMap:getPos(id, type)
	if type == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif type == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(id)
	else
		return RougeMapEditModel.instance:getPathPointPos(id)
	end
end

function RougeMiddleLayerEditMap:exitEditLine()
	gohelper.destroy(self.editLineGo)

	self.editLineGo = nil
	self.startPos = nil
end

function RougeMiddleLayerEditMap:addLine(startType, startId, endType, endId)
	startType, startId, endType, endId = RougeMapHelper.formatLineParam(startType, startId, endType, endId)

	RougeMapEditModel.instance:addLine(startType, startId, endType, endId)

	local lineItem = self:getUserDataTb_()

	lineItem.lineGo = self.editLineGo
	lineItem.startId = startId
	lineItem.endId = endId

	local lineNamePre

	if startType == RougeMapEnum.MiddleLayerPointType.Pieces or startType == RougeMapEnum.MiddleLayerPointType.Leave then
		table.insert(self.mapLineList, lineItem)

		lineNamePre = "map"
	else
		table.insert(self.lineList, lineItem)

		lineNamePre = "path"
	end

	self.editLineGo.name = string.format("%s___%s_%s", lineNamePre, startId, endId)

	self:drawLineById(self.editLineGo, startType, startId, endType, endId)

	self.editLineGo = nil
end

function RougeMiddleLayerEditMap:updateDrawingLine(endPos)
	if not self.editLineGo then
		return
	end

	endPos.z = 0

	self:drawLine(self.editLineGo, self.startPos, endPos)
end

return RougeMiddleLayerEditMap
