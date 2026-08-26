-- chunkname: @modules/logic/room/entity/comp/RoomVehicleMoveComp.lua

module("modules.logic.room.entity.comp.RoomVehicleMoveComp", package.seeall)

local RoomVehicleMoveComp = class("RoomVehicleMoveComp", LuaCompBase)

function RoomVehicleMoveComp:ctor(entity)
	self.entity = entity
	self.moveSpeed = 0.2
	self.rotationSpeed = 90
	self.maxRotationAngle = 150
	self.endPathWaitTime = 0
	self.radius = 0.1
	self.crossloadMaxWaitTime = 15
	self._crossloadEndTime = 0
	self._endNodeResourcePointOffest = 0.42
	self._isStop = false
	self._isWalking = false
	self._moveParams = {}
	self._rotationParams = {}
end

function RoomVehicleMoveComp:init(go)
	self.go = go
	self.targetTrs = self.go.transform
	self._scene = GameSceneMgr.instance:getCurScene()
	self._seeker = ZProj.AStarSeekWrap.Get(self.go)

	self:initVehicleParam()

	for layerTag = 0, 31 do
		self._seeker:SetTagTraversable(layerTag, RoomAStarHelper.walkableTag(self._resId, layerTag))
	end

	self:_delayFindPath()
end

function RoomVehicleMoveComp:initVehicleParam()
	self._mo = self:getVehicleMO()
	self._resId = self._mo and self._mo.resourceId

	if self._mo then
		local cfg = self._mo:getReplaceDefideCfg()

		if cfg then
			self.moveSpeed = cfg.moveSpeed * 0.01
			self.rotationSpeed = cfg.rotationSpeed

			if cfg.endPathWaitTime then
				self.endPathWaitTime = cfg.endPathWaitTime * 0.001 or self.endPathWaitTime or 0
			end

			self._useType = cfg.useType

			if cfg.radius and cfg.radius > 0 then
				local direSize = RoomBlockEnum.BlockSize * math.sqrt(3) * 0.5
				local radius = math.min(cfg.radius * 0.01, direSize)
				local offset = (1 - radius / direSize) * 0.5

				self._endNodeResourcePointOffest = math.max(0.1, offset)
			end
		end
	end
end

function RoomVehicleMoveComp:addEventListeners()
	return
end

function RoomVehicleMoveComp:removeEventListeners()
	if not gohelper.isNil(self._seeker) then
		self._seeker:RemoveOnPathCall()
	end

	self._seeker = nil
end

function RoomVehicleMoveComp:_reset()
	self._isInitPosition = false
	self._mo = self:getVehicleMO()

	if self._mo then
		self._resId = self._mo.resourceId or self._resId
	end

	if self.pathList and #self.pathList > 0 then
		for i = #self.pathList, 1, -1 do
			RoomVectorPool.instance:recycle(self.pathList[i])
			table.remove(self.pathList, i)
		end
	end
end

function RoomVehicleMoveComp:_delayFindPath(delay)
	self:_returnFindPath()

	self._delayFindPathing = true

	local delayTime = delay or 0.5

	TaskDispatcher.runDelay(self._onDelayFindPath, self, delayTime)

	if delayTime > 0 and (not self.pathList or #self.pathList <= 0) then
		self:_setIsWalking(false, delay)
	end
end

function RoomVehicleMoveComp:_setIsWalking(isWalking, delay)
	if self._isWalking == isWalking then
		return
	end

	self._isWalking = isWalking

	local mo = self:getVehicleMO() or self._mo
	local vehicleCfg = mo and mo:getReplaceDefideCfg()

	if vehicleCfg then
		local audioId = vehicleCfg.audioStop

		if self._isWalking then
			audioId = vehicleCfg.audioWalk
		end

		if audioId and audioId ~= 0 then
			RoomHelper.audioExtendTrigger(audioId, self.go)
		end
	end

	if self.entity then
		if self._isWalking then
			if not RoomEvent.VehicleStartMove then
				local eventId = RoomEvent.VehicleStopMove

				self.entity:dispatchEvent(eventId, delay)
			end
		end
	end
end

function RoomVehicleMoveComp:_onDelayFindPath()
	self._delayFindPathing = false

	self:findPath()
end

function RoomVehicleMoveComp:_returnFindPath()
	TaskDispatcher.cancelTask(self._onDelayFindPath, self)
end

function RoomVehicleMoveComp:findPath()
	local seeker = self._seeker

	if not seeker then
		return
	end

	local mo = self:getVehicleMO() or self._mo

	if not mo then
		self:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有MO数据")

		return
	end

	local curNode = mo:getCurNode()
	local curDire = mo.enterDirection
	local nextNode, nextEnterDire, curExitDire = mo:findNextWeightNode()
	local hexPoint = nextNode and nextNode.hexPoint

	if not hexPoint then
		self:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有位置信息")

		return
	end

	local areaNodeList = mo:getAreaNode()

	if areaNodeList and #areaNodeList > 1 and tabletool.indexOf(areaNodeList, nextNode) then
		self:_followTrunAround()
		self:_delayFindPath()

		return
	end

	local findNextDir = nextEnterDire

	if nextNode:isEndNode() then
		findNextDir = mo:findEndDir(nextNode, nextEnterDire)

		if nextNode == curNode then
			if findNextDir == nextEnterDire then
				findNextDir = 0
			end

			nextEnterDire = findNextDir
		end
	end

	local isCrossLoad, buildingUid = self:_isCrossload(curNode, curDire, curExitDire)

	if not isCrossLoad then
		isCrossLoad, buildingUid = self:_isCrossload(nextNode, nextEnterDire, findNextDir)
	end

	if isCrossLoad then
		local crossLoadResId, canMove = RoomCrossLoadController.instance:crossload(buildingUid, self._resId)

		if self._crossloadEndTime <= 0 then
			self._crossloadEndTime = Time.time + 15
		end

		if crossLoadResId ~= self._resId and self._crossloadEndTime < Time.time then
			self._crossloadEndTime = 0

			mo:moveToNode(nextNode, nextEnterDire, true)
		end

		if crossLoadResId ~= self._resId or not canMove then
			self:_delayFindPath()

			return
		end
	else
		self._crossloadEndTime = 0
	end

	local findDireList = {
		findNextDir
	}

	if nextNode:isEndNode() and findNextDir ~= nextEnterDire then
		table.insert(findDireList, nextEnterDire)
	end

	local param = {
		nextNode = nextNode,
		nextEnterDire = nextEnterDire,
		direList = findDireList,
		isCrossLoad = isCrossLoad,
		buildingUid = buildingUid
	}

	if self._useType == RoomVehicleEnum.UseType.Aircraft then
		local nextHexPoint = nextNode.hexPoint
		local nextPosX, nextPosZ = HexMath.hexXYToPosXY(nextHexPoint.x, nextHexPoint.y, RoomBlockEnum.BlockSize)
		local pathV3List = {
			Vector3(nextPosX, RoomBuildingEnum.VehicleInitOffestY, nextPosZ)
		}

		self:_setPathV3ListParam(param, pathV3List)
	else
		self:_startFindPath(param, nextNode:isEndNode() and self._endNodeResourcePointOffest)
	end
end

function RoomVehicleMoveComp:_startFindPath(findParam, offset)
	local seeker = self._seeker

	if seeker and findParam and #findParam.direList > 0 then
		local findNextDir = findParam.direList[1]

		table.remove(findParam.direList, 1)

		local position = HexMath.resourcePointToPosition(ResourcePoint.New(findParam.nextNode.hexPoint, findNextDir), RoomBlockEnum.BlockSize, offset or 0.4)

		seeker:RemoveOnPathCall()
		seeker:AddOnPathCall(self._onPathCall, self, findParam)
		seeker:StartPath(self.targetTrs.localPosition, Vector3(position.x, 0, position.y))
	end
end

function RoomVehicleMoveComp:_onPathCall(findParam, pathList, isError, errorMsg)
	local pathV3List

	self:_setPathV3ListParam(findParam, (not isError or nil) and RoomVectorPool.instance:packPosList(pathList), isError)

	if isError then
		if #findParam.direList > 0 then
			self:_startFindPath(findParam)
		else
			self:_delayFindPath()
		end
	end
end

function RoomVehicleMoveComp:_setPathV3ListParam(findParam, pathV3List, isError)
	if findParam and findParam.nextNode and (#findParam.direList < 1 or not isError) then
		local mo = self:getVehicleMO() or self._mo
		local curDire = mo.enterDirection

		mo:moveToNode(findParam.nextNode, findParam.nextEnterDire, isError and true or false)

		local vehicleCfg = mo:getReplaceDefideCfg()

		if findParam.isCrossLoad and RoomConfig.instance:getAudioExtendConfig(vehicleCfg.audioCrossload) then
			RoomHelper.audioExtendTrigger(vehicleCfg.audioCrossload, self.go)
		elseif findParam.nextEnterDire ~= curDire and RoomConfig.instance:getAudioExtendConfig(vehicleCfg.audioTurn) then
			RoomHelper.audioExtendTrigger(vehicleCfg.audioTurn, self.go)
		end
	end

	if not isError then
		self.pathList = pathV3List

		self:_moveNext()
	end
end

function RoomVehicleMoveComp:_isCrossload(node, enterDire, curExitDire)
	if node then
		return RoomCrossLoadController.instance:isEnterBuilingCrossLoad(node.hexPoint.x, node.hexPoint.y, enterDire, curExitDire)
	end
end

function RoomVehicleMoveComp:_moveNext()
	if not self._isInitPosition and #self.pathList > 1 then
		self._isInitPosition = true

		local initPosition = self.pathList[1]
		local px, py, pz = transformhelper.getLocalPos(self.targetTrs)

		transformhelper.setLocalPos(self.targetTrs, px, initPosition.y, pz)

		if Vector3.Distance(Vector3(px, initPosition.y, pz), initPosition) <= 0.001 then
			table.remove(self.pathList, 1)
			RoomVectorPool.instance:recycle(initPosition)
		end
	end

	if #self.pathList > 0 then
		local pos = self.pathList[1]

		table.remove(self.pathList, 1)
		self:_moveTo(pos.x, pos.y, pos.z)
		RoomVectorPool.instance:recycle(pos)
	end
end

function RoomVehicleMoveComp:_moveTo(x, y, z)
	self:_killMoveToTween()

	local fromPos = self.targetTrs.position
	local toPos = Vector3(x, y, z)
	local distance = Vector3.Distance(fromPos, toPos)
	local duration = distance / self.moveSpeed
	local mps = self._moveParams

	mps.originalX = fromPos.x
	mps.originalY = fromPos.y
	mps.originalZ = fromPos.z
	mps.x = x
	mps.y = y
	mps.z = z
	self._tweenId = self._scene.tween:tweenFloat(0, 1, duration, self._frameCallback, self._finishCallback, self, mps)

	if math.abs(x - mps.originalX) > 1e-06 or math.abs(z - mps.originalZ) > 1e-06 then
		local targetDir = Vector3(x - mps.originalX, y - mps.originalY, z - mps.originalZ)
		local toRotation = Quaternion.LookRotation(targetDir, Vector3.up)
		local fromRotation = self.targetTrs.rotation
		local angle = Quaternion.Angle(fromRotation, toRotation)

		if angle < self.maxRotationAngle then
			local duration = angle / self.rotationSpeed
			local rps = self._rotationParams

			rps.fromRotation = fromRotation
			rps.toRotation = toRotation
			rps.angle = angle
			self._tweenRotionId = self._scene.tween:tweenFloat(0, 1, duration, self._frameRotationCallback, nil, self, rps)
		else
			self.targetTrs:LookAt(toPos)
			self.entity.vehiclefollow:updateFollower()

			if self._mo then
				local vehicleCfg = self._mo:getReplaceDefideCfg()

				if vehicleCfg then
					RoomHelper.audioExtendTrigger(vehicleCfg.audioTurnAround, self.go)
				end
			end
		end
	else
		self.targetTrs:LookAt(toPos)
	end

	self:_setIsWalking(true)
end

function RoomVehicleMoveComp:_killMoveToTween()
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenRotionId then
		self._scene.tween:killById(self._tweenRotionId)

		self._tweenRotionId = nil
	end
end

function RoomVehicleMoveComp:_frameCallback(value, param)
	local x = param.originalX + (param.x - param.originalX) * value
	local y = param.originalY + (param.y - param.originalY) * value
	local z = param.originalZ + (param.z - param.originalZ) * value

	transformhelper.setPos(self.targetTrs, x, y, z)
	self.entity.vehiclefollow:updateFollower()
end

function RoomVehicleMoveComp:_frameRotationCallback(value, param)
	self.targetTrs.rotation = Quaternion.RotateTowards(param.fromRotation, param.toRotation, value * param.angle)
end

function RoomVehicleMoveComp:_finishCallback(param)
	transformhelper.setPos(self.targetTrs, param.x, param.y, param.z)
	self.entity.vehiclefollow:addFollerPathPos(param.x, param.y, param.z)

	if #self.pathList <= 0 then
		local isEndNode = self:_isCurNodeIsEndNode()

		if isEndNode then
			self:_followTrunAround()
		end

		if self.endPathWaitTime > 0 and isEndNode then
			self:_delayFindPath(self.endPathWaitTime)
		else
			self:findPath()
		end
	else
		self:_moveNext()
	end
end

function RoomVehicleMoveComp:_followTrunAround()
	if self.entity.vehiclefollow:turnAround() then
		self._isInitPosition = false
	end
end

function RoomVehicleMoveComp:_isCurNodeIsEndNode()
	local mo = self:getVehicleMO() or self._mo

	if mo then
		local node = mo:getCurNode()

		if node and node:isEndNode() then
			return true
		end
	end

	return false
end

function RoomVehicleMoveComp:getIsStop()
	return self._isStop
end

function RoomVehicleMoveComp:stop()
	if self._isStop then
		return
	end

	self._isStop = true

	if not gohelper.isNil(self._seeker) then
		self._seeker:RemoveOnPathCall()
	end

	self:_killMoveToTween()
	self:_returnFindPath()
	self:_setIsWalking(false)
end

function RoomVehicleMoveComp:restart()
	if not self._isStop then
		return
	end

	self._isStop = false

	self:_reset()
	self:_delayFindPath()
end

function RoomVehicleMoveComp:getVehicleMO()
	return self.entity:getVehicleMO()
end

function RoomVehicleMoveComp:getSeeker()
	return self._seeker
end

function RoomVehicleMoveComp:beforeDestroy()
	self:removeEventListeners()
	self:_returnFindPath()
	self:_killMoveToTween()
end

return RoomVehicleMoveComp
