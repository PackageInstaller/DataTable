-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_MiddleLayerEditMap.lua

module("modules.logic.gm.view.rouge2.Rouge2_MiddleLayerEditMap", package.seeall)

local Rouge2_MiddleLayerEditMap = class("Rouge2_MiddleLayerEditMap", Rouge2_BaseMap)

function Rouge2_MiddleLayerEditMap:init(mapGo)
	Rouge2_MiddleLayerEditMap.super.init(self, mapGo)

	self.tempVector1 = Vector3.New(0, 0, 0)
	self.tempVector2 = Vector3.New(0, 0, 0)

	self:initReflection()
end

function Rouge2_MiddleLayerEditMap:initReflection()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype("UnityEngine.LineRenderer")

	self.lineCompProperty = tolua.getproperty(type, "positionCount")
	self.lineCompMethod = tolua.getmethod(type, "SetPosition", typeof("System.Int32"), typeof(Vector3))
end

function Rouge2_MiddleLayerEditMap:initMap()
	Rouge2_MiddleLayerEditMap.super.initMap(self)

	local mapSize = Rouge2_MapModel.instance:getMapSize()

	Rouge2_MapModel.instance:setCameraSize(mapSize.y / 2)
	transformhelper.setLocalPos(self.mapTransform, 0, 0, Rouge2_MapEnum.OffsetZ.Map)
end

function Rouge2_MiddleLayerEditMap:createMapNodeContainer()
	self.layerPointContainer = gohelper.create3d(self.mapGo, "layerPointContainer")
	self.goLayerLinePathContainer = gohelper.create3d(self.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(self.layerPointContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(self.goLayerLinePathContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.PathContainer)
	Rouge2_MiddleLayerEditMap.super.createMapNodeContainer(self)
end

function Rouge2_MiddleLayerEditMap:handleOtherRes(loader)
	local nodePrefab = loader:getAssetItem(Rouge2_MapEnum.RedNodeResPath):GetResource()
	local greenPointPrefab = loader:getAssetItem(Rouge2_MapEnum.GreenNodeResPath):GetResource()

	self.linePrefab = loader:getAssetItem(Rouge2_MapEnum.LineResPath):GetResource()
	self.pointPrefab = nodePrefab
	self.pathPointPrefab = greenPointPrefab
end

function Rouge2_MiddleLayerEditMap:createMap()
	self:initPoints()
	self:initPathPoints()
	self:initLeavePoint()
	self:initLines()
	self:initMapLine()
end

function Rouge2_MiddleLayerEditMap:initPoints()
	self.pointItemDict = {}

	local pointDict = Rouge2_MapEditModel.instance:getPointsDict()

	for id, pos in pairs(pointDict) do
		self:createPoint(id, pos, Rouge2_MapEnum.MiddleLayerPointType.Pieces)
	end
end

function Rouge2_MiddleLayerEditMap:initPathPoints()
	self.pathPointItemDict = {}

	local pointDict = Rouge2_MapEditModel.instance:getPathPointsDict()

	for id, pos in pairs(pointDict) do
		self:createPoint(id, pos, Rouge2_MapEnum.MiddleLayerPointType.Path)
	end
end

function Rouge2_MiddleLayerEditMap:initLeavePoint()
	local leavePos = Rouge2_MapEditModel.instance:getLeavePos()

	if not leavePos then
		return
	end

	self:createLeavePoint(leavePos)
end

function Rouge2_MiddleLayerEditMap:initLines()
	self.lineList = {}

	local lineList = Rouge2_MapEditModel.instance:getLineList()

	for _, line in ipairs(lineList) do
		local lineItem = self:createLine(Rouge2_MapEnum.MiddleLayerPointType.Path, line.startId, Rouge2_MapEnum.MiddleLayerPointType.Path, line.endId, "path")

		table.insert(self.lineList, lineItem)
	end
end

function Rouge2_MiddleLayerEditMap:initMapLine()
	self.mapLineList = {}

	local lineList = Rouge2_MapEditModel.instance:getMapLineList()

	for _, line in ipairs(lineList) do
		local lineItem = self:createLine((line.startId == Rouge2_MapEnum.LeaveId or nil) and Rouge2_MapEnum.MiddleLayerPointType.Leave, line.startId, Rouge2_MapEnum.MiddleLayerPointType.Path, line.endId, "map")

		table.insert(self.mapLineList, lineItem)
	end
end

function Rouge2_MiddleLayerEditMap:createLeavePoint(pos)
	self.goLeave = self.goLeave or gohelper.create3d(self.layerPointContainer, "leave")
	self.trLeave = self.goLeave.transform

	gohelper.setActive(self.goLeave, true)
	transformhelper.setLocalPos(self.trLeave, pos.x, pos.y, 0)
	transformhelper.setLocalScale(self.trLeave, Rouge2_MapEditModel.Radius, Rouge2_MapEditModel.Radius, Rouge2_MapEditModel.Radius)
end

function Rouge2_MiddleLayerEditMap:createPoint(id, pos, type)
	local pointItem = self:getUserDataTb_()

	if type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
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
	transformhelper.setLocalScale(pointItem.transform, Rouge2_MapEditModel.Radius, Rouge2_MapEditModel.Radius, Rouge2_MapEditModel.Radius)
end

function Rouge2_MiddleLayerEditMap:createLine(startType, startId, endType, endId, lineNamePre)
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

function Rouge2_MiddleLayerEditMap:drawLineById(go, startType, startId, endType, endId)
	local pos1 = self:getPointPos(startType, startId)
	local pos2 = self:getPointPos(endType, endId)

	if not pos1 or not pos2 then
		logError("startId = " .. startId .. "endId = " .. endId)
	end

	self:drawLine(go, pos1, pos2)
end

function Rouge2_MiddleLayerEditMap:drawLine(go, startPos, endPos)
	self.tempVector1:Set(startPos.x, startPos.y, startPos.z)
	self.tempVector2:Set(endPos.x, endPos.y, endPos.z)

	local lineComp = go:GetComponent("LineRenderer")

	self.lineCompProperty:Set(lineComp, 2, nil)
	self.lineCompMethod:Call(lineComp, 0, self.tempVector1)
	self.lineCompMethod:Call(lineComp, 1, self.tempVector2)
end

function Rouge2_MiddleLayerEditMap:getPointPos(type, id)
	if type == Rouge2_MapEnum.MiddleLayerPointType.Leave then
		return Rouge2_MapEditModel.instance:getLeavePos()
	elseif type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
		return Rouge2_MapEditModel.instance:getPointPos(id)
	elseif type == Rouge2_MapEnum.MiddleLayerPointType.Path then
		return Rouge2_MapEditModel.instance:getPathPointPos(id)
	end
end

function Rouge2_MiddleLayerEditMap:addPoint(scenePos)
	scenePos.z = 0

	local id = Rouge2_MapEditModel.instance:addPoint(scenePos)

	self:createPoint(id, scenePos, Rouge2_MapEnum.MiddleLayerPointType.Pieces)
end

function Rouge2_MiddleLayerEditMap:addPathPoint(scenePos)
	scenePos.z = 0

	local id = Rouge2_MapEditModel.instance:addPathPoint(scenePos)

	self:createPoint(id, scenePos, Rouge2_MapEnum.MiddleLayerPointType.Path)
end

function Rouge2_MiddleLayerEditMap:addLeavePoint(scenePos)
	local leavePos = Rouge2_MapEditModel.instance:getLeavePos()

	if leavePos then
		GameFacade.showToastString("离开点只能有一个。")

		return
	end

	scenePos.z = 0

	Rouge2_MapEditModel.instance:setLeavePoint(scenePos)
	self:createLeavePoint(scenePos)
end

function Rouge2_MiddleLayerEditMap:deletePoint(type, id)
	if type == Rouge2_MapEnum.MiddleLayerPointType.Leave then
		Rouge2_MapEditModel.instance:deleteLeavePoint()
		gohelper.setActive(self.goLeave, false)

		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.startId == id then
				Rouge2_MapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end

		return
	end

	local itemDict = type == Rouge2_MapEnum.MiddleLayerPointType.Pieces and self.pointItemDict or self.pathPointItemDict
	local pointItem = itemDict[id]

	if not pointItem then
		return
	end

	Rouge2_MapEditModel.instance:deletePoint(id, type)

	itemDict[id] = nil

	gohelper.destroy(pointItem.go)

	if type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.startId == id then
				Rouge2_MapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end
	else
		for index = #self.lineList, 1, -1 do
			local line = self.lineList[index]

			if line.startId == id or line.endId == id then
				Rouge2_MapEditModel.instance:removeLine(index)
				table.remove(self.lineList, index)
				gohelper.destroy(line.lineGo)
			end
		end

		for index = #self.mapLineList, 1, -1 do
			local line = self.mapLineList[index]

			if line.endId == id then
				Rouge2_MapEditModel.instance:removeMapLine(index)
				table.remove(self.mapLineList, index)
				gohelper.destroy(line.lineGo)
			end
		end
	end
end

function Rouge2_MiddleLayerEditMap:setPointPos(id, type, x, y)
	local pointItem = type == Rouge2_MapEnum.MiddleLayerPointType.Pieces and self.pointItemDict[id] or self.pathPointItemDict[id]

	if not pointItem then
		return
	end

	transformhelper.setLocalPos(pointItem.transform, x, y, 0)
	pointItem.scenePos:Set(x, y)

	if type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
		for _, lineItem in ipairs(self.mapLineList) do
			if lineItem.startId == id then
				self:drawLineById(lineItem.lineGo, Rouge2_MapEnum.MiddleLayerPointType.Pieces, lineItem.startId, Rouge2_MapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end
	else
		for _, lineItem in ipairs(self.mapLineList) do
			if lineItem.endId == id then
				self:drawLineById(lineItem.lineGo, Rouge2_MapEnum.MiddleLayerPointType.Pieces, lineItem.startId, Rouge2_MapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end

		for _, lineItem in ipairs(self.lineList) do
			if lineItem.startId == id or lineItem.endId == id then
				self:drawLineById(lineItem.lineGo, Rouge2_MapEnum.MiddleLayerPointType.Path, lineItem.startId, Rouge2_MapEnum.MiddleLayerPointType.Path, lineItem.endId)
			end
		end
	end
end

function Rouge2_MiddleLayerEditMap:createEditingLine(startId, type)
	local name = string.format("%s_%s_edit", type, startId)

	self.editLineGo = gohelper.clone(self.linePrefab, self.goLayerLinePathContainer, name)

	gohelper.setActive(self.editLineGo, true)

	self.startPos = self:getPos(startId, type)
end

function Rouge2_MiddleLayerEditMap:getPos(id, type)
	if type == Rouge2_MapEnum.MiddleLayerPointType.Leave then
		return Rouge2_MapEditModel.instance:getLeavePos()
	elseif type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
		return Rouge2_MapEditModel.instance:getPointPos(id)
	else
		return Rouge2_MapEditModel.instance:getPathPointPos(id)
	end
end

function Rouge2_MiddleLayerEditMap:exitEditLine()
	gohelper.destroy(self.editLineGo)

	self.editLineGo = nil
	self.startPos = nil
end

function Rouge2_MiddleLayerEditMap:addLine(startType, startId, endType, endId)
	startType, startId, endType, endId = Rouge2_MapHelper.formatLineParam(startType, startId, endType, endId)

	Rouge2_MapEditModel.instance:addLine(startType, startId, endType, endId)

	local lineItem = self:getUserDataTb_()

	lineItem.lineGo = self.editLineGo
	lineItem.startId = startId
	lineItem.endId = endId

	local lineNamePre

	if startType == Rouge2_MapEnum.MiddleLayerPointType.Pieces or startType == Rouge2_MapEnum.MiddleLayerPointType.Leave then
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

function Rouge2_MiddleLayerEditMap:updateDrawingLine(endPos)
	if not self.editLineGo then
		return
	end

	endPos.z = 0

	self:drawLine(self.editLineGo, self.startPos, endPos)
end

return Rouge2_MiddleLayerEditMap
