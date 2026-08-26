-- chunkname: @modules/logic/explore/map/unit/ExploreBaseMoveUnit.lua

module("modules.logic.explore.map.unit.ExploreBaseMoveUnit", package.seeall)

local ExploreBaseMoveUnit = class("ExploreBaseMoveUnit", ExploreBaseDisplayUnit)

function ExploreBaseMoveUnit:canMove()
	return self.mo.isCanMove
end

function ExploreBaseMoveUnit:isMoving()
	return self._isMoving
end

function ExploreBaseMoveUnit:beginPick()
	return
end

function ExploreBaseMoveUnit:endPick()
	return
end

function ExploreBaseMoveUnit:setMoveDir(v)
	self._moveDirKey = v

	self:tryMoveByDir()
end

function ExploreBaseMoveUnit:tryMoveByDir()
	if self:checkUseMoveDir() and not self._isMoving and ExploreModel.instance:isHeroInControl() and UIBlockMgr.instance:isBlock() ~= true and ZProj.TouchEventMgr.Fobidden ~= true then
		local nodeKey = ExploreHelper.getKey(self.nodePos)
		local tempNode = ExploreMapModel.instance:getNode(nodeKey)
		local startH = tempNode.height

		self:_updateRealMoveDir()

		local tarPos = self.nodePos + self._realMoveDir
		local nodeKey = ExploreHelper.getKey(tarPos)

		tempNode = ExploreMapModel.instance:getNode(nodeKey)

		if tempNode and tempNode:isWalkable(startH) then
			self:moveTo(tarPos)
		else
			self:onCheckDir(self.nodePos, tarPos)
		end
	end
end

function ExploreBaseMoveUnit:moveTo(pos, callback, callbackObj)
	self._tarUnitMO = nil

	self:_startMove(pos, callback, callbackObj)
end

function ExploreBaseMoveUnit:moveByPath(path, moveDir, lockDir, callback, callbackObj)
	local pathLen = #path

	if pathLen <= 0 then
		if callback then
			callback(callbackObj, self.nodePos, self.nodePos)
		end

		return
	end

	self._lockDir = lockDir
	self._moveDir = moveDir

	if moveDir then
		self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, moveDir)
	end

	self._pathArray = path
	self._walkDistance = pathLen
	self._gotoCallback = callback
	self._gotoCallbackObj = callbackObj
	self._endPos = path[self._walkDistance]

	self:_startMove2()
	self:onStartMove()
end

function ExploreBaseMoveUnit:reStartMoving()
	if self._isMoving then
		self:_startMove(self._endPos, self._gotoCallback, self._gotoCallbackObj)
	end
end

function ExploreBaseMoveUnit:getMoveDistance()
	if not self._isMoving then
		return 0
	end

	return self._walkDistance
end

function ExploreBaseMoveUnit:getRunTotalTime()
	if self._isMoving then
		return self._runTotalTime
	else
		return 0
	end
end

function ExploreBaseMoveUnit:stopMoving(force)
	if not self._isMoving then
		return
	end

	if not force then
		local nextPos = self._nextNodePos
		local key = ExploreHelper.getKey(nextPos)
		local node = ExploreMapModel.instance:getNode(key)

		if node.nodeType == ExploreEnum.NodeType.Ice then
			return
		end

		self._isStopMoving = true

		return nextPos
	end

	self._isMoving = false

	if self._moveDir then
		self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	self._moveDir = nil
	self._lockDir = nil
	self._nextWorldPos = nil
	self._nextNodePos = nil
	self._oldWorldPos = nil

	self:onEndMove()

	self._walkDistance = 0

	if self._tureDir then
		self:onDirChange(self._tureDir)

		self._tureDir = nil
	end

	TaskDispatcher.cancelTask(self.onMoveTick, self)
end

function ExploreBaseMoveUnit:onCheckDir(oldTilemapPos, newTilemapPos)
	return
end

function ExploreBaseMoveUnit:onCheckDirByPos(oldPos, newPos)
	return
end

function ExploreBaseMoveUnit:onDirChange(tureDir)
	return
end

function ExploreBaseMoveUnit:onMoveTick()
	self:_moving()
end

function ExploreBaseMoveUnit:onStartMove()
	return
end

function ExploreBaseMoveUnit:onEndMove()
	return
end

function ExploreBaseMoveUnit:moveSpeed()
	return ExploreAnimEnum.RoleSpeed.walk
end

function ExploreBaseMoveUnit:onDestroy()
	self._gotoCallback = nil
	self._gotoCallbackObj = nil
	self._endPos = nil
	self._exploreMap = nil

	TaskDispatcher.cancelTask(self.onMoveTick, self)
	ExploreBaseMoveUnit.super.onDestroy(self)
end

function ExploreBaseMoveUnit:_startMove(pos, callback, callbackObj)
	self._gotoCallback = callback
	self._gotoCallbackObj = callbackObj
	self._endPos = pos

	if not self.nodePos or ExploreHelper.isPosEqual(self.nodePos, self._endPos) then
		self:_onEndMoveCallback()

		return
	end

	self._exploreMap = self._exploreMap or ExploreController.instance:getMap()
	self._pathArray = self._exploreMap:startFindPath(self.nodePos, self._endPos)

	local pathLen = #self._pathArray

	if pathLen == 0 then
		self:_onEndMoveCallback()

		return
	end

	self._walkDistance = pathLen

	self:_startMove2()
	self:onStartMove()
end

function ExploreBaseMoveUnit:_startMove2()
	self._isMoving = true

	TaskDispatcher.runRepeat(self.onMoveTick, self, 0)
	self:onMoveTick()
end

function ExploreBaseMoveUnit:_moving()
	if self._nextWorldPos then
		self._runStartTime = self._runStartTime + Time.deltaTime

		local runPos = Vector3.Lerp(self._oldWorldPos, self._nextWorldPos, math.min(1, self._runStartTime / self._runTotalTime))

		if self._runStartTime >= self._runTotalTime then
			self:setPosByNode(self._nextNodePos)

			self._nextWorldPos = nil

			if self._isStopMoving then
				self._pathArray = {}
				self._isStopMoving = nil
			end

			self:_moving()
		else
			self:setPos(runPos)
		end

		return
	end

	if #self._pathArray == 0 and ExploreModel.instance:isHeroInControl() then
		self:_addMovePathByDir()
	end

	if #self._pathArray > 0 then
		local oldTilemapPos = self.nodePos

		self._nextNodePos = table.remove(self._pathArray)
		self._runTotalTime = self:moveSpeed()

		if ExploreHelper.isPosEqual(oldTilemapPos, self._nextNodePos) then
			return
		end

		local oldNode = ExploreMapModel.instance:getNode(ExploreHelper.getKey(oldTilemapPos))
		local nextNode = ExploreMapModel.instance:getNode(ExploreHelper.getKey(self._nextNodePos))

		if not self._lockDir and nextNode:isWalkable(oldNode.height) == false then
			self:_endMove()

			return
		end

		self._oldWorldPos = self.position
		self._nextWorldPos = ExploreHelper.tileToPos(self._nextNodePos)
		self._nextWorldPos.y = self._oldWorldPos.y
		self._runStartTime = 0

		self:onCheckDir(oldTilemapPos, self._nextNodePos)
		self:onCheckDirByPos(self._oldWorldPos, self._nextWorldPos)

		return
	end

	self:_endMove()
end

function ExploreBaseMoveUnit:_addMovePathByDir()
	if self:checkUseMoveDir() and ExploreModel.instance:isHeroInControl() and self:_checkInUIBlock() == false and ZProj.TouchEventMgr.Fobidden ~= true then
		local nodeKey = ExploreHelper.getKey(self.nodePos)
		local tempNode = ExploreMapModel.instance:getNode(nodeKey)
		local startH = tempNode.height

		self:_updateRealMoveDir()

		local tarPos = self.nodePos + self._realMoveDir
		local nodeKey = ExploreHelper.getKey(tarPos)

		tempNode = ExploreMapModel.instance:getNode(nodeKey)

		if tempNode and tempNode:isWalkable(startH) then
			table.insert(self._pathArray, tarPos)
		end
	end
end

ExploreBaseMoveUnit.ExploreMoveRequest = 13574

function ExploreBaseMoveUnit:_checkInUIBlock()
	for blockKey, _ in pairs(UIBlockMgr.instance._blockKeyDict) do
		if blockKey == UIBlockKey.MsgLock then
			for cmd, _ in pairs(GameGlobalMgr.instance:getMsgLockState()._blockCmdDict) do
				if ExploreBaseMoveUnit.ExploreMoveRequest ~= cmd then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function ExploreBaseMoveUnit:_updateRealMoveDir()
	local rotate = ExploreMapModel.instance.nowMapRotate % 360

	if rotate < 0 then
		rotate = rotate + 360
	end

	local offIndex = Mathf.Round(rotate / 90)
	local index = ExploreEnum.RoleMoveRotateDirIndex[self._moveDirKey] + offIndex

	index = index % 4
	self._realMoveDir = ExploreEnum.RoleMoveRotateDir[index]
end

function ExploreBaseMoveUnit:checkUseMoveDir()
	return self._moveDirKey
end

function ExploreBaseMoveUnit:_endMove()
	self._walkDistance = 0

	if self._tureDir then
		self:onDirChange(self._tureDir)

		self._tureDir = nil
	end

	TaskDispatcher.cancelTask(self.onMoveTick, self)

	self._nextNodePos = nil

	self:_onEndMoveCallback()
end

function ExploreBaseMoveUnit:_onEndMoveCallback()
	self._isMoving = false

	if self._moveDir then
		self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	self._moveDir = nil
	self._moveDirKey = nil
	self._lockDir = nil

	self:onEndMove()

	if self._gotoCallback then
		self._gotoCallback(self._gotoCallbackObj, self.nodePos, self._endPos)
	end
end

return ExploreBaseMoveUnit
