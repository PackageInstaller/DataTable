-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGameRootCell.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGameRootCell", package.seeall)

local DomAdvCopyPinGameRootCell = class("DomAdvCopyPinGameRootCell")

DomAdvCopyPinGameRootCell.SuccessTweenTime = 0.8

function DomAdvCopyPinGameRootCell:ctor(parentGo, obstacle, needle)
	self._templateObstacle = goutil.cloneAndSetParent(obstacle, parentGo.transform, "templateObstacle")
	self._templateNeedle = goutil.cloneAndSetParent(needle, parentGo.transform, "templateNeedle")

	goutil.setActive(self._templateObstacle, false)
	goutil.setActive(self._templateNeedle, false)

	self._rotateRoot = goutil.findChild(parentGo, "rotateRoot")
	self._rotateRootRect = self._rotateRoot:GetComponent(goutil.Type_RectTransform)
	self._arrowGoList = {}
	self._targetPosGoList = {}
	self._arrowGoList[1] = goutil.findChild(parentGo, "arrow1")
	self._targetPosGoList[1] = goutil.findChild(parentGo, "targetPos1")

	local arrow2 = goutil.findChild(parentGo, "arrow2")
	local targetPos2 = goutil.findChild(parentGo, "targetPos2")

	if arrow2 and targetPos2 then
		self._arrowGoList[2] = arrow2
		self._targetPosGoList[2] = targetPos2
	end

	self._role = goutil.findChild(parentGo, "role")
	self._gameRootMo = nil
	self._usingObstacleList = {}
	self._usingNeedleList = {}
	self._freeObstacleList = {}
	self._freeNeedleList = {}
	self._recentShootNeedleList = {}
end

function DomAdvCopyPinGameRootCell:initGameState(gameRootMo, mode, stagePlanId, stageId, reviveData)
	self:clearGameState()
	PinGameController.instance:registerLocalNotify(PinGameController.ClickShootEvent, self._onClickShoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.StopRotateRoot, self._onStopRotateRoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.PauseRotateRoot, self._onPauseRotateRoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.PlaySuccessTween, self._onPlaySuccessTween, self)

	self._gameRootMo = gameRootMo
	self._mode = mode
	self._stagePlanId = stagePlanId
	self._stageId = stageId
	self._reviveData = reviveData
	self._leftCount = self._gameRootMo.winCount
	self._sucHitCount = 0
	self._needleIndex = 0

	PinGameController.instance:localNotify(PinGameController.UpdateNeedleLeftNumEvent, self._leftCount, 0)
	GameUtil.setLocalRotation(self._rotateRoot, 0, 0, 0)
	GameUtil.setWidth(self._rotateRoot, gameRootMo.rootRadius * 2)
	GameUtil.setHeight(self._rotateRoot, gameRootMo.rootRadius * 2)

	local obstacleLine = goutil.findChild(self._templateObstacle, "line")
	local obstacleCircle = goutil.findChild(self._templateObstacle, "line/circle")

	GameUtil.setWidth(obstacleLine, gameRootMo.lineLength)
	GameUtil.setWidth(obstacleCircle, gameRootMo.obstacleRadius * 2)
	GameUtil.setHeight(obstacleCircle, gameRootMo.obstacleRadius * 2)

	local needleLine = goutil.findChild(self._templateNeedle, "line")
	local needleCircle = goutil.findChild(self._templateNeedle, "line/circle")

	GameUtil.setWidth(needleLine, gameRootMo.lineLength)
	GameUtil.setWidth(needleCircle, gameRootMo.lineRadius * 2)
	GameUtil.setHeight(needleCircle, gameRootMo.lineRadius * 2)
	self:_setObstacles()
	self:_loadRoleModel()

	self._isStartGame = false
end

function DomAdvCopyPinGameRootCell:startGameState()
	self._isStartGame = true

	self:_startRotateRoot()
end

function DomAdvCopyPinGameRootCell:clearGameState()
	PinGameController.instance:unregisterLocalNotify(PinGameController.ClickShootEvent, self._onClickShoot, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.StopRotateRoot, self._onStopRotateRoot, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.PauseRotateRoot, self._onPauseRotateRoot, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.PlaySuccessTween, self._onPlaySuccessTween, self)

	self._isStartGame = false

	self:_stopRotateRoot()
	GameUtil.setLocalRotation(self._rotateRoot, 0, 0, 0)

	for i, go in ipairs(self._usingObstacleList) do
		self:_recycleObstacle(go)
	end

	table.clear(self._usingObstacleList)

	for i, go in ipairs(self._usingNeedleList) do
		self:_recycleNeedle(go)
	end

	table.clear(self._usingNeedleList)
	self:_clearRecentNeedleList()
	self:_stopFlashTween()
	self:_stopFailTween()
	self:_stopSuccessTween()
	self:_resetRoleModel()
end

function DomAdvCopyPinGameRootCell:_setObstacles()
	if not self._gameRootMo.obstacleList then
		for i, degree in ipairs(self._gameRootMo.obstacleList) do
			local obstacle = self:_getObstacle()

			obstacle.name = "obstacle" .. i

			goutil.setActive(obstacle, true)
			self:_setPosAndDegree(obstacle, self._gameRootMo.rootRadius, degree)
			table.insert(self._usingObstacleList, obstacle)
		end
	end
end

function DomAdvCopyPinGameRootCell:_getObstacle()
	if #self._freeObstacleList > 0 then
		return table.remove(self._freeObstacleList, #self._freeObstacleList)
	else
		return goutil.cloneAndSetParent(self._templateObstacle, self._rotateRoot.transform, "obstacle")
	end
end

function DomAdvCopyPinGameRootCell:_recycleObstacle(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		table.insert(self._freeObstacleList, go)
	end
end

function DomAdvCopyPinGameRootCell:_getNeedle()
	if #self._freeNeedleList > 0 then
		return table.remove(self._freeNeedleList, #self._freeNeedleList)
	else
		return goutil.cloneAndSetParent(self._templateNeedle, self._rotateRoot.transform, "needle")
	end
end

function DomAdvCopyPinGameRootCell:_recycleNeedle(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		table.insert(self._freeNeedleList, go)
	end
end

function DomAdvCopyPinGameRootCell:_shootNeedle()
	self:_clearRecentNeedleList()

	for i, degree in ipairs(self._gameRootMo.shootDir) do
		local needle = self:_getNeedle()

		goutil.setActive(needle, true)

		self._needleIndex = self._needleIndex + 1
		needle.name = "needle" .. self._needleIndex

		table.insert(self._usingNeedleList, needle)

		local x, y, z = GameUtil.getLocalRotation(self._rotateRoot)
		local targetDegree = -z + degree

		self:_setPosAndDegree(needle, self._gameRootMo.rootRadius, targetDegree)
		self:_addToRecentNeedleList(needle)
	end

	self:_startFlashTween()
end

function DomAdvCopyPinGameRootCell:_addToRecentNeedleList(needle)
	table.insert(self._recentShootNeedleList, needle)
end

function DomAdvCopyPinGameRootCell:_clearRecentNeedleList()
	table.clear(self._recentShootNeedleList)
end

function DomAdvCopyPinGameRootCell:_recycleRecentNeedles()
	for i, go in ipairs(self._recentShootNeedleList) do
		table.removebyvalue(self._usingNeedleList, go)
		self:_recycleNeedle(go)
	end

	self:_clearRecentNeedleList()
end

function DomAdvCopyPinGameRootCell:_setPosAndDegree(go, rootRadius, goTargetDegree)
	GameUtil.setAnchoredPos(go, Mathf.Cos(goTargetDegree * Mathf.Deg2Rad) * rootRadius, Mathf.Sin(goTargetDegree * Mathf.Deg2Rad) * rootRadius)
	GameUtil.setLocalRotation(go, 0, 0, goTargetDegree)
end

function DomAdvCopyPinGameRootCell:_onClickShoot()
	if self._isStartGame then
		local x, y, z = GameUtil.getLocalRotation(self._rotateRoot)

		if self._leftCount > 0 then
			self:_shootNeedle()
		end

		self._leftCount = Mathf.Max(0, self._leftCount - 1)

		local isExistIntersect = self:_isExistIntersect()

		if not isExistIntersect then
			self._sucHitCount = self._sucHitCount + 1
		end

		PinGameController.instance:localNotify(PinGameController.UpdateNeedleLeftNumEvent, self._leftCount, self._sucHitCount)

		if self._leftCount > 0 then
			if isExistIntersect then
				PinGameController.instance:localNotify(PinGameController.PlaySuccessTween)
			end
		else
			PinGameController.instance:localNotify(PinGameController.PlaySuccessTween)
		end
	end
end

function DomAdvCopyPinGameRootCell:_onStopRotateRoot()
	self._isStartGame = false

	self:_stopRotateRoot()
end

function DomAdvCopyPinGameRootCell:_onPauseRotateRoot()
	self._isStartGame = false

	self:_pauseRotateRoot()
end

function DomAdvCopyPinGameRootCell:_onPlaySuccessTween()
	self._isStartGame = false

	self:_stopRotateRoot()
	self:_playSuccessTween()
end

function DomAdvCopyPinGameRootCell:_startRotateRoot()
	self:_stopRotateRoot()

	local duration = Mathf.Abs(360 / self._gameRootMo.rotateSpeed)
	local isClockwise = self._gameRootMo.rotateSpeed > 0
	local sign = isClockwise and 1 or -1

	self._rotateTween = self._rotateRoot.transform:DOLocalRotate(Vector3.New(0, 0, 360 * sign), duration, DG.Tweening.RotateMode.FastBeyond360):SetLoops(-1, DG.Tweening.LoopType.Restart):SetEase(DG.Tweening.Ease.Linear)
end

function DomAdvCopyPinGameRootCell:_stopRotateRoot()
	if self._rotateTween then
		self._rotateTween:Kill()

		self._rotateTween = nil
	end
end

function DomAdvCopyPinGameRootCell:_pauseRotateRoot()
	if self._rotateTween then
		self._rotateTween:Pause()
	end
end

function DomAdvCopyPinGameRootCell:_playRotateRootFromPause()
	if self._rotateTween then
		self._rotateTween:Play()
	end
end

function DomAdvCopyPinGameRootCell:playFromPause()
	self._isStartGame = true

	self:_recycleRecentNeedles()
	self:_playRotateRootFromPause()
end

function DomAdvCopyPinGameRootCell:_getPosInRotateRoot(needleGo)
	local needleAnchoredPos = GameUtil.getAnchoredPos(needleGo)
	local x, y, z = GameUtil.getLocalRotation(needleGo)
	local lineVec = Vector2.New(Mathf.Cos(z * Mathf.Deg2Rad) * self._gameRootMo.lineLength, Mathf.Sin(z * Mathf.Deg2Rad) * self._gameRootMo.lineLength)

	return needleAnchoredPos + lineVec
end

function DomAdvCopyPinGameRootCell:_isExistIntersect()
	local shootDirCount = #self._gameRootMo.shootDir
	local needleCount = #self._usingNeedleList
	local radiusSum = self._gameRootMo.lineRadius * 2

	for i = 1, shootDirCount do
		local newNeedle = self._usingNeedleList[needleCount - (i - 1)]
		local newNeedlePos = self:_getPosInRotateRoot(newNeedle)

		for j, v in ipairs(self._usingObstacleList) do
			local oldNeedlePos = self:_getPosInRotateRoot(v)
			local distance = GameUtil.distance(oldNeedlePos.x, oldNeedlePos.y, 0, newNeedlePos.x, newNeedlePos.y, 0)

			if distance <= radiusSum then
				return true
			end
		end

		for j, v in ipairs(self._usingNeedleList) do
			if j <= needleCount - shootDirCount then
				local oldNeedlePos = self:_getPosInRotateRoot(v)
				local distance = GameUtil.distance(oldNeedlePos.x, oldNeedlePos.y, 0, newNeedlePos.x, newNeedlePos.y, 0)

				if distance <= radiusSum then
					return true
				end
			end
		end
	end
end

function DomAdvCopyPinGameRootCell:_loadRoleModel()
	self:_resetRoleModel()

	local cfg = self._gameRootMo
	local curFaceId = cfg.raceId
	local x, y, scale = checknumber(cfg.pos[1]), checknumber(cfg.pos[2]), checknumber(cfg.scale)

	local function callback(go)
		self._skeletonGraphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._role, scale, callback, false, x, y)
end

function DomAdvCopyPinGameRootCell:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
	self._skeletonGraphic = nil
end

function DomAdvCopyPinGameRootCell:_startFlashTween()
	self:_stopFlashTween()
end

function DomAdvCopyPinGameRootCell:_stopFlashTween()
	if self._flashTween then
		self._flashTween:Kill(true)

		self._flashTween = nil
	end

	if self._skeletonGraphic then
		self._skeletonGraphic.color = Color.white
	end
end

function DomAdvCopyPinGameRootCell:_playFailTween(callback)
	self:_stopFailTween()

	self._failTween = self._rotateRoot.transform:DOScale(1.5, 0.2):SetEase(DG.Tweening.Ease.Linear):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(function()
		callback()
	end)
end

function DomAdvCopyPinGameRootCell:_stopFailTween()
	if self._failTween then
		self._failTween:Kill(true)

		self._failTween = nil
	end

	GameUtil.setLocalScale(self._rotateRoot, 1, 1, 1)
end

function DomAdvCopyPinGameRootCell:_playSuccessTween()
	self:_stopSuccessTween()

	local isClockwise = self._gameRootMo.rotateSpeed > 0
	local sign = isClockwise and 1 or -1

	self._successTween = self._rotateRoot.transform:DOLocalRotate(Vector3.New(0, 0, 360 * sign), DomAdvCopyPinGameRootCell.SuccessTweenTime, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.Linear):SetRelative()
end

function DomAdvCopyPinGameRootCell:_stopSuccessTween()
	if self._successTween then
		self._successTween:Kill()

		self._successTween = nil
	end
end

return DomAdvCopyPinGameRootCell
