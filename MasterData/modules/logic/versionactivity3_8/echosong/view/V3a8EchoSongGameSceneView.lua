-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameSceneView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameSceneView", package.seeall)

local V3a8EchoSongGameSceneView = class("V3a8EchoSongGameSceneView", BaseView)

function V3a8EchoSongGameSceneView:onInitView()
	self._goBg1 = gohelper.findChild(self.viewGO, "#sImage_FullBG1")
	self._goBg2 = gohelper.findChild(self.viewGO, "#sImage_FullBG2")
	self._gojoystick = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick")
	self._goscene = gohelper.findChild(self.viewGO, "#go_scene")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameSceneView:addEvents()
	return
end

function V3a8EchoSongGameSceneView:removeEvents()
	return
end

function V3a8EchoSongGameSceneView:_btnResetOnClick()
	return
end

function V3a8EchoSongGameSceneView:_onResetGame()
	self._progressInfo = {}

	V3a8EchoSongController.setSaveStr(V3a8EchoSongEnum.SaveType.Progress, V3a8EchoSongModel.instance:getGameId(), cjson.encode(self._progressInfo))
	self:_rollback()
	self:_updateScenePos()
end

function V3a8EchoSongGameSceneView:_onRestartGame()
	self:_rollback()
	self:_updateScenePos()

	self._skipLateUpdate = false
end

function V3a8EchoSongGameSceneView:_onShowResultView(isSuccess)
	self._skipLateUpdate = true

	self:_resetJoystick()

	if isSuccess then
		gohelper.setActive(self._sceneRoot, false)
	end
end

function V3a8EchoSongGameSceneView:_onFinishSavePoint()
	self:_saveProgress()
end

function V3a8EchoSongGameSceneView:_onGuideDragJoystick()
	self._isGuideDragJoystick = true
end

function V3a8EchoSongGameSceneView:_onGuideShortPress()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Short)
end

function V3a8EchoSongGameSceneView:_editableInitView()
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.Event3Trigger, self._onEvent3Trigger, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.Enemy1Init, self._onEnemy1Init, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.Enemy2Init, self._onEnemy2Init, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ResetGame, self._onResetGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.RestartGame, self._onRestartGame, self, LuaEventSystem.High)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ShowResultView, self._onShowResultView, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.FinishSavePoint, self._onFinishSavePoint, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.GuideDragJoystick, self._onGuideDragJoystick, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.GuideShortPress, self._onGuideShortPress, self)
	self:createScene()
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
end

function V3a8EchoSongGameSceneView:_showBg()
	local showBgIndex = V3a8EchoSongEnum.BgType.Green
	local bg2 = gohelper.findChild(self._sceneNode, "unit/bg2")

	if bg2 and bg2.gameObject.activeSelf then
		showBgIndex = V3a8EchoSongEnum.BgType.Purple
	end

	V3a8EchoSongModel.instance:setBgType(showBgIndex)

	local res = self.viewContainer:getSetting().otherRes["bg" .. showBgIndex]
	local texture = self.viewContainer:getRes(res)
	local meshRender = self._sceneBgGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	if not self._sceneBgMat then
		local sharedMat = meshRender and meshRender.sharedMaterial

		if sharedMat then
			self._sceneBgMat = UnityEngine.Object.Instantiate(sharedMat)
			meshRender.sharedMaterial = self._sceneBgMat
		end
	end

	if self._sceneBgMat then
		self._sceneBgMat:SetTexture("_MainTex", texture)
	end

	gohelper.setActive(self["_goBg" .. showBgIndex], true)
end

function V3a8EchoSongGameSceneView:createScene()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("V3a8EchoSongGameScene")

	gohelper.addChild(sceneRoot, self._sceneRoot)

	self._sceneBgGo = self:getResInst(self.viewContainer:getSetting().otherRes.sceneBg, self._sceneRoot)
	self._sceneBallNode = UnityEngine.GameObject.New("node")

	gohelper.addChild(self._sceneRoot, self._sceneBallNode)

	self._initBallNodePosX, self._initBallNodePosY = transformhelper.getPos(self._sceneBallNode.transform)

	local ballItem = self:getResInst(self.viewContainer:getSetting().otherRes.ballItem, self._sceneBallNode, "ballItem")

	gohelper.setActive(ballItem, false)

	local hitBallItem = self:getResInst(self.viewContainer:getSetting().otherRes.hitBallItem, self._sceneBallNode, "hitBallItem")

	gohelper.setActive(hitBallItem, false)
	V3a8EchoSongModel.instance:initBalls(self._sceneBallNode, ballItem, hitBallItem)

	self._cameraRootTrans = CameraMgr.instance:getMainCameraTrs().parent
end

function V3a8EchoSongGameSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = 5
end

function V3a8EchoSongGameSceneView:_onEnemy1Init(params)
	local id = params.id
	local enemyItem = self._enemys[id]

	if not enemyItem then
		local path = self.viewContainer:getSetting().otherRes.enemyItem
		local enemyGo = self:getResInst(path, self._itemNode, "enemy_" .. tostring(id))

		enemyItem = MonoHelper.addNoUpdateLuaComOnceToGo(enemyGo, V3a8EchoSongEnemy1EntityComp)
		self._enemys[id] = enemyItem

		enemyItem:initComp(self, id, params)
	end
end

function V3a8EchoSongGameSceneView:_onEnemy2Init(params)
	local id = params.id
	local enemyItem = self._enemys[id]

	if not enemyItem then
		local path = self.viewContainer:getSetting().otherRes.enemyItem
		local enemyGo = self:getResInst(path, self._itemNode, "enemy_" .. tostring(id))

		enemyItem = MonoHelper.addNoUpdateLuaComOnceToGo(enemyGo, V3a8EchoSongEnemy2EntityComp)
		self._enemys[id] = enemyItem

		enemyItem:initComp(self, id, params)
	end
end

function V3a8EchoSongGameSceneView:_startEnemysLogic()
	for k, v in pairs(self._enemys) do
		v:startLogic()
	end
end

function V3a8EchoSongGameSceneView:checkEntityHit(ballItem)
	if ballItem and ballItem:getTriggerType() == V3a8EchoSongEnum.ParticleType.Enemy2 then
		self._mainPlayer:checkHitParticle(ballItem)
	else
		for k, v in pairs(self._enemys) do
			v:checkHitParticle(ballItem)
		end

		self:_checkTrapBallHit(ballItem)
	end
end

function V3a8EchoSongGameSceneView:_checkTrapBallHit(ballItem)
	if not ballItem then
		return
	end

	for i = 1, #self._traps do
		self._traps[i]:checkBallInBounds(ballItem)
	end
end

function V3a8EchoSongGameSceneView:_onEvent3Trigger(id, triggerType)
	local item = self._comps[id]

	if not item then
		logError("V3a8EchoSongGameSceneView _onEvent3Trigger item is nil id:", tostring(id))

		return
	end

	if item:getType() ~= V3a8EchoSongEnum.UnitType.Trap then
		logError("V3a8EchoSongGameSceneView _onEvent3Trigger item type is not trap id:", tostring(id))

		return
	end

	item:setTrigger(triggerType)
end

function V3a8EchoSongGameSceneView:_initProgress()
	self._progressInfo = self:_loadProgress() or {}

	self:_rollback()
end

function V3a8EchoSongGameSceneView:_loadProgress()
	local str = V3a8EchoSongController.getSaveStr(V3a8EchoSongEnum.SaveType.Progress, V3a8EchoSongModel.instance:getGameId())

	if not string.nilorempty(str) then
		local ok, json = pcall(cjson.decode, str)

		if ok then
			return json
		else
			logError("V3a8EchoSongGameSceneView _loadProgress 非法json:", tostring(str))
		end
	end
end

function V3a8EchoSongGameSceneView:_saveProgress()
	self._progressInfo = self:_getCurProgressInfo()

	if self._progressInfo then
		V3a8EchoSongController.setSaveStr(V3a8EchoSongEnum.SaveType.Progress, V3a8EchoSongModel.instance:getGameId(), cjson.encode(self._progressInfo))
		logNormal("V3a8EchoSongGameSceneView _saveProgress")
	end
end

function V3a8EchoSongGameSceneView:_getCurProgressInfo()
	local result = {}

	for id, v in pairs(self._comps) do
		local info = v:getRecordInfo()

		if info then
			if not result[id] then
				result[id] = info
			else
				logError("V3a8EchoSongGameSceneView _getCurProgressInfo id repeat:", tostring(id))
			end
		end
	end

	for id, v in pairs(self._enemys) do
		local info = v:getRecordInfo()

		if info then
			if not result[id] then
				result[id] = info
			else
				logError("V3a8EchoSongGameSceneView _getCurProgressInfo id repeat:", tostring(id))
			end
		end
	end

	result[V3a8EchoSongEnum.MainPlayerId] = self._mainPlayer:getRecordInfo()

	return result
end

function V3a8EchoSongGameSceneView:_rollback()
	if not self._progressInfo then
		logError("V3a8EchoSongGameSceneView _rollback progressInfo is nil")

		return
	end

	for id, v in pairs(self._comps) do
		local info = self._progressInfo[id]

		v:rollback(info)
	end

	for id, v in pairs(self._enemys) do
		local info = self._progressInfo[id]

		v:rollback(info)
	end

	local info = self._progressInfo[V3a8EchoSongEnum.MainPlayerId]

	self._mainPlayer:rollback(info)
end

function V3a8EchoSongGameSceneView:onOpen()
	self._comps = self:getUserDataTb_()
	self._enemys = self:getUserDataTb_()
	self._traps = self:getUserDataTb_()
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	self._isSlow = true
	self._sceneNode = self:getResInst(V3a8EchoSongController.instance:getScenePath(), self._goscene)
	self._initScenePosX, self._initScenePosY = transformhelper.getPos(self._goscene.transform)
	self._itemNode = gohelper.create2d(self._sceneNode, "item")

	self:_showBg()
	self:_initUnits()
	self:_initMainPlayer()
	self:_initProgress()
	self:_startEnemysLogic()
	self:_updateScenePos()

	self._joystick = MonoHelper.addNoUpdateLuaComOnceToGo(self._gojoystick, V3a8EchoSongJoystick)
	self._skipLateUpdate = false

	LateUpdateBeat:Add(self._onLateUpdate, self)
end

function V3a8EchoSongGameSceneView:_initUnits()
	local unitGo = gohelper.findChild(self._sceneNode, "unit")

	if not unitGo then
		logError("not find unit")

		return
	end

	local dynamicGo = gohelper.findChild(self._sceneNode, "dynamic")

	if not dynamicGo then
		logError("not find dynamic")

		return
	end

	transformhelper.setLocalScale(unitGo.transform, V3a8EchoSongEnum.SceneScale, V3a8EchoSongEnum.SceneScale, 1)
	transformhelper.setLocalScale(dynamicGo.transform, V3a8EchoSongEnum.SceneScale, V3a8EchoSongEnum.SceneScale, 1)

	self._unitMap = {}

	for unitName, unitValue in pairs(V3a8EchoSongEnum.UnitType) do
		self._unitMap[unitValue] = unitName
	end

	local dynamicTrans = dynamicGo.transform

	for i = 0, dynamicTrans.childCount - 1 do
		local child = dynamicTrans:GetChild(i)
		local name = child.name
		local paramList = GameUtil.splitString2(name, true, "|", "#")
		local firstParam = paramList[1]
		local secondParam = paramList[2]
		local thirdParam = paramList[3]
		local unitValue = firstParam[1]
		local unitName = self._unitMap[unitValue]

		if not unitName then
			logError("not find unitName", unitValue)
		else
			local clsName = string.format("V3a8EchoSong%sComp", unitName)
			local cls = _G[clsName]

			if not cls then
				logError(string.format("V3a8EchoSongGameSceneView:_initUnits unitName = %s, clsName = %s not found", unitName, clsName))
			elseif not secondParam or not secondParam[1] then
				logError("secondParam is nil type:", unitName)
			else
				local id = secondParam[1]

				if self._comps[id] then
					logError("V3a8EchoSongGameSceneView:_initUnits id is repeat:", id)
				else
					local item = MonoHelper.addNoUpdateLuaComOnceToGo(child.gameObject, cls)

					item:initComp(self, unitValue, id, thirdParam, paramList)

					self._comps[id] = item

					if unitValue == V3a8EchoSongEnum.UnitType.Trap then
						table.insert(self._traps, item)
					end
				end
			end
		end
	end
end

function V3a8EchoSongGameSceneView:_initMainPlayer()
	local path = self.viewContainer:getSetting().otherRes.roleItem

	self._mainPlayerGo = self:getResInst(path, self._itemNode, "mainPlayer")

	local spawnUnit = self:_getItemByType(V3a8EchoSongEnum.UnitType.SpawnPoint)

	if spawnUnit then
		local x, y = recthelper.getAnchor(spawnUnit:getGo().transform)

		recthelper.setAnchor(self._mainPlayerGo.transform, x, y)
	end

	self._mainPlayer = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, V3a8EchoSongMainPlayerEntityComp)
	self._tempPos = Vector2()
end

function V3a8EchoSongGameSceneView:getMainPlayerGo()
	return self._mainPlayerGo
end

function V3a8EchoSongGameSceneView:_getItemByType(type)
	for k, item in pairs(self._comps) do
		if item:getType() == type then
			return item
		end
	end
end

function V3a8EchoSongGameSceneView:getCompById(id)
	return self._comps[id]
end

function V3a8EchoSongGameSceneView:_moveMainPlayer(x, y, strength)
	self._mainPlayer:move(x, y, strength)
	self:_updateScenePos()

	self._tempPos.x, self._tempPos.y = recthelper.getAnchor(self._mainPlayerGo.transform)

	local mainPlayerWorldX, mainPlayerWorldY = transformhelper.getPos(self._mainPlayerGo.transform)

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.MoveMainPlayer, self._tempPos, mainPlayerWorldX, mainPlayerWorldY)
end

function V3a8EchoSongGameSceneView:_updateScenePos()
	local posX, posY = recthelper.getAnchor(self._mainPlayerGo.transform)
	local scaleX, scaleY = transformhelper.getLocalScale(self._goscene.transform)

	recthelper.setAnchor(self._goscene.transform, -posX * scaleX, -posY * scaleY)

	local curPosX, curPosY = transformhelper.getPos(self._goscene.transform)
	local deltaX = curPosX - self._initScenePosX
	local deltaY = curPosY - self._initScenePosY

	transformhelper.setLocalScale(self._sceneBallNode.transform, scaleX, scaleY, 1)
	transformhelper.setPosXY(self._sceneBallNode.transform, self._initBallNodePosX + deltaX, self._initBallNodePosY + deltaY)
end

function V3a8EchoSongGameSceneView:externalUpdateScenePos()
	self:_updateScenePos()
end

function V3a8EchoSongGameSceneView:_onLateUpdate()
	if self._skipLateUpdate then
		return
	end

	local pressKeyX, pressKeyY
	local skipInput = not not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongInGuide)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongDragScreen) then
		return
	end

	if not self._isMobilePlayer and not skipInput then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
			pressKeyX = 1
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
			pressKeyX = -1
		end

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
			pressKeyY = 1
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
			pressKeyY = -1
		end

		if self._isSlow then
			pressKeyX = pressKeyX and pressKeyX * 0.5
			pressKeyY = pressKeyY and pressKeyY * 0.5
		end

		if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.LeftAlt) or UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.RightAlt) then
			self._isSlow = not self._isSlow
		end

		if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Space) then
			if self._spaceKeyDownTime then
				if Time.time - self._spaceKeyDownTime > V3a8EchoSongEnum.LongPressTime then
					V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Long)
				else
					V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Short)
				end

				self._spaceKeyDownTime = nil
			end
		elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Space) then
			self._spaceKeyDownTime = Time.time
		end
	end

	local isDragging = self._joystick:getIsDragging()

	if not isDragging and (pressKeyX or pressKeyY) then
		self._joystick:setInPutValue(pressKeyX, pressKeyY)
	end

	if isDragging or pressKeyX or pressKeyY then
		local input = self._joystick:getInputValue()
		local strength = self._joystick:getStrength()

		self:_moveMainPlayer(input.x, input.y, strength)

		self._needReset = true

		if self._isGuideDragJoystick then
			self._isGuideDragJoystick = nil

			TaskDispatcher.cancelTask(self._sendGuideMovePlayer, self)
			TaskDispatcher.runDelay(self._sendGuideMovePlayer, self, 1)
		end
	elseif self._needReset then
		self:_stopMove()
		self:_resetJoystick()

		self._needReset = false
	end

	transformhelper.setPosXY(self._cameraRootTrans, 0, 0)
end

function V3a8EchoSongGameSceneView:_sendGuideMovePlayer()
	self._joystick:reset()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.GuideMoveMainPlayer)
end

function V3a8EchoSongGameSceneView:_resetJoystick()
	if not self._joystick then
		return
	end

	self._joystick:reset()
	self._mainPlayer:clearMoveTime()
end

function V3a8EchoSongGameSceneView:_stopMove()
	self._mainPlayer:stopMove()
end

function V3a8EchoSongGameSceneView:onClose()
	LateUpdateBeat:Remove(self._onLateUpdate, self)
	TaskDispatcher.cancelTask(self._sendGuideMovePlayer, self)

	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

function V3a8EchoSongGameSceneView:onDestroyView()
	if self._sceneBgMat then
		UnityEngine.Object.Destroy(self._sceneBgMat)

		self._sceneBgMat = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return V3a8EchoSongGameSceneView
