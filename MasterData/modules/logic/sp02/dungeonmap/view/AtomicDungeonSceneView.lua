-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonSceneView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonSceneView", package.seeall)

local AtomicDungeonSceneView = class("AtomicDungeonSceneView", BaseView)

function AtomicDungeonSceneView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)
	self._gomapInfo = gohelper.findChild(self.viewGO, "root/#go_mapInfo")
	self._txtmapName = gohelper.findChildText(self.viewGO, "root/#go_mapInfo/bg/#txt_mapName")
	self._gotransitionEffect = gohelper.findChild(self.viewGO, "#go_transitionEffect")
	self._gomapSelectRoot = gohelper.findChild(self.viewGO, "root/#go_mapSelectRoot")
	self._sliderPolygon = gohelper.findChildSlider(self.viewGO, "root/#go_polygonSlider")
	self._goClickMask = gohelper.findChild(self.viewGO, "#go_clickMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonSceneView:addEvents()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnFocusElement, self.onFocusElement, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.JumpToMap, self.onJumpToMap, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onUnitCameraVisibleChange, self.setUnitCameraShowState, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)

	if self._drag then
		self._drag:AddDragBeginListener(self.onMapDragBegin, self)
		self._drag:AddDragEndListener(self.onMapDragEnd, self)
		self._drag:AddDragListener(self.onMapDrag, self)
	end

	self._sliderPolygon:AddOnValueChanged(self._onPolygonMapRangeChange, self)
end

function AtomicDungeonSceneView:removeEvents()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnFocusElement, self.onFocusElement, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.JumpToMap, self.onJumpToMap, self)
	self.removeEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onUnitCameraVisibleChange, self.setUnitCameraShowState, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self._sliderPolygon:RemoveOnValueChanged()
end

function AtomicDungeonSceneView:_editableInitView()
	self.tempScenePos = Vector3()
	self.curScenePos = Vector3()
	self.curSceneRotateY = nil
	self.elementRootUrl = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_elementview.prefab"
	self.testingElementRootUrl = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_testingelementview.prefab"
	self.sceneCanvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	self.mapSelectLightUrl = "scenes/sp02_m_s20_zthd/prefab/sp02_m_s20_zthd_light01.prefab"
	self.mapLightUrl = "scenes/sp02_m_s20_zthd/prefab/sp02_m_s20_zthd_light02.prefab"
	self.mapSelectUrl = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.WholeMapUrl)
	self.mainCamera = CameraMgr.instance:getMainCamera()

	gohelper.setActive(self._gotransitionEffect, false)
	gohelper.setActive(self._goClickMask, false)

	local cameraDefaultPos = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.WholeMapCameraPos)

	self.cameraDefaultPosData = string.splitToNumber(cameraDefaultPos, "#")

	local cameraDefaultRot = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.WholeMapCameraRot)

	self.cameraDefaultRotData = string.splitToNumber(cameraDefaultRot, "#")
	self.transitionImage = gohelper.findChild(self._gotransitionEffect, "img_RT"):GetComponent(gohelper.Type_RawImage)
	self.transitionAnimPlayer = SLFramework.AnimatorPlayer.Get(self._gotransitionEffect)
	self.minOrthoSize = nil
	self.maxOrthoSize = nil
	self.isBackingToMapSelect = false
end

function AtomicDungeonSceneView:initMapRootNode()
	local sceneRoot = CameraMgr.instance:getSceneRoot()
	local sceneRootUrl = self.viewContainer:getSetting().otherRes[5]

	self.sceneRoot = self.viewContainer:getResInst(sceneRootUrl, sceneRoot, AtomicDungeonEnum.SceneRootName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self.sceneRoot.transform, 0, y, 0)

	local skyPrefabUrl = self.viewContainer:getSetting().otherRes[6]

	self.skyPreb = self.viewContainer:getResInst(skyPrefabUrl, self.sceneRoot, "AtomicSky")

	local dofMaskPrefabUrl = self.viewContainer:getSetting().otherRes[7]

	self.dofMaskPreb = self.viewContainer:getResInst(dofMaskPrefabUrl, self.sceneRoot, "AtomicDofMask")

	local meshRender = self.dofMaskPreb:GetComponent(typeof(UnityEngine.MeshRenderer))

	self.dofMaskMaterial = meshRender.material
end

function AtomicDungeonSceneView:onUpdateParam()
	self:refreshMap()
end

function AtomicDungeonSceneView:onOpen()
	self.lastMapId = 0

	self:initMapRootNode()

	local lastFightParam = AtomicDungeonModel.instance:getLastElementFightParam()
	local lastPolygonFightParam = AtomicDungeonModel.instance:getLastPolygonFightParam()

	AtomicDungeonModel.instance:setIsMapSelect(not lastFightParam and (not lastPolygonFightParam or lastPolygonFightParam.isInMapSelectState))
	MainCameraMgr.instance:addView(self.viewName, nil, nil, self)
	self:initCamera()
	self:refreshMap()
	self:checkOpenPolygonSelectView()
end

function AtomicDungeonSceneView:initCamera()
	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.unitCamera = CameraMgr.instance:getUnitCamera()
	self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ = transformhelper.getLocalPos(self.mainCamera.transform)
	self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ = transformhelper.getLocalRotation(self.mainCamera.transform)
	self.cameraTrace = CameraMgr.instance:getCameraTrace()
	self.cameraTraceState = self.cameraTrace.EnableTrace
	self.cameraTrace.EnableTrace = false
	self.originFarClip = self.mainCamera.farClipPlane
	self.originNearClip = self.mainCamera.nearClipPlane
	self.originFieldOfView = self.mainCamera.fieldOfView
	self.mainCamera.farClipPlane = AtomicDungeonEnum.FarClipPlane
	self.mainCamera.nearClipPlane = AtomicDungeonEnum.NearClipPlane
	self.mainCamera.fieldOfView = AtomicDungeonEnum.FieldOfView
	self.unitCamera.farClipPlane = AtomicDungeonEnum.FarClipPlane
	self.unitCamera.nearClipPlane = AtomicDungeonEnum.NearClipPlane
	self.unitCamera.fieldOfView = AtomicDungeonEnum.FieldOfView
	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if self.isInMapSelectState then
		transformhelper.setLocalPos(self.mainCamera.transform, self.cameraDefaultPosData[1], self.cameraDefaultPosData[2], self.cameraDefaultPosData[3])
		transformhelper.setLocalRotation(self.mainCamera.transform, self.cameraDefaultRotData[1], self.cameraDefaultRotData[2], self.cameraDefaultRotData[3])
		transformhelper.setLocalPos(self.unitCamera.transform, self.cameraDefaultPosData[1], self.cameraDefaultPosData[2], self.cameraDefaultPosData[3])
		transformhelper.setLocalRotation(self.unitCamera.transform, self.cameraDefaultRotData[1], self.cameraDefaultRotData[2], self.cameraDefaultRotData[3])
	end

	local animControllerUrl = self.viewContainer:getSetting().otherRes[4]
	local animControllerInst = self.viewContainer._abLoader:getAssetItem(animControllerUrl):GetResource(animControllerUrl)

	self.cameraRootAnimPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
	self.cameraRootGO = CameraMgr.instance:getCameraRootGO()
	self.cameraRootAnim = CameraMgr.instance:getCameraRootAnimator()
	self.cameraAnimDefaultState = self.cameraRootAnim.enabled
	self.cameraRootAnim.enabled = true
	self.cameraRootAnim.runtimeAnimatorController = nil
	self.cameraRootAnim.runtimeAnimatorController = animControllerInst

	self.cameraRootAnim:Play("idle", 0, 0)
	self.cameraRootAnim:Update(0)

	self.unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	self.ppvolumeWrap = gohelper.findChildComponent(self.unitCameraGO, "PPVolume", PostProcessingMgr.PPVolumeWrapType)
end

function AtomicDungeonSceneView:setSceneStartMask()
	gohelper.setActive(self.unitCameraGO, true)

	self.ppvolumeWrap.DofDistance = 1
	self.ppvolumeWrap.DofFactor = 1
	self.ppvolumeWrap.DofFarBlur = 0
	self.ppvolumeWrap.DofLength = 2
	self.ppvolumeWrap.DofNearBlur = 0
	self.ppvolumeWrap.RolesStoryMaskActive = false

	self.ppvolumeWrap:Load()
end

function AtomicDungeonSceneView:setSceneEndMask()
	self.ppvolumeWrap.DofDistance = 0
	self.ppvolumeWrap.DofFactor = 0
	self.ppvolumeWrap.DofFarBlur = 0
	self.ppvolumeWrap.DofLength = 40
	self.ppvolumeWrap.DofNearBlur = 0
	self.ppvolumeWrap.RolesStoryMaskActive = true

	self.ppvolumeWrap:Load()
	gohelper.setActive(self.unitCameraGO, false)
end

function AtomicDungeonSceneView:initCameraSetting()
	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	self.isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	local scale = GameUtil.getAdapterScale()

	if self.isInMapSelectState then
		self.mainCamera.orthographic = false
		self.cameraRootAnim.enabled = true

		self:setSceneStartMask()
		self.dofMaskMaterial:SetTextureScale("_MainTex", Vector2(0, 0.9))
	elseif self.isInPolygonState then
		self.mainCamera.orthographic = true
		self.cameraRootAnim.enabled = false

		local scale = GameUtil.getAdapterScale()

		self.mainCamera.orthographicSize = self.minOrthoSize and self.maxOrthoSize and Mathf.Lerp(self.maxOrthoSize, self.minOrthoSize, self._sliderPolygon:GetValue()) or AtomicDungeonEnum.DungeonMapCameraSize * scale

		transformhelper.setLocalPos(self.mainCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
		transformhelper.setLocalRotation(self.mainCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)
		transformhelper.setLocalPos(self.unitCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
		transformhelper.setLocalRotation(self.unitCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)
		self:setSceneEndMask()
	else
		self.mainCamera.orthographic = false

		transformhelper.setLocalPos(self.mainCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
		transformhelper.setLocalRotation(self.mainCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)
		transformhelper.setLocalPos(self.unitCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
		transformhelper.setLocalRotation(self.unitCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)

		self.cameraRootAnim.enabled = false

		self:setSceneStartMask()
		self.dofMaskMaterial:SetTextureScale("_MainTex", Vector2(0, 500))
	end

	self.mainCamera.fieldOfView = AtomicDungeonEnum.FieldOfView * scale
	self.mainCamera.farClipPlane = AtomicDungeonEnum.FarClipPlane
	self.mainCamera.nearClipPlane = AtomicDungeonEnum.NearClipPlane
	self.unitCamera.fieldOfView = AtomicDungeonEnum.FieldOfView * scale
	self.unitCamera.farClipPlane = AtomicDungeonEnum.FarClipPlane
	self.unitCamera.nearClipPlane = AtomicDungeonEnum.NearClipPlane
end

function AtomicDungeonSceneView:setUnitCameraShowState(isShow)
	local isViewOpen = ViewMgr.instance:isOpen(ViewName.AtomicDungeonMainView) or ViewMgr.instance:isOpening(ViewName.AtomicDungeonMainView)

	if not isShow and not self.isInPolygonState and isViewOpen then
		local unitCameraGO = CameraMgr.instance:getUnitCameraGO()

		gohelper.setActive(unitCameraGO, true)
	end
end

function AtomicDungeonSceneView:_onPolygonMapRangeChange(param, value)
	if not self.isInPolygonState or not self.minOrthoSize or not self.maxOrthoSize then
		return
	end

	self.mainCamera.orthographicSize = Mathf.Lerp(self.maxOrthoSize, self.minOrthoSize, value)

	self:initScene()
	self:directSetScenePos(self.tempScenePos)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonMapRangeChange, value)
end

function AtomicDungeonSceneView:refreshMap()
	self:killTween()

	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	self.isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	self.curMapId = AtomicDungeonModel.instance:getCurMapId()
	self.dungeonMapId = AtomicDungeonModel.instance:getMapInfoId(self.curMapId)
	self.arenaMapId = AtomicDungeonConfig.instance:getDungeonMapId(self.curMapId)

	self:initCameraSetting()

	if self.dungeonMapId == self.lastMapId then
		if not self.mapLoadedDone or not self.elementsRootGO or self.isInMapSelectState then
			return
		end

		self:setMapPos()
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnInitElements, self.elementsRootGO, self.sceneGo, self.sceneRoot)
	end

	if self.isInPolygonState then
		local var_14_0 = AtomicDungeonConfig.instance:getArenaMapIdByPolygonMapId(self.curMapId)

		if not var_14_0 then
			var_14_0 = AtomicDungeonConfig.instance:getDungeonMapId(self.curMapId)

			do
				local arenaMapId = var_14_0
				local lastArenaMapId = self.lastMapId

				if self.lastMapId > 0 and AtomicDungeonModel.instance:checkArenaMapIsPolygon(self.lastMapId) then
					local lastMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(self.lastMapId)

					lastArenaMapId = lastMapConfig.arenaId
				end

				if arenaMapId ~= lastArenaMapId then
					self:loadMap()
				else
					self:switchDungeonAndPolygonMap()
				end

				self.lastMapId = self.dungeonMapId
			end

			if self.isInMapSelectState or not self.isInPolygonState then
				AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_mapamb_loop)

				goto label_14_1
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)

	::label_14_1::

	self:setCloseOverrideFunc()
end

function AtomicDungeonSceneView:loadMap()
	self.curMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(self.curMapId)
	self.mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(self.curMapConfig.infoId)
	self.mapRes = self.mapInfoConfig.res

	if self.mapLoadedDone then
		self.oldMapLoader = self.mapLoader
		self.oldSceneGo = self.sceneGo
		self.oldLightGo = self.lightGO
		self.mapLoader = nil
	end

	if self.mapLoader then
		self.mapLoader:dispose()

		self.mapLoader = nil
	end

	self.mapLoadedDone = false
	self.mapLoader = MultiAbLoader.New()

	self:addLoadRes()
	self.mapLoader:startLoad(self.loadSceneFinish, self)
end

function AtomicDungeonSceneView:addLoadRes()
	if self.isInMapSelectState then
		self.mapLoader:addPath(ResUrl.getDungeonMapRes(self.mapSelectUrl))
		self.mapLoader:addPath(self.mapSelectLightUrl)
	else
		self.mapLoader:addPath(ResUrl.getDungeonMapRes(self.mapRes))
		self.mapLoader:addPath(self.elementRootUrl)
		self.mapLoader:addPath(self.mapLightUrl)
	end

	self.mapLoader:addPath(self.sceneCanvasUrl)
end

function AtomicDungeonSceneView:loadSceneFinish()
	self.mapLoadedDone = true

	self:disposeOldMap()

	local assetUrl = self.isInMapSelectState and ResUrl.getDungeonMapRes(self.mapSelectUrl) or ResUrl.getDungeonMapRes(self.mapRes)
	local assetItem = self.mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self.sceneGo = gohelper.clone(mainPrefab, self.sceneRoot, self.arenaMapId)
	self.buildingSceneGO = gohelper.findChild(self.sceneGo, "Building")
	self.polygonSceneGO = gohelper.findChild(self.sceneGo, "Trial")

	if self.buildingSceneGO then
		gohelper.setActive(self.buildingSceneGO, not self.isInMapSelectState and not self.isInPolygonState)
	end

	if self.polygonSceneGO then
		gohelper.setActive(self.polygonSceneGO, not self.isInMapSelectState and self.isInPolygonState)
	end

	local lastEleFightParam = AtomicDungeonModel.instance:getLastElementFightParam()

	if not self.isInMapSelectState and not lastEleFightParam then
		AtomicDungeonStatHelper.instance:initDungeonStartTime()
	end

	self.sceneTrans = self.sceneGo.transform

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnLoadSceneFinish, {
		mapSceneGo = self.sceneGo
	})

	if not self.isInMapSelectState then
		self:initScene()
		self:initElements()
		self:setMapPos()
		gohelper.setActive(self._gomapSelectRoot, false)

		if self.isInPolygonState then
			self._sliderPolygon:SetValue(1)
			self._sliderPolygon:SetValue(0.5)
		end
	else
		self:setWholeMapPos()
	end

	self:addMapLight()

	self.dungeonMapAnim = not self.isInMapSelectState and not self.isInPolygonState and self.sceneGo:GetComponent(gohelper.Type_Animator) or nil

	if self._gotransitionEffect.activeSelf then
		self.transitionAnimPlayer:Play(self.isBackingToMapSelect and "close03" or "close", self.hideTransitionEffect, self)
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_map_transition_2)

		if self.isInMapSelectState then
			self:doBackToMapSelect()
		end
	end

	self.isBackingToMapSelect = false

	if not self.isInPolygonState then
		local unitCameraGO = CameraMgr.instance:getUnitCameraGO()

		gohelper.setActive(unitCameraGO, true)
	end
end

function AtomicDungeonSceneView:switchDungeonAndPolygonMap()
	self:disposeElement()
	gohelper.setActive(self.buildingSceneGO, not self.isInPolygonState)
	gohelper.setActive(self.polygonSceneGO, self.isInPolygonState)

	self.curMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(self.curMapId)
	self.mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(self.curMapConfig.infoId)

	self:initScene()
	self:initElements()
	self:setMapPos()
	self._sliderPolygon:SetValue(1)

	if self.isInPolygonState and not self.isInMapSelectState then
		self._sliderPolygon:SetValue(0.5)
	end

	local mainView = self.viewContainer:getDungeonMainView()

	if mainView then
		mainView:playViewAnim(true, false)
	end

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnLoadSceneFinish, {
		mapSceneGo = self.sceneGo
	})
end

function AtomicDungeonSceneView:checkOpenPolygonSelectView()
	local hasLastPolygonFightParam = AtomicDungeonModel.instance:getLastPolygonFightParam()

	if hasLastPolygonFightParam then
		local param = tabletool.copy(hasLastPolygonFightParam)

		AtomicDungeonController.instance:openAtomicDungeonPolygonSelectView(param)
	end

	AtomicDungeonModel.instance:cleanLastPolygonFightParam()
end

function AtomicDungeonSceneView:_onScreenResize()
	if self.sceneGo and not self.isInMapSelectState then
		self:initScene()
		self:directSetScenePos(self.tempScenePos)
	end

	self:initCameraSetting()
end

function AtomicDungeonSceneView:initScene()
	if self.isInPolygonState then
		if not self.polygonSceneGO then
			local curSceneGO = self.buildingSceneGO
			local sizeGo = gohelper.findChild(curSceneGO, "size")

			self.sceneGORoot = gohelper.findChild(curSceneGO, "go")

			local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
			local boxScaleX, boxScaleY, boxScaleZ = transformhelper.getLocalScale(sizeGo.transform, 0, 0, 0)
			local canvasGo
			local scale = GameUtil.getAdapterScale()
			local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
			local uiCamera = CameraMgr.instance:getUICamera()

			if uiCamera then
				if not uiCamera.orthographicSize then
					local uiCameraSize = AtomicDungeonEnum.DungeonMapCameraSize
					local cameraSizeRate = AtomicDungeonEnum.DungeonMapCameraSize / uiCameraSize
					local posTL = worldcorners[1] * scale * cameraSizeRate
					local posBR = worldcorners[3] * scale * cameraSizeRate

					self.viewWidth = math.abs(posBR.x - posTL.x)
					self.viewHeight = math.abs(posBR.y - posTL.y)

					local baseViewWidth = self.viewWidth
					local baseViewHeight = self.viewHeight
					local boundTL_x = posTL.x
					local boundTL_y = posTL.y

					if self.isInPolygonState and self.mainCamera then
						local zoomRate = self.mainCamera.orthographicSize / (AtomicDungeonEnum.DungeonMapCameraSize * scale)

						self.viewWidth = self.viewWidth * zoomRate
						self.viewHeight = self.viewHeight * zoomRate
						boundTL_x = posTL.x * zoomRate
						boundTL_y = posTL.y * zoomRate
					end

					local moveRangeX = box.size.x * boxScaleX - self.viewWidth

					if moveRangeX < 0 then
						moveRangeX = 0
					end

					local moveRangeY = box.size.y * boxScaleY - self.viewHeight

					if moveRangeY < 0 then
						moveRangeY = 0
					end

					self.mapMinX = boundTL_x - moveRangeX
					self.mapMaxX = boundTL_x
					self.mapMinY = boundTL_y
					self.mapMaxY = boundTL_y + moveRangeY

					if self.isInPolygonState then
						local mapWidth = box.size.x * boxScaleX
						local mapHeight = box.size.y * boxScaleY

						self.maxOrthoSize = AtomicDungeonEnum.DungeonMapCameraSize * math.min(mapWidth / baseViewWidth, mapHeight / baseViewHeight)
						self.minOrthoSize = AtomicDungeonEnum.DungeonMapCameraSize * scale
						self.minOrthoSize = math.min(self.minOrthoSize, self.maxOrthoSize)
						self.mainCamera.orthographicSize = Mathf.Lerp(self.maxOrthoSize, self.minOrthoSize, self._sliderPolygon:GetValue())

						gohelper.setActive(self._gofullscreen, true)
					end
				end
			end
		end
	end
end

function AtomicDungeonSceneView:addMapLight()
	if self.isInMapSelectState then
		if not self.mapSelectLightUrl then
			local lightUrl = self.mapLightUrl
			local assetItem = self.mapLoader:getAssetItem(lightUrl)
			local mainPrefab = assetItem:GetResource(lightUrl)

			self.lightGO = gohelper.clone(mainPrefab, self.sceneGo)

			if not self.isInMapSelectState then
				local lightCompGO = gohelper.findChild(self.lightGO, "light1")
				local lightComp = lightCompGO:GetComponent(typeof(UnityEngine.Light))
				local rotate = self.mapInfoConfig.lightRot
				local rotateParam = string.splitToNumber(rotate, "#")

				transformhelper.setLocalRotation(lightCompGO.transform, rotateParam[1], rotateParam[2], rotateParam[3])

				lightComp.color = GameUtil.parseColor("#" .. self.mapInfoConfig.lightColor)
			end
		end
	end
end

function AtomicDungeonSceneView:initElements()
	local canvasAssetItem = self.mapLoader:getAssetItem(self.sceneCanvasUrl)
	local canvasPrefab = canvasAssetItem:GetResource(self.sceneCanvasUrl)

	self.elementCanvasGo = gohelper.clone(canvasPrefab, self.sceneGORoot, "AtomicElementsCanvas")
	self.elementCanvasGo:GetComponent("Canvas").worldCamera = self.mainCamera

	gohelper.setLayer(self.elementCanvasGo, (not self.isInMapSelectState and not self.isInPolygonState or nil) and (UnityLayer.Unit or UnityLayer.Scene))

	local elementRootAssetItem = self.mapLoader:getAssetItem(self.elementRootUrl)
	local elementRootPrefab = elementRootAssetItem:GetResource(self.elementRootUrl)

	self.elementsRootGO = gohelper.clone(elementRootPrefab, self.elementCanvasGo, "elementsRoot")

	local rootGO = gohelper.findChild(self.elementsRootGO, "root")

	self.rootScale = transformhelper.getLocalScale(rootGO.transform)

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnInitElements, self.elementsRootGO, self.sceneGo, self.sceneRoot)
end

function AtomicDungeonSceneView:setMapPos()
	local curInElementId = AtomicDungeonModel.instance:getCurInElementId()
	local curElementInMapId = AtomicDungeonModel.instance:getCurElementInMapId()

	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	self.isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	transformhelper.setLocalPos(self.sceneTrans, 0, 0, 0)

	if self.isInPolygonState then
		if curInElementId > 0 and self.curMapId == curElementInMapId then
			local elementConfig = AtomicDungeonConfig.instance:getElementConfig(curInElementId)
			local pos = string.splitToNumber(elementConfig.pos, "#")

			if not -pos[1] then
				local elementMapPosX = 0

				if not -pos[2] then
					local elementMapPosY = 0

					self.tempScenePos:Set(elementMapPosX, elementMapPosY, 0)
				end
			end
		else
			local pos = self.mapInfoConfig.initPos
			local posParam = string.splitToNumber(pos, "#")

			self.tempScenePos:Set(posParam[1], posParam[2], 0)
		end

		if self.needTween then
			self:tweenSetScenePos(self.tempScenePos)

			self.needTween = false
		else
			self:directSetScenePos(self.tempScenePos)
		end
	elseif not self.isInMapSelectState then
		self.curSceneRotateY = nil

		local rotate = self.mapInfoConfig.initRot
		local rotateParam = string.splitToNumber(rotate, "#")

		transformhelper.setLocalRotation(self.buildingSceneGO.transform, rotateParam[1], rotateParam[2], rotateParam[3])

		self.initRotateX, self.initRotateY, self.initRotateZ = rotateParam[1], rotateParam[2], rotateParam[3]
		self.maxRotateX = rotateParam[1] + AtomicDungeonEnum.MaxDragMoveUp
		self.minRotateX = rotateParam[1] - AtomicDungeonEnum.MaxDragMoveDown

		local pos = self.mapInfoConfig.initPos
		local posParam = string.splitToNumber(pos, "#")

		transformhelper.setLocalPos(self.buildingSceneGO.transform, posParam[1], posParam[2], posParam[3])
	end
end

function AtomicDungeonSceneView:setWholeMapPos()
	local mapSelectPos = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.WholeMapPos)
	local posParam = string.splitToNumber(mapSelectPos, "#")

	transformhelper.setLocalPos(self.sceneTrans, posParam[1], posParam[2], 0)
end

function AtomicDungeonSceneView:tweenSetScenePos(targetPos)
	self.tweenTargetPosX, self.tweenTargetPosY = self:getTargetPos(targetPos)
	self.tweenStartPosX, self.tweenStartPosY = self:getTargetPos(self.curScenePos)

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function AtomicDungeonSceneView:tweenFrameCallback(weight)
	local curPosX = Mathf.Lerp(self.tweenStartPosX, self.tweenTargetPosX, weight)
	local curPosY = Mathf.Lerp(self.tweenStartPosY, self.tweenTargetPosY, weight)

	self.tempScenePos:Set(curPosX, curPosY, 0)
	self:directSetScenePos(self.tempScenePos)
end

function AtomicDungeonSceneView:tweenFinishCallback()
	self.tempScenePos:Set(self.tweenTargetPosX, self.tweenTargetPosY, 0)
	self:directSetScenePos(self.tempScenePos)
end

function AtomicDungeonSceneView:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self.curScenePos:Set(x, y, 0)

	if not self.polygonSceneGO or gohelper.isNil(self.polygonSceneGO.transform) then
		return
	end

	transformhelper.setLocalPos(self.polygonSceneGO.transform, self.curScenePos.x, self.curScenePos.y, 0)

	if not self.isInMapSelectState then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnUpdateElementArrow)
	end
end

function AtomicDungeonSceneView:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self.mapMinX or not self.mapMaxX or not self.mapMinY or not self.mapMaxY then
		if self.mapInfoConfig then
			local pos = self.mapInfoConfig.initPos
			local posParam = string.splitToNumber(pos, "#")

			x = posParam[1] or 0
			y = posParam[2] or 0
		end
	else
		x = Mathf.Clamp(x, self.mapMinX, self.mapMaxX)
		y = Mathf.Clamp(y, self.mapMinY, self.mapMaxY)
	end

	return x, y
end

function AtomicDungeonSceneView:onClickElement(elementComp)
	if self.isInPolygonState and elementComp and elementComp.config then
		self:focusElementByComp(elementComp)
	end
end

function AtomicDungeonSceneView:focusElementByComp(elementComp)
	if not elementComp or not elementComp.go then
		return
	end

	local elementPos = self.elementsRootGO.transform:InverseTransformPoint(elementComp.go.transform.position)

	if not -elementPos.x then
		if not -elementPos.y then
			local elementMapPosY = 0

			self.tempScenePos:Set(-elementPos.x, elementMapPosY, 0)
			self:tweenSetScenePos(self.tempScenePos)
		end
	end
end

function AtomicDungeonSceneView:focusElementByCo(elementConfig)
	local pos = string.splitToNumber(elementConfig.pos, "#")

	if not -(pos[1] * self.rootScale) then
		if not -(pos[2] * self.rootScale) then
			local elementMapPosY = 0

			self.tempScenePos:Set(-(pos[1] * self.rootScale), elementMapPosY, 0)
			self:tweenSetScenePos(self.tempScenePos)
		end
	end
end

function AtomicDungeonSceneView:onFocusElement(elementId, force)
	local sceneElementsView = self.viewContainer:getDungeonSceneElementsView()

	if not sceneElementsView then
		return
	end

	local elementComp = sceneElementsView:getElemenetComp(elementId)

	if elementComp and elementComp.config then
		self:focusElementByComp(elementComp)
	elseif force then
		local elementCo = AtomicDungeonConfig.instance:getElementConfig(elementId)
		local keyElementMo = AtomicDungeonModel.instance:getKeyElementMo(elementId)
		local forceElementCo = elementCo or keyElementMo and keyElementMo.config

		if forceElementCo then
			self:focusElementByCo(forceElementCo)
		end
	end
end

function AtomicDungeonSceneView:setSceneRotateY(posOffset)
	if not self.sceneGORoot then
		return
	end

	if not self.curSceneRotateY then
		_, self.curSceneRotateY = transformhelper.getLocalRotation(self.sceneGORoot.transform)
	end

	self.curSceneRotateY = self.curSceneRotateY - posOffset.x * AtomicDungeonEnum.RotateSpeed

	transformhelper.setLocalRotation(self.sceneGORoot.transform, 0, self.curSceneRotateY, 0)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnUpdateElementArrow)
end

function AtomicDungeonSceneView:setSceneRotateX(posOffset)
	if not self.buildingSceneGO or gohelper.isNil(self.buildingSceneGO.transform) then
		return
	end

	local curSceneRotateX, curSceneRotateY, curSceneRotateZ = transformhelper.getLocalRotation(self.buildingSceneGO.transform)

	curSceneRotateX = curSceneRotateX > 180 and curSceneRotateX - 360 or curSceneRotateX
	curSceneRotateX = curSceneRotateX - posOffset.y * AtomicDungeonEnum.RotateSpeed
	curSceneRotateX = Mathf.Clamp(curSceneRotateX, self.minRotateX, self.maxRotateX)

	transformhelper.setLocalRotation(self.buildingSceneGO.transform, curSceneRotateX, curSceneRotateY, curSceneRotateZ)

	self.curSceneRotateX = curSceneRotateX
end

function AtomicDungeonSceneView:tweenToInitRotateX()
	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self.buildingSceneGO.transform, self.initRotateX, self.initRotateY, self.initRotateZ, Mathf.Abs(self.curSceneRotateX - self.initRotateX) * 0.1)
end

function AtomicDungeonSceneView:onMapDragBegin(param, pointerEventData)
	AtomicDungeonModel.instance:setDraggingMapState(true)

	self.dragBeginPos = self:getDragWorldPos(pointerEventData)

	self:cleanTweenToInitRotateX()
end

function AtomicDungeonSceneView:onMapDrag(param, pointerEventData)
	if not self.dragBeginPos or self.isInMapSelectState then
		return
	end

	local dragPos = self:getDragWorldPos(pointerEventData)
	local posOffset = dragPos - self.dragBeginPos

	self.dragBeginPos = dragPos

	if self.isInPolygonState then
		self.tempScenePos:Set(self.curScenePos.x + posOffset.x, self.curScenePos.y + posOffset.y)
		self:directSetScenePos(self.tempScenePos)
	else
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnDragDungeonScene)
	end

	AtomicDungeonModel.instance:setDraggingMapState(true)
end

function AtomicDungeonSceneView:onMapDragEnd(param, pointerEventData)
	self.dragBeginPos = nil

	AtomicDungeonModel.instance:setDraggingMapState(false)

	if not self.isInPolygonState and not self.isInMapSelectState then
		-- block empty
	end
end

function AtomicDungeonSceneView:getDragWorldPos(pointerEventData)
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, self.mainCamera, refPos))
end

function AtomicDungeonSceneView:captureScreen()
	self.topUILayerGO = ViewMgr.instance:getUILayer(UILayerName.Top)

	gohelper.setActive(self.topUILayerGO, false)
	ZProj.ScreenCaptureUtil.Instance:CaptureScreenshotAsTexture(self.onCaptureScreenDone, self)
end

function AtomicDungeonSceneView:onCaptureScreenDone(texture2d)
	self.transitionImage.texture = texture2d

	gohelper.setActive(self.topUILayerGO, true)
end

function AtomicDungeonSceneView:enterDungeonMap(arenaMapId)
	transformhelper.setLocalPos(self.mainCamera.transform, self.cameraDefaultPosData[1], self.cameraDefaultPosData[2], self.cameraDefaultPosData[3])
	transformhelper.setLocalRotation(self.mainCamera.transform, self.cameraDefaultRotData[1], self.cameraDefaultRotData[2], self.cameraDefaultRotData[3])
	transformhelper.setLocalPos(self.unitCamera.transform, self.cameraDefaultPosData[1], self.cameraDefaultPosData[2], self.cameraDefaultPosData[3])
	transformhelper.setLocalRotation(self.unitCamera.transform, self.cameraDefaultRotData[1], self.cameraDefaultRotData[2], self.cameraDefaultRotData[3])

	local mapId = AtomicDungeonModel.instance:getMapIdByArenaMapId(arenaMapId)

	AtomicDungeonModel.instance:setCurMapId(mapId)
	self.cameraRootAnimPlayer:Play("enter" .. arenaMapId, self.doFocusToDungeonMapFinish, self)

	local mainView = self.viewContainer:getDungeonMainView()

	if mainView then
		mainView:setMainUIShowState(false)
		gohelper.setActive(self._gomapSelectRoot, false)
	end

	gohelper.setActive(self._gotransitionEffect, true)
	gohelper.setActive(self._goClickMask, true)
	self.transitionAnimPlayer:Play("open", nil, self)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_map_transition_1)
end

function AtomicDungeonSceneView:doFocusToDungeonMapFinish()
	self:captureScreen()
	AtomicDungeonModel.instance:setIsMapSelect(false)

	self.lastMapId = 0

	TaskDispatcher.runDelay(self.refreshMap, self, AtomicDungeonEnum.DelayRefrashMapTime)

	local mainView = self.viewContainer:getDungeonMainView()

	if mainView then
		mainView:setMainUIShowState(true)
		gohelper.setActive(self._gomapSelectRoot, false)
	end
end

function AtomicDungeonSceneView:backToMapSelect()
	gohelper.setActive(self._gotransitionEffect, false)
	gohelper.setActive(self._gotransitionEffect, true)
	gohelper.setActive(self._goClickMask, true)

	if self.dungeonMapAnim then
		self.dungeonMapAnim:Play("bake", 0, 0)
		self.dungeonMapAnim:Update(0)
	end

	AtomicDungeonStatHelper.instance:sendDungeonResultInfo("主动返回")
	self.transitionAnimPlayer:Play("close02", self.doBackToMapRefrashMap, self)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_map_transition_1)

	local mainView = self.viewContainer:getDungeonMainView()

	if mainView then
		mainView:setMainUIShowState(false)
		mainView:hideAlarmRule()
		gohelper.setActive(self._gomapSelectRoot, false)
	end
end

function AtomicDungeonSceneView:doBackToMapRefrashMap()
	self:captureScreen()
	AtomicDungeonModel.instance:setIsMapSelect(true)
	AtomicDungeonModel.instance:cleanNewElements()

	self.lastMapId = 0
	self.isBackingToMapSelect = true

	TaskDispatcher.runDelay(self.refreshMap, self, AtomicDungeonEnum.DelayRefrashMapTime)
end

function AtomicDungeonSceneView:doBackToMapSelect()
	gohelper.setActive(self._gomapSelectRoot, false)

	local curMapId = AtomicDungeonModel.instance:getCurMapId()
	local arenaMapId = AtomicDungeonModel.instance:getMapInfoId(curMapId)

	self.cameraRootAnimPlayer.animator.enabled = true

	self.cameraRootAnimPlayer:Play("exit" .. arenaMapId, self.doBackToMapSelectFinish, self)
end

function AtomicDungeonSceneView:doBackToMapSelectFinish()
	gohelper.setActive(self._gotransitionEffect, false)
	gohelper.setActive(self._goClickMask, false)

	local mainView = self.viewContainer:getDungeonMainView()

	if mainView then
		mainView:setMainUIShowState(true)
		gohelper.setActive(self._gomapSelectRoot, true)
	end

	self.isBackingToMapSelect = false
end

function AtomicDungeonSceneView:enterPolygonMap()
	if self.dungeonMapAnim then
		self.dungeonMapAnim:Play("close", 0, 0)
		self.dungeonMapAnim:Update(0)
	end

	self:doEnterPolygonMap()
end

function AtomicDungeonSceneView:doEnterPolygonMap()
	TaskDispatcher.runDelay(self.refreshMap, self, AtomicDungeonEnum.DelayRefrashMapTime)
end

function AtomicDungeonSceneView:backToDungeonMap()
	self:doBackToDungeonMap()
end

function AtomicDungeonSceneView:doBackToDungeonMap()
	local polygonMapId = AtomicDungeonModel.instance:getCurMapId()
	local arenaMapId = AtomicDungeonConfig.instance:getDungeonMapId(polygonMapId)
	local mapId = AtomicDungeonModel.instance:getMapIdByArenaMapId(arenaMapId)

	AtomicDungeonModel.instance:setCurMapId(mapId)
	TaskDispatcher.runDelay(self.refreshMap, self, AtomicDungeonEnum.DelayRefrashMapTime)
end

function AtomicDungeonSceneView:hideTransitionEffect()
	gohelper.setActive(self._gotransitionEffect, false)
	gohelper.setActive(self._goClickMask, false)
	self:destroyCaptureTexture()
end

function AtomicDungeonSceneView:setCloseOverrideFunc()
	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if self.isInMapSelectState then
		self.viewContainer:setOverrideCloseClick(self.closeThis, self)
	else
		self.isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

		if self.isInPolygonState then
			self.viewContainer:setOverrideCloseClick(self.backToDungeonMap, self)
		else
			self.viewContainer:setOverrideCloseClick(self.backToMapSelect, self)
		end
	end
end

function AtomicDungeonSceneView:onJumpToMap(jumpMapId)
	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	self.curMapId = AtomicDungeonModel.instance:getCurMapId()

	local curArenaMapId = AtomicDungeonModel.instance:getMapInfoId(self.curMapId)

	if curArenaMapId ~= jumpMapId or self.isInMapSelectState then
		self.lastMapId = self.isInMapSelectState and 0 or curArenaMapId

		AtomicDungeonModel.instance:setIsMapSelect(false)

		local isPolygonMap = AtomicDungeonModel.instance:checkArenaMapIsPolygon(jumpMapId)
		local mapId = AtomicDungeonModel.instance:getMapIdByArenaMapId(jumpMapId)
		local targetMapId = isPolygonMap and jumpMapId or mapId

		AtomicDungeonModel.instance:setCurMapId(targetMapId)
		self:refreshMap()
	else
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnCloseTaskView)
	end
end

function AtomicDungeonSceneView:setSceneVisible(isVisible)
	AtomicDungeonModel.instance:setCanClickElementState(isVisible)
end

function AtomicDungeonSceneView:onClose()
	self:killTween()
	TaskDispatcher.cancelTask(self.refreshMap, self)
	self:setSceneEndMask()

	self.mainCamera.orthographicSize = 5
	self.mainCamera.orthographic = false
	self.cameraTrace.EnableTrace = self.cameraTraceState
	self.mainCamera.farClipPlane = self.originFarClip
	self.mainCamera.nearClipPlane = self.originNearClip
	self.mainCamera.fieldOfView = self.originFieldOfView
	self.unitCamera.farClipPlane = self.originFarClip
	self.unitCamera.nearClipPlane = self.originNearClip
	self.unitCamera.fieldOfView = self.originFieldOfView
	self.cameraRootAnim.enabled = false
	self.cameraRootAnim.runtimeAnimatorController = nil

	transformhelper.setLocalPos(self.mainCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
	transformhelper.setLocalRotation(self.mainCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)
	transformhelper.setLocalPos(self.unitCamera.transform, self.originCameraPosX, self.originCameraPosY, self.originCameraPosZ)
	transformhelper.setLocalRotation(self.unitCamera.transform, self.originCameraRotX, self.originCameraRotY, self.originCameraRotZ)

	self.cameraRootAnim.enabled = self.cameraAnimDefaultState

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
	AtomicDungeonModel.instance:saveLocalKeyElementData()
end

function AtomicDungeonSceneView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self:cleanTweenToInitRotateX()
end

function AtomicDungeonSceneView:cleanTweenToInitRotateX()
	if self.rotaTweenId then
		ZProj.TweenHelper.KillById(self.rotaTweenId)

		self.rotaTweenId = nil
	end
end

function AtomicDungeonSceneView:destroyCaptureTexture()
	if self.transitionImage.texture then
		local texture = self.transitionImage.texture

		self.transitionImage.texture = nil

		gohelper.destroy(texture)
	end
end

function AtomicDungeonSceneView:_onCloseView(viewName)
	if not self.isInPolygonState and (viewName == ViewName.AtomicDataBaseView or viewName == ViewName.AtomicCultivateView or viewName == ViewName.AtomicDungeonTaskView or viewName == ViewName.AtomicLineGameView or viewName == ViewName.AtomicColorGameView or viewName == ViewName.AtomicRhythmGameView) then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_mapamb_loop)
	end
end

function AtomicDungeonSceneView:onDestroyView()
	gohelper.destroy(self.sceneRoot)
	gohelper.destroy(self.skyPreb)
	gohelper.destroy(self.dofMaskPreb)
	self:disposeOldMap()

	self.sceneTrans = nil

	if self.sceneGo then
		gohelper.destroy(self.sceneGo)

		self.sceneGo = nil
	end

	if self.mapLoader then
		self.mapLoader:dispose()
	end

	if self.topUILayerGO then
		gohelper.setActive(self.topUILayerGO, true)
	end

	TaskDispatcher.cancelTask(self.refreshMap, self)
	self:destroyCaptureTexture()
end

function AtomicDungeonSceneView:disposeOldMap()
	if self.oldMapLoader then
		self.oldMapLoader:dispose()

		self.oldMapLoader = nil
	end

	self:disposeElement()

	if self.oldLightGo then
		gohelper.destroy(self.oldLightGo)

		self.oldLightGo = nil
	end

	if self.oldSceneGo then
		gohelper.destroy(self.oldSceneGo)

		self.oldSceneGo = nil
	end

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnDisposeOldMap)
end

function AtomicDungeonSceneView:disposeElement()
	if self.elementCanvasGo then
		gohelper.destroy(self.elementCanvasGo)

		self.elementCanvasGo = nil
	end

	if self.elementsRootGO then
		gohelper.destroy(self.elementsRootGO)

		self.elementsRootGO = nil
	end

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnDisposeOldMap)
end

return AtomicDungeonSceneView
