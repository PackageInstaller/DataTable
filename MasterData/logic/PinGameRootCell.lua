-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameRootCell.lua

module("logic.extensions.pingame.view.PinGameRootCell", package.seeall)

local PinGameRootCell = class("PinGameRootCell")

PinGameRootCell.SuccessTweenTime = 0.8

function PinGameRootCell:ctor(parentGo, obstacle, needle)
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

function PinGameRootCell:initGameState(gameRootMo, mode, stagePlanId, stageId, isLocalGame, activityId, reviveData)
	self:clearGameState()
	PinGameController.instance:registerLocalNotify(PinGameController.ClickShootEvent, self._onClickShoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.StopRotateRoot, self._onStopRotateRoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.PauseRotateRoot, self._onPauseRotateRoot, self)
	PinGameController.instance:registerLocalNotify(PinGameController.PlaySuccessTween, self._onPlaySuccessTween, self)

	self._gameRootMo = gameRootMo
	self._mode = mode
	self._stagePlanId = stagePlanId
	self._stageId = stageId
	self._isLocalGame = isLocalGame
	self._activityId = activityId
	self._reviveData = reviveData
	self._leftCount = self._gameRootMo.winCount
	self._needleIndex = 0

	PinGameController.instance:localNotify(PinGameController.UpdateNeedleLeftNumEvent, self._leftCount)
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

function PinGameRootCell:startGameState()
	self._isStartGame = true

	self:_startRotateRoot()
end

function PinGameRootCell:clearGameState()
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
	self:_stopDelayTween()
	self:_resetRoleModel()
end

function PinGameRootCell:_setObstacles()
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

function PinGameRootCell:_getObstacle()
	if #self._freeObstacleList > 0 then
		return table.remove(self._freeObstacleList, #self._freeObstacleList)
	else
		return goutil.cloneAndSetParent(self._templateObstacle, self._rotateRoot.transform, "obstacle")
	end
end

function PinGameRootCell:_recycleObstacle(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		table.insert(self._freeObstacleList, go)
	end
end

function PinGameRootCell:_getNeedle()
	if #self._freeNeedleList > 0 then
		return table.remove(self._freeNeedleList, #self._freeNeedleList)
	else
		return goutil.cloneAndSetParent(self._templateNeedle, self._rotateRoot.transform, "needle")
	end
end

function PinGameRootCell:_recycleNeedle(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		table.insert(self._freeNeedleList, go)
	end
end

function PinGameRootCell:_shootNeedle()
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

function PinGameRootCell:_addToRecentNeedleList(needle)
	table.insert(self._recentShootNeedleList, needle)
end

function PinGameRootCell:_clearRecentNeedleList()
	table.clear(self._recentShootNeedleList)
end

function PinGameRootCell:_recycleRecentNeedles()
	for i, go in ipairs(self._recentShootNeedleList) do
		table.removebyvalue(self._usingNeedleList, go)
		self:_recycleNeedle(go)
	end

	self:_clearRecentNeedleList()
end

function PinGameRootCell:_setPosAndDegree(go, rootRadius, goTargetDegree)
	GameUtil.setAnchoredPos(go, Mathf.Cos(goTargetDegree * Mathf.Deg2Rad) * rootRadius, Mathf.Sin(goTargetDegree * Mathf.Deg2Rad) * rootRadius)
	GameUtil.setLocalRotation(go, 0, 0, goTargetDegree)
end

function PinGameRootCell:_onClickShoot()
	if self._isStartGame then
		local x, y, z = GameUtil.getLocalRotation(self._rotateRoot)

		if self._leftCount > 0 then
			self:_shootNeedle()
		end

		self._leftCount = Mathf.Max(0, self._leftCount - 1)

		PinGameController.instance:localNotify(PinGameController.UpdateNeedleLeftNumEvent, self._leftCount)
		self:_whetherToEndTheGame()
	end
end

function PinGameRootCell:_onStopRotateRoot()
	self._isStartGame = false

	self:_stopRotateRoot()
end

function PinGameRootCell:_onPauseRotateRoot()
	self._isStartGame = false

	self:_pauseRotateRoot()
end

function PinGameRootCell:_onPlaySuccessTween()
	self._isStartGame = false

	self:_stopRotateRoot()
	self:_playSuccessTween()
end

function PinGameRootCell:_startRotateRoot()
	self:_stopRotateRoot()

	local duration = Mathf.Abs(360 / self._gameRootMo.rotateSpeed)
	local isClockwise = self._gameRootMo.rotateSpeed > 0
	local sign = isClockwise and 1 or -1

	self._rotateTween = self._rotateRoot.transform:DOLocalRotate(Vector3.New(0, 0, 360 * sign), duration, DG.Tweening.RotateMode.FastBeyond360):SetLoops(-1, DG.Tweening.LoopType.Restart):SetEase(DG.Tweening.Ease.Linear)
end

function PinGameRootCell:_stopRotateRoot()
	if self._rotateTween then
		self._rotateTween:Kill()

		self._rotateTween = nil
	end
end

function PinGameRootCell:_pauseRotateRoot()
	if self._rotateTween then
		self._rotateTween:Pause()
	end
end

function PinGameRootCell:_playRotateRootFromPause()
	if self._rotateTween then
		self._rotateTween:Play()
	end
end

function PinGameRootCell:playFromPause()
	self._isStartGame = true

	self:_recycleRecentNeedles()
	self:_playRotateRootFromPause()
end

function PinGameRootCell:_getPosInRotateRoot(needleGo)
	local needleAnchoredPos = GameUtil.getAnchoredPos(needleGo)
	local x, y, z = GameUtil.getLocalRotation(needleGo)
	local lineVec = Vector2.New(Mathf.Cos(z * Mathf.Deg2Rad) * self._gameRootMo.lineLength, Mathf.Sin(z * Mathf.Deg2Rad) * self._gameRootMo.lineLength)

	return needleAnchoredPos + lineVec
end

function PinGameRootCell:_isExistIntersect()
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

function PinGameRootCell:_whetherToEndTheGame()
	if self._leftCount > 0 then
		if self:_isExistIntersect() then
			PinGameController.instance:localNotify(PinGameController.PauseRotateRoot)
			self:_playFailTween(function()
				if not self._isLocalGame then
					local cfg = PinGameConfig.instance:getRecoverCostCfg(self._activityId, self._reviveData.curNum + 1)

					if self._reviveData.curNum >= self._reviveData.maxNum or cfg and not MaterialMgr.getMatEnough(cfg.cost) then
						local isSuccess = false

						PinGameController.instance:sendPM_PinGameEndGameReq(self._activityId, self._mode, self._stageId, isSuccess)

						local text = "游戏失败！"

						local function okFunc()
							PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_Fail)
						end

						TipsFacade.instance:openTipWindowNoX(lang("tip"), text, okFunc, nil, UnityEngine.TextAnchor.MiddleCenter)
					else
						local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)
						local text = string.format("就差一点点就成功了，\n是否需要消耗<quad name=%d:%d|icon size=25 width=1 offsetY=-5/>*%d复活1次？\n本局还可复活%d次", matType, id, matNum, self._reviveData.maxNum - self._reviveData.curNum)

						local function okFunc()
							PinGameAgent.instance:sendPM_PinGameRecoverReq(self._activityId)
						end

						local function cancelFunc()
							local isSuccess = false

							PinGameController.instance:sendPM_PinGameEndGameReq(self._activityId, self._mode, self._stageId, isSuccess)
							PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_Fail)
						end

						TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cancelFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
					end
				else
					local text = "游戏失败！"

					local function okFunc()
						PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_Fail)
					end

					TipsFacade.instance:openTipWindowNoX(lang("tip"), text, okFunc, nil, UnityEngine.TextAnchor.MiddleCenter)
				end
			end)
		end
	else
		PinGameController.instance:localNotify(PinGameController.PlaySuccessTween)
		self:_playDelayTween(function()
			if not self._isLocalGame then
				local isSuccess = true

				PinGameController.instance:sendPM_PinGameEndGameReq(self._activityId, self._mode, self._stageId, isSuccess)
			end

			local text = "游戏胜利！"

			local function okFunc()
				PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_Success)
			end

			TipsFacade.instance:openTipWindowNoX(lang("tip"), text, okFunc, nil, UnityEngine.TextAnchor.MiddleCenter)
		end)
	end
end

function PinGameRootCell:_loadRoleModel()
	self:_resetRoleModel()

	local cfg = self._gameRootMo
	local curFaceId = cfg.raceId
	local x, y, scale = checknumber(cfg.pos[1]), checknumber(cfg.pos[2]), checknumber(cfg.scale)

	local function callback(go)
		self._skeletonGraphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._role, scale, callback, false, x, y)
end

function PinGameRootCell:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
	self._skeletonGraphic = nil
end

function PinGameRootCell:_startFlashTween()
	self:_stopFlashTween()
end

function PinGameRootCell:_stopFlashTween()
	if self._flashTween then
		self._flashTween:Kill(true)

		self._flashTween = nil
	end

	if self._skeletonGraphic then
		self._skeletonGraphic.color = Color.white
	end
end

function PinGameRootCell:_playFailTween(callback)
	self:_stopFailTween()

	self._failTween = self._rotateRoot.transform:DOScale(1.5, 0.2):SetEase(DG.Tweening.Ease.Linear):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(function()
		callback()
	end)
end

function PinGameRootCell:_stopFailTween()
	if self._failTween then
		self._failTween:Kill(true)

		self._failTween = nil
	end

	GameUtil.setLocalScale(self._rotateRoot, 1, 1, 1)
end

function PinGameRootCell:_playSuccessTween()
	self:_stopSuccessTween()

	local isClockwise = self._gameRootMo.rotateSpeed > 0
	local sign = isClockwise and 1 or -1

	self._successTween = self._rotateRoot.transform:DOLocalRotate(Vector3.New(0, 0, 360 * sign), PinGameRootCell.SuccessTweenTime, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.Linear):SetRelative()
end

function PinGameRootCell:_stopSuccessTween()
	if self._successTween then
		self._successTween:Kill()

		self._successTween = nil
	end
end

function PinGameRootCell:_playDelayTween(callback)
	self:_stopDelayTween()

	self._delayTween = TweenUtil.DoDelay(PinGameRootCell.SuccessTweenTime, function()
		callback()
	end)
end

function PinGameRootCell:_stopDelayTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

return PinGameRootCell
