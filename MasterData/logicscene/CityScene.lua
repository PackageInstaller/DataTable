-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/CityScene.lua

module("logicscene.scene.impl.CityScene", package.seeall)

local CityScene = class("CityScene", SceneBase)
local HUDRoot, UICamera, GameCamera, UICanvas

function CityScene:ctor(container)
	CityScene.super.ctor(self, container)

	self._otherPlayerVisible = true
	self._forcedVisiblePlayerId = nil

	if not HUDRoot then
		HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

		SceneHudMgr.instance:setHudCacheParent(SceneHudMgr.HUD_OTHERS_PLAYER, HUDRoot)
	end

	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end
end

function CityScene:_initComponents()
	self:_addComponent("unitFactory", CityUnitFactory)
	self:_addComponent("festivals", SceneCompFestivals)
	self:_addComponent("camera", CitySceneCameraEx)
	self:_addComponent("stage", SceneCityStage)
	self:_addComponent("pathFinder", ScenePathFinderEx)
	self:_addComponent("joystick", SceneJoystickListenerEx)
	self:_addComponent("picker", ScenePickerEx)
	self:_addComponent("otherPlayers", SceneOtherPlayers)
	self:_addComponent("monsterMgr", SceneMonsterMgr)
	self:_addComponent("bgm", SceneBgmMgr)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("npcUnlock", SceneCompNpcsUnlock)
	self:_addComponent("idleAnimations", SceneCompIdleAnimations)
end

function CityScene:setFestival(festivel)
	self._festivel = festivel
end

function CityScene:getFestival()
	return self._festivel
end

function CityScene:setSwithFestival(isSwitchFestival)
	self._isSwitchFestival = isSwitchFestival
end

function CityScene:isSwithFestival()
	return self._isSwitchFestival
end

function CityScene:setUnderBridge(under)
	self._underBridge = under
end

function CityScene:isUnderBridge()
	return self._underBridge
end

function CityScene:onEnter(sceneId, bornX, bornZ)
	SceneMainPlayer.instance:onEnterScene(self)
	UIStateManager.instance:setRoot(self:getDefaultView())

	self._visibleElements = {}
	self._visibleElementReses = {}

	CityScene.super.onEnter(self, sceneId, bornX, bornZ)
end

function CityScene:startTransitionScene()
	self.joystick:setEnable(false)
	self.picker:enabled(false)
end

function CityScene:onEnterFinished()
	SceneMainPlayer.instance:updatePlayerPosition(self)
	self.camera:updateCameraParams()
	self.stage.wholeScene:BuildSceneTree()
	GameUtil.SetSceneAmbient(self:getSceneId())
	SceneMainPlayer.instance:onEnterSceneFinished(self)
	TaskController.instance:resetInnerPause()
	UIStateManager.instance:setRoot(self:getDefaultView())

	CommonObjectMgr.shadowOrder = nil
	AoSceneManager.Instance.enabled = true

	AoSceneManager.Instance:EnabledSceneQuery(true)

	self.isReady = true
	self.mainPlayer = SceneMainPlayer.instance

	local wholeScene = self.stage.wholeScene

	wholeScene:RegisterTriggerListener(self._onTriggerEnter, self)
	wholeScene:RegisterTransmitPointsListener(self._onTransmitPointEnter, self)
	wholeScene:RegisterTransmitGroupsListener(self._onTransmitGroupEnter, self)

	local mainGo = self.mainPlayer:getMainPlayer().go.transform

	wholeScene:SetTransmiGroupsTarget(mainGo)
	wholeScene:SetTransmitPointsTarget(mainGo)
	wholeScene:SetTriggerTarget(mainGo)
	TriggersMgr.instance:onEnterSceneFinished(self:getSceneId())
	BarriersMgr.instance:onEnterSceneFinished(self:getSceneId())
	SceneNpcsMgr.instance:onEnterSceneFinished(self:getSceneId())
	SceneElemsMgr.instance:onEnterSceneFinished(self:getSceneId())
	self:_openViewOnEnter()
	GlobalDispatcher:addListener(GlobalNotify.NewSceneUnlock, self._onSceneUnlock, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneUnlockReady, self._onSceneUnlockReady, self)

	UnityEngine.Time.timeScale = 1

	BattleFacade.instance:clearStatus()

	self.defaultView = nil

	UIStateManager.instance:setRoot(self:getDefaultView())
	CityScene.super.onEnterFinished(self)
end

function CityScene:getDefaultView()
	if self.defaultView then
		return self.defaultView
	end

	return ViewName.MainUI
end

function CityScene:onExitFinished()
	self:_clearAllElementsReses()
	ColorfulEggsController.instance:clearAllTriggeredEggs()
	SceneMainPlayer.instance:onExitSceneFinished(self)
	CityScene.super.onExitFinished(self)
	GameEffectManager.instance:clearAll()
	GameEffectManager.instance:releaseUnuseResources()

	if not goutil.isNil(self._container) then
		goutil.destroy(self._container)

		self._container = nil
	end
end

function CityScene:onExit()
	AoSceneManager.Instance:EnabledSceneQuery(false)

	AoSceneManager.Instance.enabled = false

	SceneMainPlayer.instance:onExitScene()

	self._otherPlayerVisible = true

	GlobalDispatcher:removeListener(GlobalNotify.SceneUnlockReady, self._onSceneUnlockReady, self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSceneUnlock, self._onSceneUnlock, self)

	self._ingoreTransmitPoint = nil
	self._userVariabls = nil

	UIStateManager.instance:setRoot(nil)
	GlobalController.instance:closePlayerStrengthChange()

	self.isReady = nil
	self._visibleElements = nil

	self:_recyleAllTranspointHud()
	self:removeAllTriggers()
	CityScene.super.onExit(self)
end

function CityScene:_recyleAllTranspointHud()
	if self._transformHuds then
		for k, v in pairs(self._transformHuds) do
			v:SetActive(false)
			SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TRANSMITPOINT, v)
		end

		self._transformHuds = nil
	end
end

function CityScene:_clearAllElementsReses()
	if self._visibleElementReses then
		for k, v in pairs(self._visibleElementReses) do
			v:Release()
		end

		self._visibleElementReses = nil
	end
end

function CityScene:_createTranspointHud(id, go)
	local hud = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_TRANSMITPOINT, function(hudType, hudGo)
		if self._visibleElements and self._visibleElements[id] and not goutil.isNil(go) then
			self:_initTranspointHud(go, hudGo, id)
		else
			hudGo:SetActive(false)
			SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TRANSMITPOINT, hudGo)
		end
	end)

	if hud then
		self:_initTranspointHud(go, hud, id)
	end
end

function CityScene:_initTranspointHud(go, hud, sceneId)
	if hud.transform.parent ~= HUDRoot.transform then
		hud.transform:SetParent(HUDRoot.transform)
	end

	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)
	local name = goutil.findChild(hud, "Name"):GetComponent("Text")

	name.text = sceneCo.scene_name
	hud.name = "sceneName_" .. sceneId

	hud:SetActive(true)

	self._transformHuds = self._transformHuds or {}
	self._transformHuds[sceneId] = hud

	local nameGo = goutil.findChild(go, "name")
	local followCom = hud:GetComponent(ComponentType.UIFollowTarget)

	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.canvas = UICanvas

	if nameGo then
		followCom.target = nameGo.transform
		followCom.offsetY3D = 0
	else
		followCom.target = go.transform
		followCom.offsetY3D = 2.9
	end

	followCom.enabled = true

	Framework.TransformUtil.SetLocalPos(hud.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(hud.transform, 1, 1, 1)
end

function CityScene:_recyleTranspointHud(id)
	if self._transformHuds then
		local hud = self._transformHuds[id]

		if hud then
			hud:SetActive(false)
			SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TRANSMITPOINT, hud)

			self._transformHuds[id] = nil
		end
	end
end

function CityScene:update(deltaTime)
	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:update(deltaTime)
		end
	end

	if self.mainPlayer then
		local mainPlayer = self.mainPlayer:getMainPlayer()

		if mainPlayer then
			mainPlayer:update(deltaTime)
		end
	end

	self.walkEff:update(deltaTime)
	ColorfulEggsController.instance:updateEggs(deltaTime)

	if self.npcUnlock then
		self.npcUnlock:update()
	end

	if self.festivals then
		self.festivals:update(deltaTime)
	end
end

function CityScene:lateUpdate()
	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if v2.lateUpdate then
				v2:lateUpdate()
			end
		end
	end
end

function CityScene:setIngoreTransmitPoint(ingoreTransmitPoint)
	self._ingoreTransmitPoint = ingoreTransmitPoint
end

function CityScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(visible)
	end

	if self.walkEff then
		self.walkEff:setVisible(visible)
	end

	self._otherPlayerVisible = visible

	self.unitFactory:showUnits(visible)
end

function CityScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(visible)
	end
end

function CityScene:visibleOthersObjects(visible)
	local units = self.unitFactory:getAllUnit()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if v2:getTag() ~= UnitTag.Pet or v2:getOwner() ~= mainPlayer then
				v2:setVisible(visible)
			end
		end
	end

	self._otherPlayerVisible = visible
end

function CityScene:visibleNpcs(visible)
	self.unitFactory:showUnitsByTag(UnitTag.Npc, visible)
end

function CityScene:getSceneType()
	return SceneType.City
end

function CityScene:triggerBarrierGroup(groupId, triggered)
	self.stage.wholeScene:TriggerBarrierGroup(groupId, triggered)
end

function CityScene:createTrigger(triggerId)
	self.stage.wholeScene:AddTrigger(self:getSceneId(), triggerId)
end

function CityScene:removeTrigger(triggerId)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.triggerId == triggerId then
		mainPlayer.triggerId = nil
	end

	self.stage.wholeScene:RemoveTrigger(self:getSceneId(), triggerId)
end

function CityScene:removeAllTriggers()
	if self.stage.wholeScene then
		self.stage.wholeScene:ClearTriggers()
	end
end

function CityScene:createElement(elemId, layer)
	self.stage.wholeScene:BuildElement(elemId, layer)
end

function CityScene:removeElement(elemId)
	self.stage.wholeScene:RemoveElement(elemId)
end

function CityScene:getTransmitPoint(toSceneId)
	if toSceneId == self._curSceneId then
		return nil
	end

	return self.stage.wholeScene:GetTransmitPointPos(toSceneId, nil, nil)
end

function CityScene:getTriggerPos(triggerId)
	return self.stage.wholeScene:GetTriggerPos(triggerId, nil, nil)
end

function CityScene:getNpcModel(npcId)
	local path = self:_onNpcModel(npcId)

	if path then
		return path
	end

	return self.stage.wholeScene:GetNpcModel(npcId)
end

function CityScene:createMainPlayerPet()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local px, py = mainPlayer.transform:getPos()
	local found, posX, posY = self.stage.wholeScene:FindNotBerrierAround(mainPlayer.sceneUnit, px, py, false, nil, nil)

	return self.unitFactory:createMainPlayerPet(posX, posY)
end

function CityScene:removeMainPlayerPet()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.petUnit then
		if mainPlayer.petUnit.petUnit then
			self.unitFactory:destroyCommonObject(mainPlayer.petUnit.petUnit:getTag(), mainPlayer.petUnit.petUnit.id)

			mainPlayer.petUnit.petUnit = nil
		end

		self.unitFactory:destroyCommonObject(mainPlayer.petUnit:getTag(), mainPlayer.petUnit.id)

		mainPlayer.petUnit = nil
	end
end

function CityScene:createUnitPet(unit, itemId, avatarPetData, petName, petTag)
	if not avatarPetData or not self.stage or not self.stage.wholeScene then
		return
	end

	local playerPosX, playerPosY = unit.transform:getPos()
	local found, posX, posY = self.stage.wholeScene:FindNotBerrierAround(unit.sceneUnit, playerPosX, playerPosY, false, nil, nil)
	local petId = checknumber(itemId)
	local name = petName or ""
	local userData = {}

	userData.ownerTag = unit:getTag()
	userData.ownerId = unit.id
	userData.partIds = avatarPetData or {}
	userData.petName = name
	userData.petId = petId
	userData.petTag = petTag

	local userDataStr = GameUtil.jsonToString(userData)

	self.unitFactory:createUnitPet(petId, posX, posY, userDataStr)
end

function CityScene:createUnitZoo(unit, itemId, zooData)
	if not zooData or not self.stage or not self.stage.wholeScene then
		return
	end

	local playerPosX, playerPosY = unit.transform:getPos()
	local found, posX, posY = self.stage.wholeScene:FindNotBerrierAround(unit.sceneUnit, playerPosX, playerPosY, false, nil, nil)
	local petId = checknumber(itemId)
	local userData = {}

	userData.ownerTag = unit:getTag()
	userData.ownerId = unit.id
	userData.partIds = zooData.partIds or {}
	userData.preName = CityUnitFactory.UnitPlayerZoo

	local userDataStr = GameUtil.jsonToString(userData)

	self.unitFactory:createUnitPet(petId, posX, posY, userDataStr)
end

function CityScene:removeUnitPet(unit, key)
	local petUnit = unit and unit:getPetUnit(key)

	if petUnit then
		self.unitFactory:destroyCommonObject(petUnit:getTag(), petUnit.id)
		unit:removePetUnit(key)
	end
end

function CityScene:removeAllUnitPet(unit)
	local petUnits = unit and unit:getAllPetUnit()

	if petUnits then
		for k, v in pairs(petUnits) do
			self.unitFactory:destroyCommonObject(v:getTag(), v.id)
		end

		unit:removeAllPetUnit()
	end
end

function CityScene:showOthersPlayers(visible)
	self._otherPlayerVisible = visible

	self.unitFactory:showUnitsByTag(UnitTag.Player, visible)
end

function CityScene:getCellRowAndColIndexByPosition(x, y)
	return self.stage.wholeScene:GetCellIndexByPositionForLua(x, y, nil, nil)
end

function CityScene:isPositionReachable(unit, x, y)
	return self.stage.wholeScene:IsPositionReachable(unit, x, y)
end

function CityScene:getNearestTransmitGroupPos(startX, startY, endX, endY)
	return self.stage.wholeScene:GetNearestTransmitGroupPos(startX, startY, endX, endY, nil, nil, nil, nil)
end

function CityScene:getSceneSize()
	return self.stage.wholeScene:GetSize()
end

function CityScene:findRandomNotBerrierAround(sceneunit, x, y, checkAirWaill)
	return self.stage.wholeScene:FindRandomNotBerrierAround(sceneunit, x, y, checkAirWaill or false, nil, nil)
end

function CityScene:findRandomNotBerrierAroundWithDistance(sceneunit, x, y, distance, checkAirWaill)
	return self.stage.wholeScene:FindRandomNotBerrierAround(sceneunit, x, y, distance, checkAirWaill or false, nil, nil)
end

function CityScene:getElementTriggerParams(elementId)
	return self.stage.wholeScene:GetElementTriggerParams(elementId, nil, nil, nil)
end

function CityScene:_onNpcModel(npcId)
	return SceneConfig.instance:getNpcModelFromConfig(npcId)
end

function CityScene:_onNpcVisible(npcId, go, visible)
	local unit = self.unitFactory:getUnit(UnitTag.Npc, npcId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible(go)
		end
	end
end

function CityScene:_onNpcCreate(npcId, pos, ofs, paths, moveSpeed, reverse, nameOfs, scale)
	local unit = self.unitFactory:createNpcUnit(npcId)

	if unit and unit.onUnitCreated then
		unit:onUnitCreated({
			posX = pos.x,
			posY = pos.y,
			posZ = pos.z,
			paths = paths,
			ofsX = ofs.x,
			ofsZ = ofs.z,
			ofsY = ofs.y,
			moveSpeed = moveSpeed,
			reverse = reverse,
			nameOfsX = nameOfs.x,
			nameOfsY = nameOfs.y,
			nameOfsZ = nameOfs.z,
			scaleX = scale.x,
			scaleY = scale.y,
			scaleZ = scale.z
		})
	end

	if self.stage.wholeScene.preloadAll and self.stage.wholeScene:GetFunctionType(npcId) == 0 then
		self.stage:loadRes(self:getNpcModel(npcId))
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnNpcCreated, unit)

	if unit then
		return unit.go
	end

	return nil
end

function CityScene:_onNpcDestroy(npcId, quality)
	local unit = self.unitFactory:getUnit(UnitTag.Npc, npcId)

	GlobalDispatcher:dispatch(GlobalNotify.OnNpcDestroyed, unit)

	if unit then
		self.unitFactory:removeUnit(UnitTag.Npc, npcId)
	end

	if self.stage.wholeScene.preloadAll and self.stage.wholeScene:GetFunctionType(npcId) == 0 and not self.stage.wholeScene:IsFilterByLod(quality) then
		self.stage:unloadRes(self:getNpcModel(npcId))
	end
end

function CityScene:_onTriggerEnter(sceneId, triggerId, enter)
	local mainPlayer = self.mainPlayer:getMainPlayer()

	if enter then
		mainPlayer.triggerId = triggerId

		GlobalDispatcher:dispatch(GlobalNotify.EnterSceneTrigger, sceneId, triggerId)
	else
		mainPlayer.triggerId = nil

		GlobalDispatcher:dispatch(GlobalNotify.LeaveSceneTrigger, sceneId, triggerId)
	end
end

function CityScene:_onTransmitPointEnter(enter, toSceneId)
	local mainPlayer = self.mainPlayer:getMainPlayer()

	if self._ingoreTransmitPoint or enter == nil then
		mainPlayer.transmitPoint = nil

		return
	end

	mainPlayer.transmitPoint = toSceneId

	local function callBack()
		if rescache.resLoadMode == Framework.ResourceLoadMode.RemoteAssetBundle then
			if toSceneId == 1001 or toSceneId == 118 or toSceneId == 103 or toSceneId == 104 then
				mainPlayer.transmitPoint = toSceneId

				GlobalFacade.instance:enterCity(toSceneId, self._curSceneId)
			else
				TipsFacade.instance:openPopupWindow(lang("tip"), "新手阶段手动跳转场景会触发资源下载，游戏可能会卡顿一小会儿，并且新地图可能出现显示不全，确定跳转吗？", function()
					mainPlayer.transmitPoint = toSceneId

					GlobalFacade.instance:enterCity(toSceneId, self._curSceneId)
				end, nil, lang("确定"), lang("取消"), UnityEngine.TextAnchor.MiddleCenter)
			end
		else
			mainPlayer.transmitPoint = toSceneId

			GlobalFacade.instance:enterCity(toSceneId, self._curSceneId)
		end
	end

	if TaskController.instance:checkPauseOnEscort(callBack) then
		return
	end

	callBack()
end

function CityScene:_onTransmitGroupEnter(enter, id, fromX, fromY, toX, toY)
	local mainPlayer = self.mainPlayer:getMainPlayer()

	if enter then
		mainPlayer.transmitGroupId = id

		mainPlayer.transform:setPos(toX, toY, 0, true)
	else
		mainPlayer.transmitGroupId = nil
	end
end

function CityScene:_onPlayerVisible(playerId, go, visible)
	local unit = self.unitFactory:getUnit(UnitTag.Player, playerId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible(go)
		end

		if visible then
			local petUnit = unit:getPetUnit(SceneUnitBase.UnitPet)

			if petUnit then
				self.stage.wholeScene:ForbidCommonObject(petUnit:getTag(), petUnit.id, false)
			end

			local petUnit = unit:getPetUnit(SceneUnitBase.UnitZoo)

			if petUnit then
				self.stage.wholeScene:ForbidCommonObject(petUnit:getTag(), petUnit.id, false)
			end
		end
	end
end

function CityScene:_onPlayerCreate(playerId, x, y)
	local unit = self.unitFactory:createOtherPlayerUnit(playerId)

	if unit and unit.onUnitCreated then
		unit:onUnitCreated({
			posX = x,
			posY = y
		})
	end

	if unit then
		unit:setVisible(self._otherPlayerVisible)

		return unit.go
	end

	return nil
end

function CityScene:_onPlayerDestroy(playerId)
	local unit = self.unitFactory:getUnit(UnitTag.Player, playerId)

	if unit then
		self.unitFactory:removeUnit(UnitTag.Player, playerId)
	end
end

function CityScene:_onPlayerQualityCull(playerId)
	local unit = self.unitFactory:getUnit(UnitTag.Player, playerId)

	if unit then
		local petUnit = unit:getPetUnit(SceneUnitBase.UnitPet)

		if petUnit then
			self.stage.wholeScene:ForbidCommonObject(petUnit:getTag(), petUnit.id, true)
		end

		local petUnit = unit:getPetUnit(SceneUnitBase.UnitZoo)

		if petUnit then
			self.stage.wholeScene:ForbidCommonObject(petUnit:getTag(), petUnit.id, true)
		end
	end
end

function CityScene:_onMonsterVisible(insId, go, visible)
	local unit = self.unitFactory:getUnit(UnitTag.Monster, insId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible(go)
		end
	end
end

function CityScene:_onMonsterCreate(insId, mstId, zoneId, x, y, z, motion)
	local unit = self.unitFactory:createMonsterUnit(insId, mstId, zoneId)

	if unit and unit.onUnitCreated then
		unit:onUnitCreated({
			posX = x,
			posY = y,
			posZ = z,
			motion = motion
		})
	end

	if unit then
		return unit.go
	end

	return nil
end

function CityScene:_onMonsterDestroy(insId)
	local unit = self.unitFactory:getUnit(UnitTag.Monster, insId)

	if unit then
		self.unitFactory:removeUnit(UnitTag.Monster, insId)
	end
end

function CityScene:_onCommonObjVisible(tag, insId, go, visible)
	local unit = self.unitFactory:getUnit(tag, insId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible(go)
		end
	end
end

function CityScene:_onCommonObjCreate(tag, insId, itemId, userData, x, y, z, motion)
	local unit = self.unitFactory:createCommonObjectUnit(tag, insId, itemId, userData)

	if unit and unit.onUnitCreated then
		unit:onUnitCreated({
			posX = x,
			posY = y,
			posZ = z,
			motion = motion
		})
	end

	if unit then
		return unit.go
	end

	return nil
end

function CityScene:_onCommonObjDestroy(tag, insId)
	local unit = self.unitFactory:getUnit(tag, insId)

	if unit then
		self.unitFactory:removeUnit(tag, insId)
	end
end

function CityScene:_onSceneUnlock(sceneId)
	if self._visibleElements then
		local mapNode = self._visibleElements[sceneId]

		if not mapNode then
			return
		end

		local lock = goutil.findChild(mapNode, "map/map/lock")

		if lock then
			lock:SetActive(false)
		end
	end
end

function CityScene:_onSceneUnlockReady()
	if self._visibleElements then
		for k, v in pairs(self._visibleElements) do
			local mapNode = v

			if not goutil.isNil(mapNode) then
				local lock = goutil.findChild(mapNode, "map/map/lock")

				if UnlockFacade.instance:isSceneUnLock(k) then
					lock:SetActive(false)
				else
					lock:SetActive(true)
				end
			end
		end
	end
end

function CityScene:_onElementCreate(elementId, path, quality, pos)
	if self.stage.wholeScene.preloadAll then
		self.stage:loadRes(path)
	end
end

function CityScene:_onElementDestroy(elementId, path, quality)
	if self.stage.wholeScene.preloadAll and not self.stage.wholeScene:IsFilterByLod(quality) then
		self.stage:unloadRes(path)
	end
end

function CityScene:_onElementVisible(elementId, go, toSceneId, visible)
	if self._visibleElements and visible and toSceneId and toSceneId > 0 then
		self._visibleElements[toSceneId] = go

		local mapNode = goutil.findChild(go, "map/map")

		if mapNode then
			mapNode.gameObject:SetActive(true)

			local sceneCo = SceneConfig.instance:getSceneCo(toSceneId)

			if sceneCo and sceneCo.showImage and #sceneCo.showImage > 0 then
				local lock = goutil.findChild(go, "map/map/lock")
				local resPath = "scene/scene_icons/" .. sceneCo.showImage
				local res = self._visibleElementReses[toSceneId]

				if res and res.IsSuccess then
					GoUtil.SetTextureByPropertyName(mapNode.gameObject, "_MainTex", res:GetMainAsset())
				else
					getres(resPath, function(resLoad)
						if self._visibleElements and self._visibleElements[toSceneId] then
							if not self._visibleElementReses[toSceneId] then
								self._visibleElementReses[toSceneId] = resLoad

								resLoad:Retain()
							end

							GoUtil.SetTextureByPropertyName(mapNode.gameObject, "_MainTex", resLoad:GetMainAsset())
						end
					end)
				end

				if UnlockFacade.instance:isSceneUnLock(toSceneId) then
					lock:SetActive(false)
				else
					lock:SetActive(true)
				end

				self:_createTranspointHud(toSceneId, go)
			else
				mapNode.gameObject:SetActive(false)
				self:_recyleTranspointHud(toSceneId)
			end
		end
	end

	if not visible and toSceneId and toSceneId > 0 and self._visibleElements then
		if self._visibleElementReses[toSceneId] then
			self._visibleElementReses[toSceneId]:Release()

			self._visibleElementReses[toSceneId] = nil
		end

		self._visibleElements[toSceneId] = nil

		self:_recyleTranspointHud(toSceneId)
	end

	local unit = self.unitFactory:getUnit(UnitTag.SceneElement, elementId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible()
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnSceneElementVisible, self:getSceneId(), elementId, go, visible)
end

function CityScene:_openViewOnEnter(...)
	ViewMgr.instance:open(ViewName.VirtualJoystick)
	UIJumper.instance:resumeStack()
	ViewMgr.instance:open(ViewName.HorseLanternView)
	ViewMgr.instance:open(ViewName.ItemFly)
	ViewMgr.instance:setPermanent(ViewName.HorseLanternView, true)
	ViewMgr.instance:setPermanent(ViewName.ItemFly, true)
	ViewMgr.instance:setPermanent(ViewName.VirtualJoystick, true)
	GMController.instance:showGM(true)
end

function CityScene:isBreakPathFindingWhileHitAirwall()
	return false
end

function CityScene:isNeedMergePath()
	return true
end

function CityScene:showForcedVisiblePlayers()
	if checknumber(self._forcedVisiblePlayerId) <= 0 then
		return
	end

	local userId = tostring(self._forcedVisiblePlayerId)
	local playerObj = SystemReflexHelp.getPlayerObject(self.stage.wholeScene, userId)

	if playerObj then
		SystemReflexHelp.callOnVisibleOfSceneObjectPlayer(playerObj, nil)
	end
end

function CityScene:recordForcedVisiblePlayers(playerId)
	self._forcedVisiblePlayerId = tostring(playerId)

	self:showForcedVisiblePlayers()
end

return CityScene
