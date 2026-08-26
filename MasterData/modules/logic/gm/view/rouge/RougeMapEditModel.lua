-- chunkname: @modules/logic/gm/view/rouge/RougeMapEditModel.lua

module("modules.logic.gm.view.rouge.RougeMapEditModel", package.seeall)

local RougeMapEditModel = class("RougeMapEditModel")

function RougeMapEditModel:init(middleLayerId)
	self.middleLayerId = middleLayerId
	self.middleLayerCo = RougeMapConfig.instance:getMiddleLayerCo(self.middleLayerId)
	self.idCounter = 0
	self.pathPointIdCounter = 0

	self:loadLayerCo()
end

function RougeMapEditModel:getMiddleLayerId()
	return self.middleLayerId
end

function RougeMapEditModel:loadLayerCo()
	self:loadPoints()
	self:loadPathPoints()
	self:loadPath()
	self:loadLeavePoint()
end

function RougeMapEditModel:getPointId()
	self.idCounter = self.idCounter + 1

	return self.idCounter
end

function RougeMapEditModel:getPathPointId()
	self.pathPointIdCounter = self.pathPointIdCounter + 1

	return self.pathPointIdCounter
end

function RougeMapEditModel:loadPoints()
	local pointList = self.middleLayerCo.pointPos

	self.pointDict = {}
	self.pointList = {}
	self.pointId2PathIdDict = {}

	for _, pointPos in ipairs(pointList) do
		local pos = Vector3.New(pointPos.x, pointPos.y, 0)
		local id = self:getPointId()

		self.pointDict[id] = pos

		table.insert(self.pointList, {
			id = id,
			pos = pos
		})

		self.pointId2PathIdDict[id] = pointPos.z
	end

	table.sort(self.pointList, function(a, b)
		return a.id < b.id
	end)
end

function RougeMapEditModel:loadPathPoints()
	local pointList = self.middleLayerCo.pathPointPos

	self.pathPointDict = {}
	self.pathPointList = {}

	for _, pointPos in ipairs(pointList) do
		local pos = Vector3.New(pointPos.x, pointPos.y, 0)
		local id = self:getPathPointId()

		self.pathPointDict[id] = pos

		table.insert(self.pathPointList, {
			id = id,
			pos = pos
		})
	end

	table.sort(self.pathPointList, function(a, b)
		return a.id < b.id
	end)
end

function RougeMapEditModel:loadPath()
	local pathList = self.middleLayerCo.path

	self.lineList = {}

	for _, path in ipairs(pathList) do
		table.insert(self.lineList, {
			startId = path.x,
			endId = path.y
		})
	end

	self.point2PathMapLineList = {}

	for pointId, pathPointId in pairs(self.pointId2PathIdDict) do
		table.insert(self.point2PathMapLineList, {
			startId = pointId,
			endId = pathPointId
		})
	end
end

function RougeMapEditModel:loadLeavePoint()
	local leavePos = self.middleLayerCo.leavePos

	if not leavePos then
		self:setLeavePoint(nil)

		return
	end

	local pos = Vector2(leavePos.x, leavePos.y)
	local pathId = leavePos.z

	self:setLeavePoint(pos)

	if not self.pathPointDict[pathId] then
		return
	end

	table.insert(self.point2PathMapLineList, {
		startId = RougeMapEnum.LeaveId,
		endId = pathId
	})

	self.pointId2PathIdDict[RougeMapEnum.LeaveId] = pathId
end

function RougeMapEditModel:addPoint(pos)
	local id = self:getPointId()

	self.pointDict[id] = pos

	table.insert(self.pointList, {
		id = id,
		pos = pos
	})
	table.sort(self.pointList, function(a, b)
		return a.id < b.id
	end)

	return id
end

function RougeMapEditModel:addPathPoint(pos)
	local id = self:getPathPointId()

	self.pathPointDict[id] = pos

	table.insert(self.pathPointList, {
		id = id,
		pos = pos
	})
	table.sort(self.pathPointList, function(a, b)
		return a.id < b.id
	end)

	return id
end

function RougeMapEditModel:setLeavePoint(pos)
	self.leavePos = pos
end

function RougeMapEditModel:getLeavePos()
	return self.leavePos
end

function RougeMapEditModel:deleteLeavePoint()
	self.leavePos = nil
	self.pointId2PathIdDict[RougeMapEnum.LeaveId] = nil
end

function RougeMapEditModel:deletePoint(id, type)
	if type == RougeMapEnum.MiddleLayerPointType.Pieces then
		self.pointDict[id] = nil

		local index = self:getPointIndex(id)

		if index then
			table.remove(self.pointList, index)
			table.sort(self.pointList, function(a, b)
				return a.id < b.id
			end)
		end

		self.pointId2PathIdDict[id] = nil

		return
	end

	self.pathPointDict[id] = nil

	local index = self:getPathPointIndex(id)

	if index then
		table.remove(self.pathPointList, index)
		table.sort(self.pathPointList, function(a, b)
			return a.id < b.id
		end)

		for pointId, pathId in pairs(self.pointId2PathIdDict) do
			if pathId == id then
				self.pointId2PathIdDict[pointId] = nil
			end
		end
	end
end

function RougeMapEditModel:addLine(startType, startId, endType, endId)
	if startType == RougeMapEnum.MiddleLayerPointType.Pieces or startType == RougeMapEnum.MiddleLayerPointType.Leave then
		self.pointId2PathIdDict[startId] = endId

		table.insert(self.point2PathMapLineList, {
			startId = startId,
			endId = endId
		})

		return
	end

	table.insert(self.lineList, {
		startId = startId,
		endId = endId
	})
end

function RougeMapEditModel:removeLine(index)
	table.remove(self.lineList, index)
end

function RougeMapEditModel:removeMapLine(index)
	table.remove(self.point2PathMapLineList, index)
end

function RougeMapEditModel:checkNeedRemoveMap(pointId, pathId, lineItem)
	local startType, startId = lineItem.startType, lineItem.startId
	local endType, endId = lineItem.endType, lineItem.endId

	if startType == RougeMapEnum.MiddleLayerPointType.Pieces and startId == pointId then
		return true
	end

	if startType == RougeMapEnum.MiddleLayerPointType.Path and startId == pathId then
		return true
	end

	if endType == RougeMapEnum.MiddleLayerPointType.Pieces and endId == pointId then
		return true
	end

	if endType == RougeMapEnum.MiddleLayerPointType.Path and endId == pathId then
		return true
	end
end

function RougeMapEditModel:getPointsDict()
	return self.pointDict
end

function RougeMapEditModel:getPointList()
	return self.pointList
end

function RougeMapEditModel:getPointMap()
	return self.pointId2PathIdDict
end

function RougeMapEditModel:getPathPointsDict()
	return self.pathPointDict
end

function RougeMapEditModel:getPathPointList()
	return self.pathPointList
end

function RougeMapEditModel:getLineList()
	return self.lineList
end

function RougeMapEditModel:getMapLineList()
	return self.point2PathMapLineList
end

function RougeMapEditModel:getPointPos(id)
	return self.pointDict[id]
end

function RougeMapEditModel:getPathPointPos(id)
	return self.pathPointDict[id]
end

RougeMapEditModel.PointTypeCanAddLineDict = {
	[RougeMapEnum.MiddleLayerPointType.Pieces] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"两个元件位置之间不能添加路径"
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false,
			"元件点和离开点不能添加路径"
		}
	},
	[RougeMapEnum.MiddleLayerPointType.Path] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false
		}
	},
	[RougeMapEnum.MiddleLayerPointType.Leave] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"元件点和离开点不能添加路径"
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false,
			"两个离开点之间不能添加路径"
		}
	}
}

function RougeMapEditModel:checkCanAddLine(startType, startId, endType, endId)
	local canAddLine = RougeMapEditModel.PointTypeCanAddLineDict

	if not canAddLine[1] then
		GameFacade.showToastString(canAddLine[1])

		return false
	end

	if startType == RougeMapEnum.MiddleLayerPointType.Leave or endId == RougeMapEnum.MiddleLayerPointType.Leave then
		if self.pointId2PathIdDict[RougeMapEnum.LeaveId] then
			GameFacade.showToastString("一个离开点只能映射一个路径点")

			return false
		end

		return false
	end

	for _, lineItem in ipairs(self.lineList) do
		if startType == lineItem.startType and startId == lineItem.startId and endType == lineItem.endType and endId == lineItem.endId or startType == lineItem.endType and startId == lineItem.endId and endType == lineItem.startType and endId == lineItem.startId then
			if startType == endType then
				GameFacade.showToastString("已添加路径")
			else
				GameFacade.showToastString("已添加映射")
			end

			return false
		end
	end

	startType, startId, endType, endId = RougeMapHelper.formatLineParam(startType, startId, endType, endId)

	if startType ~= endType and self.pointId2PathIdDict[startId] then
		GameFacade.showToastString("一个元件只能映射一个路径点")

		return
	end

	return true
end

RougeMapEditModel.Radius = 1

function RougeMapEditModel:getPointByPos(scenePos)
	for id, pos in pairs(self.pointDict) do
		if Vector2.Distance(pos, scenePos) <= RougeMapEditModel.Radius then
			return id, RougeMapEnum.MiddleLayerPointType.Pieces
		end
	end

	for id, pos in pairs(self.pathPointDict) do
		if Vector2.Distance(pos, scenePos) <= RougeMapEditModel.Radius then
			return id, RougeMapEnum.MiddleLayerPointType.Path
		end
	end

	if self.leavePos and Vector2.Distance(self.leavePos, scenePos) <= RougeMapEditModel.Radius then
		return RougeMapEnum.LeaveId, RougeMapEnum.MiddleLayerPointType.Leave
	end
end

function RougeMapEditModel:generateNodeConfig()
	local pointList = self.pointList

	if #pointList < 1 then
		GameFacade.showToastString("没有添加任何节点")

		return
	end

	local strList = {}

	for _, point in ipairs(pointList) do
		local pos = point.pos
		local pathPointId = self.pointId2PathIdDict[point.id]
		local pathPointIndex = self:getPathPointIndex(pathPointId)

		if pathPointIndex == nil then
			local message = string.format("节点id : %s 没有添加路径节点映射", point.id)

			GameFacade.showToastString(message)
			logError(message)

			return
		end

		table.insert(strList, string.format("%s#%s#%s", pos.x, pos.y, pathPointIndex))
	end

	if not self:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(strList, "|"))
	GameFacade.showToastString("生成节点配置成功")
end

function RougeMapEditModel:generatePathNodeConfig()
	local pointList = self.pathPointList

	if #pointList < 1 then
		GameFacade.showToastString("没有添加任何路径节点")

		return
	end

	if not self:checkNavigation() then
		return
	end

	local strList = {}

	for _, point in ipairs(pointList) do
		local pos = point.pos

		table.insert(strList, string.format("%s#%s", pos.x, pos.y))
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(strList, "|"))
	GameFacade.showToastString("生成路径节点配置成功")
end

function RougeMapEditModel:generateNodePath()
	if #self.lineList < 1 then
		GameFacade.showToastString("没有添加任何路径")

		return
	end

	local strList = {}

	for _, line in ipairs(self.lineList) do
		local s_index = self:getPathPointIndex(line.startId)
		local e_index = self:getPathPointIndex(line.endId)

		table.insert(strList, string.format("%s#%s", s_index, e_index))
	end

	if not self:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(strList, "|"))
	GameFacade.showToastString("生成路径配置成功")
end

function RougeMapEditModel:getPointIndex(id)
	for index, point in ipairs(self.pointList) do
		if point.id == id then
			return index
		end
	end
end

function RougeMapEditModel:getPathPointIndex(id)
	for index, point in ipairs(self.pathPointList) do
		if point.id == id then
			return index
		end
	end
end

function RougeMapEditModel:getLineDict()
	self.lineDict = {}

	for _, line in ipairs(self.lineList) do
		self.lineDict[line.startId] = self.lineDict[line.startId] or {}
		self.lineDict[line.endId] = self.lineDict[line.endId] or {}
		self.lineDict[line.startId][line.endId] = true
		self.lineDict[line.endId][line.startId] = true
	end

	return self.lineDict
end

function RougeMapEditModel:checkNavigation()
	self:getLineDict()

	local canArrive = true
	local pointLen = #self.pointList
	local startPathId = self.pointId2PathIdDict[self.pointList[1].id]
	local arrivedList = {}

	for i = 2, pointLen do
		local point = self.pointList[i]
		local endId = self.pointId2PathIdDict[point.id]

		tabletool.clear(arrivedList)

		if not self:navigationTo(startPathId, endId, 1, arrivedList) then
			local msg = string.format("id : %s, 不可达", point.id)

			GameFacade.showToastString(msg)

			canArrive = false
		end
	end

	return canArrive
end

function RougeMapEditModel:navigationTo(startId, endId, level, arrivedList)
	if tabletool.indexOf(arrivedList, startId) then
		return
	end

	table.insert(arrivedList, startId)

	if level > 20 then
		GameFacade.showToastString("死循环了...")
		table.remove(arrivedList)

		return
	end

	local nextDict = self.lineDict[startId]

	if not nextDict then
		table.remove(arrivedList)

		return
	end

	for pathId, _ in pairs(nextDict) do
		if pathId == endId then
			table.insert(arrivedList, endId)

			return true
		end
	end

	for pathId, _ in pairs(nextDict) do
		if self:navigationTo(pathId, endId, level + 1, arrivedList) then
			return true
		end
	end
end

function RougeMapEditModel:generateLeaveNodeConfig()
	local pathPointId = self.pointId2PathIdDict[RougeMapEnum.LeaveId]

	if not pathPointId then
		GameFacade.showToastString("离开点 没有添加路径节点映射")

		return
	end

	local pathPointIndex = self:getPathPointIndex(pathPointId)
	local leavePos = self:getLeavePos()

	ZProj.GameHelper.SetSystemBuffer(string.format("%s#%s#%s", leavePos.x, leavePos.y, pathPointIndex))
	GameFacade.showToastString("生成离开点配置成功")
end

function RougeMapEditModel:setHook()
	local frame = UnityEngine.Time.frameCount
	local _t = os.clock()

	debug.sethook(function()
		if frame ~= UnityEngine.Time.frameCount then
			frame = UnityEngine.Time.frameCount
			_t = os.clock()
		elseif os.clock() - _t > 5 then
			error("loop !!!")
		end
	end, "l")
end

RougeMapEditModel.instance = RougeMapEditModel.New()

return RougeMapEditModel
