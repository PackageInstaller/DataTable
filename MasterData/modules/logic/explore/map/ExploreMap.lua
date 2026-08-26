-- chunkname: @modules/logic/explore/map/ExploreMap.lua

module("modules.logic.explore.map.ExploreMap", package.seeall)

local ExploreMap = class("ExploreMap")

function ExploreMap:ctor()
	self._loader = nil
	self._mapGo = nil
	self._clickEffectContainer = nil
	self._clickEffectLoader = nil
	self._initDone = false
	self._needLoadedCount = 0
	self._needUnitLoadedCount = 0
end

function ExploreMap:isInitDone()
	return self._initDone
end

function ExploreMap:getAllUnit()
	return self._unitDic
end

function ExploreMap:getUnit(id, notShowError)
	if self._unitDic[id] then
		return self._unitDic[id]
	elseif notShowError ~= true then
		logError("unit not find in map:" .. id)
	end
end

function ExploreMap:getUnitByPos(pos)
	local key = ExploreHelper.getKey(pos)
	local unitList = {}

	if self._unitPosDic[key] then
		for i, v in ipairs(self._unitPosDic[key]) do
			if ExploreModel.instance:isUseItemOrUnit(v.id) == false then
				table.insert(unitList, v)
			end
		end
	end

	return unitList
end

function ExploreMap:getUnitByType(type)
	for _, unit in pairs(self._unitDic) do
		if unit:getUnitType() == type then
			return unit
		end
	end
end

function ExploreMap:getUnitsByType(type)
	local list = {}

	for _, unit in pairs(self._unitDic) do
		if unit:getUnitType() == type then
			table.insert(list, unit)
		end
	end

	return list
end

function ExploreMap:getUnitsByTypeDict(dict)
	local list = {}

	for _, unit in pairs(self._unitDic) do
		if dict[unit:getUnitType()] then
			table.insert(list, unit)
		end
	end

	return list
end

function ExploreMap:getHeroPos()
	if self._hero then
		return self._hero.nodePos
	end
end

function ExploreMap:getHero()
	return self._hero
end

function ExploreMap:loadMap()
	ExploreMapTriggerController.instance:registerMap(self)

	self._root = GameSceneMgr.instance:getScene(SceneType.Explore):getSceneContainerGO()
	self._mapId = ExploreModel.instance:getMapId()

	local episodeId = ExploreConfig.instance:getEpisodeId(self._mapId)

	self._episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	self._mapPrefabPath = ExploreConstValue.MapPrefab
	self._mapConfigPath = string.format(ExploreConstValue.MapConfigPath, ExploreModel.instance:getMapId())
	self._meshPath = string.format(ExploreConstValue.MapNavMeshPath, ExploreModel.instance:getMapId())

	local loader = MultiAbLoader.New()

	self._loader = loader

	loader:addPath(self._mapPrefabPath)
	loader:addPath(ExploreConstValue.EntryCameraCtrlPath)
	loader:addPath(self._meshPath)
	loader:startLoad(self._loadedFinish, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickMap, self._onClickMap, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickUnit, self._onClickUnit, self)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, self._onCharacterPosChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self._onCharacterPosChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterStartMove, self._onCharacterStartMove, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.MoveHeroToPos, self.moveTo, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, self._onHeroMoveEnd, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitNodeChange, self._onUnitNodeChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatusChange, self._onUnitStatusChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatus2Change, self.OnUnitStatus2Change, self)
	ExploreController.instance:registerCallback(ExploreEvent.UpdateMoveDir, self.UpdateMoveDir, self)
	ExploreController.instance:registerCallback(ExploreEvent.CounterChange, self.CounterChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.CounterInitDone, self.CounterInitDone, self)
	ExploreController.instance:registerCallback(ExploreEvent.HeroFirstAnimEnd, self.beginCameraAnim, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function ExploreMap:unloadMap()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickMap, self._onClickMap, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickUnit, self._onClickUnit, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, self._onCharacterPosChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self._onCharacterPosChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterStartMove, self._onCharacterStartMove, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.MoveHeroToPos, self.moveTo, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self._onHeroMoveEnd, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitNodeChange, self._onUnitNodeChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatusChange, self._onUnitStatusChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatus2Change, self.OnUnitStatus2Change, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.UpdateMoveDir, self.UpdateMoveDir, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterChange, self.CounterChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterInitDone, self.CounterInitDone, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, self.onSceneObjLoadedDone, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroFirstAnimEnd, self.beginCameraAnim, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	self:destroy()
	gohelper.destroy(self._mapGo)
	self._loader:dispose()
end

function ExploreMap:setCameraPos(pos)
	self._cameraComponent:setCameraPos(pos)

	if self._preloadComp then
		self._preloadComp:updateCameraPos(pos)
	end
end

function ExploreMap:clearUnUseObj()
	if self._preloadComp then
		self._preloadComp:clearUnUseObj()
	end

	ResDispose.unloadTrue()
end

function ExploreMap:addUnitNeedLoadedNum(num)
	self._needUnitLoadedCount = self._needUnitLoadedCount + num

	if self._waitAllObjLoaded and self._needLoadedCount <= 0 and self._needUnitLoadedCount <= 0 then
		self._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function ExploreMap:markWaitAllSceneObj()
	if not self._preloadComp then
		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)

		return
	end

	self._waitAllObjLoaded = true
	self._needLoadedCount = self._preloadComp:calcNeedLoadedSceneObj()

	if self._needLoadedCount > 0 then
		ExploreController.instance:registerCallback(ExploreEvent.SceneObjLoadedCb, self.onSceneObjLoadedDone, self)
	elseif self._needUnitLoadedCount <= 0 then
		self._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function ExploreMap:onSceneObjLoadedDone()
	self._needLoadedCount = self._needLoadedCount - 1

	if self._needLoadedCount <= 0 then
		ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, self.onSceneObjLoadedDone, self)

		if self._needUnitLoadedCount <= 0 then
			self._waitAllObjLoaded = false

			ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
		end
	end
end

function ExploreMap:showGrid()
	for i, node in pairs(self._walkableList) do
		local grid = ExploreGrid.New(self:getContainRootByAreaId(node.areaId).node)

		grid:setName(node.walkableKey)
		grid:setPosByNode(node.pos)
	end
end

function ExploreMap:GetTilemapMousePos(mousePosition, onlyNavigate)
	local ray = self._cameraComponent:getCamera():ScreenPointToRay(mousePosition)
	local mask = onlyNavigate and ExploreHelper.getNavigateMask() or ExploreHelper.getSceneMask()
	local isHit, hitInfo = UnityEngine.Physics.Raycast(ray, nil, Mathf.Infinity, mask)

	if isHit then
		local clickComp = tolua.getpeer(hitInfo.collider)
		local hitPos = hitInfo.point

		return clickComp, ExploreHelper.posToTile(hitPos), hitPos
	end
end

function ExploreMap:getHitTriggerTrans(mask)
	local ray = self._cameraComponent:getCamera():ScreenPointToRay(GamepadController.instance:getMousePosition())

	mask = mask or ExploreHelper.getTriggerMask()

	local isHit, hitInfo = UnityEngine.Physics.Raycast(ray, nil, Mathf.Infinity, mask)

	if isHit then
		return hitInfo.transform
	end
end

function ExploreMap:getSceneY(pos)
	local oldY = pos.y

	pos.y = 10

	local isHit, hitInfo = UnityEngine.Physics.Raycast(pos, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

	pos.y = oldY

	if isHit then
		return hitInfo.point.y
	else
		return oldY
	end
end

function ExploreMap:UpdateMoveDir(dir)
	if dir and self:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if self._hero then
		self._hero:setMoveDir(dir)
	end
end

function ExploreMap:_onViewClose(viewName)
	if viewName == ViewName.LoadingView and GameSceneMgr.instance:getCurSceneType() == SceneType.Explore then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)

		if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.Battle then
			ViewMgr.instance:openView(ViewName.ExploreEnterView)
		elseif self._hero then
			self._hero:onRoleFirstEnter()
		end
	end
end

function ExploreMap:CounterChange(id, count)
	local unit = self:getUnit(id, true)

	if unit then
		unit:onUpdateCount(count)
	end
end

function ExploreMap:CounterInitDone()
	for id, unit in pairs(self._unitDic) do
		unit:onUpdateCount(ExploreCounterModel.instance:getCount(id), ExploreCounterModel.instance:getTotalCount(id))
	end
end

function ExploreMap:moveTo(pos, callBack, callBackObj)
	if pos == nil then
		-- block empty
	else
		local units = self:getUnitByPos(pos)

		for i, unit in ipairs(units) do
			if unit.mo.triggerByClick ~= false and (not unit.clickComp or unit.clickComp.enable) then
				self:_onClickUnit(unit.mo)

				return true
			end
		end

		self._hero:moveTo(pos, callBack, callBackObj)
	end
end

function ExploreMap:_showClickEffect(pos)
	AudioMgr.instance:trigger(AudioEnum.Explore.ClickFloor)
	gohelper.setActive(self._clickEffectContainer, false)
	gohelper.setActive(self._clickEffectContainer, true)

	local worldPos = ExploreHelper.tileToPos(pos)

	worldPos.y = self:getSceneY(worldPos)
	self._clickEffectContainer.transform.position = worldPos
end

function ExploreMap:startFindPath(startPos, endPos, nextPos)
	self._route = self._route or ExploreAStarFindRoute.New()

	local startKey = ExploreHelper.getKeyXY(startPos.x, startPos.y)
	local height = self._walkableList[startKey].height
	local walkableListExceptItem = {}

	for i, node in pairs(self._walkableList) do
		if node:isWalkable(height) then
			walkableListExceptItem[i] = node.walkableKey
		end
	end

	local path, nearestPos = self._route:startFindPath(walkableListExceptItem, startPos, endPos, nextPos)

	if #path <= 0 then
		endPos = nearestPos
		path, nearestPos = self._route:startFindPath(walkableListExceptItem, startPos, nearestPos, nextPos)
	end

	local firstPathCornerNum = ExploreHelper.getCornerNum(path, startPos)

	if firstPathCornerNum > 1 then
		local invertedPath = self._route:startFindPath(walkableListExceptItem, endPos, startPos, nextPos)
		local invertCornerNum = ExploreHelper.getCornerNum(invertedPath, endPos)

		if #invertedPath > 0 and invertCornerNum < firstPathCornerNum then
			path = {
				endPos
			}

			for i = #invertedPath, 2, -1 do
				table.insert(path, invertedPath[i])
			end
		end
	end

	return path
end

function ExploreMap:_onHeroMoveEnd(pos)
	local unitList = self:getUnitByPos(pos)

	for i, unit in ipairs(unitList) do
		if unit:isEnable() then
			unit:onRoleStay()
		end
	end
end

function ExploreMap:_onCharacterStartMove(nowPos, nextPos)
	ExploreMapModel.instance:setNodeLight(nowPos)
end

function ExploreMap:_onUnitNodeChange(changeUnit, nowPos, prePos)
	if prePos then
		local mo = changeUnit.mo

		for x = mo.offsetSize[1], mo.offsetSize[3] do
			for y = mo.offsetSize[2], mo.offsetSize[4] do
				local nodeKey = ExploreHelper.getKeyXY(prePos.x + x, prePos.y + y)

				if self._unitPosDic[nodeKey] ~= nil then
					tabletool.removeValue(self._unitPosDic[nodeKey], changeUnit)
				end
			end
		end

		if nowPos then
			for x = mo.offsetSize[1], mo.offsetSize[3] do
				for y = mo.offsetSize[2], mo.offsetSize[4] do
					local nodeKey = ExploreHelper.getKeyXY(nowPos.x + x, nowPos.y + y)

					if self._unitPosDic[nodeKey] == nil then
						self._unitPosDic[nodeKey] = {}
					end

					table.insert(self._unitPosDic[nodeKey], changeUnit)
				end
			end
		end
	end

	local levelUnitList = {}
	local enterUnitList = {}

	if nowPos then
		enterUnitList = self:getUnitByPos(nowPos)
	end

	if prePos then
		levelUnitList = self:getUnitByPos(prePos)

		for i, unit in ipairs(levelUnitList) do
			if changeUnit ~= unit and unit:isEnable() and tabletool.indexOf(enterUnitList, unit) == nil then
				unit:onRoleLeave(nowPos or prePos, prePos, changeUnit)
			end
		end
	end

	for i, unit in ipairs(enterUnitList) do
		if changeUnit ~= unit and unit:isEnable() and tabletool.indexOf(levelUnitList, unit) == nil then
			unit:onRoleEnter(nowPos, prePos, changeUnit)
		end
	end

	self:checkUnitNear(nowPos, changeUnit)
end

function ExploreMap:checkAllRuneTrigger()
	for _, unit in pairs(self._unitDic) do
		if unit:getUnitType() == ExploreEnum.ItemType.Rune then
			unit:checkShowIcon()
		end
	end
end

function ExploreMap:checkUnitNear(nowPos, unit)
	if self._nearIdList and nowPos and unit then
		local isNearRole = ExploreHelper.getDistance(nowPos, self._hero.nodePos) == 1
		local preNear = false
		local index

		for key, id in pairs(self._nearIdList) do
			if id == unit.id then
				preNear = true
				index = key

				break
			end
		end

		if isNearRole ~= preNear then
			if preNear then
				table.remove(self._nearIdList, index)
				unit:onRoleFar()
			else
				table.insert(self._nearIdList, unit.id)
				unit:onRoleNear()
			end
		end
	end
end

function ExploreMap:_onUnitStatusChange(unitId, changeBit)
	if not self._initDone then
		return
	end

	local unit = self:getUnit(unitId, true)

	if unit then
		unit:onStatusChange(changeBit)
	end
end

function ExploreMap:OnUnitStatus2Change(unitId, preStatuInfo, nowStatuInfo)
	if not self._initDone then
		return
	end

	local unit = self:getUnit(unitId, true)

	if unit then
		unit:onStatus2Change(preStatuInfo, nowStatuInfo)
	end
end

function ExploreMap:_onCharacterNodeChange(nowPos, prePos, nextPos)
	if prePos and self._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and self:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreModel.instance:setStepPause(false)
	end

	local levelUnitList = {}
	local enterUnitList = self:getUnitByPos(nowPos)

	if prePos then
		levelUnitList = self:getUnitByPos(prePos)

		for i, unit in ipairs(levelUnitList) do
			if unit:isEnable() and tabletool.indexOf(enterUnitList, unit) == nil then
				unit:onRoleLeave(nowPos, prePos, self._hero)
			end
		end
	end

	for i, unit in ipairs(enterUnitList) do
		if unit:isEnable() and tabletool.indexOf(levelUnitList, unit) == nil then
			unit:onRoleEnter(nowPos, prePos, self._hero)
		end
	end

	ExploreMapModel.instance:setNodeLight(nowPos)

	if prePos and self._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and self:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreRpc.instance:sendExploreMoveRequest(nowPos.x, nowPos.y)
	end

	local node = ExploreMapModel.instance:getNode(ExploreHelper.getKey(nowPos))

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, node and node.cameraId)

	if node then
		local areaMo = ExploreMapModel.instance:getMapAreaMO(node.areaId)

		if areaMo then
			ExploreMapModel.instance:setIsShowResetBtn(areaMo.isCanReset)
		end
	end

	self._nearIdList = self._nearIdList or {}

	local nowNearIds = {}

	for dir = 0, 270, 90 do
		local pos = ExploreHelper.dirToXY(dir)
		local key = ExploreHelper.getKeyXY(nowPos.x + pos.x, nowPos.y + pos.y)
		local list = self._unitPosDic[key]

		if list then
			for _, unit in pairs(list) do
				nowNearIds[unit.id] = true
			end
		end
	end

	for i = #self._nearIdList, 1, -1 do
		local id = self._nearIdList[i]

		if nowNearIds[id] then
			nowNearIds[id] = nil
		else
			local unit = self:getUnit(id, true)

			if unit then
				unit:onRoleFar()
			end

			table.remove(self._nearIdList, i)
		end
	end

	for id in pairs(nowNearIds) do
		table.insert(self._nearIdList, id)

		local unit = self:getUnit(id, true)

		if unit then
			unit:onRoleNear()
		end
	end
end

function ExploreMap:_onCharacterPosChange(pos)
	self:setCameraPos(pos)
end

function ExploreMap:_onClickUnit(unitMO)
	self._hero:moveToTar(unitMO)
end

function ExploreMap:setMapStatus(status, data)
	if self._compDict[self._nowStatus] then
		if not self._compDict[self._nowStatus]:canSwitchStatus(status) then
			return false
		end

		self._compDict[self._nowStatus]:onStatusEnd()
	end

	self._nowStatus = status

	if self._compDict[self._nowStatus] then
		self._compDict[self._nowStatus]:onStatusStart(data)
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.MapStatusChange, status)

	return true
end

function ExploreMap:_onClickMap(mousePosition)
	if self._compDict[self._nowStatus] then
		return self._compDict[self._nowStatus]:onMapClick(mousePosition)
	end

	if not self._mapGo or not self._mapGo.activeInHierarchy then
		return
	end

	local clickComp, pos = self:GetTilemapMousePos(mousePosition)
	local isClickUnit = false

	if clickComp and clickComp:click() then
		-- block empty
	elseif clickComp == nil then
		isClickUnit = self:moveTo(pos)
	else
		clickComp, pos = self:GetTilemapMousePos(mousePosition, true)

		if pos then
			isClickUnit = self:moveTo(pos)
		else
			clickComp, pos = self:GetTilemapMousePos(mousePosition)
			isClickUnit = self:moveTo(pos)
		end
	end

	local nodeCanWalk = false

	if pos then
		local key = ExploreHelper.getKey(pos)

		nodeCanWalk = ExploreMapModel.instance:getNodeCanWalk(key)
	end

	if ExploreModel.instance:isHeroInControl() and pos and not clickComp and not isClickUnit and nodeCanWalk then
		self:_showClickEffect(pos)
	end
end

function ExploreMap:adjustSpineLookRotation(unit)
	if unit and not gohelper.isNil(unit.go) then
		unit:setRotate(self._cameraComponent:getRotation())
	end
end

function ExploreMap:_loadedFinish(multiAbLoader)
	if self._episodeCo and self._episodeCo.bgmevent > 0 then
		-- block empty
	end

	local assetItem = self._loader:getAssetItem(self._mapPrefabPath)
	local mainPrefab = assetItem:GetResource(self._mapPrefabPath)
	local mapGo = gohelper.clone(mainPrefab, self._root)

	self._mapGo = mapGo

	local navMeshGo = gohelper.create3d(mapGo, "NavMesh")
	local meshAssetItem = self._loader:getAssetItem(self._meshPath)

	if meshAssetItem and meshAssetItem.IsLoadSuccess then
		local meshCollider = gohelper.onceAddComponent(navMeshGo, typeof(UnityEngine.MeshCollider))

		meshCollider.sharedMesh = meshAssetItem:GetResource()

		gohelper.setLayer(navMeshGo, UnityLayer.Scene)
	end

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)
	ExploreMapModel.instance:initMapData(ExploreConfig.instance:getMapConfig(), ExploreModel.instance.mapId)
	mapGo:SetActive(false)
	self:_initMap()

	if self._preloadComp == nil then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
	end
end

function ExploreMap:getLoader()
	return self._loader
end

function ExploreMap:getNowStatus()
	return self._nowStatus
end

function ExploreMap:getCompByType(type)
	if not self._compDict then
		return
	end

	return self._compDict[type]
end

function ExploreMap:getCatchComp()
	return self._catchComponent
end

function ExploreMap:_initMap()
	if not self._mapGo then
		return
	end

	self._mapGo:SetActive(true)

	self._cameraComponent = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreCamera)

	self._cameraComponent:setMap(self)

	self._nowStatus = ExploreEnum.MapStatus.Normal
	self._compDict = {}
	self._compDict[ExploreEnum.MapStatus.UseItem] = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapUseItemComp)
	self._compDict[ExploreEnum.MapStatus.MoveUnit] = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapUnitMoveComp)
	self._compDict[ExploreEnum.MapStatus.RotateUnit] = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapUnitRotateComp)

	for status, comp in pairs(self._compDict) do
		comp:setMap(self)
		comp:setMapStatus(status)
	end

	self._preloadComp = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapScenePreloadComp)

	if self._preloadComp.hasInit == false then
		self._preloadComp = nil
	end

	self._catchComponent = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapUnitCatchComp)
	self._fovComponent = MonoHelper.addLuaComOnceToGo(self._mapGo, ExploreMapFOVComp)
	self._unitRoot = gohelper.findChild(self._mapGo, "unit")

	self:_buildNode()
	self:_buildUnit()
	self:_initCharacter()
	self:_initClickEffect()

	if self._preloadComp == nil then
		self:showGrid()
	end

	self._fovComponent:setMap(self)
	self._catchComponent:setMap(self)
	ExploreCounterModel.instance:reCalcCount()

	for i, v in pairs(self._unitDic) do
		v:onMapInit()
	end

	self._initDone = true

	ExploreController.instance:getMapLight():initLight()
	ExploreController.instance:getMapWhirl():init(self._mapGo)
	ExploreController.instance:getMapPipe():init()
	self._cameraComponent:initHeroPos()
end

function ExploreMap:beginCameraAnim()
	for i, v in pairs(self._unitDic) do
		v:onHeroInitDone()
	end
end

function ExploreMap:getUnitRoot()
	return self._unitRoot
end

function ExploreMap:getContainRootByAreaId(areaId)
	if type(areaId) ~= "number" then
		areaId = 0
	end

	self._areaRoots = self._areaRoots or {}

	if not self._areaRoots[areaId] then
		self._areaRoots[areaId] = {}
		self._areaRoots[areaId].go = gohelper.create3d(self._mapGo, "area_" .. areaId)
		self._areaRoots[areaId].unit = gohelper.create3d(self._areaRoots[areaId].go, "unit")
		self._areaRoots[areaId].sceneObj = gohelper.create3d(self._areaRoots[areaId].go, "sceneObj")
		self._areaRoots[areaId].node = gohelper.create3d(self._areaRoots[areaId].go, "node")

		local areaMo = ExploreMapModel.instance:getMapAreaMO(areaId)

		if areaMo and not areaMo.visible then
			gohelper.setActive(self._areaRoots[areaId].go, false)
		end
	end

	return self._areaRoots[areaId]
end

function ExploreMap:_buildNode()
	self._walkableList = {}

	local dic = ExploreMapModel.instance:getNodeDic()

	for i, node in pairs(dic) do
		self._walkableList[node.walkableKey] = node
	end
end

function ExploreMap:_buildUnit()
	self._unitDic = {}
	self._hideUnitDic = {}
	self._unitPosDic = {}

	local dic = ExploreMapModel.instance:getUnitDic()

	for i, mo in pairs(dic) do
		self:enterUnit(mo)
	end

	local allInteractInfo = ExploreModel.instance:getAllInteractInfo()

	if allInteractInfo then
		for id, v in pairs(allInteractInfo) do
			local mo = ExploreMapModel.instance:getUnitMO(id)

			if mo == nil then
				ExploreController.instance:updateUnit(v)
			end
		end
	end
end

function ExploreMap:haveNodeXY(key)
	return not not self._walkableList[key]
end

function ExploreMap:enterUnit(mo)
	local unit = self._unitDic[mo.id]

	if not mo:isEnter() then
		self._hideUnitDic[mo.id] = unit

		return
	end

	local isNewUnit

	if unit == nil then
		if self._hideUnitDic[mo.id] then
			unit = self._hideUnitDic[mo.id]
			self._hideUnitDic[mo.id] = nil
		else
			local cls = mo:getUnitClass()

			unit = cls.New(self:getContainRootByAreaId((mo.type == ExploreEnum.ItemType.SceneAudio or nil) and -9999999).unit)
		end

		isNewUnit = true or isNewUnit
	end

	self._unitDic[mo.id] = unit

	local nodePos = unit.nodePos

	unit:setData(mo)

	if isNewUnit or not nodePos then
		for x = mo.offsetSize[1], mo.offsetSize[3] do
			for y = mo.offsetSize[2], mo.offsetSize[4] do
				local nodeKey = ExploreHelper.getKeyXY(mo.nodePos.x + x, mo.nodePos.y + y)

				if self._unitPosDic[nodeKey] == nil then
					self._unitPosDic[nodeKey] = {}
				end

				if not tabletool.indexOf(self._unitPosDic[nodeKey], unit) then
					table.insert(self._unitPosDic[nodeKey], unit)
				end
			end
		end

		if self._initDone then
			unit:setInFOV(true)
			unit:checkLight()
		end
	end
end

function ExploreMap:removeUnit(id)
	local unit = self._unitDic[id]

	if unit then
		local mo = unit.mo

		self._hideUnitDic[mo.id] = unit
		self._unitDic[mo.id] = nil

		for x = mo.offsetSize[1], mo.offsetSize[3] do
			for y = mo.offsetSize[2], mo.offsetSize[4] do
				local nodeKey = ExploreHelper.getKeyXY(mo.nodePos.x + x, mo.nodePos.y + y)

				if self._unitPosDic[nodeKey] ~= nil then
					for _, otherUnit in pairs(self._unitPosDic[nodeKey]) do
						if otherUnit ~= unit then
							otherUnit:onRoleLeave(unit.nodePos, unit.nodePos, unit)
						end
					end

					tabletool.removeValue(self._unitPosDic[nodeKey], unit)
				end
			end
		end

		unit:setExit()
	end
end

function ExploreMap:_initCharacter()
	local roleGo = gohelper.findChild(self._mapGo, "role")

	self._hero = ExploreHero.New(roleGo)

	self._hero:setMap(self)
	self._hero:onUpdateExploreInfo()
	self._hero:setResPath("modules/explore/roles/prefabs/hero.prefab")
end

function ExploreMap:_initClickEffect()
	self._clickEffectContainer = UnityEngine.GameObject.New("ClickEffect")

	gohelper.addChild(self._mapGo, self._clickEffectContainer)

	self._clickEffectLoader = PrefabInstantiate.Create(self._clickEffectContainer)

	self._clickEffectLoader:startLoad(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect), function()
		self._effectGo = self._clickEffectLoader:getInstGO()

		gohelper.addChild(self._clickEffectContainer, self._effectGo)
		gohelper.setActive(self._clickEffectContainer, false)

		self._effectOrderContainer = gohelper.findChildComponent(self._effectGo, "root", typeof(ZProj.EffectOrderContainer))
	end)
end

function ExploreMap:destroy()
	for i, unit in pairs(self._unitDic) do
		unit:destroy()
	end

	for i, unit in pairs(self._hideUnitDic) do
		unit:destroy()
	end

	if self._hero then
		self._hero:destroy()

		self._hero = nil
	end

	if self._clickEffectLoader then
		self._clickEffectLoader:dispose()

		self._clickEffectLoader = nil
	end

	gohelper.destroy(self._clickEffectContainer)

	self._clickEffectContainer = nil
	self._unitDic = nil
	self._hideUnitDic = nil
	self._nowStatus = ExploreEnum.MapStatus.Normal
	self._compDict = nil

	ExploreModel.instance:setHeroControl(true)
	ExploreMapTriggerController.instance:unRegisterMap(self)
	ExploreMapModel.instance:clear()
	ZProj.ExploreHelper.Clear()
	ViewMgr.instance:closeView(ViewName.ExploreEnterView)
	ExploreHeroCatchUnitFlow.instance:clear()
	ExploreHeroFallAnimFlow.instance:clear()
	ExploreHeroTeleportFlow.instance:clear()
	ExploreHeroResetFlow.instance:clear()
	ExploreMapLightPool.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalkStop)
	AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlideStop)
	AudioMgr.instance:trigger(AudioEnum.Explore.ElevatorStop)
end

return ExploreMap
