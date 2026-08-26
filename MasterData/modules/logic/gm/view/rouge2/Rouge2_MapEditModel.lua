-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_MapEditModel.lua

module("modules.logic.gm.view.rouge2.Rouge2_MapEditModel", package.seeall)

local Rouge2_MapEditModel = class("Rouge2_MapEditModel")

function Rouge2_MapEditModel:init(middleLayerId)
	self.middleLayerId = middleLayerId
	self.middleLayerCo = Rouge2_MapConfig.instance:getMiddleLayerCo(self.middleLayerId)
	self.idCounter = 0
	self.pathPointIdCounter = 0

	self:loadLayerCo()
end

function Rouge2_MapEditModel:getMiddleLayerId()
	return self.middleLayerId
end

function Rouge2_MapEditModel:loadLayerCo()
	self:loadPoints()
	self:loadPathPoints()
	self:loadPath()
	self:loadLeavePoint()
end

function Rouge2_MapEditModel:getPointId()
	self.idCounter = self.idCounter + 1

	return self.idCounter
end

function Rouge2_MapEditModel:getPathPointId()
	self.pathPointIdCounter = self.pathPointIdCounter + 1

	return self.pathPointIdCounter
end

function Rouge2_MapEditModel:loadPoints()
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

function Rouge2_MapEditModel:loadPathPoints()
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

function Rouge2_MapEditModel:loadPath()
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

function Rouge2_MapEditModel:loadLeavePoint()
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
		startId = Rouge2_MapEnum.LeaveId,
		endId = pathId
	})

	self.pointId2PathIdDict[Rouge2_MapEnum.LeaveId] = pathId
end

function Rouge2_MapEditModel:addPoint(pos)
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

function Rouge2_MapEditModel:addPathPoint(pos)
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

function Rouge2_MapEditModel:setLeavePoint(pos)
	self.leavePos = pos
end

function Rouge2_MapEditModel:getLeavePos()
	return self.leavePos
end

function Rouge2_MapEditModel:deleteLeavePoint()
	self.leavePos = nil
	self.pointId2PathIdDict[Rouge2_MapEnum.LeaveId] = nil
end

function Rouge2_MapEditModel:deletePoint(id, type)
	if type == Rouge2_MapEnum.MiddleLayerPointType.Pieces then
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

function Rouge2_MapEditModel:addLine(startType, startId, endType, endId)
	if startType == Rouge2_MapEnum.MiddleLayerPointType.Pieces or startType == Rouge2_MapEnum.MiddleLayerPointType.Leave then
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

function Rouge2_MapEditModel:removeLine(index)
	table.remove(self.lineList, index)
end

function Rouge2_MapEditModel:removeMapLine(index)
	table.remove(self.point2PathMapLineList, index)
end

function Rouge2_MapEditModel:checkNeedRemoveMap(pointId, pathId, lineItem)
	local startType, startId = lineItem.startType, lineItem.startId
	local endType, endId = lineItem.endType, lineItem.endId

	if startType == Rouge2_MapEnum.MiddleLayerPointType.Pieces and startId == pointId then
		return true
	end

	if startType == Rouge2_MapEnum.MiddleLayerPointType.Path and startId == pathId then
		return true
	end

	if endType == Rouge2_MapEnum.MiddleLayerPointType.Pieces and endId == pointId then
		return true
	end

	if endType == Rouge2_MapEnum.MiddleLayerPointType.Path and endId == pathId then
		return true
	end
end

function Rouge2_MapEditModel:getPointsDict()
	return self.pointDict
end

function Rouge2_MapEditModel:getPointList()
	return self.pointList
end

function Rouge2_MapEditModel:getPointMap()
	return self.pointId2PathIdDict
end

function Rouge2_MapEditModel:getPathPointsDict()
	return self.pathPointDict
end

function Rouge2_MapEditModel:getPathPointList()
	return self.pathPointList
end

function Rouge2_MapEditModel:getLineList()
	return self.lineList
end

function Rouge2_MapEditModel:getMapLineList()
	return self.point2PathMapLineList
end

function Rouge2_MapEditModel:getPointPos(id)
	return self.pointDict[id]
end

function Rouge2_MapEditModel:getPathPointPos(id)
	return self.pathPointDict[id]
end

Rouge2_MapEditModel.PointTypeCanAddLineDict = {
	[Rouge2_MapEnum.MiddleLayerPointType.Pieces] = {
		[Rouge2_MapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"两个元件位置之间不能添加路径"
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Leave] = {
			false,
			"元件点和离开点不能添加路径"
		}
	},
	[Rouge2_MapEnum.MiddleLayerPointType.Path] = {
		[Rouge2_MapEnum.MiddleLayerPointType.Pieces] = {
			true
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Leave] = {
			false
		}
	},
	[Rouge2_MapEnum.MiddleLayerPointType.Leave] = {
		[Rouge2_MapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"元件点和离开点不能添加路径"
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[Rouge2_MapEnum.MiddleLayerPointType.Leave] = {
			false,
			"两个离开点之间不能添加路径"
		}
	}
}

function Rouge2_MapEditModel:checkCanAddLine(startType, startId, endType, endId)
	local canAddLine = Rouge2_MapEditModel.PointTypeCanAddLineDict

	if not canAddLine[1] then
		GameFacade.showToastString(canAddLine[1])

		return false
	end

	if startType == Rouge2_MapEnum.MiddleLayerPointType.Leave or endId == Rouge2_MapEnum.MiddleLayerPointType.Leave then
		if self.pointId2PathIdDict[Rouge2_MapEnum.LeaveId] then
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

	startType, startId, endType, endId = Rouge2_MapHelper.formatLineParam(startType, startId, endType, endId)

	if startType ~= endType and self.pointId2PathIdDict[startId] then
		GameFacade.showToastString("一个元件只能映射一个路径点")

		return
	end

	return true
end

Rouge2_MapEditModel.Radius = 1

function Rouge2_MapEditModel:getPointByPos(scenePos)
	for id, pos in pairs(self.pointDict) do
		if Vector2.Distance(pos, scenePos) <= Rouge2_MapEditModel.Radius then
			return id, Rouge2_MapEnum.MiddleLayerPointType.Pieces
		end
	end

	for id, pos in pairs(self.pathPointDict) do
		if Vector2.Distance(pos, scenePos) <= Rouge2_MapEditModel.Radius then
			return id, Rouge2_MapEnum.MiddleLayerPointType.Path
		end
	end

	if self.leavePos and Vector2.Distance(self.leavePos, scenePos) <= Rouge2_MapEditModel.Radius then
		return Rouge2_MapEnum.LeaveId, Rouge2_MapEnum.MiddleLayerPointType.Leave
	end
end

function Rouge2_MapEditModel:generateNodeConfig()
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

function Rouge2_MapEditModel:generatePathNodeConfig()
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

function Rouge2_MapEditModel:generateNodePath()
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

function Rouge2_MapEditModel:getPointIndex(id)
	for index, point in ipairs(self.pointList) do
		if point.id == id then
			return index
		end
	end
end

function Rouge2_MapEditModel:getPathPointIndex(id)
	for index, point in ipairs(self.pathPointList) do
		if point.id == id then
			return index
		end
	end
end

function Rouge2_MapEditModel:getLineDict()
	self.lineDict = {}

	for _, line in ipairs(self.lineList) do
		self.lineDict[line.startId] = self.lineDict[line.startId] or {}
		self.lineDict[line.endId] = self.lineDict[line.endId] or {}
		self.lineDict[line.startId][line.endId] = true
		self.lineDict[line.endId][line.startId] = true
	end

	return self.lineDict
end

function Rouge2_MapEditModel:checkNavigation()
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

function Rouge2_MapEditModel:navigationTo(startId, endId, level, arrivedList)
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

function Rouge2_MapEditModel:generateLeaveNodeConfig()
	local pathPointId = self.pointId2PathIdDict[Rouge2_MapEnum.LeaveId]

	if not pathPointId then
		GameFacade.showToastString("离开点 没有添加路径节点映射")

		return
	end

	local pathPointIndex = self:getPathPointIndex(pathPointId)
	local leavePos = self:getLeavePos()

	ZProj.GameHelper.SetSystemBuffer(string.format("%s#%s#%s", leavePos.x, leavePos.y, pathPointIndex))
	GameFacade.showToastString("生成离开点配置成功")
end

function Rouge2_MapEditModel:setHook()
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

Rouge2_MapEditModel.instance = Rouge2_MapEditModel.New()

return Rouge2_MapEditModel
