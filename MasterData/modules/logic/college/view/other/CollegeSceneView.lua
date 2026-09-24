-- chunkname: @modules/logic/college/view/other/CollegeSceneView.lua

module("modules.logic.college.view.other.CollegeSceneView", package.seeall)

local CollegeSceneView = class("CollegeSceneView", BaseView)

function CollegeSceneView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_full")
	self._gofullscreen2 = gohelper.findChild(self.viewGO, "#go_full2")
	self._buildingUIRoot = gohelper.findChild(self.viewGO, "#go_full/#go_city/#go_sceneui")
	self._buildingUI = gohelper.findChild(self.viewGO, "#go_full/#go_city/#go_sceneui/#go_building")
	self._areaUIRoot = gohelper.findChild(self.viewGO, "#go_full/#go_map/#go_sceneui")
	self._areaUI = gohelper.findChild(self.viewGO, "#go_full/#go_map/#go_sceneui/#go_area")
	self._buildingElementUI = gohelper.findChild(self.viewGO, "#go_full/#go_city/#go_sceneui/#go_element")
	self._areaElementUI = gohelper.findChild(self.viewGO, "#go_full/#go_map/#go_sceneui/#go_element")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._drag2 = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen2)
	self._click2 = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen2)
	self._curCameraSizeType = CollegeEnum.DungeonMapCameraSizeType.High
	self._curCameraSize = CollegeEnum.DungeonMapCameraSize[self._curCameraSizeType]

	MainCameraMgr.instance:addView(self.viewName, self._setCamera, nil, self)

	self._sceneMo = CollegeModel.instance:getSceneMo()

	gohelper.setActive(self._buildingUI, false)
	gohelper.setActive(self._areaUI, false)
	gohelper.setActive(self._buildingElementUI, false)
	gohelper.setActive(self._areaElementUI, false)

	self._viewAnim = gohelper.findComponentAnim(self.viewGO)

	self:initScene()
end

function CollegeSceneView:addEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag2:AddDragBeginListener(self._onDragBegin, self)
	self._drag2:AddDragEndListener(self._onDragEnd, self)
	self._drag2:AddDragListener(self._onDrag, self)
	self._click2:AddClickDownListener(self._onClickDown, self)
	self._click2:AddClickUpListener(self._onClickUp, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.ChangeSceneType, self.setShowMap, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.ChangeCameraSizeType, self.setCurCameraSize, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.TweenCameraPosAndSetSize, self.setCurCameraSizeAndSetPos, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.TweenCameraPos, self.setTweenCameraPos, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.MilestoneUpdate, self.updateMapElement, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.RealSwitchScene, self._realChangeType, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.ChangeSceneTypeEnd, self._onChangeSceneEnd, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnMainViewPlayOpenAnim, self._onPlayOpenAnim, self)
end

function CollegeSceneView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._drag2:RemoveDragBeginListener()
	self._drag2:RemoveDragListener()
	self._drag2:RemoveDragEndListener()
	self._click2:RemoveClickDownListener()
	self._click2:RemoveClickUpListener()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.ChangeSceneType, self.setShowMap, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.ChangeCameraSizeType, self.setCurCameraSize, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.TweenCameraPosAndSetSize, self.setCurCameraSizeAndSetPos, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.TweenCameraPos, self.setTweenCameraPos, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.MilestoneUpdate, self.updateMapElement, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.RealSwitchScene, self._realChangeType, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.ChangeSceneTypeEnd, self._onChangeSceneEnd, self)
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.OnMainViewPlayOpenAnim, self._onPlayOpenAnim, self)
end

function CollegeSceneView:_onScreenResize()
	self:_setCamera()
	self:_calcSceneSize()
	self:directSetScenePos(self._scenePos)
end

function CollegeSceneView:_setCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale()

	camera.orthographic = true
	camera.orthographicSize = self._curCameraSize * scale
end

function CollegeSceneView:initScene()
	if self._goRoot then
		return
	end

	self._scenePos = Vector3()
	self._mapPos = Vector3()
	self._cityPos = Vector3()

	local str = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.CityDefaultPos)

	if not string.nilorempty(str) then
		local arr = string.splitToNumber(str, "#")

		self._cityPos:Set(arr[1], arr[2], arr[3])
	end

	str = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.MapDefaultPos)

	if not string.nilorempty(str) then
		local arr = string.splitToNumber(str, "#")

		self._mapPos:Set(arr[1], arr[2], arr[3])
	end

	self._tempVector = Vector3()

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._goRoot = gohelper.create3d(sceneRoot, "CollegeMapScene")
	self._goScene = gohelper.create3d(self._goRoot, "root")
	self._goCity = gohelper.create3d(self._goScene, "city")
	self._goMap = gohelper.create3d(self._goScene, "map")
	self._goMapbg = gohelper.create3d(self._goScene, "mapbg")
	self._cityInst = self:getResInst(self.viewContainer._viewSetting.otherRes.city, gohelper.create3d(self._goCity, "res"))
	self._cityLowInst = self:getResInst(self.viewContainer._viewSetting.otherRes.city_low, gohelper.create3d(self._goCity, "res"))
	self._mapInst = self:getResInst(self.viewContainer._viewSetting.otherRes.map, gohelper.create3d(self._goMap, "res"))
	self._mapBgInst = self:getResInst(self.viewContainer._viewSetting.otherRes.mapbg, gohelper.create3d(self._goMapbg, "res"))
	self._cityBuildingRoot = gohelper.create3d(self._goCity, "building")
	self._cityElementRoot = gohelper.create3d(self._goCity, "element")
	self._cityRoleRoot = gohelper.create3d(self._goCity, "role")
	self._mapBuildingRoot = gohelper.create3d(self._goMap, "area")
	self._mapElementRoot = gohelper.create3d(self._goMap, "element")

	gohelper.setActive(self._cityInst, true)
	gohelper.setActive(self._cityLowInst, false)
	gohelper.setActive(self._cityElementRoot, false)
	gohelper.setActive(self._mapElementRoot, false)

	local _, y = transformhelper.getLocalPos(CameraMgr.instance:getCameraTraceGO().transform)

	transformhelper.setLocalPos(self._goRoot.transform, 0, y, 0)
	self:_setCamera()
	self:initBuilding(self._cityBuildingRoot)
	self:initArea(self._mapBuildingRoot)
	self:initMapElement()

	local go = gohelper.create3d(self._goCity, "otherRes")
	local constStr = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.ExtraBuildingPaths)

	if not string.nilorempty(constStr) then
		local arr = string.split(constStr, "#")

		for i, v in ipairs(arr) do
			local loader = PrefabInstantiate.Create(gohelper.create3d(go, v))

			loader:startLoad(string.format("modules/college/scene/prefab/%s.prefab", v))
		end
	end
end

function CollegeSceneView:getRoleRoot()
	return self._cityRoleRoot
end

function CollegeSceneView:initBuilding(go)
	local uiRoot = gohelper.create2d(self._buildingUIRoot, "buildingui")

	for i, v in ipairs(self._sceneMo.buildingBox.buildings) do
		local building = gohelper.create3d(go, "building" .. v.id)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(building, CollegeSceneBuildingItem)

		transformhelper.setLocalPos(building.transform, v.pos.x, v.pos.y, v.pos.z)

		local ui = gohelper.clone(self._buildingUI, uiRoot, "building" .. v.id)

		gohelper.setActive(ui, true)
		comp:setUI(ui, self._buildingUIRoot)
		comp:updateData(v)
	end
end

function CollegeSceneView:initArea(go)
	local uiRoot = gohelper.create2d(self._areaUIRoot, "areaui")

	for i, v in ipairs(self._sceneMo.worldMap.areas) do
		local area = gohelper.create3d(go, "area" .. v.id)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(area, CollegeSceneAreaItem)

		transformhelper.setLocalPos(area.transform, v.pos.x, v.pos.y, v.pos.z)

		local ui = gohelper.clone(self._areaUI, uiRoot, "area" .. v.id)

		gohelper.setActive(ui, true)
		comp:setUI(ui, self._areaUIRoot)
		comp:updateData(v)
	end

	self:initCloudItem(go)
end

function CollegeSceneView:initCloudItem(go)
	local cloudGo = gohelper.findChild(self._mapInst, "ui/#go_cloud")

	MonoHelper.addNoUpdateLuaComOnceToGo(cloudGo, CollegeCloudItem)
end

function CollegeSceneView:initMapElement()
	self.mapElements = {}

	for i, v in pairs(self._sceneMo.milestoneBox:getSceneUnlockNodes()) do
		self:_addMapElement(v)
	end
end

function CollegeSceneView:_addMapElement(co)
	local id = co.id
	local isCity = co.location == CollegeEnum.SceneType.City

	if isCity then
		if not self._cityElementRoot then
			local root = self._mapElementRoot
			local element = gohelper.create3d(root, "element" .. id)
			local comp = MonoHelper.addNoUpdateLuaComOnceToGo(element, CollegeSceneElementItem)
			local pos = Vector3()

			if not string.nilorempty(co.pos) then
				do
					local arr = string.splitToNumber(co.pos, "#")

					pos:Set(arr[1], arr[2], arr[3])
					transformhelper.setLocalPos(element.transform, pos.x, pos.y, pos.z)
				end

				if isCity then
					local ui = gohelper.cloneInPlace(self._buildingElementUI or self._areaElementUI, "element" .. id)

					gohelper.setActive(ui, true)
					comp:setScale(isCity and 2 or 1)
					comp:setUI(ui)

					local data = {
						pos = pos,
						co = co
					}

					comp:updateData(data)

					self.mapElements[id] = comp
				end
			end
		end
	end
end

function CollegeSceneView:updateMapElement()
	local elements = self._sceneMo.milestoneBox:getSceneUnlockNodes()

	for i, v in pairs(elements) do
		if not self.mapElements[v.id] then
			self:_addMapElement(v)
		end
	end

	for k, v in pairs(self.mapElements) do
		if not elements[k] then
			v:destroy()

			self.mapElements[k] = nil
		end
	end
end

function CollegeSceneView:_calcSceneSize(cameraSize)
	if not self._curMapInst then
		return
	end

	self._mapMinX, self._mapMaxX, self._mapMinY, self._mapMaxY = self:_calcSize(cameraSize, self._curMapInst)

	if CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map then
		self._mapBgMinX, self._mapBgMaxX, self._mapBgMinY, self._mapBgMaxY = self:_calcSize(cameraSize, self._mapBgInst)
	end
end

function CollegeSceneView:_calcSize(cameraSize, root)
	if not root then
		return
	end

	local sizeGo = gohelper.findChild(root.gameObject, "root/size")

	if not sizeGo then
		logError("地图资源没有size节点")

		return 0, 0, 0, 0
	end

	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
	local mapSize = box.size
	local center = box.center
	local lossyScale = sizeGo.transform.lossyScale

	mapSize.x = mapSize.x * lossyScale.x
	mapSize.y = mapSize.y * lossyScale.y
	center.x = center.x * lossyScale.x
	center.y = center.y * lossyScale.y

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		if not uiCamera.orthographicSize then
			local uiCameraSize = 5
			local cameraSizeRate = (cameraSize or self._curCameraSize) / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate
			local viewWidth = math.abs(posBR.x - posTL.x)
			local viewHeight = math.abs(posBR.y - posTL.y)
			local posX, posY, posZ = transformhelper.getLocalPos(sizeGo.transform)

			center.x = center.x + posX
			center.y = center.y + posY

			local mapMinX = posTL.x - (mapSize.x / 2 - viewWidth) - center.x
			local mapMaxX = posTL.x + mapSize.x / 2 - center.x
			local mapMinY = posTL.y - mapSize.y / 2 - center.y
			local mapMaxY = posTL.y + (mapSize.y / 2 - viewHeight) - center.y

			mapMinX = math.min(mapMinX, mapMaxX)
			mapMinY = math.min(mapMinY, mapMaxY)

			return mapMinX, mapMaxX, mapMinY, mapMaxY
		end
	end
end

function CollegeSceneView:setShowMap(type, callback, callobj)
	if type == CollegeModel.instance.curSceneType then
		if callback then
			callback(callobj)
		end

		return
	end

	if not CollegeModel.instance.curSceneType then
		CollegeModel.instance.curSceneType = type

		self:_realChangeType(true)

		return
	end

	CollegeModel.instance.curSceneType = type
	self._switchSceneCallback = callback
	self._switchSceneCallbackObj = callobj

	transformhelper.setLocalPos(self._cityElementRoot.transform, 10000, 10000, 0)
	transformhelper.setLocalPos(self._mapElementRoot.transform, 10000, 10000, 0)
	ViewMgr.instance:openView(ViewName.CollegeSwitchSceneAnimView)
end

function CollegeSceneView:_realChangeType(isFirst)
	local type = CollegeModel.instance.curSceneType

	gohelper.setActive(self._goMapbg, type == CollegeEnum.SceneType.Map)
	gohelper.setActive(self._goMap, type == CollegeEnum.SceneType.Map)
	gohelper.setActive(self._goCity, type == CollegeEnum.SceneType.City)

	if type == CollegeEnum.SceneType.Map then
		self._curMapInst = self._mapInst or self._cityInst
	end

	if type == CollegeEnum.SceneType.Map then
		self._curMapRoot = self._goMap or self._goCity
	end

	self._curMapRoot = self._curMapRoot.transform

	if CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map then
		if not CollegeEnum.DungeonMapCameraSize2 then
			local sizeTb = CollegeEnum.DungeonMapCameraSize

			self._curCameraSize = sizeTb[self._curCameraSizeType]

			if type == CollegeEnum.SceneType.Map then
				self._scenePos = self._mapPos or self._cityPos
			end

			if not isFirst then
				self._viewAnim.enabled = true

				self._viewAnim:Play(type == CollegeEnum.SceneType.Map and "switch_map" or "switch_city", 0, 0)
			end

			self:_onScreenResize()
			self.viewContainer:dispatchEvent(CollegeEvent.SetViewStatName, (type == CollegeEnum.SceneType.City or nil) and (CollegeStatEnum.ViewName.Main or CollegeStatEnum.ViewName.Main_Map))
		end
	end
end

function CollegeSceneView:_onChangeSceneEnd()
	if self._curCameraSizeType == CollegeEnum.DungeonMapCameraSizeType.High then
		transformhelper.setLocalPos(self._cityElementRoot.transform, 0, 0, 0)
		transformhelper.setLocalPos(self._mapElementRoot.transform, 0, 0, 0)
	end

	local callback = self._switchSceneCallback
	local callobj = self._switchSceneCallbackObj

	self._switchSceneCallback = nil
	self._switchSceneCallbackObj = nil

	if callback then
		self._switchSceneCallback(callobj)
	end
end

function CollegeSceneView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)
end

function CollegeSceneView:_onDrag(param, pointerEventData)
	if self._curCameraSizeType ~= CollegeEnum.DungeonMapCameraSizeType.High then
		return
	end

	if not self._dragBeginPos or not self._goScene then
		return
	end

	self._isClickDown = false

	local pos = self:getDragWorldPos(pointerEventData)
	local deltaPos = pos - self._dragBeginPos

	self._dragBeginPos = pos

	self._tempVector:Set(self._scenePos.x + deltaPos.x, self._scenePos.y + deltaPos.y)
	self:directSetScenePos(self._tempVector)
end

function CollegeSceneView:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
end

function CollegeSceneView:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function CollegeSceneView:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self._scenePos.x = x
	self._scenePos.y = y

	if not self._curMapRoot or gohelper.isNil(self._curMapRoot) then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnMapSceneDrag, self._scenePos)
	transformhelper.setLocalPos(self._curMapRoot, x, y, 0)
	self:_refreshMapBgPos(x, y)
end

function CollegeSceneView:_refreshMapBgPos(x, y, isTween, time)
	if CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map then
		local mapSizeX = math.max(self._mapMaxX - self._mapMinX, 0.01)
		local mapBgSizeX = math.max(self._mapBgMaxX - self._mapBgMinX, 0.01)
		local bgX = self._mapBgMinX + (x - self._mapMinX) / mapSizeX * mapBgSizeX
		local mapSizeY = math.max(self._mapMaxY - self._mapMinY, 0.01)
		local mapBgSizeY = math.max(self._mapBgMaxY - self._mapBgMinY, 0.01)
		local bgY = self._mapBgMinY + (y - self._mapMinY) / mapSizeY * mapBgSizeY

		if isTween then
			ZProj.TweenHelper.DOLocalMove(self._goMapbg.transform, bgX, bgY, 0, time)
		else
			transformhelper.setLocalPos(self._goMapbg.transform, bgX, bgY, 0)
		end
	end
end

function CollegeSceneView:setCurCameraSizeAndSetPos(pos, type, time, callback, callobj)
	if type == self._curCameraSizeType then
		self:setTweenCameraPos(pos, time, callback, callobj)

		return
	end

	self._targetPos = pos

	self:setCurCameraSize(type, time, callback, callobj)
end

function CollegeSceneView:setCurCameraSize(type, time, callback, callobj)
	time = time or 0.5

	if type == CollegeEnum.DungeonMapCameraSizeType.High then
		self._targetPos = nil

		gohelper.setActive(self._cityInst, true)
		gohelper.setActive(self._cityLowInst, false)
		transformhelper.setLocalPos(self._cityElementRoot.transform, 0, 0, 0)
		transformhelper.setLocalPos(self._mapElementRoot.transform, 0, 0, 0)
	else
		transformhelper.setLocalPos(self._cityElementRoot.transform, 10000, 10000, 0)
		transformhelper.setLocalPos(self._mapElementRoot.transform, 10000, 10000, 0)
	end

	if self._curCameraSizeType == type then
		if callback then
			callback(callobj)
		end

		return
	end

	self._endCallback = callback
	self._endCallbackObj = callobj
	self._curCameraSizeType = type

	self:killCameraTween()

	if CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map then
		if not CollegeEnum.DungeonMapCameraSize2 then
			local sizeTb = CollegeEnum.DungeonMapCameraSize
			local toSize = sizeTb[self._curCameraSizeType]

			self._cameraTweenId = ZProj.TweenHelper.DOTweenFloat(self._curCameraSize, toSize, time, self._onTweenCameraSize, self._onTweenCameraSizeEnd, self)

			self:_calcSceneSize(toSize)

			local finalX, finalY = self:getTargetPos(self._targetPos or self._scenePos)

			ZProj.TweenHelper.DOLocalMove(self._curMapRoot, finalX, finalY, 0, time)
			self:_refreshMapBgPos(finalX, finalY, true, time)
			self:_calcSceneSize()
		end
	end
end

function CollegeSceneView:_onTweenCameraSizeEnd()
	if self._curCameraSizeType ~= CollegeEnum.DungeonMapCameraSizeType.High and CollegeModel.instance.curFocusData then
		gohelper.setActive(self._cityInst, false)
		gohelper.setActive(self._cityLowInst, true)
	end

	self:_calcSceneSize()
	self:directSetScenePos(self._targetPos or self._scenePos)
	self:doEndCallback()

	self._cameraTweenId = nil
end

function CollegeSceneView:doEndCallback()
	local callback = self._endCallback
	local callobj = self._endCallbackObj

	self._endCallback = nil
	self._endCallbackObj = nil

	if callback then
		self._endCallback(callobj)
	end
end

function CollegeSceneView:killCameraTween()
	if self._cameraTweenId then
		ZProj.TweenHelper.KillById(self._cameraTweenId)

		self._cameraTweenId = nil
	end
end

function CollegeSceneView:_onTweenCameraSize(value)
	self._curCameraSize = value

	self:_setCamera()
	CollegeController.instance:dispatchEvent(CollegeEvent.OnMapSceneSizeChange)
end

function CollegeSceneView:_onClickDown()
	self._isClickDown = true
end

function CollegeSceneView:_onClickUp()
	if self._isClickDown then
		CollegeController.instance:dispatchEvent(CollegeEvent.OnMapClick)
	end

	self._isClickDown = false
end

function CollegeSceneView:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self._mapMinX or not self._mapMinY then
		return x, y
	end

	if x < self._mapMinX then
		x = self._mapMinX
	elseif x > self._mapMaxX then
		x = self._mapMaxX
	end

	if y < self._mapMinY then
		y = self._mapMinY
	elseif y > self._mapMaxY then
		y = self._mapMaxY
	end

	return x, y
end

function CollegeSceneView:setTweenCameraPos(pos, time, callback, callobj)
	if type(pos) == "string" then
		local arr = string.splitToNumber(pos, "_") or {}

		pos = Vector3.New(arr[1], arr[2], arr[3])

		if arr[4] then
			time = arr[4]
		end
	end

	time = time or 0.5

	local x, y = self:getTargetPos(pos)

	self._targetPos = pos:Clone()
	self._targetPos.x = x
	self._targetPos.y = y

	if (x - self._scenePos.x)^2 + (y - self._scenePos.y)^2 < 0.1 then
		if callback then
			callback(callobj)
		end

		return
	end

	self:killCameraTween()

	self._fromPos = self._scenePos:Clone()
	self._endCallback = callback
	self._endCallbackObj = callobj
	self._cameraTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self._onTweenCameraPos, self._onTweenFinish, self)
end

function CollegeSceneView:_onTweenCameraPos(value)
	self:directSetScenePos(Vector3.Lerp(self._fromPos, self._targetPos, value))
end

function CollegeSceneView:_onTweenFinish()
	self:doEndCallback()

	self._cameraTweenId = nil
end

function CollegeSceneView:onOpen()
	return
end

function CollegeSceneView:_onPlayOpenAnim()
	gohelper.setActive(self._goRoot, true)
	gohelper.setActive(self._cityElementRoot, true)
	gohelper.setActive(self._mapElementRoot, true)
end

function CollegeSceneView:onClose()
	self:killCameraTween()
end

function CollegeSceneView:onDestroyView()
	self:killCameraTween()
	gohelper.destroy(self._goRoot)

	self._goRoot = nil
end

return CollegeSceneView
